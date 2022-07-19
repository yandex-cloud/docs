{% if audience != "internal" %}

```bash
sudo mkdir --parents ~/.postgresql && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document ~/.postgresql/root.crt && \
sudo chmod 0600 ~/.postgresql/root.crt
```

{% else %}

```bash
sudo mkdir --parents ~/.postgresql && \
sudo wget "{{ pem-path }}" \
    --output-document ~/.postgresql/root.crt && \
sudo chmod 0600 ~/.postgresql/root.crt
```

{% endif %}
