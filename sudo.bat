@echo off
REM 「 」「,」「=」「;」で区切らず、引数を全部取得する
set arg=%*
REM 「"」を「\"」にエスケープする
set replacedArg=%arg:"=\"%
REM .\sudo\main.ps1にエスケープ済みの引数を渡す。
pwsh -ExecutionPolicy Unrestricted -File "%~dp0sudo\main.ps1" "%replacedArg%"
