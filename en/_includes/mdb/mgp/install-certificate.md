{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p ~/.postgresql && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.postgresql/root.crt && \
   chmod 0655 ~/.postgresql/root.crt
   ```

   The certificate will be saved to the `~/.postgresql/root.crt` file.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.postgresql; curl.exe -o $HOME\.postgresql\root.crt {{ crt-web-path }}
   ```

   The certificate will be saved to the `$HOME\.postgresql\root.crt` file.

   Corporate policies and antivirus software can block the download of certificates. For more information, see [FAQ](../../../managed-postgresql/qa/connection.md#get-ssl-error).

{% endlist %}
