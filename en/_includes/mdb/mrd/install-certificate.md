```bash
mkdir --parents ~/.redis && \
wget "{{ crt-web-path }}" \
    --output-document ~/.redis/{{ crt-local-file }} && \
chmod 0655 ~/.redis/{{ crt-local-file }}
```

To use graphical IDEs, [download a certificate]({{ crt-web-path }}) and specify the path to it in the connection settings.
