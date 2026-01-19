```bash
mkdir -p ~/.redis && \
wget "{{ crt-web-path }}" \
     --output-document ~/.redis/{{ crt-local-file }} && \
chmod 0655 ~/.redis/{{ crt-local-file }}
```

Сертификат будет сохранен в файле `~/.redis/{{ crt-local-file }}`.
