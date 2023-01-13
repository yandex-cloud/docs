
```bash
sudo mkdir --parents ~/.opensearch && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document ~/.opensearch/root.crt && \
sudo chmod 0600 ~/.opensearch/root.crt
```

