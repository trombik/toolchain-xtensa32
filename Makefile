# $FreeBSD$

PORTNAME=	toolchain-xtensa32
# XXX not sure this is the right version number.
# versioning scheme has not been documented anywhere.
PORTVERSION=	2.50200.80
CATEGORIES=	devel

MAINTAINER=	y@trombik.org
COMMENT=	ESP32 GCC Cross-compiler Toolchain for platform.io

LICENSE=	GPLv2
LICENSE_FILE=	${WRKSRC}/COPYING

BUILD_DEPENDS=	flex:textproc/flex \
	gperf:devel/gperf \
	git:devel/git \
	bash:shells/bash \
	gsed:textproc/gsed \
	grep:textproc/gnugrep \
	gawk:lang/gawk \
	autoconf:devel/autoconf \
	makeinfo:print/texinfo \
	wget:ftp/wget \
	help2man:misc/help2man \
	gpatch:devel/patch

USES=	gmake bison libtool:build

USE_GITHUB=	yes
GH_ACCOUNT=	espressif
GH_PROJECT=	crosstool-NG
GH_TAGNAME=	6c4433a

# XXX should work with clang(1), but have not confirmed yet
USE_GCC=	yes

# cannot compile with gcc6 without this.
# XXX note that, even though USE_CXXSTD is set to `yes` here, the port patches
# files (see below), not the provided ports mechanism. emphasizing here that
# the build does not work with recent compilers.
USE_CXXSTD=	c++98

GNU_CONFIGURE=	yes
MY_CONFIGURE_ARGS+=	--enable-local \
					--with-bash=${PREFIX}/bin/bash \
					--with-awk=${PREFIX}/bin/gawk \
					--with-automake=${PREFIX}/bin/automake \
					--with-make=${PREFIX}/bin/${GMAKE} \
					--with-libtool=${PREFIX}/bin/libtool \
					--with-libtoolize=${PREFIX}/bin/libtoolize

PLIST_SUB+=	PORTVERSION=${PORTVERSION} \
			MACHINE=${MACHINE} \
			PORTNAME=${PORTNAME}

# the build process would fetches the files _during_ the build, see
# post-extract below.
MY_EXTRA_DISTFILES=	\
	binutils-2.25.1.tar.bz2:binutils \
	expat-2.1.0.tar.gz:expat \
	gcc-5.2.0.tar.bz2:gcc \
	gdb-7.10.tar.xz:gdb \
	gmp-6.0.0a.tar.xz:gmp \
	mpc-1.0.3.tar.gz:mpc \
	isl-0.14.tar.xz:isl \
	mpfr-3.1.3.tar.xz:mpfr \
	newlib-2.2.0.tar.gz:newlib \
	ncurses-6.0.tar.gz:ncurses
DISTFILES+=	${MY_EXTRA_DISTFILES}

MASTER_SITE_ISL+= \
	http://isl.gforge.inria.fr/
MASTER_SITE_NEWLIB+= \
	http://sourceware.org/pub/%SUBDIR%/
MASTER_SITES+=	GNU/binutils:binutils \
	SF/expat/expat/2.1.0:expat \
	GNU/gcc/gcc-5.2.0:gcc \
	GNU/gdb:gdb \
	GNU/gmp:gmp \
	ISL/:isl \
	GNU/ncurses:ncurses \
	GNU/mpc:mpc \
	GNU/mpfr:mpfr \
	NEWLIB/newlib:newlib

.include <bsd.port.pre.mk>

