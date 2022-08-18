{% if audience != "internal" %}

```bash
mkdir --parents ~/.mongodb && \
wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document ~/.mongodb/root.crt && \
chmod 0644 ~/.mongodb/root.crt
```

{% else %}

```bash
mkdir --parents ~/.mongodb && \
wget "{{ pem-path }}" \
    --output-document ~/.mongodb/root.crt && \
chmod 0644 ~/.mongodb/root.crt
```

{% endif %}
