@echo off
setlocal enabledelayedexpansion

:: Disclaimer and title:
echo Password finder by pranavinsight!



echo DISCLAIMER: This script is intended for authorized use only.
echo You must have Administrative Privileges to run this script.
echo Unauthorized access to sensitive data is illegal and unethical.
echo Proceeding implies you have proper authorization.
echo.
set /p confirmation=Do you want to proceed? (yes/no): 
if /i not "!confirmation!"=="yes" (
    echo PASSWORD CRACKER ACTIVATED!
    endlocal
    exit /b 1
)

:: Define the registry path and value name
set "regPath=HKCU\Software\YourSoftware"  :: Modify this path as needed
set "valueName=YourHashedPassword"  :: Modify this value name as needed

:: Retrieve the hashed password from the registry
for /f "tokens=3*" %%A in ('reg query "%regPath%" /v "%valueName%" 2^>nul') do set "storedHash=%%B"

:: Check if the hash was retrieved successfully
if not defined storedHash (
    echo Failed to retrieve the hashed password from the registry.
    pause
    endlocal
    exit /b 1
else
    echo The stored hash is: %storedHash%
)

:: Prompt user for the password to compare
set /p password=Enter the password to compare:

:: Hash the input password using PowerShell (SHA-256 example)
for /f "tokens=* delims=" %%i in ('powershell -command "[BitConverter]::ToString([System.Security.Cryptography.SHA256]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes('%password%'))).Replace('-','').ToLower()"') do set "inputHash=%%i"


:: Compare the hashed input password with the stored hash
if "%inputHash%"=="%storedHash%" (
    echo Yay! Password matches the stored hash.
    echo You have sucessfully cracked your passcode
    exit /b 1
) else (
    echo Password does not match the stored hash. You can use the stored hash to decrypt it in a 'password decryption program'.
    echo The stored hash is: %storedHash%
)

pause
endlocal
