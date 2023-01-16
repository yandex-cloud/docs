```bash
mkdir --parents ~/.mysql && \
wget "{{ crt-web-path }}" \
    --output-document ~/.mysql/root.crt && \
chmod 0600 ~/.mysql/root.crt
```
