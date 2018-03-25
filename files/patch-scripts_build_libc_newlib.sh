--- scripts/build/libc/newlib.sh.orig	2018-03-24 12:57:39 UTC
+++ scripts/build/libc/newlib.sh
@@ -108,7 +108,7 @@ do_libc() {
     #   host   : the machine building newlib
     #   target : the machine newlib runs on
     CT_DoExecLog CFG                                    \
-    CC_FOR_BUILD="${CT_BUILD}-gcc"                      \
+    CC_FOR_BUILD="${CT_BUILD}-%%CC%%"                      \
     CFLAGS_FOR_TARGET="${cflags_for_target}"            \
     AR=${CT_TARGET}-ar                                  \
     RANLIB=${CT_TARGET}-ranlib                          \
