# $env:path should contain a path to editbin.exe and signtool.exe

$ErrorActionPreference = "Stop"

mkdir build_scripts\win_build

git status

Write-Output "   ---"
Write-Output "Use pyinstaller to create lotus .exe's"
Write-Output "   ---"
$SPEC_FILE = (python -c 'import lotus; print(lotus.PYINSTALLER_SPEC_PATH)') -join "`n"
pyinstaller --log-level INFO $SPEC_FILE

Write-Output "   ---"
Write-Output "Copy lotus executables to lotus-blockchain-gui\"
Write-Output "   ---"
Copy-Item "dist\daemon" -Destination "..\lotus-blockchain-gui\packages\gui\" -Recurse

Write-Output "   ---"
Write-Output "Setup npm packager"
Write-Output "   ---"
Set-Location -Path ".\npm_windows" -PassThru
Set-Location -Path "..\" -PassThru

Set-Location -Path "..\lotus-blockchain-gui" -PassThru

git status

git status

# Change to the GUI directory
Set-Location -Path "packages\gui" -PassThru

Write-Output "   ---"
Write-Output "Increase the stack for lotus command for (lotus plots create) chiapos limitations"
# editbin.exe needs to be in the path
editbin.exe /STACK:8000000 daemon\lotus.exe
Write-Output "   ---"

#Write-Output "   ---"
#Write-Output "node winstaller.js"
#node winstaller.js
#Write-Output "   ---"

git status

git status

Write-Output "   ---"
Write-Output "Moving final binaries to expected location"
Write-Output "   ---"
Copy-Item ".\Lotus-win32-x64" -Destination "$env:GITHUB_WORKSPACE\" -Recurse

Write-Output "   ---"
Write-Output "Windows CLI complete"
Write-Output "   ---"
