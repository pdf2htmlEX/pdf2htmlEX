# pdf2htmlEX tests

This directory contains a collection of python3 unittests of the output of 
pdf2htmlEX.

The graphical output of pdf2htmlEX can be tested both locally and remotely 
using [Selenium](https://www.selenium.dev/) and the [Pillow Python Imaging 
Library](https://python-pillow.org/).

The browser tests use Selenium to take a screenshot of a FireFox browser's 
rendering of the pdf2htmlEX output for a given pdf file and compares that 
image to an image of the previously saved reference html. 

## Tests which are currently failing:

- **browser_tests/text_visibility** At the moment clipping has been broken 
and needs to be fixed. Rerun `runLocalBrowserTests` and use the 
`compareTestImages` for the `test_visibility` test to see the problem. 

## Running tests

There are three shell scripts which automate the running of a given 
collection of tests: 

1. **runLocalTests** runs a simple collection of tests which do not 
require Selenium or a browser. 

```
  ./runLocalTests
```

2. **runLocalBrowserTests** runs a more complex collection of tests which 
*require* Selenium, a FireFox browser, as well as a 'virtual frame buffer' 
(Xvfb) to be installed. 

```
  ./runLocalBrowserTests
```

3. **runRemoteBrowserTests** runs the same complex collection of tests as 
run by `runLocalBrowserTests` but this time using 'Sauce Connect'. (At the 
moment this is not fully implemented or (re)tested) 

```
  ./runRemoteBrowserTests
```

In order to run these tests, you *must* have the correct testing software 
installed locally. To do this you can run the command: 

```
  ./installAutomaticTestSoftware
```

## Understanding browser test failures

If any of the automatic browser tests *fail* then you might want to 
manually view the PNG images for a given test using the command: 

```
  ./compareTestImages <<testNam>>
```

This command opens the three PNG images associated with a given failed 
test so that you can manually compare the new output (`*.out.png`), the 
reference output (`*.ref.png`) and an image of the 'difference' between 
the two images (`*.diff.png`). To pass, the 'difference' image must be 
*completely* black. 

Usually it will be obvious that the newer version of pdf2htmlEX has only 
slightly moved various image elements. Any such tests can be made to pass 
by updating the reference html using the tool:

```
  ./regenerateTestHtml <<testName>>
```

This command will regenerate the reference html for the specifed test.

All of these manual comparison tools require additional software which can 
be installed using the command: 

```
  ./installManualTestSoftware
```

--- 

## OLD README contents:

### Dependencies

- python2 and packages
  - Python Imaging Library
  - Selenium
  - unittest
- Firefox
  - firefoxdriver

### Usage
- Run all tests:
  - python test_output.py
  - python test_local_browser.py
- Environment variables:
  - `export P2H_TEST_GEN=1` to generate new reference files (when done, `unset P2H_TEST_GEN`)
  - `export P2H_TEST_REMOTE=1` to test different browsers using Sauce Labs
    - Install `sauceclient` for Python
    - Set correct values for `SAUCE_USERNAME` and `SAUCE_ACCESS_KEY`
    - Setup a HTTP server at `/` on port 8000
    - Enable Sauce Connect
    - See `.travis.yml` as an example
    - python test_remote_browser.py

### Add new test cases

- Make sure you have the proper copyrights.
- Using meaningful file names, a description of the file, or issueXXX.pdf.
- Make each test case minimal:
  - One page only, unless the test case is about multiple pages.
  - Grayscale only, unless the test case is about colors.
  - Remove unnecessary elements.
- [Optional] Include the source files that the PDF file is generated from.
- Add the new PDF file to the correct folder in `test/`, and add a new function in the corresponding Python file
- Run `P2H_TEST_GEN=1 test/test.py test_issueXXX` to generate the reference, assuming that the new function is called `test_issueXXX`
