{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p ~/.mysql && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.mysql/root.crt && \
   chmod 0600 ~/.mysql/root.crt
   ```

   The certificate is saved to the `~/.mysql/root.crt` file.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.mysql; curl.exe -o $HOME\.mysql\root.crt {{ crt-web-path }}
   ```

   The certificate is saved to the `$HOME\.mysql\root.crt` file.

{% endlist %}
