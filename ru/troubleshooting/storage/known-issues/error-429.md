# Устранение ошибки 429


## Описание проблемы {#issue-description}

При попытке удалить несколько файлов одновременно возникает ошибка:
```
message: ; status: 429; description: ; code: undefined; Request ID: undefined; Trace ID: undefined;
```
## Решение {#issue-resolution}

Такая ошибка говорит о слишком большом количестве запросов. При её возникновении рекомендуем снизить частоту обращений к Object Storage.

{% noteinfo %}

Со всеми кодами ошибок и ответов API Object Storage можно ознакомиться в [документации](../../../storage/s3/api-ref/response-codes.md)

{% endnote %}

Для удаления большого количества объектов рекомендуем воспользоваться AWS CLI и удалить файлы рекурсивно командой:

```
aws s3 --endpoint-url=https://storage.yandexcloud.net rm s3://bucket-name --recursive
```

Также можно удалить рекурсивно все файлы с одинаковым префиксом. Следующая команда удалит все файлы с префиксом `my-folder/` в бакете `my-bucket`:

```
aws s3 --endpoint-url=https://storage.yandexcloud.net rm s3://my-bucket/my-folder/ --recursive
```

Инструкция по установке и настройке AWS CLI также есть в нашей [документации](../../../docs/storage/tools/aws-cli).
