{% list tabs %}

- Linux (Bash) и macOS (Zsh)

   ```bash
   mkdir -p {{ crt-local-dir }} && \
   wget "{{ crt-web-path }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
   chmod 0655 {{ crt-local-dir }}{{ crt-local-file }}
   ```

   Сертификат будет сохранен в файле `{{ crt-local-dir }}{{ crt-local-file }}`.

- Windows (PowerShell)

   ```powershell
   mkdir $HOME\.kafka; curl.exe -o $HOME\.kafka\{{ crt-local-file }} {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\.kafka\{{ crt-local-file }}`.

{% endlist %}
