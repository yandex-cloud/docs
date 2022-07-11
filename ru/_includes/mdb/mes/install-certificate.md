{% if audience == "internal" %}

```bash
sudo mkdir --parents ~/.elasticsearch && \
sudo wget "{{ pem-path }}" \
    --output-document ~/.elasticsearch/root.crt && \
sudo chmod 0600 ~/.elasticsearch/root.crt
```

{% else %}

```bash
sudo mkdir --parents ~/.elasticsearch && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document ~/.elasticsearch/root.crt && \
sudo chmod 0600 ~/.elasticsearch/root.crt
```

{% endif %}
