@echo off
setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"
set "BUILD_DIR=%SCRIPT_DIR%..\etc\build"

REM Locate ant (check PATH first, then fallback to common locations)
where ant >nul 2>nul
if errorlevel 1 (
  if exist "C:\tools\apache-ant-1.10.15\bin\ant.bat" (
    set "ANT_CMD=C:\tools\apache-ant-1.10.15\bin\ant.bat"
  ) else if exist "C:\tools\apache-ant-*\bin\ant.bat" (
    for /d %%d in ("C:\tools\apache-ant-*") do set "ANT_CMD=%%d\bin\ant.bat"
  ) else (
    set "ANT_CMD=ant"
  )
) else (
  set "ANT_CMD=ant"
)

REM Ensure ANT_OPTS includes UTF-8 file.encoding (required by Closure Compiler on CJK Windows)
if not defined ANT_OPTS (
  set "ANT_OPTS=-Dfile.encoding=UTF-8"
) else (
  echo !ANT_OPTS! | findstr /C:"file.encoding" >nul
  if errorlevel 1 set "ANT_OPTS=!ANT_OPTS! -Dfile.encoding=UTF-8"
)

echo ANT_OPTS=%ANT_OPTS%
echo Building draw.io from %BUILD_DIR%...

pushd "%BUILD_DIR%"
%ANT_CMD% -f build.xml %*
set "BUILD_EXIT=%errorlevel%"
popd

if %BUILD_EXIT% neq 0 (
  echo Build failed with exit code %BUILD_EXIT%
  exit /b %BUILD_EXIT%
)

echo Build successful.
exit /b 0
