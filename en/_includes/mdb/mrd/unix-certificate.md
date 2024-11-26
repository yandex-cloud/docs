```bash
mkdir -p ~/.redis && \
wget "{{ crt-web-path }}" \
     --output-document ~/.redis/{{ crt-local-file }} && \
chmod 0655 ~/.redis/{{ crt-local-file }}
```

The certificate will be saved to the `~/.redis/{{ crt-local-file }}` file.
