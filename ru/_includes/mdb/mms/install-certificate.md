
```bash
mkdir --parents {{ crt-local-dir }} && \
wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
chmod 0600 {{ crt-local-dir }}{{ crt-local-file }}
```

