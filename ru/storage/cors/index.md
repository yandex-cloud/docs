# CORS

Yandex Object Storage поддерживает кросс-доменные запросы к объектам в бакете.

Настройка [конфигурации CORS](configuration.md) для каждого бакета доступна через:

- [Консоль управления](setup.md) Яндекс.Облака.
- [HTTP API, совместимый с Amazon S3](../s3/index.md).

    Таким образом, можно управлять конфигурацией CORS с помощью [инструментов](../instruments/index.md), которые взаимодействуют с Object Storage через HTTP API, совместимый с Amazon S3.

## Пример загрузки конфигурации CORS с помощью утилиты AWS CLI

Поместим конфигурацию CORS в файл `cors.json`:

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

Загрузим `cors.json` в бакет `shared-bucket`:

```
aws s3api put-bucket-cors --bucket shared-bucket --cors-configuration file://cors.json \
    --endpoint-url=https://storage.yandexcloud.net
```
