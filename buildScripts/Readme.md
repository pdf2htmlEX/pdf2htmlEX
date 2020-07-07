# Building pdf2htmlEX

Because of its intimate use of *specific* versions of both Poppler and 
FontForge, cleanly building `pdf2htmlEX` is rather more complex than 
normal. 

The (shell) scripts in this directory help automate this mutli-stage 
process. 

For all but the most experienced programmers, we *strongly* encourage you 
to use these scripts to build `pdf2htmlEX`. 

---

**Table of contents**

- [TL;DR ...](#tldr-)
  - [Downloading precompiled versions](#downloading-precompiled-versions-downloads)
  - [Building yourself](#building-yourself)
- [The problem](#the-problem)
- [Our solution](#our-solution)
- [The gory details ...](#the-gory-details-)
  - [Top-level scripts](#top-level-scripts)
  - [Individual steps](#individual-steps)
  - [Helper files and scripts](#helper-files-and-scripts)
- [Yet more details?](#yet-more-details)

---

## TL;DR ...

### Downloading precompiled versions

For most users, you probably really want to simply download one of the 
[precompiled versions of 
`pdf2htmlEX`](https://github.com/pdf2htmlEX/pdf2htmlEX/releases): 

- [Debian archive](https://en.wikipedia.org/wiki/Dpkg) : Download, 
  [apt](https://en.wikipedia.org/wiki/APT_(software)) install locally, 
  and run... 

  This will work on any [Debian](https://www.debian.org/) based and most 
  recent Windows 10 machines. 

  Experienced users of Linux, may be able to repackage the `*.deb` we 
  provide for use with their favourite package management tool. 

- [AppImage](https://appimage.org/) : Download, make executable, and 
  run... 

  This will work on most Linuxes, and most recent Windows 10.
  
  (It will not currently work on MacOS or Alpine based machines).

- [OCI](https://opencontainers.org/) Image from the [`pdf2htmlEX` Docker 
  hub](https://hub.docker.com/orgs/pdf2htmlex/repositories). 

  This will work on any machine with an OCI Container system (such as 
  Docker, Podman, CRI-O, Kubernetes) installed. 

  (Note: that *advanced* use of `pdf2htmlEX` requires careful attention to 
  the configuration of various tools, such as fontconfig, iconv and your 
  locally available fonts use by the poppler and fontforge libraries. The 
  OCI container images created by the pdf2htmlEX team might not be as well 
  configured for *your needs* as an OCI container created and configured 
  by you) 

### Building yourself

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
installing `pdf2htmlEX` into /usr/local/bin. 

**NOTE:** at the moment this will **only** work on machines with a 
[Debian](https://www.debian.org/) based distribution. such as 
[Ubuntu](https://ubuntu.com/), [Linux Mint](https://linuxmint.com/), etc. 

**NOTE:** there is currently an *experimental* build script, 
`./buildScripts/buildInstallLocallyAlpine`, for builds in Alpine 
environments. 

## The problem

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

## Our solution

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

Hence this directory has a large number of shell scripts each of which 
automate one simple step in the overall our build process. 

## The gory details ...

The shell scripts in this directory automate the download, build, install, 
test and upload steps required to provide a complete build/test/release 
cycle of `pdf2htmlEX`. 

Each script can be used individually to re-run a particular step if needed.

### Top-level scripts

Typically, most users, will run one of the following "top-level" scripts: 

1. **`buildInstallLocallyApt`** (**`buildInstallLocallyAlpine`**)

   This will automate:

     1. the installation of all required development tools 
        and libraries,
  
     2. download and statically compile the required versions of both 
        Poppler and FontForge, 

     3. compile and install `pdf2htmlEX`.

   The `*Apt` script will build on any machine which uses the 
   `apt`/`apt-get` command. 

   The `*Alpine` script will build on any machine which uses the 
   `apk` command (Alpine). 

2. **`createImagesApt`** (**`createImagesAlpine`**)

   Following a successful `buildInstallLocallyApt`, the `createImagesApt` 
   shell script will create the following images: 

     1. AppImage

     2. OCI Container image

     3. Debian archive

   Following a successful `buildInstallLocallyAlpine`, the 
   `createImagesAlpine` shell script will create the following images: 

     1. Alpine tar file

     2. OCI Container image

3. **`runTests`**

   Following a successful `buildInstallLocallyApt` (or 
   `buildInstallLocallyAlpine` ), the `runTests` shell script will run the 
   various 'local' tests reporting errors as they occur. 

   When run in [Travis-ci](https://travis-ci.org/), failing browser tests 
   will *not* fail the overall Travis build, but will instead upload the 
   test results to the GitHub Release page for later review. 

4. **`uploadImages`**

   Following successful `buildInstallLocally`, `createImages` and 
   `runTests`, this will automate the upload of the various artefacts to 
   the `pdf2htmlEX` releases page, and docker hub repository. 

   **Note** that this step requires the user to enter passwords for each 
   of the respective services. *Most* users will not need (or be able) to 
   run this step. 

5. **`travisLinuxDoItAll`**

   This script is used by the `.travis.yml` configuration to build, test 
   and upload a complete `pdf2htmlEX` release cycle. It is essentially a 
   compendium of all of the build scripts in the correct order. 

### Individual steps

- **`buildFontforge`**: Compiles a *static* version of `libfontforge` for 
  use by `pdf2htmlEX`.

  Statically linking `libfontforge` into `phd2htmlEX` ensures that any 
  versions of FontForge already installed by the user, are not broken by 
  the user's installation of `pdf2htmlEX`. 

- **`buildPdf2htmlEX`**: Compiles and links `pdf2htmlEX`. 

- **`buildPoppler`**: Compiles a *static* version of `libpoppler` and 
  `libpopper-glib` for use by `pdf2htmlEX`. 

  Statically linking `libpoppler` and `libpoppler-glib` into `phd2htmlEX` 
  ensures that any versions of Poppler already installed by the user, are 
  not broken by the user's installation of `pdf2htmlEX`. 

- **`createAlpineTarFile`**: Using an already compiled version of `pdf2htmlEX`, 
  installs it and `popper-data` into a tar file suitable for use in any 
  Alpine environment. 

- **`createAppImage`**: Using an already compiled version of `pdf2htmlEX`, 
  installs it and `popper-data` into an AppImage.

- **`createDebianPackage`**: Using an already compiled version of 
  `pdf2htmlEX`, installs it and `poppler-data` into a Debian archive 
  (`*.deb`). 

- **`createContainerAlpineImageFromTarFile`**: Installs the Alpine tar file 
  archive of `pdf2htmlEX` created by `createAlpineTarFile` into an Alpine 
  Container. 

- **`createContainerUbuntuImageFromDeb`**: Installs the Debian archive of 
  `pdf2htmlEX` created by `createDebianPackage` into a Container. 

- **`getBuildToolsAlpine`**: Locally `apk` installs all development 
  *tools* required to build `pdf2htmlEX`. 

- **`getBuildToolsApt`**: Locally `apt` installs all development *tools* 
  required to build `pdf2htmlEX`. 

- **`getDevLibrariesAlpine`**: Locally `apk` installs all development 
  *libraries* required to build `pdf2htmlEX`.

- **`getDevLibrariesApt`**: Locally `apt` installs all development 
  *libraries* required to build `pdf2htmlEX`.

  This script provides a definitive list of all libraries required to run 
  `pdf2htmlEX`. 

  This script provides a definitive list of all libraries required to run 
  `pdf2htmlEX`. 

- **`getFontforge`**: Downloads and unpacks the version of FontForge specified in the 
  `FONTFORGE_VERSION` environment variable into the 
  `pdf2htmlEX/fontoforge` directory.

  The `FONTFORGE_VERSION` variable is specified in the `versionEnvs` 
  script. 

- **`getPoppler`**:  Downloads and unpacks the version of Poppler specified in the 
  `POPPLER_VERSION` environment variable into the `pdf2htmlEX/poppler` 
  directory.

  The `POPPLER_VERSION` variable is specified in the `versionEnvs` script. 

  The `getPoppler` script also downloads and unpacks the most recent 
  version of `poppler-data`. Since `poppler-data` does not change very 
  often, the correct version of `poppler-data` is specified in the 
  `getPoppler` script itself. 

- **`installPdf2htmlEX`**: Installs an already compiled version of 
  `pdf2htmlEX` and `poppler-data` into the location specified by the 
  `PDF2HTMLEX_PREFIX` environment variable.

  The `PDF2HTMLEX_PREFIX` variable is specified in the `versionEnvs` 
  script. 

- **`runTests`**: Runs the tests located in the 
  `pdf2htmlEX/pdf2htmlEX/test` directory. See the 
  `pdf2htmlEX/pdf2htmlEx/test` directory's Readme file for details. 

- **`uploadContainerImage`**: Upload the `pdf2htmlEX` Container image to 
  Docker hub repository associated to the docker hub users specified in 
  the `DOCKER_HUB_USERNAME` environement variable.

  Unless the `DOCKER_HUB_USERNAME` and `DOCKER_HUB_PASSWORD` environment 
  variables are pre-defined, this script will prompt the user for the 
  respective values. 

- **`uploadGitHubRelease`**: Upload the `pdf2htmlEX` artefacts (AppImage, 
  Debian archive, test results, etc) to the *continuous* section of the 
  release page associated with the `TRAVIS_REPO_SLUG` (user/project) 
  environment variable.

  Unless the `GITHUB_USERNAME`, `GITHUB_TOKEN`, and `TRAVIS_REPO_SLUG` 
  (user/project) environment variables are pre-defined, this script will 
  prompt the user for the respective values. 

### Helper files and scripts

- **`versionEnvs`**: Specifies all of the evnironment variables required 
  for a standard build of `pdf2htmlEX`. Changes in this script effect 
  *all* of the other build scripts. 

- **`reSourceVersionEnvs`**: This shell script is automatically generated 
  by the build scripts as they are run. It records the values of all 
  important environment variables required by the buildScripts. It is 
  typcically `source`d by each script before it preforms any actions. 

- **`reportEnvs`**: Echos all important enviroment variables to the 
  console. This script is used by the top-level scripts to ensure the 
  current environment variables are listed before each build. 

- **`uploadGitHubReleaseDSL`**: A collection of shell functions used by the 
  `uploadGitHubRelease` script to automate the upload of release artefacts.

- **`uploadGitHubReleaseMessage`**: The contents of this *text* file is 
  used by the `uploadGitHubRelease` script as the contents of the release 
  message, as visible to the user, for the 'continuous' release section. 

- **`listFilesByChangeTime`**: A simple shell script which lists the files 
  in the buildScripts directory by most recently changed files first. 

- **`Readme.md`**: This read me file.

## Yet more details?

The various shell script files are meant to be fairly readable. They 
contain additional comments about what each step is meant to be doing. 

