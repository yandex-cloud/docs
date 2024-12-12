{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p ~/.mongodb && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.mongodb/root.crt && \
   chmod 0644 ~/.mongodb/root.crt
   ```

   The certificate will be saved to the `~/.mongodb/root.crt` file.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.mongodb; curl.exe -o $HOME\.mongodb\root.crt {{ crt-web-path }}
   ```

   The certificate will be saved to the `$HOME\.mongodb\root.crt` file.

   Corporate policies and antivirus software can block the download of certificates. For more information, see [FAQ](../../../managed-mongodb/qa/mongodb.md#get-ssl-error).

{% endlist %}
