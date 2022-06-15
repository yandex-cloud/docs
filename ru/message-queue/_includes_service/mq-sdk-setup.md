Для настройки создайте в домашнем каталоге файлы конфигурации и задайте в них:

- Статический ключ в файле `.aws/credentials`:
   ```
   [default]
               aws_access_key_id = <id>
               aws_secret_access_key = <secretKey>
   ```

- Регион по умолчанию в файле `.aws/config`:
   ```
   [default]
               region=RU-CENTRAL
   ```
   {% note info %}

   Для работы с {{ objstorage-full-name }} всегда указывайте регион — `RU-CENTRAL`. Другие значения региона могут привести к ошибке авторизации.

   {% endnote %}
