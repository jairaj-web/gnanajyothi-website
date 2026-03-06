import re, os, glob

pages = ["index.html","about.html","programs.html","facilities.html","fees.html","gallery.html","contact.html"]

print("=" * 60)
print("SEO AUDIT - gnanajyothi.in")
print("=" * 60)

issues = []

for f in pages:
    if not os.path.exists(f): continue
    c = open(f).read()

    title = re.search(r"<title>(.*?)</title>", c)
    desc = re.search(r'name="description"[^>]*content="([^"]*)"', c)
    keywords = re.search(r'name="keywords"[^>]*content="([^"]*)"', c)
    h1s = re.findall(r"<h1[^>]*>(.*?)</h1>", c, re.DOTALL)
    h2s = re.findall(r"<h2[^>]*>(.*?)</h2>", c, re.DOTALL)
    canonical = re.search(r'rel="canonical"[^>]*href="([^"]*)"', c)
    schema = bool(re.search(r'application/ld\+json', c))
    faq = "FAQPage" in c
    og = bool(re.search(r'og:title', c))
    twitter = bool(re.search(r'twitter:card', c))
    gtag = "G-V1WNGC4FRF" in c
    imgs = re.findall(r"<img[^>]*>", c, re.IGNORECASE)
    no_alt = [i for i in imgs if "alt=" not in i.lower()]

    t = title.group(1) if title else "MISSING"
    d = desc.group(1) if desc else "MISSING"
    h = re.sub(r"<[^>]+>","",h1s[0]).strip() if h1s else "MISSING"
    can = canonical.group(1) if canonical else "MISSING"

    print(f"\n--- {f} ---")
    print(f"  Title ({len(t)} chars): {t[:80]}")
    print(f"  Desc  ({len(d)} chars): {d[:100]}")
    print(f"  H1: {h[:70]}")
    print(f"  H2 count: {len(h2s)} | Schema: {'YES' if schema else 'NO'} | FAQ: {'YES' if faq else 'NO'} | OG: {'YES' if og else 'NO'} | GA: {'YES' if gtag else 'NO'}")
    print(f"  Canonical: {can}")
    print(f"  Images missing alt: {len(no_alt)}")

    # Flag issues
    if len(t) > 65: issues.append(f"TITLE TOO LONG ({f}): {len(t)} chars")
    if len(t) < 30: issues.append(f"TITLE TOO SHORT ({f}): {len(t)} chars")
    if d == "MISSING": issues.append(f"NO DESCRIPTION ({f})")
    elif len(d) > 160: issues.append(f"DESC TOO LONG ({f}): {len(d)} chars")
    elif len(d) < 100: issues.append(f"DESC TOO SHORT ({f}): {len(d)} chars")
    if h == "MISSING": issues.append(f"NO H1 ({f})")
    if len(h1s) > 1: issues.append(f"MULTIPLE H1s ({f}): {len(h1s)}")
    if not schema: issues.append(f"NO SCHEMA ({f})")
    if not faq: issues.append(f"NO FAQ SCHEMA ({f})")
    if not og: issues.append(f"NO OG TAGS ({f})")
    if not gtag: issues.append(f"NO GOOGLE ANALYTICS ({f})")
    if can == "MISSING": issues.append(f"NO CANONICAL ({f})")
    if no_alt: issues.append(f"MISSING ALT TEXT ({f}): {len(no_alt)} images")

print("\n" + "=" * 60)
print(f"ISSUES FOUND: {len(issues)}")
print("=" * 60)
for i in issues:
    print(f"  ❌ {i}")

# Check sitemap and robots
print("\n=== Files Check ===")
for f2 in ["sitemap.xml","robots.txt","404.html"]:
    print(f"  {f2}: {'EXISTS' if os.path.exists(f2) else 'MISSING'}")
