{% list tabs %}

- Linux (Bash) и macOS (Zsh)

   ```bash
   mkdir -p ~/.elasticsearch && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.elasticsearch/root.crt && \
   chmod 0600 ~/.elasticsearch/root.crt
   ```

   Сертификат будет сохранен в файле `~/.elasticsearch/root.crt`.

- Windows (PowerShell)

   ```powershell
   mkdir $HOME\.elasticsearch; curl.exe -o $HOME\.elasticsearch\root.crt {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\.elasticsearch\root.crt`.

{% endlist %}
