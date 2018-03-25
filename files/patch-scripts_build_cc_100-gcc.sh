--- scripts/build/cc/100-gcc.sh.orig	2018-01-09 11:06:47 UTC
+++ scripts/build/cc/100-gcc.sh
@@ -433,7 +433,7 @@ do_gcc_core_backend() {
 
     # Use --with-local-prefix so older gccs don't look in /usr/local (http://gcc.gnu.org/PR10532)
     CT_DoExecLog CFG                                   \
-    CC_FOR_BUILD="${CT_BUILD}-gcc"                     \
+    CC_FOR_BUILD="%%CC%%"                     \
     CFLAGS="${cflags}"                                 \
     CXXFLAGS="${cflags}"                               \
     LDFLAGS="${core_LDFLAGS[*]}"                       \
@@ -504,9 +504,9 @@ do_gcc_core_backend() {
         # compilers for canadian build and use the defaults on other
         # configurations.
         if [ "${CT_BARE_METAL},${CT_CANADIAN}" = "y,y" ]; then
-            repair_cc="CC_FOR_BUILD=${CT_BUILD}-gcc \
+            repair_cc="CC_FOR_BUILD=%%CC%% \
                        CXX_FOR_BUILD=${CT_BUILD}-g++ \
-                       GCC_FOR_TARGET=${CT_TARGET}-gcc"
+                       GCC_FOR_TARGET=%%CC%%"
         else
             repair_cc=""
         fi
@@ -925,9 +925,9 @@ do_gcc_backend() {
     CT_DoLog DEBUG "Extra config passed: '${extra_config[*]}'"
 
     CT_DoExecLog CFG                                \
-    CC_FOR_BUILD="${CT_BUILD}-gcc"                  \
+    CC_FOR_BUILD="%%CC%%"                  \
     CFLAGS="${cflags}"                              \
-    CXXFLAGS="${cflags}"                            \
+    CXXFLAGS="${cflags} %%CXXFLAGS%%"                            \
     LDFLAGS="${final_LDFLAGS[*]}"                   \
     CFLAGS_FOR_TARGET="${CT_TARGET_CFLAGS}"         \
     CXXFLAGS_FOR_TARGET="${CT_TARGET_CFLAGS}"       \
