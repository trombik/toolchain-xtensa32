--- scripts/build/companion_libs/110-mpfr.sh.orig	2018-01-09 11:06:47 UTC
+++ scripts/build/companion_libs/110-mpfr.sh
@@ -134,7 +134,7 @@ do_mpfr_backend() {
 
     CT_DoLog EXTRA "Configuring MPFR"
     CT_DoExecLog CFG                                    \
-    CC="${host}-gcc"                                    \
+    CC="${host}-%%CC%%"                                    \
     CFLAGS="${cflags}"                                  \
     LDFLAGS="${ldflags}"                                \
     "${CT_SRC_DIR}/mpfr-${CT_MPFR_VERSION}/configure"   \
