
```bash
sudo mkdir ~/.redis && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document=~/.redis/YandexInternalRootCA.crt && \
sudo chmod 0655 ~/.redis/YandexInternalRootCA.crt
```

Для использования графических IDE [скачайте сертификат](https://{{ s3-storage-host }}{{ pem-path }}) и укажите путь к нему в настройках подключения.
