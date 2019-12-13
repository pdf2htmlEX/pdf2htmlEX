# FontForge: the missing headers

The FontForge header files in this directory are taken from the 
FontForge-20190801 release.

They are headers which are not usually installed by the FontForge make 
system.


## Required headers

- `autowidth.h` required for FVRemoveKerns
- `bitmapchar.h` required for SFReplaceEncodingBDFProps
- `cvimages.h` required for FVImportImages
- `fvfonts.h` required for SFFindSlot
- `namelist.h` required for UniFromName
- `savefont.h` required for GenerateScript
- `splineorder2.h` required for SFConvertToOrder2
- `splineutil.h` required for AltUniFree
- `splineutil2.h` required for SplineFontNew
- `start.h` required for InitSimpleStuff
- `tottf.h` required for SFDefaultOS2Info

## Helpful headers

- `encoding.h` conflicts with an existing header in the src/util directory.
