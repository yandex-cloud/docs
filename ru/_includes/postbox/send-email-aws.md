1. [Установите](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) утилиту командной строки AWS CLI.
1. Настройте AWS CLI:
    1. Запустите интерактивную настройку профиля:
        ```
        aws configure
        ```
    1. Укажите полученный ранее идентификатор ключа сервисного аккаунта `postbox-user`:
        ```
        AWS Access Key ID [****************ver_]: <идентификатор_ключа_сервисного_аккаунта>
        ```
    1. Укажите полученный ранее секретный ключ сервисного аккаунта `postbox-user`:
        ```
        AWS Secret Access Key [****************w5lb]: <секретный_ключ_сервисного_аккаунта>
        ```
    1. Укажите имя региона по умолчанию {{ region-id }}:
        ```
        Default region name [{{ region-id }}]: {{ region-id }}
        ```
    1. Укажите формат выходных данных по умолчанию json:
        ```
        Default output format [None]: json
        ```

1. Подготовьте два JSON-файла:

    * `destination.json` — файл со списком адресов назначения:

        ```json
        {
          "ToAddresses": ["test@example.com"]
        }
        ```

    * `message.json` — файл с темой и содержимым письма:

       ```json
       {
         "Simple": {
           "Subject": {
             "Data": "Test message",
             "Charset": "UTF-8"
           },
           "Body": {
             "Text": {
               "Data": "Test message. Hello!",
               "Charset": "UTF-8"
             }
           }
         }
       }
       ```

1. Отправьте письмо с помощью AWS CLI:

    ```bash
    aws sesv2 send-email \
      --from-email-address mail@example.com \
      --destination file://destination.json \
      --content file://message.json \
      --endpoint-url {{ postbox-endpoint }}
    ```

1. Проверьте почтовый ящик, указанный в `destination.json`, — туда должно прийти письмо.