{% if audience != "internal" %}

```bash
sudo mkdir ~/.redis && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" \
    --output-document ~/.redis/{{ crt-local-file }} && \
sudo chmod 0655 ~/.redis/{{ crt-local-file }}
```

To use the graphical IDE, [download the certificate](https://{{ s3-storage-host }}{{ pem-path }}) and specify the path to it in the connection settings.

{% else %}

```bash
sudo mkdir ~/.redis && \
sudo wget "{{ pem-path }}" \
    --output-document ~/.redis/{{ crt-local-file }} && \
sudo chmod 0655 ~/.redis/{{ crt-local-file }}
```

To use the graphical IDE, [download the certificate]({{ pem-path }}) and specify the path to it in the connection settings.

{% endif %}
