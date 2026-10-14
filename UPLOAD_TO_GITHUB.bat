@echo off
setlocal
cd /d "%~dp0"
echo Kintsugi Aurelius preview - GitHub upload
where git >nul 2>nul
if errorlevel 1 (
  echo Git is required. Install Git for Windows from https://git-scm.com/download/win
  echo After installing, run this file again.
  pause
  exit /b 1
)
if not exist .git (
  git init -b main
  if errorlevel 1 goto fail
)
git config user.name >nul 2>nul
if errorlevel 1 git config user.name "Kintsugi Aurelius"
git config user.email >nul 2>nul
if errorlevel 1 git config user.email "vision2motionbuild@gmail.com"
git remote get-url origin >nul 2>nul
if errorlevel 1 git remote add origin https://github.com/joe3583-spec/kintsugi-aurelius-preview.git
git fetch origin main
if errorlevel 1 goto fail
git checkout -B main origin/main
if errorlevel 1 goto fail
git add -A
if errorlevel 1 goto fail
git commit -m "Add Kintsugi Aurelius preview website"
if errorlevel 1 (
  echo Commit did not complete. Review messages above.
  pause
  exit /b 1
)
git push -u origin main
if errorlevel 1 goto fail
echo.
echo UPLOAD SUCCEEDED. Now enable GitHub Pages in repository Settings, Pages.
pause
exit /b 0
:fail
echo.
echo Upload stopped. No force push was attempted.
pause
exit /b 1
