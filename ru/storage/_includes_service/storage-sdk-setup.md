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
               region=us-east-1
   ```
   > [!NOTE]
   >
   > Для работы с Yandex Object Storage всегда указывайте регион — `us-east-1`. Другие значения региона могут привести к ошибке авторизации.
   >

Для доступа к [!KEYREF objstorage-name] используйте адрес `[!KEYREF s3-storage-host]`.