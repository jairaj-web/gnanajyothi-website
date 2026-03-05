# Gnanajyothi Website - How to Fix and Deploy

## The Problem
The live website at https://gnanajyothi.in/ is showing a broken page with:
- Empty content between the "Home" heading and footer
- Missing hero section, features, about sections
- Basically, only header and footer display

## The Cause
The server has an outdated/corrupted version of index.html. The local files are correct and working.

## Verified Working Locally
Tested `index.html` locally - displays correctly with:
- ✅ Hero section: "Welcome to Gnanajyothi School"
- ✅ "Since 1989 - 37 Years of Excellence" badge
- ✅ Call Now and Enquire Now buttons
- ✅ All content sections (Features, About, Stats, Programs)
- ✅ Full footer with contact info

## Files Ready to Upload
All files are fixed and ready:
- `index.html` (73KB) - Main homepage
- `about.html` (48KB) - About page
- `facilities.html` (33KB) - Facilities page
- `programs.html` (45KB) - Programs page
- `contact.html` (42KB) - Contact page
- `whatsapp.js` (861 bytes) - WhatsApp integration

## 4 Ways to Upload (Choose One)

### Method 1: SCP/SSH (Fastest - If SSH Key Available)
**If you have the SSH private key:**

```batch
# Place private key at: %USERPROFILE%\.ssh\gnanajyothi_key
# Then run:
upload-all.bat
```

Or manually:
```bash
scp -i ~/.ssh/gnanajyothi_key index.html u202368585@gnanajyothi.in:~/public_html/
scp -i ~/.ssh/gnanajyothi_key about.html u202368585@gnanajyothi.in:~/public_html/
scp -i ~/.ssh/gnanajyothi_key facilities.html u202368585@gnanajyothi.in:~/public_html/
scp -i ~/.ssh/gnanajyothi_key programs.html u202368585@gnanajyothi.in:~/public_html/
scp -i ~/.ssh/gnanajyothi_key contact.html u202368585@gnanajyothi.in:~/public_html/
scp -i ~/.ssh/gnanajyothi_key whatsapp.js u202368585@gnanajyothi.in:~/public_html/
```

### Method 2: FTP/SFTP (Password-based)
**Use your hosting FTP credentials:**

1. Open FileZilla (free) or any FTP client
2. Connect with:
   - **Host:** gnanajyothi.in or ftp.gnanajyothi.in
   - **Username:** u202368585
   - **Password:** [your cPanel/FTP password]
   - **Port:** 21 (FTP) or 22 (SFTP) or 2222 (alternative SFTP)
3. Navigate to `public_html` folder
4. Upload all 6 files

Or use the provided script:
```batch
upload-ftp.bat
```

### Method 3: cPanel File Manager (Web-based)
1. Log in to your hosting cPanel
2. Click **File Manager**
3. Navigate to `public_html`
4. Click **Upload** for each file:
   - index.html
   - about.html
   - facilities.html
   - programs.html
   - contact.html
   - whatsapp.js
5. Overwrite existing files when prompted

### Method 4: PowerShell with Posh-SSH
```powershell
# Install module if needed
Install-Module Posh-SSH -Force

# Upload files
$cred = New-Object System.Management.Automation.PSCredential("u202368585", (New-Object System.Security.SecureString))
Set-SCPItem -ComputerName gnanajyothi.in -Credential $cred -Path ./index.html -Destination /home/u202368585/public_html/ -KeyFile ~/.ssh/gnanajyothi_key
```

## After Upload - Clear Cache
1. Clear browser cache: Press `Ctrl+F5` or `Ctrl+Shift+R`
2. Or open in incognito/private mode
3. Visit https://gnanajyothi.in/ to verify

## What You Should See After Fix
- Full hero section with gradient background
- "Welcome to Gnanajyothi School" heading
- "Since 1989 - 37 Years of Excellence" badge
- Two CTA buttons: "Call Now" and "Enquire Now"
- Features section with 4 cards
- About section with school info
- Statistics counter section
- Programs section with 3 cards
- Testimonials section
- Contact section with form
- Full footer

## Troubleshooting

**If upload fails:**
- Check your internet connection
- Verify credentials with hosting provider
- Try different upload method

**If site still broken after upload:**
1. Hard refresh: `Ctrl+Shift+R`
2. Clear browser cache completely
3. Check server-side caching (contact host to clear)
4. Verify files uploaded to `public_html` (not root)

**If SSH times out:**
- Your network may block SSH (common in corporate/public WiFi)
- Use FTP method instead
- Or upload from a different network

## Contact
If issues persist after uploading:
- Check with hosting provider about server caching
- Verify domain points to correct public_html folder

---

**Current Status:** All local files are fixed and verified working. Just need to upload to server.
