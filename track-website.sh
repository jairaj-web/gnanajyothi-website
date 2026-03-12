#!/bin/bash
# =====================================================
# Gnanajyothi School — Daily Website Tracker
# Run: bash track-website.sh
# =====================================================

SITE="https://gnanajyothi.in"
DATE=$(date '+%Y-%m-%d %H:%M')
LOG="c:/Users/Laptop/OneDrive/Desktop/Ganajothi/website-tracking-log.txt"

echo "" >> "$LOG"
echo "=====================================================" >> "$LOG"
echo "DAILY CHECK — $DATE" >> "$LOG"
echo "=====================================================" >> "$LOG"

PAGES=(
  "/"
  "/about.html"
  "/programs.html"
  "/facilities.html"
  "/fees.html"
  "/gallery.html"
  "/contact.html"
  "/blog.html"
  "/best-schools-yelahanka.html"
  "/lkg-admission-yelahanka-2026.html"
  "/ukg-admission-yelahanka-2026.html"
  "/pre-kg-admission-yelahanka-2026.html"
  "/class-1-admission-age-karnataka-2026.html"
  "/rte-admission-karnataka-2026.html"
  "/school-fees-yelahanka-2026.html"
  "/kseeb-vs-cbse.html"
  "/karnataka-school-holiday-list-2026.html"
  "/school-admission-documents-bangalore.html"
  "/state-board-schools-yelahanka.html"
  "/school-near-yelahanka-new-town.html"
  "/class-6-7-admission-yelahanka-2026.html"
  "/after-school-activities-yelahanka.html"
  "/school-transfer-karnataka.html"
  "/sitemap.xml"
  "/robots.txt"
)

echo "" >> "$LOG"
echo "[ PAGE STATUS ]" >> "$LOG"
OK=0; FAIL=0
for PAGE in "${PAGES[@]}"; do
  STATUS=$(curl -o /dev/null -s -w "%{http_code}" --max-time 10 "$SITE$PAGE")
  if [ "$STATUS" = "200" ]; then
    echo "  ✅ $STATUS — $PAGE" >> "$LOG"
    ((OK++))
  else
    echo "  ❌ $STATUS — $PAGE  ← PROBLEM" >> "$LOG"
    ((FAIL++))
  fi
done
echo "" >> "$LOG"
echo "  RESULT: $OK OK / $FAIL FAILED" >> "$LOG"

echo "" >> "$LOG"
echo "[ RESPONSE TIME — Homepage ]" >> "$LOG"
TIME=$(curl -o /dev/null -s -w "%{time_total}s" --max-time 15 "$SITE/")
echo "  Homepage load time: $TIME" >> "$LOG"

echo "" >> "$LOG"
echo "[ SECURITY HEADERS ]" >> "$LOG"
HEADERS=$(curl -sI --max-time 10 "$SITE/" | grep -iE "strict-transport|x-frame|x-content-type|cache-control")
echo "$HEADERS" | while read line; do echo "  $line" >> "$LOG"; done

echo "" >> "$LOG"
echo "[ SITEMAP ]" >> "$LOG"
SITEMAP_STATUS=$(curl -o /dev/null -s -w "%{http_code}" --max-time 10 "$SITE/sitemap.xml")
URL_COUNT=$(curl -s --max-time 10 "$SITE/sitemap.xml" | grep -c "<loc>")
echo "  Sitemap HTTP status: $SITEMAP_STATUS" >> "$LOG"
echo "  URLs in sitemap: $URL_COUNT" >> "$LOG"

echo "" >> "$LOG"
echo "[ DONE — See full log at website-tracking-log.txt ]" >> "$LOG"

# Also print to console
cat "$LOG" | tail -50
