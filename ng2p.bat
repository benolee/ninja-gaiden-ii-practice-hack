@copy /B "Ninja Gaiden II - The Dark Sword of Chaos (U) [!].nes" ng2phack.nes
@xkas.exe -o ng2phack.nes ng2p.asm
@echo error: %errorlevel%
@REM xkas returns 0 for some errors, 1 for others. -__-
@REM further reason to find another patching assembler
@pause