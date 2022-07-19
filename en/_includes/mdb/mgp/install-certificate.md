

```bash
mkdir --parents ~/.postgresql && \
wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document ~/.postgresql/root.crt && \
chmod 0600 ~/.postgresql/root.crt
```

