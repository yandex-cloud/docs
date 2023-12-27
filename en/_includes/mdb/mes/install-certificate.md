{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p ~/.elasticsearch && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.elasticsearch/root.crt && \
   chmod 0600 ~/.elasticsearch/root.crt
   ```

   The certificate is saved to the `~/.elasticsearch/root.crt` file.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.elasticsearch; curl.exe -o $HOME\.elasticsearch\root.crt {{ crt-web-path }}
   ```

   The certificate is saved to the `$HOME\.elasticsearch\root.crt` file.

{% endlist %}
