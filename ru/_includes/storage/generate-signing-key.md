Чтобы сгенерировать подписывающий ключ:

1. Закодируйте дату с помощью секретного ключа:

    ```
    DateKey = sign("AWS4" + "SecretKey", "yyyymmdd")
    ```

1. Закодируйте регион с помощью полученного на предыдущем шаге ключа `DateKey`:

    ```
    RegionKey = sign(DateKey, "{{ region-id }}")
    ```

1. Закодируйте сервис с помощью полученного на предыдущем шаге ключа `RegionKey`:

    ```
    ServiceKey = sign(RegionKey, "s3")
    ```

1. Получите подписывающий ключ:

    ```
    SigningKey = sign(ServiceKey, "aws4_request")
    ```
