#!/bin/bash
set -x

template_file="network_exporter.yml.template"
output_file="network_exporter.yml"

cp "$template_file" "$output_file"

# Extract all hostnames (pattern: something.something.something)
grep -oE '([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}' "$template_file" | sort | uniq | while read -r host; do
  ip=$(dig +short "$host" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' | head -n1)
  echo "Hostname: $host -> IP: ${ip:-NOT RESOLVED}"
  if [[ -n "$ip" ]]; then
    sed -i "s/$host/$ip/g" "$output_file"
  fi
done


cat /app/cfg/network_exporter.yml