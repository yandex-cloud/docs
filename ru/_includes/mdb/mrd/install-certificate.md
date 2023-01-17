```bash
mkdir --parents ~/.redis && \
wget "{{ crt-web-path }}" \
    --output-document ~/.redis/{{ crt-local-file }} && \
chmod 0655 ~/.redis/{{ crt-local-file }}
```

Для использования графических IDE [скачайте сертификат]({{ crt-web-path }}) и укажите путь к нему в настройках подключения.
