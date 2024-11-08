Где:
* `<IAM-токен>` — полученный перед началом работы IAM-токен.
* `<идентификатор_обложки>` — сохраненное ранее значение идентификатора обложки.

Результат:

```text
{
  "uploadUrl": "https://{{ s3-storage-host }}/videoplatform-thumbnail/vpltleyrfnjh********?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=********3aBOmv27nzbJZaEHZ%2F20241102%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20241102T190000Z&X-Amz-Expires=43200&X-Amz-Signature=057fe4c0da26c7758474f5eaa85ff41d7212632572fb636ed6d8f65d039c309b&X-Amz-SignedHeaders=host"
}
```

Поле `uploadUrl` содержит подписанную ссылку, с помощью которой вы сможете загрузить файл обложки.