#!/usr/bin/env python3
"""
Comprehensive screenshot capture for visual analysis and mobile optimization testing.
Tests multiple pages at different viewport sizes.
"""

import os
import sys
from pathlib import Path
from playwright.sync_api import sync_playwright

# Fix encoding on Windows
if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

# Create screenshots directory with proper Windows path handling
screenshots_dir = Path(os.path.expanduser("~") + r"\OneDrive\Desktop\Ganajothi\screenshots")
screenshots_dir.mkdir(parents=True, exist_ok=True)

print(f"Screenshots directory: {screenshots_dir}")

# Base URL
BASE_URL = "https://gnanajyothi.in"

# Pages to test - key pages for analysis
PAGES = [
    ("", "Homepage"),
    ("about.html", "About"),
    ("programs.html", "Programs"),
    ("gallery.html", "Gallery"),
    ("fees.html", "Fees"),
    ("contact.html", "Contact"),
    ("blog.html", "Blog Index"),
    ("best-schools-yelahanka.html", "Blog: Best Schools"),
    ("lkg-admission-yelahanka-2026.html", "Blog: LKG Admission"),
    ("class-1-admission-age-karnataka-2026.html", "Blog: Class 1 Admission"),
]

# Viewport configurations
VIEWPORTS = [
    {"name": "desktop", "width": 1920, "height": 1080},
    {"name": "tablet", "width": 768, "height": 1024},
    {"name": "mobile", "width": 375, "height": 812},
]

def capture_screenshots():
    with sync_playwright() as p:
        browser = p.chromium.launch()
        screenshot_count = 0

        for page_file, page_name in PAGES:
            url = f"{BASE_URL}/{page_file}" if page_file else BASE_URL

            for viewport in VIEWPORTS:
                try:
                    page = browser.new_page(
                        viewport={
                            "width": viewport["width"],
                            "height": viewport["height"]
                        },
                        device_scale_factor=1
                    )

                    # Navigate to page
                    msg = f"Capturing {page_name} at {viewport['width']}x{viewport['height']}... "
                    print(msg, end="", flush=True)
                    page.goto(url, wait_until='networkidle', timeout=30000)

                    # Filename
                    safe_name = page_file.replace('.html', '') or 'index'
                    filename = f"{safe_name}_{viewport['name']}.png"
                    filepath = screenshots_dir / filename

                    # Capture full page screenshot
                    page.screenshot(path=str(filepath), full_page=True)
                    print("[OK]")
                    screenshot_count += 1

                    page.close()

                except Exception as e:
                    print(f"[ERROR] {str(e)[:40]}")

        browser.close()
        print(f"\n[SUCCESS] Captured {screenshot_count} screenshots to: {screenshots_dir}")

if __name__ == "__main__":
    capture_screenshots()
