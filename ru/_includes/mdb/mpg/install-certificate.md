{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p ~/.postgresql && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.postgresql/root.crt && \
   chmod 0600 ~/.postgresql/root.crt
   ```

   Сертификат будет сохранен в файле `~/.postgresql/root.crt`.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.postgresql; curl.exe -o $HOME\.postgresql\root.crt {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\.postgresql\root.crt`.

{% endlist %}
