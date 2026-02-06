Выполните запрос:

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <IAM-токен>" \
  -d '{
       "folderId": "b1g07hj5r6i4********",
       "name": "baremetal-ubuntu",
       "description": "New OS Baremetal Image",
       "uri": "https://storage.yandexcloud.net/bm-test-backet/new-server-amd64.iso",
       "labels": {
         "key": "ubuntu"
       }
      }' \
  "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/images"
```

Где:

* `<IAM-токен>` — IAM-токен для аутентификации.
* `folderId` — идентификатор каталога.
* `name` — имя образа. Требования к имени:

  {% include [name-format](../../_includes/name-format.md) %}

* `description` — описание образа. Необязательный параметр.
* `uri` — ссылка на образ, полученная в {{ objstorage-name }}.
* `labels` — метки образа. Необязательный параметр.
  
Результат:

```bash
{
"done": false,
"metadata": {
  "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.CreateImageMetadata",
  "imageId": "ly5kr5tjsple********"
},
"id": "ly5iwrc2uvuf********",
"description": "User image create",
"createdAt": "2025-12-07T20:31:52.845955Z",
"createdBy": "ajeb9l33h6mu********",
"modifiedAt": "2025-12-07T20:31:52.845955Z"
}
```

  Отслеживайте статус операции по полю `done`.
