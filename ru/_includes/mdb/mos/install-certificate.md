{% list tabs %}

- Linux (Bash) и macOS (Zsh)

   ```bash
   mkdir -p ~/.opensearch && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.opensearch/root.crt && \
   chmod 0600 ~/.opensearch/root.crt
   ```

   Сертификат будет сохранен в файле `~/.opensearch/root.crt`.

- Windows (PowerShell)

   ```powershell
   mkdir $HOME\.opensearch; curl -o $HOME\.opensearch\root.crt {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\.opensearch\root.crt`.

{% endlist %}
