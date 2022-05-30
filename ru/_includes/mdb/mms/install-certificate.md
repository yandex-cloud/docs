{% if audience != "internal" %}

```bash
sudo mkdir --parents /usr/local/share/ca-certificates/Yandex && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document=/usr/local/share/ca-certificates/Yandex/YandexCA.crt && \
sudo chmod 0600 /usr/local/share/ca-certificates/Yandex/YandexCA.crt
```

{% else %}

```bash
sudo mkdir --parents /usr/local/share/ca-certificates/Yandex && \
sudo wget "{{ pem-path }}" \
    --output-document=/usr/local/share/ca-certificates/Yandex/YandexCA.crt && \
sudo chmod 0600 /usr/local/share/ca-certificates/Yandex/YandexCA.crt
```

{% endif %}
