{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p ~/.opensearch && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.opensearch/root.crt && \
   chmod 0600 ~/.opensearch/root.crt
   ```

   Сертификат будет сохранен в файле `~/.opensearch/root.crt`.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.opensearch; curl --output $HOME\.opensearch\root.crt {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\.opensearch\root.crt`.

   Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее см. в разделе [Вопросы и ответы](../../../managed-opensearch/qa/index.md#get-ssl-error).

{% endlist %}
