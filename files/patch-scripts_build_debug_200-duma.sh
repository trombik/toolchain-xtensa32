--- scripts/build/debug/200-duma.sh.orig	2018-01-09 11:06:47 UTC
+++ scripts/build/debug/200-duma.sh
@@ -40,9 +40,9 @@ do_debug_duma_build() {
     libs="${libs# }"
     CT_DoLog EXTRA "Building libraries '${libs}'"
     CT_DoExecLog ALL                    \
-    ${make} HOSTCC="${CT_BUILD}-gcc"    \
-         CC="${CT_TARGET}-gcc"          \
-         CXX="${CT_TARGET}-gcc"         \
+    ${make} HOSTCC="${CT_BUILD}-%%CC%%"    \
+         CC="${CT_TARGET}-%%CC%%"          \
+         CXX="${CT_TARGET}-%%CC%%"         \
          RANLIB="${CT_TARGET}-ranlib"   \
          DUMA_CPP="${DUMA_CPP}"         \
          ${libs}
