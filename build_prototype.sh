#!/bin/bash
set -ex

# --- Configuration ---
ARCHS="x86_64;arm64" # For CMAKE_OSX_ARCHITECTURES
INSTALL_PREFIX="$(pwd)/staging" # Install everything into a local staging area first
HOMEBREW_PREFIX_VAL="%%HOMEBREW_PREFIX%%" # Placeholder for actual Homebrew prefix

# Ensure paths to Homebrew-installed libraries are discoverable
export PKG_CONFIG_PATH="$HOMEBREW_PREFIX_VAL/lib/pkgconfig:$HOMEBREW_PREFIX_VAL/share/pkgconfig:/usr/lib/pkgconfig"
export CMAKE_PREFIX_PATH="$HOMEBREW_PREFIX_VAL:$CMAKE_PREFIX_PATH"
export PATH="$HOMEBREW_PREFIX_VAL/bin:$PATH"

# --- Build Poppler (Static) ---
echo "Building Poppler..."
# Assume Poppler source is in ./poppler-24.01.0
if [ ! -d poppler-24.01.0 ]; then
    echo "Poppler source directory not found!"
    exit 1
fi
cd poppler-24.01.0
mkdir -p build && cd build

cmake .. \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" \
    -DCMAKE_OSX_ARCHITECTURES="$ARCHS" \
    -DENABLE_UNSTABLE_API_ABI_HEADERS=OFF \
    -DBUILD_GTK_TESTS=OFF \
    -DBUILD_QT5_TESTS=OFF \
    -DBUILD_QT6_TESTS=OFF \
    -DBUILD_CPP_TESTS=OFF \
    -DBUILD_MANUAL_TESTS=OFF \
    -DENABLE_BOOST=OFF \
    -DENABLE_SPLASH=ON \
    -DENABLE_UTILS=OFF \
    -DENABLE_CPP=OFF \
    -DENABLE_GLIB=ON \
    -DENABLE_GOBJECT_INTROSPECTION=OFF \
    -DENABLE_GTK_DOC=OFF \
    -DENABLE_QT5=OFF \
    -DENABLE_QT6=OFF \
    -DENABLE_LIBOPENJPEG="none" \
    -DENABLE_DCTDECODER="libjpeg" \
    -DENABLE_CMS="none" \
    -DENABLE_LCMS=OFF \
    -DENABLE_LIBCURL=OFF \
    -DENABLE_LIBTIFF=OFF \
    -DWITH_TIFF=OFF \
    -DWITH_NSS3=OFF \
    -DENABLE_NSS3=OFF \
    -DENABLE_GPGME=OFF \
    -DENABLE_ZLIB=ON \
    -DENABLE_ZLIB_UNCOMPRESS=OFF \
    -DUSE_FLOAT=OFF \
    -DBUILD_SHARED_LIBS=OFF \
    -DRUN_GPERF_IF_PRESENT=OFF \
    -DEXTRA_WARN=OFF \
    -DWITH_JPEG=ON \
    -DWITH_PNG=ON \
    -DWITH_Cairo=ON

ninja install
cd ../..

# --- Build FontForge (Static) ---
echo "Building FontForge..."
# Assume FontForge source is in ./fontforge-20230101
if [ ! -d fontforge-20230101 ]; then
    echo "FontForge source directory not found!"
    exit 1
fi
cd fontforge-20230101
# Apply patches if any (example)
# git apply ../patches/fontforge-20170731-fixGDraw.patch
mkdir -p build && cd build

cmake .. \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" \
    -DCMAKE_OSX_ARCHITECTURES="$ARCHS" \
    -DBUILD_SHARED_LIBS:BOOL=OFF \
    -DENABLE_GUI:BOOL=OFF \
    -DENABLE_X11:BOOL=OFF \
    -DENABLE_NATIVE_SCRIPTING:BOOL=ON \
    -DENABLE_PYTHON_SCRIPTING:BOOL=OFF \
    -DENABLE_PYTHON_EXTENSION:AUTO=OFF \
    -DENABLE_LIBSPIRO:BOOL=OFF \
    -DENABLE_LIBUNINAMESLIST:BOOL=OFF \
    -DENABLE_LIBGIF:AUTO=OFF \
    -DENABLE_LIBJPEG:AUTO=ON \
    -DENABLE_LIBPNG:AUTO=ON \
    -DENABLE_LIBREADLINE:AUTO=OFF \
    -DENABLE_LIBTIFF:AUTO=ON \
    -DENABLE_WOFF2:AUTO=OFF \
    -DENABLE_DOCS:AUTO=OFF \
    -DENABLE_CODE_COVERAGE:BOOL=OFF \
    -DENABLE_DEBUG_RAW_POINTS:BOOL=OFF \
    -DENABLE_FONTFORGE_EXTRAS:BOOL=OFF \
    -DENABLE_MAINTAINER_TOOLS:BOOL=OFF \
    -DENABLE_TILE_PATH:BOOL=OFF \
    -DENABLE_WRITE_PFM:BOOL=OFF \
    -DENABLE_SANITIZER:ENUM="none" \
    -DENABLE_FREETYPE_DEBUGGER:PATH="" \
    -DSPHINX_USE_VENV:BOOL=OFF \
    -DREAL_TYPE:ENUM="double" \
    -DTHEME:ENUM="tango"

ninja install
cd ../..

# --- Build pdf2htmlEX ---
echo "Building pdf2htmlEX..."
# Assume pdf2htmlEX source is in current directory .
if [ ! -f CMakeLists.txt ] && [ -f pdf2htmlEX/CMakeLists.txt ]; then
    # If we are in the root of the cloned repo, cd into the subdir
    cd pdf2htmlEX
fi

# The CMakeLists.txt for pdf2htmlEX will need to find Poppler and FontForge
# We've installed them into $INSTALL_PREFIX, so we need to tell pdf2htmlEX's CMake
export PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
export CMAKE_PREFIX_PATH="$INSTALL_PREFIX:$CMAKE_PREFIX_PATH"

# For pdf2htmlEX/share scripts (build_css.sh, build_js.sh) to find java
# Assuming openjdk is installed by Homebrew and in PATH
# In a real formula, Formula["openjdk"].opt_prefix would be used
export JAVA_HOME="$HOMEBREW_PREFIX_VAL/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

mkdir -p build && cd build
cmake .. \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX/final" \ # Final install location for pdf2htmlEX
    -DCMAKE_OSX_ARCHITECTURES="$ARCHS" \
    -DPOPPLER_STATIC=ON \
    -DFONTFORGE_STATIC=ON \
    -DCMAKE_PREFIX_PATH="$INSTALL_PREFIX;$CMAKE_PREFIX_PATH" \
    -DCMAKE_FIND_FRAMEWORK=NEVER \
    -DCMAKE_FIND_APPBUNDLE=NEVER

ninja install
cd ..
if [ -d pdf2htmlEX ]; then # go back to root if we cd'd
    cd ..
fi

echo "Build complete. Products in $INSTALL_PREFIX/final"
echo "Universal binary expected at $INSTALL_PREFIX/final/bin/pdf2htmlEX"

# --- Verification (conceptual) ---
# file "$INSTALL_PREFIX/final/bin/pdf2htmlEX"
# lipo -info "$INSTALL_PREFIX/final/bin/pdf2htmlEX"
