Name:       pdf2htmlEX
Version:    @@VERSION@@
Release:    @@REVISION@@
Summary:    pdf2htmlEX renders PDF files in HTML utilizing modern Web technologies

Group:      Development/Libraries
License:    GPLv3+
URL:        http://nexbyte.com/package/pdf2htmlEX
Source0:    http://nexbyte.com/%{name}-%{version}.tgz
BuildRoot:  %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:  x86_64

# Versions of poppler and fontforge
%define poppler_version 0.57.0
%define fontforge_version 20120731

# Fix false automatic dependency addition of provided binary
%define __requires_exclude %{_builddir}/%{name}-%{version}-%{release}%{_bindir}/fontforge

Requires: %{name}-poppler
Requires: %{name}-fontforge

BuildRequires: cairo
BuildRequires: expat
BuildRequires: fontconfig
BuildRequires: freetype
BuildRequires: glibc
BuildRequires: glib2
BuildRequires: jbigkit-libs
BuildRequires: libffi
BuildRequires: libgcc
BuildRequires: libjpeg-turbo
BuildRequires: libpng
BuildRequires: libstdc++
BuildRequires: libtiff
BuildRequires: libtool-ltdl
BuildRequires: libX11
BuildRequires: libXau
BuildRequires: libxcb
BuildRequires: libXext
BuildRequires: libxml2
BuildRequires: pcre
BuildRequires: pixman
BuildRequires: openjpeg
BuildRequires: xz

# Add dependencies to build this package here:

%description
pdf2htmlEX renders PDF files in HTML

# Poppler

%package        poppler
Summary:        PDF rendering library
Group:          System/Libraries
Url:            http://poppler.freedesktop.org/

Provides: pdfdetach
Provides: pdffonts
Provides: pdfimages
Provides: pdfinfo
Provides: pdfseparate
Provides: pdftocairo
Provides: pdftohtml
Provides: pdftoppm
Provides: pdftops
Provides: pdftotext
Provides: pdfunite
Provides: libpoppler

Requires: poppler-data

%description    poppler
poppler-%{poppler_version}
Poppler is a PDF rendering library, forked from the xpdf PDF viewer
developed by Derek Noonburg of Glyph and Cog, LLC.

# FontForge

%package        fontforge
Summary:        A Font Editor
Group:          Productivity/Graphics/Vector Editors
Url:            http://fontforge.org/

Provides: fontforge
Provides: fontimage
Provides: fontlint
Provides: sfddiff
Provides: libfontforge

BuildRequires: giflib
BuildRequires: graphite2
BuildRequires: harfbuzz
BuildRequires: libblkid
BuildRequires: libICE
BuildRequires: libSM
BuildRequires: libspiro
BuildRequires: libthai
BuildRequires: libuuid
BuildRequires: pango
BuildRequires: python = 2.7.5

%description    fontforge
fontforge-%{fontforge_version}
FontForge allows editing of outline and bitmap fonts.  With it, you can
create new fonts or modify old ones.  It also converts font formats and
can convert among PostScript (ASCII & binary Type 1, some Type 3s, and
some Type 0s), TrueType, OpenType (Type2), and CID-keyed fonts.

%prep
%setup -c -q -n pdf2htmlEX-%{version}

%build
rm -rf %{buildroot}
%{__mkdir} -p %{_builddir}/%{name}-%{version}-%{release}%{_prefix}

# build dist files
./build-centos.sh %{_builddir}/%{name}-%{version}-%{release}%{_prefix} %{_prefix}

# Copy files over from working directory to the buildroot
%install
%{__mkdir} -p %{buildroot}%{_prefix}/lib
%{__mkdir} -p %{buildroot}%{_mandir}
find %{_builddir}/%{name}-%{version}-%{release}%{_prefix}/lib -maxdepth 1 -type f -exec cp {} -t %{buildroot}%{_prefix}/lib \;
#%{__cp} %{_builddir}/%{name}-%{version}-%{release}%{_prefix}/lib %{buildroot}%{_prefix}/
%{__cp} -ad %{_builddir}/%{name}-%{version}-%{release}%{_bindir} %{buildroot}%{_prefix}/
%{__cp} -ad %{_builddir}/%{name}-%{version}-%{release}%{_datadir}/{%{name},applications,fontforge,icons,locale,mime} %{buildroot}%{_datadir}/
%{__cp} -ad %{_builddir}/%{name}-%{version}-%{release}%{_mandir}/man1 %{buildroot}%{_mandir}/

%clean
rm -rf $RPM_BUILD_ROOT

%post          poppler
/sbin/ldconfig

%postun        poppler
/sbin/ldconfig

%post          fontforge
/sbin/ldconfig

%postun        fontforge
/sbin/ldconfig

%files         poppler
%{_prefix}/lib/libpoppler.*
%{_prefix}/lib/libpoppler-cpp.*
%{_prefix}/lib/libpoppler-glib.*
%{_bindir}/pdfdetach
%{_bindir}/pdffonts
%{_bindir}/pdfimages
%{_bindir}/pdfinfo
%{_bindir}/pdfseparate
%{_bindir}/pdftocairo
%{_bindir}/pdftohtml
%{_bindir}/pdftoppm
%{_bindir}/pdftops
%{_bindir}/pdftotext
%{_bindir}/pdfunite

%doc
%{_mandir}/man?/pdfdetach*
%{_mandir}/man?/pdffonts*
%{_mandir}/man?/pdfimages*
%{_mandir}/man?/pdfinfo*
%{_mandir}/man?/pdfseparate*
%{_mandir}/man?/pdftocairo*
%{_mandir}/man?/pdftohtml*
%{_mandir}/man?/pdftoppm*
%{_mandir}/man?/pdftops*
%{_mandir}/man?/pdftotext*
%{_mandir}/man?/pdfunite*
%{_mandir}/man?/sfddiff*

%files         fontforge
%{_prefix}/lib/libfontforge.*
%{_prefix}/lib/libfontforgeexe.*
%{_prefix}/lib/libgioftp.*
%{_prefix}/lib/libgutils.*
%{_prefix}/lib/libgunicode.*
%{_bindir}/sfddiff
%{_bindir}/fontforge
%{_bindir}/fontimage
%{_bindir}/fontlint
%{_datadir}/applications/fontforge.desktop
%{_datadir}/applications/mimeinfo.cache
%{_datadir}/fontforge
%{_datadir}/icons/hicolor/*/apps/fontforge*
%{_datadir}/locale/*/LC_MESSAGES/FontForge.mo
%{_datadir}/mime/application/vnd.font-fontforge-sfd.xml
%{_datadir}/mime/packages/fontforge.xml

%doc
%{_mandir}/man?/fontforge*
%{_mandir}/man?/fontimage*
%{_mandir}/man?/fontlint*

%exclude
%{_datadir}/mime/XMLnamespaces
%{_datadir}/mime/aliases
%{_datadir}/mime/generic-icons
%{_datadir}/mime/globs
%{_datadir}/mime/globs2
%{_datadir}/mime/icons
%{_datadir}/mime/magic
%{_datadir}/mime/mime.cache
%{_datadir}/mime/subclasses
%{_datadir}/mime/treemagic
%{_datadir}/mime/types
%{_datadir}/mime/version

%files
%{_bindir}/%{name}
%{_datadir}/%{name}

%doc
%{_mandir}/man?/%{name}*
