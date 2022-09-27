
```bash
mkdir --parents ~/.redis && \
wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document ~/.redis/{{ crt-local-file }} && \
chmod 0655 ~/.redis/{{ crt-local-file }}
```

To use the graphical IDE, [download the certificate](https://{{ s3-storage-host }}{{ pem-path }}) and specify the path to it in the connection settings.

