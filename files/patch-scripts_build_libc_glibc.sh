--- scripts/build/libc/glibc.sh.orig	2018-03-24 12:19:08 UTC
+++ scripts/build/libc/glibc.sh
@@ -113,7 +113,7 @@ do_libc_backend() {
 
     # If gcc is not configured for multilib, it still prints
     # a single line for the default settings
-    multilibs=( $("${CT_TARGET}-gcc" -print-multi-lib 2>/dev/null) )
+    multilibs=( $("${CT_TARGET}-%%CC%%" -print-multi-lib 2>/dev/null) )
     for multilib in "${multilibs[@]}"; do
         multi_dir="${multilib%%;*}"
         if [ "${multi_dir}" != "." ]; then
@@ -307,7 +307,7 @@ do_libc_backend_once() {
     # Pre-seed the configparms file with values from the config option
     printf "%s\n" "${CT_LIBC_GLIBC_CONFIGPARMS}" > configparms
 
-    cross_cc=$(CT_Which "${CT_TARGET}-gcc")
+    cross_cc=$(CT_Which "${CT_TARGET}-%%CC%%")
     extra_cc_args+=" ${extra_flags}"
 
     case "${CT_LIBC_ENABLE_FORTIFIED_BUILD}" in
@@ -346,9 +346,9 @@ do_libc_backend_once() {
     CT_DoLog DEBUG "Extra flags (multilib)  : '${extra_flags}'"
 
     CT_DoExecLog CFG                                                \
-    BUILD_CC="${CT_BUILD}-gcc"                                      \
+    BUILD_CC="${CT_BUILD}-%%CC%%"                                      \
     CFLAGS="${glibc_cflags}"                                        \
-    CC="${CT_TARGET}-gcc ${CT_LIBC_EXTRA_CC_ARGS} ${extra_cc_args}" \
+    CC="${CT_TARGET}-%%CC%% ${CT_LIBC_EXTRA_CC_ARGS} ${extra_cc_args}" \
     AR=${CT_TARGET}-ar                                              \
     RANLIB=${CT_TARGET}-ranlib                                      \
     "${CONFIG_SHELL}"                                               \
