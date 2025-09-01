{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p ~/.mongodb && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.mongodb/root.crt && \
   chmod 0644 ~/.mongodb/root.crt
   ```

   Сертификат будет сохранен в файле `~/.mongodb/root.crt`.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.mongodb; curl.exe -o $HOME\.mongodb\root.crt {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\.mongodb\root.crt`.

   Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее см. в разделе [Вопросы и ответы](../../../storedoc/qa/storedoc#get-ssl-error).

{% endlist %}
