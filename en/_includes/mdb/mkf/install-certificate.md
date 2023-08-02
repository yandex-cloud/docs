{% list tabs %}

- Linux (Bash) and macOS (Zsh)

   ```bash
   mkdir -p {{ crt-local-dir }} && \
   wget "{{ crt-web-path }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
   chmod 0655 {{ crt-local-dir }}{{ crt-local-file }}
   ```

   The certificate is saved to the `{{ crt-local-dir }}{{ crt-local-file }}` file.

- Windows (PowerShell)

   ```powershell
   mkdir $HOME\.kafka; curl.exe -o $HOME\.kafka\{{ crt-local-file }} {{ crt-web-path }}
   ```

   The certificate is saved to the `$HOME\.kafka\{{ crt-local-file }}` file.

{% endlist %}
