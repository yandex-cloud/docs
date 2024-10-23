{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   {% include [unix-certificate](./unix-certificate.md) %}

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.redis; curl.exe -o $HOME\.redis\{{ crt-local-file }} {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\.redis\{{ crt-local-file }}`.

{% endlist %}
