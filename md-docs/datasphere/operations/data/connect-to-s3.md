[Документация Yandex Cloud](../../../index.md) > [Yandex DataSphere](../../index.md) > [Пошаговые инструкции](../index.md) > Подключение к источникам данных > Подключение к S3 с помощью библиотеки boto3

# Подключение к S3 с помощью библиотеки boto3

В этой инструкции описано, как подключиться к объектному хранилищу [S3](../../../glossary/s3.md) в Jupyter Notebook с помощью библиотеки `boto3`. Для подключения к объектному хранилищу вы также можете использовать [коннектор S3](s3-connectors.md).

{% note info %}

Старайтесь не использовать хранилище S3 в режиме [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)) для работы в бакете с одноуровневыми (нерекурсивными) каталогами с большим количеством файлов. Такой сценарий использования вызывает существенное снижение производительности хранилища.

{% endnote %}

Чтобы настроить подключение к S3 из кода ноутбука:

1. [Создайте секреты](secrets.md#create) `token` с идентификатором и `key_value` с секретной частью [статического ключа доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта.
1. Откройте проект DataSphere:
   
   1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
   1. Нажмите кнопку **Открыть проект в JupyterLab** и дождитесь окончания загрузки.
   1. Откройте вкладку с ноутбуком.
1. Импортируйте библиотеки:

    ```python
    import boto3
    import os
    from os import path
    ```

1. Введите имя своего бакета в хранилище:

    ```python
    bucket_name = '<имя_бакета>'
    ```

1. Установите подключение:

    ```python
    session = boto3.session.Session()

    ENDPOINT = "https://storage.yandexcloud.net"

    session = boto3.Session(
        aws_access_key_id=(os.environ['token']),
        aws_secret_access_key=(os.environ['key_value']),
        region_name="ru-central1",
    )

    s3 = session.client(
        "s3", endpoint_url=ENDPOINT)
    ```

1. Введите имя бакета и получите список объектов в нем:

    ```python
    for key in s3.list_objects(Bucket='<имя_бакета>')['Contents']:
        print(key['Key'])
    ```