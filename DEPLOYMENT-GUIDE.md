# Gnanajyothi Website - Deployment Guide

## Issue Summary
The live website at https://gnanajyothi.in/ is showing a broken page with:
- Missing hero section content
- Just a "Home" heading displayed
- Empty content area between header and footer

The local files are working correctly and display the full website properly.

## Root Cause
The server has a different/corrupted version of the HTML files compared to the local working versions.

## Solution
Upload the working local files to the server.

## Files to Upload
1. `index.html` - Homepage with hero section
2. `about.html` - About us page
3. `facilities.html` - Facilities page
4. `programs.html` - Programs page
5. `contact.html` - Contact page
6. `whatsapp.js` - WhatsApp integration

## Upload Methods

### Method 1: SSH/SCP (Recommended - Fastest)
**Requirements:** SSH private key file (`gnanajyothi_key` without .pub extension)

1. Ensure you have the private key file in `%USERPROFILE%\.ssh\gnanajyothi_key`
2. Run: `upload-all.bat`
3. All files will be uploaded automatically

### Method 2: FTP
**Requirements:** FTP credentials from your hosting provider

1. Run: `upload-ftp.bat`
2. Enter your FTP username and host when prompted
3. Enter your FTP password when prompted

### Method 3: FileZilla (GUI - Easiest)
1. Download and install FileZilla from https://filezilla-project.org/
2. Connect using your hosting credentials:
   - Host: `gnanajyothi.in` or `ftp.gnanajyothi.in`
   - Username: `u202368585`
   - Password: [your cPanel/FTP password]
   - Port: `21` (FTP) or `22` (SFTP)
3. Navigate to `public_html` folder on the server
4. Upload all HTML files and whatsapp.js

### Method 4: cPanel File Manager
1. Log in to your cPanel
2. Open File Manager
3. Navigate to `public_html` folder
4. Upload each file individually

## Testing After Upload
1. Visit https://gnanajyothi.in/
2. You should see:
   - Hero section with "Welcome to Gnanajyothi School"
   - "Since 1989 - 37 Years of Excellence" badge
   - Call Now and Enquire Now buttons
   - Features section (Why Choose Gnanajyothi?)
   - About section
   - Statistics section
   - Programs section
   - Footer with contact information

## Navigation Links
The working site has these navigation links:
- Home (index.html)
- About (about.html)
- Facilities (facilities.html)
- Programs (programs.html)
- Contact (contact.html)

## Troubleshooting

### If the page still appears broken after upload:
1. Clear browser cache (Ctrl+F5 or Cmd+Shift+R)
2. Check if there's server-side caching (contact hosting provider)
3. Verify files were uploaded to the correct directory (`public_html`)

### If SSH upload fails:
- Check that you have the private key (not the .pub file)
- Ensure the key file has correct permissions (600 on Linux/Mac)
- Try FTP method instead

### If images don't load:
- The images are loaded from external URLs (WordPress media library)
- Ensure the image URLs in the HTML are accessible
- Consider downloading and hosting images locally

## Local Testing
To test locally before uploading:
1. Double-click `index.html` in File Explorer
2. Or run a local server: `python -m http.server 8000`
3. Open http://localhost:8000 in browser

## Contact
For issues with the website code, check the local files which are working correctly.
For server/upload issues, contact your hosting provider.
