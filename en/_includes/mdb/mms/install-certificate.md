```bash
sudo mkdir --parents {{ crt-local-dir }} && \
sudo wget "{{ crt-web-path }}" \
    --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
sudo chmod 0600 {{ crt-local-dir }}{{ crt-local-file }}
```
