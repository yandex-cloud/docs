{% if audience != "internal" %}

```bash
mkdir --parents ~/.mysql && \
wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document ~/.mysql/root.crt && \
chmod 0600 ~/.mysql/root.crt
```

{% else %}

```bash
mkdir --parents ~/.mysql && \
wget "{{ pem-path }}" \
    --output-document ~/.mysql/root.crt && \
chmod 0600 ~/.mysql/root.crt
```

{% endif %}
