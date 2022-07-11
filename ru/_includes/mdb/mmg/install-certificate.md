{% if audience != "internal" %}

```bash
sudo mkdir --parents ~/.mongodb && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" \ 
    --output-document ~/.mongodb/root.crt && \
sudo chmod 0644 ~/.mongodb/root.crt
```

{% else %}

```bash
sudo mkdir --parents ~/.mongodb && \
sudo wget "{{ pem-path }}" \
    --output-document ~/.mongodb/root.crt && \
sudo chmod 0644 ~/.mongodb/root.crt
```

{% endif %}
