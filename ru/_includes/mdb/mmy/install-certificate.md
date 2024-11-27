{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p ~/.mysql && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.mysql/root.crt && \
   chmod 0600 ~/.mysql/root.crt
   ```

   Сертификат будет сохранен в файле `~/.mysql/root.crt`.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.mysql; curl.exe -o $HOME\.mysql\root.crt {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\.mysql\root.crt`.

   Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее см. в разделе [Вопросы и ответы](../../../managed-mysql/qa/connection.md#get-ssl-error).

{% endlist %}
