```bash
mkdir ~/.postgresql &&
wget "{{ crt-web-path }}" \
    --output-document ~/.postgresql/root.crt &&
chmod 0600 ~/.postgresql/root.crt
```
