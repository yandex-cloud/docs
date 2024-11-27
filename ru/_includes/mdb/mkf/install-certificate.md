{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p {{ crt-local-dir }} && \
   wget "{{ crt-web-path }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
   chmod 0655 {{ crt-local-dir }}{{ crt-local-file }}
   ```

   Сертификат будет сохранен в файле `{{ crt-local-dir }}{{ crt-local-file }}`.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.kafka; curl.exe -o $HOME\.kafka\{{ crt-local-file }} {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\.kafka\{{ crt-local-file }}`.

   Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее см. в разделе [Вопросы и ответы](../../../managed-kafka/qa/index.md#get-ssl-error).

{% endlist %}
