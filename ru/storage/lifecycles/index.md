# Жизненный цикл объектов в бакете

[!KEYREF objstorage-name] позволяет настроить время хранения объектов в бакете.

Управление [конфигурацией жизненного цикла](configuration.md) возможно через:

- [Консоль управления](setup.md) Яндекс.Облака.
- [HTTP API, совместимый с Amazon S3](../s3/index.md).
    
Таким образом, можно управлять конфигурацией жизненных циклов с помощью [инструментов](../instruments/index.md), которые взаимодействуют с [!KEYREF objstorage-name] через HTTP API, совместимый с Amazon S3.


## Пример загрузки конфигурации с помощью утилиты AWS CLI

1. Опишите конфигурацию жизненного цикла объектов в файле `lifecycles.json`:

    ```
    {
        "Rules": [
            {
                "ID": "Delete old backups",
                "Prefix": "backup/",
                "Status": "Enabled",
                "Expiration": [
                    {
                        "Days": "180"
                    }
                ]
            }
    }
    ```

2. Загрузите файл конфигурации в бакет `backup-bucket`:

    ```
    aws s3api put-bucket-lifecycle-configuration \
        --bucket backup-bucket \
        --lifecycle-configuration file://lifecycles.json \
        --endpoint-url=https://[!KEYREF s3-storage-host]
    ```
