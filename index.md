---
layout: default
title: pdf2htmlEX
sidebar: |
  - [Introduction](#introduction)
  - [Features](#features)
  - [Get Started](#get-started)
  - [Usage](#usage)
  - [License](#license)
  - [Credits](#credits)

  - [Github](https://github.com/pdf2htmlEX/pdf2htmlEX)
  - [Releases](https://github.com/pdf2htmlEX/pdf2htmlEX/releases)
  - [Wiki](https://github.com/pdf2htmlEX/pdf2htmlEX/wiki)
  - [Issues](https://github.com/pdf2htmlEX/pdf2htmlEX/issues)
  
  - [WINDOWS XP USERS](#windows-xp-users)
  
---
A beautiful demo is worth a thousand words:

* [**Typography**](/demo/geneve.html)
  [PDF](https://github.com/raphink/geneve_1564/releases/download/2016-06-08_02/geneve_1564.pdf) 
  (<a href="https://github.com/raphink/geneve_1564" target="_blank">Author</a>) 
* [**Formulas**](/demo/cheat.html) 
  [PDF](http://www.tug.org/texshowcase/cheat.pdf) 
  (<a href="http://www.tug.org/texshowcase" target="_blank">Author</a>)
* [**Magazine**](/demo/issue65_en.html) 
  [PDF](http://dl.fullcirclemagazine.org/issue65_en.pdf) 
  (<a href="http://fullcirclemagazine.org" target="_blank">Author</a>) 
* [**Scientific Paper**](/demo/demo.html) 
  [PDF](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.148.349&rep=rep1&type=pdf) 
  (<a href="https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.148.349" target="_blank">Author</a>)

* [**pdf2htmlEX Tugboat**](doc/tb108wang.html)
  [PDF](doc/tb108wang.pdf)
  (<a href="https://github.com/coolwanglu" target="_blank">Author</a>)

## Introduction {#introduction}

pdf2htmlEX renders PDF files in HTML, utilizing modern Web technologies. 
It aims to provide an accurate rendering, while being optimized for Web 
display. Text, fonts and formats are natively preserved in HTML. 
Mathematical formulas, figures and images are also supported. 

pdf2htmlEX is also a publishing tool: almost 50 options make it flexible 
for many different use cases: PDF preview, book/magazine publishing, 
personal resume... 

pdf2htmlEX is optimized for modern web browsers such as Mozilla Firefox & Google 
Chrome. 

### Why HTML?

This is an era of Web. HTML, together with CSS and JavaScript, provides 
the flexibility allowing you to embed documents with beautiful themes, 
consistent bahivours and useful features. User experience will also be 
significantly improved, documents will be plugin-free and interactive, 
users can read while downloading. 

## Features {#features}

* Single HTML file output
* *or* one HTML file per page if that is what you want...
* Images
* Precise rendering 
* Text Selection
* Font embedding & reencoding for Web
* Proper styling (Color, Transformation...)
* Links
* Optimization for Web 

### Not supported yet

* Type 3 fonts
* Non-text object (Don't worry, they will be rendered as images)

## Get started {#get-started}

You can get pdf2htmlEX in a number of ways:

* [**AppImage**]({{ site.github.releases_url }}) download, make executable, and "just run" (see 
  <a href="https://appimage.org/" target="_blank">AppImage.org</a>) 
* [**pdf2htmlEX/pdf2htmlEX**](https://hub.docker.com/orgs/pdf2htmlex/) on 
  <a href="https://hub.docker.com/" target="_blank">Docker Hub</a> 
* [**Debian Archive**]({{ site.github.releases_url }}) download, and apt install locally:
  `sudo apt install ./<<DownloadedDebFile>>`
* [**Compile yourself**]({{ site.github.repository_url}}//tree/master/buildScripts)

## Usage {#usage}

    pdf2htmlEX /path/to/foobar.pdf

    pdf2htmlEX --help

## LICENSE {#license}

GPLv2 & GPLv3 Dual licensed

**pdf2htmlEX is totally free, please credit pdf2htmlEX if you use it**

**Please consider sponsoring it if you use it for commercial purpose**

**Font extraction, conversion or redistribution may be illegal, please check your local laws**

## Credits {#credits}

pdf2htmlEX is inspired by the following projects:

* pdftops & pdftohtml from poppler 
* MuPDF
* PDF.js
* Crocodoc
* Google Doc

pdf2htmlEX uses the following projects:

* Poppler
* FontForge

Finally, many thanks are due to 

* Lu Wang ([coolwanglu](https://github.com/coolwanglu)) 

for creating the [original project](https://github.com/coolwanglu/pdf2htmlEX)

## Contact

Suggestions and questions are welcome. 

Please read [FAQ]({{ site.github.repository_url}}/wiki/FAQ) before sending an email.

## Windows XP users {#windows-xp-users}

Please make sure ClearType is turned on

(Control Panel -> Display -> Appearance -> Effects -> "Use the following method to smooth edges of screen fonts" -> ClearType)
