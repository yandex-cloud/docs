# Как настроить заголовки кэширования cache-control для объектов в бакете при HTTP-запросах


## Описание сценария {#case-description}

Необходимо настроить заголовки кэширования cache-control для объектов в бакете при HTTP-запросах.

## Решение {#case-resolution}

Можно добавить заголовок `Cache-Control` к системным метаданным на этапе загрузки или модификации объекта в бакете. Подробнее о метаданных объекта пишем в [документации](../../../storage/concepts/object.md#metadata).

Чтобы добавить `Cache-Control` к уже загруженному объекту можно воспользоваться утилитой `s3cmd`. 
Для этого выполните команду: 
```
s3cmd --add-header 'Cache-Control:3600' modify s3://<your-bucket-name>/object-name.
```

Чтобы добавить заголовок `Cache-Control` во время загрузки объекта в бакет средствами `s3cmd`, укажите параметр `--add-header`: 
```
s3cmd --add-header 'Cache-Control:3600' put local_file s3://<your-bucket-name>/object-name. 
```

{% note info %}

Установить и настроить утилиту `s3cmd` можно [по этой инструкции](../../../storage/tools/s3cmd.md).

{% endnote %}

Вы также можете воспользоваться [утилитой AWS CLI](../../../storage/tools/aws-cli.md) для добавления заголовка Cache-Control.
Пример команды для AWS CLI: 
```
aws --endpoint-url=https://storage.yandexcloud.net s3 \
cp local_file s3://bucket_name --cache-control 'max-age=3600'
```