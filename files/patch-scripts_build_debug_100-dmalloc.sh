--- scripts/build/debug/100-dmalloc.sh.orig	2018-01-09 11:06:47 UTC
+++ scripts/build/debug/100-dmalloc.sh
@@ -34,7 +34,7 @@ do_debug_dmalloc_build() {
     CT_DoLog DEBUG "Extra config passed: '${extra_config[*]}'"
 
     CT_DoExecLog CFG                                            \
-    CC="${CT_TARGET}-gcc"                                       \
+    CC="${CT_TARGET}-%%CC%%"                                       \
     CXX="${CT_TARGET}-g++"                                      \
     CPP="${CT_TARGET}-cpp"                                      \
     LD="${CT_TARGET}-ld"                                        \