# pre-seed required files for build, making it possible to build without
# network.
post-extract:
.for F in ${MY_EXTRA_DISTFILES}
	${MKDIR} ${WRKSRC}/.build/tarballs
	${CP} ${DISTDIR}/${F:C/:.*//} ${WRKSRC}/.build/tarballs/
.endfor

do-configure:
	(cd ${WRKSRC} && \
		./bootstrap && \
		${SETENV} CC="${CC}" CPP="${CPP}" CXX="${CXX}" ./configure ${MY_CONFIGURE_ARGS} )

# as `gcc` is hard-coded in scripts, fix them.
# the build process does not like user-defined CFLAGS and CXXFLAGS.
# -std=c++98 must be set when compiler is recent one.
pre-build:
	(cd ${WRKSRC} && ${REINPLACE_CMD} -e 's|%%CC%%|${CC}|g' \
		-e 's|%%CXX%%|${CXX}|g' \
		-e 's|%%CXXFLAGS%%|-std=c++98|g' \
		scripts/crosstool-NG.sh.in \
		scripts/build/cc/100-gcc.sh \
		scripts/build/companion_libs/110-mpfr.sh \
		scripts/build/companion_libs/200-libelf.sh \
		scripts/build/companion_libs/320-libiconv.sh \
		scripts/build/debug/100-dmalloc.sh \
		scripts/build/debug/200-duma.sh \
		scripts/build/debug/300-gdb.sh \
		scripts/build/debug/500-strace.sh \
		scripts/build/libc/glibc.sh \
		scripts/build/libc/newlib.sh)

do-build:
	(cd ${WRKSRC} && ${GMAKE})
	(cd ${WRKSRC} && ./ct-ng -d xtensa-esp32-elf)

.if defined(PACKAGE_BUILDING)
# disable progress bar, which makes logs unreadable, when building in
# poudriere(8)
	${REINPLACE_CMD} -e 's/^CT_LOG_PROGRESS_BAR=y.*//' ${WRKSRC}/.config
.endif

# set CT_ALLOW_BUILD_AS_ROOT_SURE so that it can be built by default
# poudriere(8) as root
	${ECHO} "CT_ALLOW_BUILD_AS_ROOT_SURE=y" >> ${WRKSRC}/.config
# build static binaries
	${ECHO} "CT_STATIC_TOOLCHAIN=y" >> ${WRKSRC}/.config
	${ECHO} "CT_GDB_CROSS_STATIC=y" >> ${WRKSRC}/.config
# disable NLS
	${ECHO} "CT_TOOLCHAIN_ENABLE_NLS=n" >> ${WRKSRC}/.config
# disable python
	${ECHO} "CT_GDB_CROSS_PYTHON=n" >> ${WRKSRC}/.config
	(cd ${WRKSRC} && ${SETENV} CC="${CC}" CPP="${CPP}" CXX="${CXX}" ./ct-ng -d build)

# fix the permissions on directories, making it possible to build as a user
	${CHMOD} 755 ${WRKSRC}/builds
	${FIND} ${WRKSRC}/builds -type d -exec ${CHMOD} 755 {} \;

# prevent the log from being included in the archive
	${RM} ${WRKSRC}/builds/xtensa-esp32-elf/build.log.bz2

# add package.json
	${CP} ${FILESDIR}/package.json ${WRKSRC}/builds/xtensa-esp32-elf/
	${REINPLACE_CMD} -e 's|%%COMMENT%%|${COMMENT}|' \
		-e 's|%%PORTNAME%%|${PORTNAME}|' \
		-e 's|%%MACHINE%%|${MACHINE}|' \
		-e 's|%%PORTVERSION%%|${PORTVERSION}|' \
		${WRKSRC}/builds/xtensa-esp32-elf/package.json
	${RM} ${WRKSRC}/builds/xtensa-esp32-elf/package.json.bak

	${TAR} -C ${WRKSRC}/builds/xtensa-esp32-elf -cz \
		-f ${WRKSRC}/builds/${PORTNAME}-freebsd_${MACHINE}-${PORTVERSION}.tar.gz .

do-install:
	${MKDIR} ${STAGEDIR}/${DATADIR}
	${INSTALL_DATA} ${WRKSRC}/builds/${PORTNAME}-freebsd_${MACHINE}-${PORTVERSION}.tar.gz \
		${STAGEDIR}/${DATADIR}/

.include <bsd.port.post.mk>
