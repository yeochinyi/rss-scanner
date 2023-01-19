#!/bin/zsh
# set -xv
KEYWORDS=$(cat keyword.txt| tr '\n' '|')
for URL in `cat rss-site.txt`; do 
    curl -sS "$URL" | yq -p=xml ".rss.channel.item[] | select(.title | test(\"(?i).*(${KEYWORDS}).*\")) | [[.title,.link]]" -o=csv | sed 's/,/\n/g'; 
done