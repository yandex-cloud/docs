---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Удаление частично загруженного объекта

Объект может быть загружен не полностью при использовании [составной загрузки](../../concepts/multipart.md). Вы не можете увидеть и удалить подобный объект с помощью консоли управления, для этого необходимо использовать [инструменты](../../tools/index.md), которые поддерживают составную загрузку.

{% list tabs %}

- AWS CLI

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} s3api abort-multipart-upload --bucket <bucket-name> --key <key> --upload-id <number>
  ```

  Если вы не знаете идентификатор загрузки (`number`), найдите его в списке загрузок.

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} s3api list-multipart-uploads --bucket <bucket-name>
  ```

{% endlist %}