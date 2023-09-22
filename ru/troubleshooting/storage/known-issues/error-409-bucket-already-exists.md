# Устранение ошибки 409 BucketAlreadyExists


## Описание проблемы {#issue-description}

При попытке создания бакета возникает ошибка:
```
409 BucketAlreadyExists, The requested bucket name is not available. The bucket namespace is shared by all users of the system. Please select a different name and try again.
```

## Решение {#issue-resolution}

Имена бакетов уникальны для всего Object Storage, поэтому не получится создать два бакета с одинаковыми именами даже в разных каталогах разных облаков. Необходимо задать другое имя бакета и попробовать снова.

Подробнее об особенностях именования бакетов пишем в [документации](../../../storage/concepts/bucket#naming).
