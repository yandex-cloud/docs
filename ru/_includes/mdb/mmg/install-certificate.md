{% list tabs %}

- Linux (Bash) и macOS (Zsh)

   ```bash
   mkdir -p ~/.mongodb && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.mongodb/root.crt && \
   chmod 0644 ~/.mongodb/root.crt
   ```

   Сертификат будет сохранен в файле `~/.mongodb/root.crt`.

- Windows (PowerShell)

   ```powershell
   mkdir $HOME\.mongodb; curl.exe -o $HOME\.mongodb\root.crt {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\.mongodb\root.crt`.

{% endlist %}
