{% if audience != "internal" %}

```bash
sudo mkdir --parents ~/.mysql && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document ~/.mysql/root.crt && \
sudo chmod 0600 ~/.mysql/root.crt
```

{% else %}

```bash
sudo mkdir --parents ~/.mysql && \
sudo wget "{{ pem-path }}" \
    --output-document ~/.mysql/root.crt && \
sudo chmod 0600 ~/.mysql/root.crt
```

{% endif %}
