# typed: false
# frozen_string_literal: true

class Pdf2htmlex < Formula
  desc "Convert PDF to HTML without losing text or format"
  homepage "https://github.com/pdf2htmlEX/pdf2htmlEX"
  url "https://github.com/pdf2htmlEX/pdf2htmlEX/archive/refs/tags/v0.18.8.rc1.tar.gz"
  version "0.18.8.rc1"
  sha256 "###SHA256_SUM_PDF2HTMLEX###" # Placeholder, replace with actual checksum
  license "GPL-3.0-or-later"
  revision 1 # Increment if resources or build logic changes without a version bump

  # Universal build supported
  # bottle :unneeded # We will build from source, bottles can be added later

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "openjdk" => :build # For YUI Compressor and Closure Compiler

  depends_on "cairo"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "gettext"
  depends_on "glib"
  depends_on "jpeg-turbo" # Homebrew standard for jpeg
  depends_on "libpng"
  depends_on "libtiff" # FontForge can use this
  depends_on "libxml2" # FontForge can use this
  depends_on "pango" # FontForge
  depends_on "harfbuzz" # FontForge

  resource "poppler" do
    url "https://poppler.freedesktop.org/poppler-24.01.0.tar.xz"
    sha256 "###SHA256_SUM_POPPLER###" # Placeholder
  end

  resource "fontforge" do
    url "https://github.com/fontforge/fontforge/archive/refs/tags/20230101.tar.gz"
    sha256 "###SHA256_SUM_FONTFORGE###" # Placeholder
  end

  def install
    # Staging prefix for our custom-built static libraries
    ENV.cxx11

    # Ensure Homebrew's libraries are found by pkg-config and cmake
    # This setup should be sufficient for most cases.
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["freetype"].opt_lib/"pkgconfig"
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["fontconfig"].opt_lib/"pkgconfig"
    # Add other specific opt_lib/pkgconfig paths if needed, but Homebrew's superenv usually handles this.

    # Remove march flags that can cause issues with older compilers or specific C++ features in dependencies
    ENV.remove "HOMEBREW_CFLAGS", / ?-march=\S*/
    ENV.remove "HOMEBREW_CXXFLAGS", / ?-march=\S*/


    archs = Hardware::CPU.universal_archs.join(";")
    staging_prefix = buildpath/"staging"

    # Centralized CMAKE_PREFIX_PATH for all Homebrew deps
    cmake_prefix_paths = [
      Formula["cairo"].opt_prefix,
      Formula["fontconfig"].opt_prefix,
      Formula["freetype"].opt_prefix,
      Formula["gettext"].opt_prefix,
      Formula["glib"].opt_prefix,
      Formula["jpeg-turbo"].opt_prefix,
      Formula["libpng"].opt_prefix,
      Formula["libtiff"].opt_prefix,
      Formula["libxml2"].opt_prefix,
      Formula["pango"].opt_prefix,
      Formula["harfbuzz"].opt_prefix,
    ].join(";")
    ENV["CMAKE_PREFIX_PATH"] = cmake_prefix_paths

    # Build Poppler
    resource("poppler").stage do
      mkdir "build" do
        system "cmake", "..",
               "-G", "Ninja",
               "-DCMAKE_BUILD_TYPE=Release",
               "-DCMAKE_INSTALL_PREFIX=#{staging_prefix}",
               "-DCMAKE_OSX_ARCHITECTURES=#{archs}",
               "-DCMAKE_PREFIX_PATH=#{ENV["CMAKE_PREFIX_PATH"]}",
               "-DCMAKE_FIND_FRAMEWORK=NEVER",
               "-DCMAKE_FIND_APPBUNDLE=NEVER",
               "-DENABLE_UNSTABLE_API_ABI_HEADERS=OFF",
               "-DBUILD_GTK_TESTS=OFF",
               "-DBUILD_QT5_TESTS=OFF",
               "-DBUILD_QT6_TESTS=OFF",
               "-DBUILD_CPP_TESTS=OFF",
               "-DBUILD_MANUAL_TESTS=OFF",
               "-DENABLE_BOOST=OFF",
               "-DENABLE_SPLASH=ON",
               "-DENABLE_UTILS=OFF",
               "-DENABLE_CPP=OFF",
               "-DENABLE_GLIB=ON",
               "-DENABLE_GOBJECT_INTROSPECTION=OFF",
               "-DENABLE_GTK_DOC=OFF",
               "-DENABLE_QT5=OFF",
               "-DENABLE_QT6=OFF",
               "-DENABLE_LIBOPENJPEG=none",
               "-DENABLE_DCTDECODER=libjpeg",
               "-DENABLE_CMS=none",
               "-DENABLE_LCMS=OFF",
               "-DENABLE_LIBCURL=OFF",
               "-DENABLE_LIBTIFF=OFF",
               "-DWITH_TIFF=OFF",
               "-DWITH_NSS3=OFF",
               "-DENABLE_NSS3=OFF",
               "-DENABLE_GPGME=OFF",
               "-DENABLE_ZLIB=ON",
               "-DENABLE_ZLIB_UNCOMPRESS=OFF",
               "-DUSE_FLOAT=OFF",
               "-DBUILD_SHARED_LIBS=OFF",
               "-DRUN_GPERF_IF_PRESENT=OFF",
               "-DEXTRA_WARN=OFF",
               "-DWITH_JPEG=ON",
               "-DWITH_PNG=ON",
               "-DWITH_Cairo=ON"
        system "ninja", "install"
      end
    end

    # Build FontForge
    resource("fontforge").stage do
      mkdir "build" do
        # FontForge needs to find the Poppler we just built in staging_prefix
        fontforge_cmake_prefix_path = "#{staging_prefix};#{ENV["CMAKE_PREFIX_PATH"]}"
        system "cmake", "..",
               "-G", "Ninja",
               "-DCMAKE_BUILD_TYPE=Release",
               "-DCMAKE_INSTALL_PREFIX=#{staging_prefix}",
               "-DCMAKE_OSX_ARCHITECTURES=#{archs}",
               "-DCMAKE_PREFIX_PATH=#{fontforge_cmake_prefix_path}",
               "-DCMAKE_FIND_FRAMEWORK=NEVER",
               "-DCMAKE_FIND_APPBUNDLE=NEVER",
               "-DBUILD_SHARED_LIBS=OFF",
               "-DENABLE_GUI=OFF",
               "-DENABLE_X11=OFF",
               "-DENABLE_NATIVE_SCRIPTING=ON",
               "-DENABLE_PYTHON_SCRIPTING=OFF",
               "-DENABLE_PYTHON_EXTENSION=OFF",
               "-DENABLE_LIBSPIRO=OFF",
               "-DENABLE_LIBUNINAMESLIST=OFF",
               "-DENABLE_LIBGIF=OFF",
               "-DENABLE_LIBJPEG=ON",
               "-DENABLE_LIBPNG=ON",
               "-DENABLE_LIBREADLINE=OFF",
               "-DENABLE_LIBTIFF=ON",
               "-DENABLE_WOFF2=OFF",
               "-DENABLE_DOCS=OFF",
               "-DENABLE_CODE_COVERAGE=OFF",
               "-DENABLE_DEBUG_RAW_POINTS=OFF",
               "-DENABLE_FONTFORGE_EXTRAS=OFF",
               "-DENABLE_MAINTAINER_TOOLS=OFF",
               "-DENABLE_TILE_PATH=OFF",
               "-DENABLE_WRITE_PFM=OFF",
               "-DENABLE_SANITIZER=none",
               "-DENABLE_FREETYPE_DEBUGGER=",
               "-DSPHINX_USE_VENV=OFF",
               "-DREAL_TYPE=double",
               "-DTHEME=tango"
        system "ninja", "install"
      end
    end

    # Configure pdf2htmlEX build
    ENV.prepend_path "PKG_CONFIG_PATH", "#{staging_prefix}/lib/pkgconfig"
    # CMAKE_PREFIX_PATH for pdf2htmlEX needs our staging_prefix and the general Homebrew paths
    pdf2htmlex_cmake_prefix_path = "#{staging_prefix};#{ENV["CMAKE_PREFIX_PATH"]}"


    ENV["JAVA_HOME"] = Formula["openjdk"].opt_prefix

    # pdf2htmlEX source is in the root of the buildpath (after url.stage)
    # It has a pdf2htmlEX subdirectory which contains the main CMakeLists.txt
    # The main tarball extracts to pdf2htmlEX-0.18.8.rc1, so cd into that.
    cd buildpath/name do # 'name' is a special var in Homebrew for the extracted dir name
      cd "pdf2htmlEX" do # The actual sources are in a subdirectory
        mkdir "build" do
          system "cmake", "..",
                 "-G", "Ninja",
                 "-DCMAKE_BUILD_TYPE=Release",
                 "-DCMAKE_INSTALL_PREFIX=#{prefix}",
                 "-DCMAKE_OSX_ARCHITECTURES=#{archs}",
                 "-DCMAKE_PREFIX_PATH=#{pdf2htmlex_cmake_prefix_path}",
                 "-DCMAKE_FIND_FRAMEWORK=NEVER",
                 "-DCMAKE_FIND_APPBUNDLE=NEVER"
          system "ninja", "install"
        end
      end
    end
  end

  test do
    (testpath/"test.pdf").write <<~EOS
      %PDF-1.4
      1 0 obj<</Type/Catalog/Pages 2 0 R>>endobj
      2 0 obj<</Type/Pages/Kids[3 0 R]/Count 1>>endobj
      3 0 obj<</Type/Page/MediaBox[0 0 612 792]/Resources<</Font<</F1 4 0 R>>>>/Contents 5 0 R>>endobj
      4 0 obj<</Type/Font/Subtype/Type1/BaseFont/Helvetica>>endobj
      5 0 obj<</Length 100>>stream
      BT /F1 24 Tf 100 700 Td (pdf2htmlEX test) Tj ET
      endstream
      endobj
      xref
      0 6
      0000000000 65535 f
      0000000009 00000 n
      0000000052 00000 n
      0000000101 00000 n
      0000000191 00000 n
      0000000242 00000 n
      trailer<</Size 6/Root 1 0 R>>
      startxref
      357
      %%EOF
    EOS

    system bin/"pdf2htmlEX", testpath/"test.pdf"
    assert_predicate testpath/"test.html", :exist?, "test.html should be created"
    assert_match "pdf2htmlEX test", (testpath/"test.html").read, "Output HTML should contain text from PDF"
    assert_match "pdf2htmlEX", (testpath/"test.html").read, "Output HTML should mention pdf2htmlEX"
  end
end
