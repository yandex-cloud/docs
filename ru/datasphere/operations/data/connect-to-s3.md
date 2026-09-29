# Подключение к S3 с помощью библиотеки boto3

В этой инструкции описано, как подключиться к объектному хранилищу [S3](../../../glossary/s3.md) в {{ jlab }} Notebook с помощью библиотеки `boto3`. Для подключения к объектному хранилищу вы также можете использовать [коннектор S3](s3-connectors.md).

{% include [fuse-disclaimer](../../../_includes/datasphere/fuse-disclaimer.md) %}

Чтобы настроить подключение к S3 из кода ноутбука:

1. [Создайте секреты](secrets.md#create) `token` с идентификатором и `key_value` с секретной частью [статического ключа доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта.
1. {% include [include](../../../_includes/datasphere/ui-before-begin.md) %}
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

    ENDPOINT = "https://{{ s3-storage-host }}"

    session = boto3.Session(
        aws_access_key_id=(os.environ['token']),
        aws_secret_access_key=(os.environ['key_value']),
        region_name="{{ region-id }}",
    )

    s3 = session.client(
        "s3", endpoint_url=ENDPOINT)
    ```

1. Получите список объектов в бакете:

    ```python
    paginator = s3.get_paginator('list_objects_v2')
    for page in paginator.paginate(Bucket='<имя_бакета>'):
        for key in page.get('Contents', []):
            print(key['Key'])
    ```
