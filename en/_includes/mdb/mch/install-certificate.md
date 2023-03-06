```bash
sudo mkdir --parents {{ crt-local-dir }} && \
sudo wget "{{ crt-web-path }}" \
    --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
sudo chmod 655 {{ crt-local-dir }}{{ crt-local-file }}
```

The certificate is saved to the `{{ crt-local-dir }}{{ crt-local-file }}` file.
