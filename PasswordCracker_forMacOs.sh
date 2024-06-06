#!/bin/bash

# Disclaimer
echo "Password finder by pranavinsight."
echo "Note: THIS SCRIPT REQUIRES macOS Catalina (10.15) OR LATER."
echo "DISCLAIMER: This script is intended for authorized use only."
echo "You must have root privileges to run this script."
echo "Unauthorized access to sensitive data is illegal and unethical."
echo "Proceeding implies you have proper authorization."
echo "This script is intended for macOS systems only."
read -p "Do you want to proceed? (yes/no): " confirmation
if [ "$confirmation" != "yes" ]; then
    echo "PASSWORD CRACKER ACTIVATED."
    exit
fi

# Check macOS version
os_version=$(sw_vers -productVersion)
required_version="10.15"
if [[ $(echo -e "$os_version\n$required_version" | sort -V | head -n1) != "$required_version" ]]; then
    echo "It seems like you are using an outdated version of macOS. The version should be atleast 10.15 (MacOs Catalina) to run this batch file."
    exit 1
fi

# Ensure you run this script with root privileges

# Define the username for which you want to retrieve the hashed password Modify "your_username" as your actual username.
username="your_username" 

# Retrieve the hashed password from the keychain (requires appropriate permissions)
storedHash=$(sudo dscl . -read /Users/$username AuthenticationAuthority | grep " ;HASHED_PW" | cut -d' ' -f4)

if [ -z "$storedHash" ]; then
    echo "Failed to retrieve the hashed password."
    exit 1
else
    echo "The stored hash is: $storedHash"
fi

# Prompt the user for the password to compare
read -sp "Enter the password to compare: " password
echo

# Hash the input password using SHA-512
inputHash=$(echo -n "$password" | shasum -a 512 | awk '{print $1}')

# Compare the hashed input password with the stored hash
if [[ "$inputHash" == "$storedHash" ]]; then
    echo "Yay! Password matches the stored hash."
else
    echo "Password does not match the stored hash. You can use the hash to put it in the password decryption program if needed."
    echo "The stored hash is: $storedHash"
fi
