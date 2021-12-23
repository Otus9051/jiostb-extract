@echo off
title JioSTB Extractor v1.0 - Otus9051
cd /d "%~dp0"

:home
cls
echo.
echo ############################################################################
echo # Special thanks:                                                          #
echo # "Alexey71"     - http://forum.xda-developers.com/member.php?u=4896512    #
echo # "BrateloSlava" - http://forum.xda-developers.com/member.php?u=4842205    #
echo # "xpirt"        - http://forum.xda-developers.com/member.php?u=5132229    #
echo # "upleung"      - https://github.com/upleung/                             #
echo # "Otus9051"     - https://github.com/Otus9051                             #
echo ############################################################################

echo Please put System, Vendor, Product and ODM files here. Check [link] for more info.

echo Press 1 to Extract everything
echo Press 2 to quit 

set /p web=Type option:
if "%web%"=="1" goto startext
if "%web%"=="2" goto quitext

:startext
echo Brotli Step 1 Extraction has started...

brotli\brotli.exe -d system.new.dat.br
brotli\brotli.exe -d vendor.new.dat.br
brotli\brotli.exe -d product.new.dat.br
brotli\brotli.exe -d odm.new.dat.br

del system.new.dat.br
del vendor.new.dat.br
del product.new.dat.br
del odm.new.dat.br

echo Brotli Step 1 Extraction has completed...

echo SDA2IMG Step 2 Extraction has started...

sdat2img\sdat2img.py system.transfer.list system.new.dat system.new.img
sdat2img\sdat2img.py vendor.transfer.list vendor.new.dat vendor.new.img
sdat2img\sdat2img.py product.transfer.list product.new.dat product.new.img
sdat2img\sdat2img.py odm.transfer.list odm.new.dat odm.new.img

del system.new.dat
del vendor.new.dat
del product.new.dat
del odm.new.dat

echo SDA2IMG Step 2 Extraction has completed...

echo Final Extraction has started...

mkdir output
imgext\imgext.exe system.new.img output\system\
imgext\imgext.exe vendor.new.img output\vendor\
imgext\imgext.exe product.new.img output\product\
imgext\imgext.exe odm.new.img output\odm\

del system.new.img
del vendor.new.img
del product.new.img
del odm.new.img

echo Extraction is Complete! Have a good day.
pause

:quitext
exit