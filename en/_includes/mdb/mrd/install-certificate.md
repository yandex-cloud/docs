{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   {% include [unix-certificate](./unix-certificate.md) %}

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.redis; curl.exe -o $HOME\.redis\{{ crt-local-file }} {{ crt-web-path }}
   ```

   The certificate will be saved to the `$HOME\.redis\{{ crt-local-file }}` file.

   Corporate policies and antivirus software can block the download of certificates. For more information, see [FAQ](../../../managed-redis/qa/general.md#get-ssl-error).

{% endlist %}
