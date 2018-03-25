--- scripts/build/companion_libs/200-libelf.sh.orig	2018-01-09 11:06:47 UTC
+++ scripts/build/companion_libs/200-libelf.sh
@@ -116,7 +116,7 @@ do_libelf_backend() {
     fi
 
     CT_DoExecLog CFG                                        \
-    CC="${host}-gcc"                                        \
+    CC="${host}-%%CC%%"                                        \
     RANLIB="${host}-ranlib"                                 \
     CFLAGS="${cflags} -fPIC"                                \
     LDFLAGS="${ldflags}"                                    \
