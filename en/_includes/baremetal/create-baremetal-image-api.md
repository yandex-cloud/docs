Run this query:

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <IAM_token>" \
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

Where:

* `<IAM_token>`: IAM token used for authentication.
* `folderId`: Folder ID.
* `name`: Image name. Follow these naming requirements:

  {% include [name-format](../../_includes/name-format.md) %}

* `description`: Image description. This is an optional parameter.
* `uri`: Image link you got in {{ objstorage-name }}.
* `labels`: Image labels. This is an optional parameter.
  
Result:

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

  Follow the status of the operation by the `done` field.
