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
     region={{ region-id }}
   ```
   {% note info %}

   Некоторые приложения, предназначенные для работы с Amazon S3, не позволяют указывать регион, поэтому {{ objstorage-name }} принимает также значение `us-east-1`.

   {% endnote %}