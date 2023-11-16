# Просмотр и удаление незавершённых загрузок


## Описание задачи {#case-description}

Возникла необходимость посмотреть или удалить незавершённые загрузки в следующих ситуациях:
- в консоли отображается незавершённая загрузка,
- объём загруженных файлов не совпадает с общим объёмом бакета.

## Решение {#case-resolution}

Недавно мы добавили возможность просмотра и удаления незавершённых загрузок [непосредственно в консоли](../../../storage/operations/objects/deleting-multipart.md).

Наличие незавершённых составных загрузок можно проверить командой:

```
aws --endpoint https://storage.yandexcloud.net s3api list-multipart-uploads --bucket <bucket_name>
```

Отменить их можно командой `abort-multipart-upload`:

```
aws --endpoint https://storage.yandexcloud.net s3api abort-multipart-upload --bucket <bucket_name> --key <object_key> --upload-id <upload_id>
```

Также вы можете [использовать CyberDuck](https://docs.cyberduck.io/protocols/s3/#multipart-uploads).

