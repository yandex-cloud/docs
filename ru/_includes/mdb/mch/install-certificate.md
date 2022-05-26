{% if audience != "internal" %}

```bash
sudo mkdir --parents /usr/local/share/ca-certificates/Yandex && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt && \
sudo chmod 655 /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
```

{% else %}

```bash
sudo mkdir --parents /usr/local/share/ca-certificates/Yandex && \
wget "{{ pem-path }}" \
    --output-document=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt && \
chmod 0655 /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
```

{% endif %}
