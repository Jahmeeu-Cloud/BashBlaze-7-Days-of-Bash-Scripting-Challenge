#!/bin/bash

# User Account Management Script
# This script provides options for managing user accounts on the system.

########################################
#
#
# Script Author: Jamiu
#
# Date: 31-12-2024
#
# Version: v1
#
#
########################################


# Function to display usage information
usage() {
    echo "Usage: $0 [OPTION]"
    echo "Options:"
    echo "  -c, --create      Create a new user account"
    echo "  -d, --delete      Delete an existing user account"
    echo "  -r, --reset       Reset the password of an existing user account"
    echo "  -l, --list        List all user accounts"
    echo "  -h, --help        Display this help message"
}

# Function to create a new user account
create_user() {
    read -p "Enter the new username: " username
    if id "$username" &>/dev/null; then
        echo "Error: The username '$username' already exists."
        exit 1
    fi
    read -s -p "Enter the password for the new user: " password
    echo
    sudo useradd -m "$username"
    echo "$username:$password" | sudo chpasswd
    echo "User '$username' created successfully."
}

# Function to delete a user account
delete_user() {
    read -p "Enter the username to delete: " username
    if ! id "$username" &>/dev/null; then
        echo "Error: The username '$username' does not exist."
        exit 1
    fi
    sudo userdel -r "$username"
    echo "User '$username' deleted successfully."
}

# Function to reset a user account password
reset_password() {
    read -p "Enter the username to reset the password for: " username
    if ! id "$username" &>/dev/null; then
        echo "Error: The username '$username' does not exist."
        exit 1
    fi
    read -s -p "Enter the new password: " password
    echo
    echo "$username:$password" | sudo chpasswd
    echo "Password for user '$username' updated successfully."
}

# Function to list all user accounts
list_users() {
    echo "Listing all user accounts:"
    awk -F: '{print "Username: " $1 ", UID: " $3}' /etc/passwd
}

# Main script logic
if [ $# -eq 0 ]; then
    usage
    exit 1
fi

case "$1" in
    -c|--create)
        create_user
        ;;
    -d|--delete)
        delete_user
        ;;
    -r|--reset)
        reset_password
        ;;
    -l|--list)
        list_users
        ;;
    -h|--help)
        usage
        ;;
    *)
        echo "Invalid option: $1"
        usage
        exit 1
        ;;
esac