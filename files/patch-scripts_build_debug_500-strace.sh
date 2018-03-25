--- scripts/build/debug/500-strace.sh.orig	2018-03-24 12:59:02 UTC
+++ scripts/build/debug/500-strace.sh
@@ -19,8 +19,8 @@ do_debug_strace_build() {
 
     CT_DoLog EXTRA "Configuring strace"
     CT_DoExecLog CFG                                        \
-    CC="${CT_TARGET}-gcc"                                   \
-    CPP="${CT_TARGET}-cpp"                                  \
+    CC="${CT_TARGET}-%%CC%%"                                   \
+    CPP="${CT_TARGET}-%%CXX%%"                                  \
     LD="${LD_TARGET}-ld"                                    \
     "${CT_SRC_DIR}/strace-${CT_STRACE_VERSION}/configure"   \
         --build=${CT_BUILD}                                 \
