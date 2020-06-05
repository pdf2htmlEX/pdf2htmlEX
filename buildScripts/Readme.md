# Building pdf2htmlEX

Because of its intimate use of *specific* versions of both Poppler and 
FontForge, cleanly building `pdf2htmlEX` is rather more complex than 
normal. 

The (bash) scripts in this directory help automate this mutli-stage 
process. 

For all but the most experienced programmers, we *strongly* encourage you 
to use these scripts to build `pdf2htmlEX`. 

---

**Table of contents**

- [TL;DR ...](#tldr-)
  - [Downloading precompiled versions](#downloading-precompiled-versions-downloads)
  - [Building yourself](#building-yourself)
- [The gory details ...](#the-gory-details-)
  - [Top-level scripts](#top-level-scripts)
  - [Individual steps](#individual-steps)
  - [Helper files and scripts](#helper-files-and-scripts)
- [Yet more details?](#yet-more-details)

---

## TL;DR ...

### Downloading precompiled versions {#Downloads}

For most users, you probably really want to simply download one of the 
[precompiled versions of 
`pdf2htmlEX`](https://github.com/pdf2htmlEX/pdf2htmlEX/releases): 

- [AppImage](https://appimage.org/) : Download, make executable, and 
  run... 

  This will work on most Linuxes, and most recent Windows 10.

- [Docker](https://www.docker.com/) Image from the [`pdf2htmlEX` Docker 
  hub](https://hub.docker.com/orgs/pdf2htmlex/repositories). 

  This will work on any machine with Docker installed.

- [Debian archive](https://en.wikipedia.org/wiki/Dpkg) : Download, 
  [apt](https://en.wikipedia.org/wiki/APT_(software)) install locally, 
  and run... 

  This will work on any [Debian](https://www.debian.org/) based and most 
  recent Windows 10 machines. 

  Experienced users of Linux, may be able to repackage this `*.deb` for 
  use with their favourite package management tool. 

### Building yourself

To build `pdf2htmlEX` on your own machine, inside the root directory of 
a fresh clone of the 
[pdf2htmlEX/pdf2htmlEX](https://github.com/pdf2htmlEX/pdf2htmlEX) 
repository, type: 

```
    ./buildScripts/buildInstallLocally
```

This will automatically install all required development tools and 
libraries, and then proceed to download and statically compile the 
required versions of both Poppler and FontForge before compiling and 
installing `pdf2htmlEX` into /usr/local/bin. 

**NOTE:** at the moment this will **only** work on machines with a 
[Debian](https://www.debian.org/) based distribution. such as 
[Ubuntu](https://ubuntu.com/), [Linux Mint](https://linuxmint.com/), etc. 

## The gory details ...

The bash scripts in this directory automate the download, build, install, 
test and upload steps required to provide a complete build/test/release 
cycle of `pdf2htmlEX`. 

Each script can be used individually to re-run a particular step if needed.

### Top-level scripts

Typically, most users, will run one of the following "top-level" scripts: 

1. **`buildInstallLocally`**

   This will automate:

     1. the installation of all required development tools 
        and libraries,
  
     2. download and statically compile the required versions of both 
        Poppler and FontForge, 

     3. compile and install `pdf2htmlEX`.

2. **`createImages`**

   Following a successful `buildInstallLocally`, this will create the 
   following images: 

     1. AppImage

     2. Docker image

     3. Debian archive

3. **`runTests`**

   Following a successful `buildInstallLocally`, this will run the various 
   'local' tests reporting errors as they occur.

   When run in [Travis-ci](https://travis-ci.org/), failing browser tests 
   will *not* fail the overall Travis build, but will instead upload the 
   test results to the GitHub Release page for later review. 

4. **`uploadImages`**

   Following successful `buildInstallLocally`, `createImages` and 
   `runTests`, this will automate the upload of the various artefacts to 
   the `pdf2htmlEX` releases page, LaunchPad ppa and docker hub 
   repository. 

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

- **`createAppImage`**: Using an already compiled version of `pdf2htmlEX`, 
  installs it and `popper-data` into an AppImage.

- **`createDebianPackage`**: Using an already compiled version of 
  `pdf2htmlEX`, installs it and `poppler-data` into a Debian archive 
  (`*.deb`). 

- **`createDockerImage`**: Using an already compile version of 
  `pdf2htmlEX`, installs it and `poppler-data` into a Docker image. 

- **`getBuildTools`**: Locally `apt` installs all development *tools* 
  required to build `pdf2htmlEX`. 

- **`getDevLibraries`**: Locally `apt` installs all development 
  *libraries* required to build `pdf2htmlEX`.

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

- **`rutTests`**: Runs the tests located in the 
  `pdf2htmlEX/pdf2htmlEX/test` directory. See the 
  `pdf2htmlEX/pdf2htmlEx/test` directory's Readme file for details. 

- **`uploadDebianArchive`**: Upload the `pdf2htmlEX` Debian archive to 
  both the GitHub releases page, as well as the LaunchPad ppa.
  
  This script has not yet been implemented.
  
- **`uploadDockerImage`**: Upload the `pdf2htmlEX` Docker image to 
  Docker hub repository associated to the docker hub users specified in 
  the `DOCKER_USERNAME` environement variable.

  Unless the `DOCKER_USERNAME` and `DOCKER_PASSWORD` environment variables 
  are pre-defined, this script will prompt the user for the respective 
  values. 

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

- **`reSourceVersionEnvs`**: This bash script is automatically generated 
  by the build scripts as they are run. It records the values of all 
  important environment variables required by the buildScripts. It is 
  typcically `source`d by each script before it preforms any actions. 

- **`reportEnvs`**: Echos all important enviroment variables to the 
  console. This script is used by the top-level scripts to ensure the 
  current environment variables are listed before each build. 

- **`uploadGitHubReleaseDSL`**: A collection of bash functions used by the 
  `uploadGitHubRelease` script to automate the upload of release artefacts.

- **`uploadGitHubReleaseMessage`**: The contents of this *text* file is 
  used by the `uploadGitHubRelease` script as the contents of the release 
  message, as visible to the user, for the 'continuous' release section. 

- **`dockerFunctions`**: A collection of bash functions used by the 
  `uploadDockerImage` script to automate the upload of the Docker images 
  to Docker Hub. 

- **`listFilesByChangeTime`**: A simple bash script which lists the files 
  in the buildScripts directory by most recently changed files first. 

- **`Readme.md`**: This read me file.

## Yet more details?

The various bash script files are meant to be fairly readable. They 
contain additional comments about what each step is meant to be doing. 

