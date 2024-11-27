{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   {% include [unix-certificate](./unix-certificate.md) %}

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.redis; curl.exe -o $HOME\.redis\{{ crt-local-file }} {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\.redis\{{ crt-local-file }}`.

   Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее см. в разделе [Вопросы и ответы](../../../managed-redis/qa/general.md#get-ssl-error).

{% endlist %}
