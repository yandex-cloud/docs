# CORS

[!KEYREF objstorage-full-name] поддерживает кросс-доменные запросы к объектам в корзине.

Настройка [конфигурации CORS](configuration.md) для каждой корзины доступна через [HTTP API, совместимый с Amazon S3](../s3/index.md). Таким образом, можно управлять конфигурацией CORS с помощью [инструментов](../instruments/index.md), которые взаимодействуют с [!KEYREF objstorage-name] через S3 HTTP API.

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

Загрузим `cors.json` в корзину `shared-bucket`:

```
aws s3api put-bucket-cors --bucket shared-bucket --cors-configuration file://cors.json \
    --endpoint-url=https://[!KEYREF s3-storage-host]
```