{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p ~/.mysql && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.mysql/root.crt && \
   chmod 0600 ~/.mysql/root.crt
   ```

   The certificate will be saved to the `~/.mysql/root.crt` file.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.mysql; curl.exe -o $HOME\.mysql\root.crt {{ crt-web-path }}
   ```

   The certificate will be saved to the `$HOME\.mysql\root.crt` file.

   Corporate policies and antivirus software can block the download of certificates. For more information, see [FAQ](../../../managed-mysql/qa/connection.md#get-ssl-error).

{% endlist %}
