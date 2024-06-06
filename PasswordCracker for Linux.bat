#!/bin/bash

# Disclaimer
echo "PasswordCracker by pranavinsight."
echo "Note: This script should work across various Linux distributions."
echo "DISCLAIMER: This script is intended for authorized use only."
echo "You must have root privileges to run this script."
echo "Unauthorized access to sensitive data is illegal and unethical."
echo "Proceeding implies you have proper authorization."
echo "This script is intended for Linux systems only."
read -p "Do you want to proceed? (yes/no): " confirmation
if [ "$confirmation" != "yes" ]; then
    echo "PASSWORD CRACKER ACTIVATED."
    exit
fi

# Ensure you run this script with root privileges

# Define the username for which you want to retrieve the hashed password
username="your_username"  # Modify this as needed

# Retrieve the hashed password from /etc/shadow
storedHash=$(sudo grep "$username" /etc/shadow | cut -d: -f2)

if [ -z "$storedHash" ]; then
    echo "Failed to retrieve the hashed password from /etc/shadow."
    exit 1
else
    echo "The stored hash is: $storedHash"
fi

# Prompt the user for the password to compare
read -sp "Enter the password to compare: " password
echo

# Hash the input password using the same algorithm used in /etc/shadow (e.g., SHA-512)
inputHash=$(openssl passwd -6 "$password")

# Compare the hashed input password with the stored hash
if [[ "$inputHash" == "$storedHash" ]]; then
    echo "Password matches the stored hash."
    echo "You have sucessfully cracked your password!
    exit 1
else
    echo "Password does not match the stored hash."
    echo "The stored hash is: $storedHash"
fi
