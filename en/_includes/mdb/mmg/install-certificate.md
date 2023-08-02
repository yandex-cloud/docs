{% list tabs %}

- Linux (Bash) and macOS (Zsh)

   ```bash
   mkdir -p ~/.mongodb && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.mongodb/root.crt && \
   chmod 0644 ~/.mongodb/root.crt
   ```

   The certificate is saved to the `~/.mongodb/root.crt` file.

- Windows (PowerShell)

   ```powershell
   mkdir $HOME\.mongodb; curl.exe -o $HOME\.mongodb\root.crt {{ crt-web-path }}
   ```

   The certificate is saved to the `$HOME\.mongodb\root.crt` file.

{% endlist %}
