
```bash
mkdir --parents ~/.redis && \
wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document ~/.redis/{{ crt-local-file }} && \
chmod 0655 ~/.redis/{{ crt-local-file }}
```

Для использования графических IDE [скачайте сертификат](https://{{ s3-storage-host }}{{ pem-path }}) и укажите путь к нему в настройках подключения.

