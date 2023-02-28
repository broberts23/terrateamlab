#!/bin/bash

# Install Apache web server
sudo apt-get update
sudo apt-get install -y apache2

# Remove default web server content
sudo rm -rf /var/www/html/*

# Copy website files to web server root directory
sudo cp -r /path/to/website/* /var/www/html/

# Restart Apache web server
sudo systemctl restart apache2