```json
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": "*",
    "Action": "*",
    "Resource": [
      "arn:aws:s3:::<имя_бакета>/*",
      "arn:aws:s3:::<имя_бакета>"
    ],
    "Condition": {
      "StringEquals": {
        "yc:private-endpoint-id": "<идентификатор_подключения>"
      }
    }
  }
}
```

Где:

* `<имя_бакета>` — имя бакета в {{ objstorage-name }}, к которому нужно применить политику доступа, например `my-s3-bucket`.
* `<идентификатор_подключения>` — идентификатор сервисного подключения (Private Endpoint), например `enpd7rq1s3f5********`.