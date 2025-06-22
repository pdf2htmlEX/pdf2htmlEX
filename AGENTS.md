
<clitools>
Jules
-------- Python --------
✅ python3: Python 3.12.11
✅ python: Python 3.12.11
✅ pip: pip 25.1.1 from /home/jules/.pyenv/versions/3.12.11/lib/python3.12/site-packages/pip (python 3.12)
✅ pipx: 1.4.3
✅ poetry: Poetry (version 2.1.3)
✅ uv: uv 0.7.13
✅ black: black, 25.1.0 (compiled: yes)
✅ mypy: mypy 1.16.1 (compiled: yes)
✅ pytest: pytest 8.4.0
✅ ruff: ruff 0.12.0
✅ pyenv: available
  system
  3.10.18
  3.12.11 (set by /home/jules/.pyenv/version)

-------- NodeJS --------
✅ node: v22.16.0 *
  v18.20.8 *
  v20.19.2 *
  → v22.16.0 *
  system *
✅ nvm: available
✅ npm: 11.4.2
✅ yarn: 1.22.22
✅ pnpm: 10.12.1
✅ eslint: v9.29.0
✅ prettier: 3.5.3
✅ chromedriver: ChromeDriver 137.0.7151.70
  (dfa4dc56b2ahb56eb2a14cad006ea5e68c60d5de-refs/branch-heads/7151@{#1875})

-------- Java --------
✅ java: openjdk version "21.0.7" 2025-04-15
  OpenJDK Runtime Environment (build 21.0.7+6-Ubuntu-0ubuntu124.04)
  OpenJDK 64-Bit Server VM (build 21.0.7+6-Ubuntu-0ubuntu124.04, mixed mode, sharing)
✅ maven: Apache Maven 3.9.10 (5f519b97e9448438d878815739f519b2eade0a91d)
✅ gradle: Gradle 8.8

-------- Go --------
✅ go: go version go1.24.3 linux/amd64

-------- Rust --------
✅ rustc: rustc 1.87.0 (17067e9ac 2025-05-09)
✅ cargo: cargo 1.87.0 (99624be96 2025-05-06)

-------- C/C++ Compilers --------
✅ clang: Ubuntu clang version 18.1.3 (1ubuntu1)
✅ gcc: gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0
✅ cmake: cmake version 3.28.3
✅ ninja: 1.11.1
✅ conan: Conan version 2.17.0

-------- Docker --------
✅ docker: Docker version 28.2.2, build e6534b4
✅ docker: Docker Compose version v2.36.2

-------- Other Utilities --------
✅ awk: GNU Awk 5.2.1, API 3.2, PMA Avon 8-g1, (GNU MPFR 4.2.1, GNU MP 6.3.0)
✅ curl: curl 8.5.0 (x86_64-pc-linux-gnu) libcurl/8.5.0 OpenSSL/3.0.13 zlib/1.3 brotli/1.1.0 zstd/1.5.5 libidn2/2.3.7 libpsl/0.21.2 (+libidn2/2.3.7) libssh/0.10.6/openssl/zlib nghttp2/1.59.0 librtmp/2.3 OpenLDAP/2.6.7
✅ git: git version 2.49.0
✅ grep: grep (GNU grep) 3.11
✅ gzip: gzip 1.12
✅ jq: jq-1.7
✅ make: GNU Make 4.3
✅ rg: ripgrep 14.1.0
✅ sed: sed (GNU sed) 4.9
✅ tar: tar (GNU tar) 1.35
✅ tmux: tmux 3.4
✅ yq: yq 0.0.0
</clitools>


<tree>
pdf2htmlEX/
├── archive
│   ├── build_for_ppa.py
│   ├── createDebianPackage
│   └── debian
│       ├── changelog
│       ├── compat
│       ├── control
│       ├── copyright
│       ├── dirs
│       ├── pdf2htmlex.NEWS
│       ├── pdf2htmlex.README
│       ├── pdf2htmlex.TODO
│       ├── rules
│       └── source
│           └── format
├── AUTHORS
├── buildScripts
│   ├── buildFontforge
│   ├── buildInstallLocallyAlpine
│   ├── buildInstallLocallyApt
│   ├── buildInstallLocallyDnf
│   ├── buildPdf2htmlEX
│   ├── buildPoppler
│   ├── createAlpineTarFile
│   ├── createAppImage
│   ├── createContainerAlpineImageFromTarFile
│   ├── createContainerUbuntuImageFromDeb
│   ├── createDebianPackage
│   ├── createImagesAlpine
│   ├── createImagesApt
│   ├── getBuildToolsAlpine
│   ├── getBuildToolsApt
│   ├── getBuildToolsDnf
│   ├── getDevLibrariesAlpine
│   ├── getDevLibrariesApt
│   ├── getDevLibrariesDnf
│   ├── getFontforge
│   ├── getPoppler
│   ├── installPdf2htmlEX
│   ├── listFilesByChangeTime
│   ├── PKGBUILD
│   ├── Readme.md
│   ├── reportEnvs
│   ├── runTests
│   ├── travisLinuxDoItAll
│   ├── uploadContainerImage
│   ├── uploadGitHubRelease
│   ├── uploadGitHubReleaseDSL
│   ├── uploadGitHubReleaseMessage
│   ├── uploadImages
│   └── versionEnvs
├── ChangeLog
├── CONTRIBUTING.md
├── INSTALL
├── LICENSE
├── LICENSE_GPLv3
├── patches
│   ├── fontforge-20170731-fixGDraw.patch
│   └── fontforge-20170731-fixGitVersion.patch
├── pdf2htmlEX
│   ├── 3rdparty
│   │   ├── closure-compiler
│   │   │   ├── compiler.jar
│   │   │   ├── COPYING
│   │   │   └── README
│   │   ├── PDF.js
│   │   │   ├── build.sh
│   │   │   ├── compatibility.js
│   │   │   ├── compatibility.min.js
│   │   │   └── LICENSE
│   │   └── yuicompressor
│   │       ├── LICENSE.TXT
│   │       └── yuicompressor-2.4.8.jar
│   ├── CMakeLists.txt
│   ├── logo
│   │   ├── design.svg
│   │   ├── LICENSE
│   │   ├── LICENSE_CC-BY-3.0
│   │   ├── notes.txt
│   │   ├── pdf2htmlEX-256x256.png
│   │   ├── pdf2htmlEX-64x64.png
│   │   ├── pdf2htmlEX.svg
│   │   └── update_png.sh
│   ├── pdf2htmlEX.1.in
│   ├── share
│   │   ├── base.css.in
│   │   ├── build_css.sh
│   │   ├── build_js.sh
│   │   ├── fancy.css.in
│   │   ├── LICENSE
│   │   ├── manifest
│   │   ├── pdf2htmlEX-64x64.png
│   │   └── pdf2htmlEX.js.in
│   ├── src
│   │   ├── ArgParser.cc
│   │   ├── ArgParser.h
│   │   ├── BackgroundRenderer
│   │   │   ├── BackgroundRenderer.cc
│   │   │   ├── BackgroundRenderer.h
│   │   │   ├── CairoBackgroundRenderer.cc
│   │   │   ├── CairoBackgroundRenderer.h
│   │   │   ├── SplashBackgroundRenderer.cc
│   │   │   └── SplashBackgroundRenderer.h
│   │   ├── Base64Stream.cc
│   │   ├── Base64Stream.h
│   │   ├── Color.cc
│   │   ├── Color.h
│   │   ├── CoveredTextDetector.cc
│   │   ├── CoveredTextDetector.h
│   │   ├── css_class_names.cmakelists.txt
│   │   ├── DrawingTracer.cc
│   │   ├── DrawingTracer.h
│   │   ├── HTMLRenderer
│   │   │   ├── draw.cc
│   │   │   ├── font.cc
│   │   │   ├── form.cc
│   │   │   ├── general.cc
│   │   │   ├── HTMLRenderer.h
│   │   │   ├── image.cc
│   │   │   ├── link.cc
│   │   │   ├── outline.cc
│   │   │   ├── state.cc
│   │   │   └── text.cc
│   │   ├── HTMLState.h
│   │   ├── HTMLTextLine.cc
│   │   ├── HTMLTextLine.h
│   │   ├── HTMLTextPage.cc
│   │   ├── HTMLTextPage.h
│   │   ├── Param.h
│   │   ├── pdf2htmlEX-config.h.in
│   │   ├── pdf2htmlEX.cc
│   │   ├── Preprocessor.cc
│   │   ├── Preprocessor.h
│   │   ├── StateManager.h
│   │   ├── StringFormatter.cc
│   │   ├── StringFormatter.h
│   │   ├── TmpFiles.cc
│   │   ├── TmpFiles.h
│   │   └── util
│   │       ├── const.cc
│   │       ├── const.h
│   │       ├── css_const.h.in
│   │       ├── encoding.cc
│   │       ├── encoding.h
│   │       ├── ffw.c
│   │       ├── ffw.h
│   │       ├── math.cc
│   │       ├── math.h
│   │       ├── mingw.cc
│   │       ├── mingw.h
│   │       ├── misc.cc
│   │       ├── misc.h
│   │       ├── namespace.h
│   │       ├── path.cc
│   │       ├── path.h
│   │       ├── SignalHandler.cc
│   │       ├── SignalHandler.h
│   │       ├── unicode.cc
│   │       └── unicode.h
│   └── test
│       ├── browser_tests
│       │   ├── basic_text
│       │   │   └── basic_text.html
│       │   ├── basic_text.pdf
│       │   ├── basic_text.tex
│       │   ├── fontfile3_opentype
│       │   │   └── fontfile3_opentype.html
│       │   ├── fontfile3_opentype.pdf
│       │   ├── geneve_1564
│       │   │   └── geneve_1564.html
│       │   ├── geneve_1564.pdf
│       │   ├── invalid_unicode_issue477
│       │   │   └── invalid_unicode_issue477.html
│       │   ├── invalid_unicode_issue477.pdf
│       │   ├── svg_background_with_page_rotation_issue402
│       │   │   └── svg_background_with_page_rotation_issue402.html
│       │   ├── svg_background_with_page_rotation_issue402.pdf
│       │   ├── test_fail
│       │   │   └── THIS_FOLDER_SHOULD_BE_EMPTY
│       │   ├── test_fail.pdf
│       │   ├── test_fail.tex
│       │   ├── text_visibility
│       │   │   └── text_visibility.html
│       │   ├── text_visibility.pdf
│       │   ├── with_form
│       │   │   └── with_form.html
│       │   └── with_form.pdf
│       ├── browser_tests.py
│       ├── compareTestImages
│       ├── fancy.min.css
│       ├── installAutomaticTestSoftwareApt
│       ├── installAutomaticTestSoftwareDnf
│       ├── installManualTestSoftware
│       ├── old
│       │   ├── convert_to_woff.fontforge
│       │   └── test.py
│       ├── produceHtmlForBrowserTests
│       ├── README.md
│       ├── regenerateTest
│       ├── runLocalBrowserTests
│       ├── runLocalTestsPython
│       ├── runLocalTestsShell
│       ├── test_local_browser.py
│       ├── test_output
│       │   ├── 1-page.pdf
│       │   ├── 2-pages.pdf
│       │   ├── 3-pages.pdf
│       │   └── issue501
│       ├── test_output.py
│       ├── test_remote_browser.py
│       ├── test.py.in
│       └── testOutput
├── PopplerReleases.md
├── README.md
└── TODO

29 directories, 187 files
</tree>

<ref>

# Building pdf2htmlEX

Because of its intimate use of *specific* versions of both 
[Poppler](https://poppler.freedesktop.org/) and 
[FontForge](https://fontforge.org/en-US/),
cleanly building `pdf2htmlEX` is rather more complex than 
normal. 

The (shell) scripts in the [`buildScripts` directory](https://github.com/pdf2htmlEX/pdf2htmlEX/tree/master/buildScripts) help automate this mutli-stage process. 

For all but the most experienced programmers, we *strongly* encourage you 
to use these scripts to build `pdf2htmlEX`. 

### [∞](#downloading-precompiled-versions) Downloading precompiled versions

For most users, you *probably really want to simply* download one of the 
[precompiled versions of 
`pdf2htmlEX`](https://github.com/pdf2htmlEX/pdf2htmlEX/releases): 

- As a [Debian archive](Download-Debian-Archive)
- As an [Alpine tar archive](Download-Alpine-Tar-Archive)
- As an [AppImage](Download-AppImage)
- As a [Docker image](Download-Docker-Image)

# Environment

pdf2htmlEX can be built in any Unix-like environment:
* **GNU/Linux:**
  `pdf2htmlEX` is currently built and released inside Ubuntu
  (Bionic, Eoan, and Focal), Alpine 3.12 docker containers,
  as well as Ubuntu-Bionic on Travis, so `pdf2htmlEX` is
  *known* to build on any Debian based distribution.

  The current `buildScripts` assume the use of either `apt` 
  (Debian) or `apk` (Alpine) for (automatic) installation of
  all required dependencies. These scripts should be easily 
  modified for other distributions.
* **macOS**:
  While it should in principle be possible to build on macOS,
  unfortunately we currently have no access to a development/testing
  environment with which to ensure the `buildScripts` are
  adequately tuned to build on macOS.

  **NOTE** that the existing [`homebrew`](https://brew.sh/)
  [build script](https://github.com/Homebrew/homebrew-core/blob/master/Formula/pdf2htmlex.rb)
  is *not* up to date and will fail.

  *Offers of help and/or temporary access to development/testing
  machines would be greatly appreciated.*

* **Windows 10 with the [Windows Subsystem
  for Linux](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux)**:

  The Debian(Apt) versions of our build scripts should build `pdf2htmlEX` (untested).

  The AppImage or Debian archive binary release objects *are* reputed to work.

* **Android**: Have a look at [Vilius Sutkus](https://github.com/ViliusSutkus89)'s [pdf2htmlEX-Android](https://github.com/ViliusSutkus89/pdf2htmlEX-Android).

# Building yourself

To build `pdf2htmlEX` on a Debian/Apt related machine, inside the root 
directory of a fresh clone of the 
[pdf2htmlEX/pdf2htmlEX](https://github.com/pdf2htmlEX/pdf2htmlEX) 
repository, type: 

```
    ./buildScripts/buildInstallLocallyApt
```

This will automatically install all required development tools and 
libraries, and then proceed to download and statically compile the 
required versions of both Poppler and FontForge before compiling and 
installing `pdf2htmlEX` into `/usr/local/bin`. 

**NOTE:** at the moment this will **only** work on machines with a 
[Debian](https://www.debian.org/) based distribution. such as 
[Ubuntu](https://ubuntu.com/), [Linux Mint](https://linuxmint.com/), etc. 

**NOTE:** there is currently an *experimental* build script, 
`./buildScripts/buildInstallLocallyAlpine`, for builds in Alpine 
environments. 

## [∞](#dependencies) Dependencies

The definitive list of build dependencies can be found in the following scripts:

1. [getBuildToolsAlpine](https://github.com/pdf2htmlEX/pdf2htmlEX/blob/master/buildScripts/getBuildToolsAlpine) for Alpine Linux
2. [getBuildToolsApt](https://github.com/pdf2htmlEX/pdf2htmlEX/blob/master/buildScripts/getBuildToolsApt) for Debian based systems
3. [getDevLibrariesAlpine](https://github.com/pdf2htmlEX/pdf2htmlEX/blob/master/buildScripts/getBuildToolsAlpine) for Alpine Linux
4. [getDevLibrariesApt](https://github.com/pdf2htmlEX/pdf2htmlEX/blob/master/buildScripts/getBuildToolsApt) for Debian based systems

## [∞](#build-options) Build options

To build `pdf2htmlEX` you require static versions of the Poppler and FontForge libraries in specific 'well-known' locations.

An automatic build uses `cmake` to build all of Poppler, FontForge and `pdf2htmlEX`.

The definitive list of cmake build options can be found in the following scripts:

1. [buildFontforge](https://github.com/pdf2htmlEX/pdf2htmlEX/blob/master/buildScripts/buildFontforge)
2. [buildPdf2htmlEX](https://github.com/pdf2htmlEX/pdf2htmlEX/blob/master/buildScripts/buildPdf2htmlEX)
3. [buildPoppler](https://github.com/pdf2htmlEX/pdf2htmlEX/blob/master/buildScripts/buildPoppler)

# Why such a complex build system?

## [∞](#the-problem) The problem

To provide its full functionality, the `pdf2htmlEX` sources make direct 
use of source code and unexposed methods from both the Poppler and 
FontForge projects. Unfortunately the source code in the Poppler and 
FontForge projects that the `pdf2htmlEX` uses changes regularly.

This means that the `pdf2htmlEX` souce code *must* be updated regularly to 
match *specific releases* of both Poppler and FontForge. 

Unfortunately, the installed versions of both Poppler and FontForge in 
most Linux distributions, lag the official releases of both of these 
projects. Even worse few distributions install the same versions.

This means that it is nearly impossible for the `pdf2htmlEX` code to 
'predict' which version of Poppler or FontForge will be installed on a 
given user's machine. 

## [∞](#our-solution) Our solution

While we *could* keep multiple versions of the `pdf2htmlEX` source code, 
each version matched to a particular distribution's installed versions of 
Poppler and FontForge, this would be a logistic and testing 'nightmare'. 

Instead, when building `pdf2htmlEX`, we download specific versions of both 
the Poppler and FontForge sources (usually the most recent), and then 
compile *static* versions of the Poppler and FontForge libraries which are 
then *statically* linked into the `pdf2htmlEX` binary. 

This means that the `pdf2htmlEX` binary is completely independent of any 
locally installed versions of either Poppler or FontForge.

However, to get the matched versions of Poppler and FontForge and then 
compile them statically, *our* build process becomes much more complex 
than a "simple", `configure, make, make install` cycle. 

Hence there are a large number of shell scripts in the [`buildScripts`
directory](https://github.com/pdf2htmlEX/pdf2htmlEX/tree/master/buildScripts)
each of which automates one 'simple' step in the overall build process. 

## [∞](#) 
</ref>

1. **Explore the project** – analyse the `buildScripts` directory to extract the exact Poppler & FontForge versions and build flags that `pdf2htmlEX` expects.

2. **Map every Linux‑centric step to macOS/Homebrew equivalents** – work out which bits can reuse existing Homebrew formulae (`poppler`, `fontforge`, etc.) and where private “resource” blocks are required.

3. **Prototype a clean, reproducible universal build** – script two native builds (arm64 and x86_64) under Homebrew and merge them with `lipo`, or use CMake’s `CMAKE_OSX_ARCHITECTURES="x86_64;arm64"` where feasible.

4. **Author a modern Formula (`pdf2htmlex.rb`) inside a new tap** created with `brew tap‑new`, add an automated test block, then run `brew audit --strict --new-formula` until it is clean.
5. **Bottle and publish** – use `brew install --build-bottle`, `brew bottle`, commit bottles, and set up a GitHub Actions workflow that pushes updates whenever the upstream tag or Poppler/FontForge revisions change.

The detailed play‑book follows.

---

## [∞](#1set-up-the-local-research-environment) 1 – Set up the local research environment

### [∞](#11-spawn-fresh-macos-runners) 1.1 Spawn fresh macOS runners

- Use `brew doctor && brew update --force --quiet` to ensure the host is pristine.
- Install Rosetta 2 on Apple Silicon if you plan to run Intel‐only tools during the analysis phase. ([formulae.brew.sh][1])

### [∞](#12-fetch-sources-and-history) 1.2 Fetch sources and history

```bash
git clone https://github.com/pdf2htmlEX/pdf2htmlEX
cd pdf2htmlEX
git submodule update --init --recursive
```

- Keep the clone handy so the assistant can run static analysis tools (`clang‑tidy`, `ruff`, `mypy`, etc.).

### [∞](#13-inventory-all-build-helpers) 1.3 Inventory all build helpers

Run a Python one‑liner that walks `buildScripts/` and prints every `build*`, `get*` and `create*` script; this seeds a to‑do list for porting.

```python
import pathlib, re, itertools, textwrap, shutil
...
```

Use **Python 3.12**, `rich` for pretty tables, and `ruff` → `black` for autofixing generated helper scripts, matching Adam’s coding standards.

---

## [∞](#2reverseengineer-the-exact-dependency-stack) 2 – Reverse‑engineer the exact dependency stack

### [∞](#21-parse-buildscripts-for-hardcoded-versions) 2.1 Parse buildScripts for hard‑coded versions

- `buildPoppler`, `buildFontforge`, `versionEnvs` hold authoritative `POPPLER_VERSION` and `FONTFORGE_VERSION` variables.
- Capture them into a JSON manifest so later steps can compare with the latest Homebrew core versions (`poppler` is updated almost weekly ([formulae.brew.sh][2]), `fontforge` monthly ([formulae.brew.sh][3])).

### [∞](#22-decide-system-formula-vs-vendored-resource) 2.2 Decide: system formula vs vendored resource

- If upstream’s required Poppler/FontForge tags **match** Homebrew, reuse the core formulae and declare them as `depends_on "poppler"` / `depends_on "fontforge"`.
- If they differ, create **resource** blocks that fetch and build the frozen revisions exactly as the Linux scripts do. The old, removed formula (see 2018 commit 995cc7e ([trac.macports.org][4])) is a useful template for embedding those resources.

### [∞](#23-identify-auxiliary-runtime-deps) 2.3 Identify auxiliary runtime deps

Look through `getBuildToolsApt` and map each Debian package to its Homebrew analogue (e.g. `pkg-config`, `glib`, `cairo`, `libpng`, `jpeg`, etc.).

---

## [∞](#3craft-a-universal-build-that-works-on-both-cpus) 3 – Craft a universal build that works on both CPUs

### [∞](#31-straightforward-route-single-cmake-pass) 3.1 Straightforward route: single CMake pass

- Invoke CMake with

  ```bash
  cmake -B build -G Ninja \
        -DCMAKE_OSX_ARCHITECTURES="x86_64;arm64" \
        -DENABLE_UNIVERSAL_BINARY=ON
  ```

  This matches Apple’s guidance on Universal 2 binaries ([developer.apple.com][5]).

- If CMake chokes on dual‑arch static libs (common with Poppler), fall back to **two separate builds** and stitch the resulting binaries with `lipo -create` ([github.com][6]).

### [∞](#32-stresstest) 3.2 Stress‑test

- Run `pdf2htmlEX --version` and convert a small PDF on both host architectures under Rosetta to verify the binary really is fat.
- Optional: push sample PDFs through the upstream Python test‑suite in `test/runLocalTestsPython`.

---

## [∞](#4write-the-homebrew-formula-skeleton) 4 – Write the Homebrew formula skeleton

### [∞](#41-bootstrap-a-tap) 4.1 Bootstrap a tap

```bash
brew tap-new yourname/pdf2htmlex
cd $(brew --repository yourname/pdf2htmlex)
```

Template files are generated for you ([docs.brew.sh][7]).

### [∞](#42-use-brew-create---tap-yournamepdf2htmlex-tarball-to-generate-formulapdf2htmlexrb-then-handedit) 4.2 Use `brew create --tap yourname/pdf2htmlex <tarball>` to generate `Formula/pdf2htmlex.rb`, then hand‑edit:

- **desc**, **homepage**, **url**, **sha256** → pull from the latest GitHub release ([github.com][8]).
- **license** `"GPL-3.0-or-later"` (see upstream `LICENSE_GPLv3`).
- **depends_on** system libraries or resource blocks from § 2.
- **def install**

  ```ruby
  system "cmake", "-S", ".", "-B", "build",
         *std_cmake_args, "-DCMAKE_OSX_ARCHITECTURES=#{Hardware::CPU.universal_archs.join(";")}"
  system "cmake", "--build", "build"
  bin.install "build/pdf2htmlEX"
  ```

- Add `test do` that converts a one‑page PDF and checks the HTML contains the word “pdf2htmlEX”.

### [∞](#43-lint--audit) 4.3 Lint & audit

Run

```bash
brew audit --strict --new-formula Formula/pdf2htmlex.rb
brew install --build-from-source pdf2htmlex
```

until both succeed without warnings ([docs.brew.sh][9]).

---

## [∞](#5bottle-and-distribute) 5 – Bottle and distribute

### [∞](#51-build-bottles) 5.1 Build bottles

```bash
brew install --build-bottle pdf2htmlex
brew bottle pdf2htmlex
```

This emits `.tar.gz` bottles for each arch that Homebrew will later pour.

### [∞](#52-commit-bottles--update-formula) 5.2 Commit bottles & update formula

Follow the canonical bottle‑commit flow: add the `sha256 cellar:` lines to `pdf2htmlex.rb`, push, and tag a release on your tap.

### [∞](#53-continuous-delivery) 5.3 Continuous delivery

Create a **GitHub Actions** workflow (`macos‑latest`, `runs-on: macos-14`) that:

1. Checks out both `pdf2htmlEX` and the tap.
2. Re‑evaluates § 2 for new Poppler/FontForge tags weekly.
3. Re‑builds, bottles, and opens a PR against the tap if anything changed.
4. Runs `brew test-bot` to ensure arm64 & x86_64 stay green.

---

## [∞](#6validation-matrix) 6 – Validation matrix

| Step                      | Intel host | Apple Silicon host | CI (GitHub) |
| ------------------------- | ---------- | ------------------ | ----------- |
| `brew install pdf2htmlex` | ✅         | ✅ (native)        | ✅          |
| Convert PDF smoke‑test    | ✅         | ✅                 | ✅          |
| `brew audit` clean        | ✅         | ✅                 | ✅          |
| Bottle pouring            | ✅         | ✅                 | ✅          |

---

## [∞](#7pointers--references-for-the-assistant) 7 – Pointers & references for the assistant

- Upstream maintainers acknowledge the current Homebrew formula is stale ([github.com][10]) and users on macOS are currently blocked ([github.com][10]).
- The old Homebrew formula (removed in 2018) shows how resources were vendored ([trac.macports.org][4]).
- Homebrew documentation on taps ([docs.brew.sh][11]), formula‑cookbook ([docs.brew.sh][9]), acceptable formula rules ([docs.brew.sh][12]).
- Poppler ([formulae.brew.sh][2]) and FontForge ([formulae.brew.sh][3]) current formulae.
- Apple guidance on universal binaries ([developer.apple.com][5]).
- Community discussion about multi‑arch Homebrew builds ([github.com][6]).

Hand the plan above to your LLM assistant; it now has a **clear, tool‑by‑tool blueprint** to analyse the codebase, adapt the build for macOS, and publish a modern Homebrew tap that “just works” on both chips.

[1]: https://formulae.brew.sh/cask/fontforge?utm_source=chatgpt.com 'fontforge - Homebrew Formulae'
[2]: https://formulae.brew.sh/formula/poppler?utm_source=chatgpt.com 'poppler - Homebrew Formulae'
[3]: https://formulae.brew.sh/formula/fontforge?utm_source=chatgpt.com 'fontforge - Homebrew Formulae'
[4]: https://trac.macports.org/ticket/56803?utm_source=chatgpt.com "56803 (pdf2htmlex @0.11: doesn't build) - MacPorts"
[5]: https://developer.apple.com/documentation/apple-silicon/building-a-universal-macos-binary?utm_source=chatgpt.com 'Building a universal macOS binary | Apple Developer Documentation'
[6]: https://github.com/orgs/Homebrew/discussions/4985?utm_source=chatgpt.com 'Installing a Universal 2 binary · Homebrew · Discussion #4985'
[7]: https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap?utm_source=chatgpt.com 'How to Create and Maintain a Tap - Homebrew Documentation'
[8]: https://github.com/pdf2htmlEX?utm_source=chatgpt.com 'pdf2htmlEX - GitHub'
[9]: https://docs.brew.sh/Formula-Cookbook?utm_source=chatgpt.com 'Formula Cookbook - Homebrew Documentation'
[10]: https://github.com/pdf2htmlEX/pdf2htmlEX/issues/159?utm_source=chatgpt.com 'how to install on macos · Issue #159 · pdf2htmlEX ... - GitHub'
[11]: https://docs.brew.sh/Taps?utm_source=chatgpt.com 'Taps (Third-Party Repositories) - Homebrew Documentation'
[12]: https://docs.brew.sh/Acceptable-Formulae?utm_source=chatgpt.com 'Acceptable Formulae - Homebrew Documentation'
