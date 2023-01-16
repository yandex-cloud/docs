```bash
sudo mkdir --parents {{ crt-local-dir }} && \
sudo wget "{{ crt-web-path }}" \
    --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
sudo chmod 655 {{ crt-local-dir }}{{ crt-local-file }}
```

Сертификат будет сохранен в файле `{{ crt-local-dir }}{{ crt-local-file }}`.
