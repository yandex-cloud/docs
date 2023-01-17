```bash
sudo mkdir --parents ~/.opensearch && \
sudo wget "{{ crt-web-path }}" \
    --output-document ~/.opensearch/root.crt && \
sudo chmod 0600 ~/.opensearch/root.crt
```
