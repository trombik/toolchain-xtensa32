--- scripts/build/debug/300-gdb.sh.orig	2018-01-09 11:06:47 UTC
+++ scripts/build/debug/300-gdb.sh
@@ -96,7 +96,7 @@ do_debug_gdb_build() {
         CC_for_gdb=
         LD_for_gdb=
         if [ "${CT_GDB_CROSS_STATIC}" = "y" ]; then
-            CC_for_gdb="${CT_HOST}-gcc -static"
+            CC_for_gdb="${CT_HOST}-%%CC%% -static"
             LD_for_gdb="${CT_HOST}-ld -static"
         fi
 
@@ -177,10 +177,10 @@ do_debug_gdb_build() {
         native_extra_config+=("--disable-nls")
 
         if [ "${CT_GDB_NATIVE_STATIC}" = "y" ]; then
-            CC_for_gdb="${CT_TARGET}-gcc -static"
+            CC_for_gdb="${CT_TARGET}-%%CC%% -static"
             LD_for_gdb="${CT_TARGET}-ld -static"
         else
-            CC_for_gdb="${CT_TARGET}-gcc"
+            CC_for_gdb="${CT_TARGET}-%%CC%%"
             LD_for_gdb="${CT_TARGET}-ld"
         fi
 
@@ -252,7 +252,7 @@ do_debug_gdb_build() {
         fi
 
         CT_DoExecLog CFG                                \
-        CC="${CT_TARGET}-gcc"                           \
+        CC="${CT_TARGET}-%%CC%%"                           \
         CPP="${CT_TARGET}-cpp"                          \
         LD="${CT_TARGET}-ld"                            \
         LDFLAGS="${gdbserver_LDFLAGS}"                  \
