{% list tabs %}

- Linux (Bash) и macOS (Zsh)

   ```bash
   mkdir -p ~/.mysql && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.mysql/root.crt && \
   chmod 0600 ~/.mysql/root.crt
   ```

   Сертификат будет сохранен в файле `~/.mysql/root.crt`.

- Windows (PowerShell)

   ```powershell
   mkdir $HOME\.mysql; curl.exe -o $HOME\.mysql\root.crt {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\.mysql\root.crt`.

{% endlist %}
