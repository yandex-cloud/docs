{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p ~/.opensearch && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.opensearch/root.crt && \
   chmod 0600 ~/.opensearch/root.crt
   ```

   The certificate will be saved to the `~/.opensearch/root.crt` file.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.opensearch; curl.exe -o $HOME\.opensearch\root.crt {{ crt-web-path }}
   ```

   The certificate will be saved to the `$HOME\.opensearch\root.crt` file.

   Corporate policies and antivirus software can block the download of certificates. For more information, see [FAQ](../../../managed-opensearch/qa/index.md#get-ssl-error).

{% endlist %}
