{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   {% include [unix-certificate](./unix-certificate.md) %}

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\AppData\Roaming\.redis; curl.exe -o $HOME\AppData\Roaming\.redis\{{ crt-local-file }} {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\AppData\Roaming\.redis\{{ crt-local-file }}`.

   Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее в разделе [Вопросы и ответы](../../../managed-valkey/qa/general.md#get-ssl-error).

{% endlist %}
