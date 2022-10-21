{% if audience != "internal" %}

```bash
sudo mkdir --parents {{ crt-local-dir }} && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
sudo chmod 655 {{ crt-local-dir }}{{ crt-local-file }}
```

{% else %}

```bash
sudo mkdir --parents {{ crt-local-dir }} && \
sudo wget "{{ pem-path }}" \
    --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
sudo chmod 0655 {{ crt-local-dir }}{{ crt-local-file }}
```

{% endif %}

Сертификат будет сохранен в файле `{{ crt-local-dir }}{{ crt-local-file }}`.
