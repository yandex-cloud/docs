```bash
mkdir --parents ~/.mongodb && \
wget "{{ crt-web-path }}" \
    --output-document ~/.mongodb/root.crt && \
chmod 0644 ~/.mongodb/root.crt
```
