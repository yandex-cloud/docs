{% if audience == "internal" %}

```bash
mkdir --parents ~/.elasticsearch && \
wget "{{ pem-path }}" \
    --output-document ~/.elasticsearch/root.crt && \
chmod 0600 ~/.elasticsearch/root.crt
```

{% else %}

```bash
mkdir --parents ~/.elasticsearch && \
wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document ~/.elasticsearch/root.crt && \
chmod 0600 ~/.elasticsearch/root.crt
```

{% endif %}
