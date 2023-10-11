# ⚠️ HIGHLY SENSITIVE INFORMATION HERE INCLUDING PASSWORDS ⚠️

website_running mywebsite.com
website_running CustomName1 otherwebsite.com
website_running CustomName2 otherwebsite.com/with/path.json
website_running CustomName3 http_basic_user:http_basic_pass@one-more-website.com

# useful if you have more than one machine
servername=something
metric_check "disk usage /" \
    "disk_usage_percent '/'" \
    "-gt" \
    90 \
    "$servername root disk usage in % is greater than"

metric_check "process number" \
    "ps -e | wc -l" \
    "-gt" \
    500 \
    "$servername process number (ps -e) is greater than"

application_status_check "ufw status" \
    "Status: ..tiv" \
    "ufw reload" \
    "$servername ufw was not active"
