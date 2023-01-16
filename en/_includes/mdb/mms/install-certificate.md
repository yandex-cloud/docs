```bash
mkdir --parents {{ crt-local-dir }} && \
wget "{{ crt-web-path }}" \
    --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
chmod 0600 {{ crt-local-dir }}{{ crt-local-file }}
```
