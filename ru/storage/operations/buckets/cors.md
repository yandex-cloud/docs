---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Настройка CORS

{{ objstorage-name }} позволяет управлять [конфигурацией CORS](../../concepts/cors.md) в бакете.

{% list tabs %}

- Консоль управления


    1. В консоли управления перейдите в бакет, для которого хотите настроить CORS.
    2. В левой панели выберите **CORS**.
    3. Нажмите кнопку **Настроить CORS**.
    4. Откроется страница, на которой вы сможете добавлять, удалять и редактировать правила конфигурации. Подробное описание полей конфигурации смотрите в разделе [{#T}](../../s3/api-ref/cors/xml-config.md).

- AWS CLI

    Чтобы загрузить конфигурацию с помощью AWS CLI:

    1. Опишите конфигурацию CORS объектов в формате JSON. Например:

        ```
        {
            "CORSRules": [
                {
                    "AllowedHeaders": ["*"],
                    "AllowedMethods": ["GET", "HEAD", "PUT", "DELETE"],
                    "MaxAgeSeconds": 3000,
                    "AllowedOrigins": ["*"]
                }
            ]
        }
        ```

        Готовую конфигурацию можно поместить в файл, например, `cors.json`.

    2. Загрузите конфигурацию в бакет, например `shared-bucket`:

        ```
        aws s3api put-bucket-cors \
            --bucket shared-bucket \
            --cors-configuration file://cors.json \
            --endpoint-url=https://{{ s3-storage-host }}
        ```

{% endlist %}