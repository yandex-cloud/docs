
```bash
mkdir --parents ~/.mongodb && \
wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document ~/.mongodb/root.crt && \
chmod 0644 ~/.mongodb/root.crt
```

