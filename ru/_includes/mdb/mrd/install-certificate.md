{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p ~/.redis && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.redis/{{ crt-local-file }} && \
   chmod 0655 ~/.redis/{{ crt-local-file }}
   ```

   Сертификат будет сохранен в файле `~/.redis/{{ crt-local-file }}`.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.redis; curl.exe -o $HOME\.redis\{{ crt-local-file }} {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\.redis\{{ crt-local-file }}`.

{% endlist %}
