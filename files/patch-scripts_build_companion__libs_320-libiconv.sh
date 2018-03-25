--- scripts/build/companion_libs/320-libiconv.sh.orig	2018-01-09 11:06:47 UTC
+++ scripts/build/companion_libs/320-libiconv.sh
@@ -105,10 +105,10 @@ do_libiconv_backend() {
         "${extra_config[@]}"                                  \
 
     CT_DoLog EXTRA "Building libiconv"
-    CT_DoExecLog ALL ${make} CC="${host}-gcc ${cflags}" ${JOBSFLAGS}
+    CT_DoExecLog ALL ${make} CC="${host}-%%CC%% ${cflags}" ${JOBSFLAGS}
 
     CT_DoLog EXTRA "Installing libiconv"
-    CT_DoExecLog ALL ${make} install CC="${host}-gcc ${cflags}"
+    CT_DoExecLog ALL ${make} install CC="${host}-%%CC%% ${cflags}"
 }
 
 fi
