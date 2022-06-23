
```bash
sudo mkdir --parents {{ crt-local-dir }} && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document={{ crt-local-dir }}{{ crt-local-file }} && \
sudo chmod 655 {{ crt-local-dir }}{{ crt-local-file }}
```

