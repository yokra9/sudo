@echo off
REM �u �v�u,�v�u=�v�u;�v�ŋ�؂炸�A������S���擾����
set arg=%*
REM �u"�v���u\"�v�ɃG�X�P�[�v����
set replacedArg=%arg:"=\"%
REM .\sudo\main.ps1�ɃG�X�P�[�v�ς݂̈�����n���B
pwsh -ExecutionPolicy Unrestricted -File "%~dp0sudo\main.ps1" "%replacedArg%"
