```bash
mkdir --parents ~/.elasticsearch && \
wget "{{ crt-web-path }}" \
    --output-document ~/.elasticsearch/root.crt && \
chmod 0600 ~/.elasticsearch/root.crt
```
