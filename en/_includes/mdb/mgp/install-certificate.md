{% list tabs %}

- Linux (Bash) and macOS (Zsh)

   ```bash
   mkdir -p ~/.postgresql && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.postgresql/root.crt && \
   chmod 0600 ~/.postgresql/root.crt
   ```

   The certificate is saved to the `~/.postgresql/root.crt` file.

- Windows (PowerShell)

   ```powershell
   mkdir $HOME\.postgresql; curl.exe -o $HOME\.postgresql\root.crt {{ crt-web-path }}
   ```

   The certificate is saved to the `$HOME\.postgresql\root.crt` file.

{% endlist %}
