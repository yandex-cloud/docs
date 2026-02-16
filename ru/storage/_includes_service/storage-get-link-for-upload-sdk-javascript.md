Перед использованием примеров сохраните необходимые аутентификационные данные в переменные окружения:

```bash
export AWS_ACCESS_KEY_ID="<идентификатор_статического_ключа>"
export AWS_SECRET_ACCESS_KEY="<секретный_ключ>"
export AWS_DEFAULT_REGION="{{ region-id }}"
export AWS_REGION="{{ region-id }}"
export AWS_ENDPOINT_URL="https://{{ s3-storage-host }}"
```

Где:
* `AWS_ACCESS_KEY_ID` — [идентификатор](../../iam/concepts/authorization/access-key.md#key-id) статического ключа доступа.
* `AWS_SECRET_ACCESS_KEY` — [секретный ключ](../../iam/concepts/authorization/access-key.md#private-key).

Код в примерах генерирует подписанный URL для загрузки объекта с заданным [ключом](../concepts/object.md#key) в заданный бакет. Полученный URL действителен в течение одного часа.

В данном примере размер загружаемого объекта ограничен и не может превышать заданного в коде значения — 5 МБ.

В примере используются библиотеки [@aws-sdk/client-s3](https://www.npmjs.com/package/@aws-sdk/client-s3) и [@aws-sdk/s3-presigned-post](https://www.npmjs.com/package/@aws-sdk/s3-presigned-post).

Выполните код:

```js
import { S3Client } from "@aws-sdk/client-s3";
import { createPresignedPost } from "@aws-sdk/s3-presigned-post";

const client = new S3Client();
const Bucket = "<имя_бакета>";
const Key = "<ключ_загружаемого_объекта>";
const max_size = 5 * 1024 * 1024;  // Максимальный размер загружаемого объекта в байтах

const Conditions = [["content-length-range", 1, max_size]];

const url = await createPresignedPost(client, {
  Bucket,
  Key,
  Conditions,
  Expires: 3600, // Срок действия ссылки в секундах
});

console.log(url)
```

Где:
* `Bucket` — [имя бакета](../concepts/bucket.md#naming), в который загружается файл.
* `Key` — [ключ](../concepts/object.md#key), который будет присвоен объекту в бакете. Например: `new-prefix/sample-object.txt`.
* `max_size` — максимально допустимый размер загружаемого файла в байтах.

Результат:

```txt
{
  url: 'https://my-sample-bucket.{{ s3-storage-host }}/',
  fields: {
    bucket: 'my-sample-bucket',
    'X-Amz-Algorithm': 'AWS4-HMAC-SHA256',
    'X-Amz-Credential': 'YCAJE98uTrKJwAtqw********/20250516/{{ region-id }}/s3/aws4_request',
    'X-Amz-Date': '20250516T210215Z',
    key: 'new-prefix/sample-object.txt',
    Policy: 'eyJleHBpcmF0aW9uIjoiMjAyNS0wNS0xNlQyMjowMjoxNVoiLCJjb25kaXRpb25zIjpbWyJjb250ZW50LWxlbmd0aC1yYW5nZSIsMSw1MjQyODgwXSx7ImJ1Y2tldCI6ImFsdGFyYXNraW4tdGVzdGVyLWJ1Y2tldCJ9LHsiWC1BbXotQWxnb3JpdGhtIjoiQVdTNC1ITUFDLVNIQTI1NiJ9LHsiWC1BbXotQ3JlZGVudGlhbCI6IllDQUpFOTh1VHJLSndBdHF3ckhKWE5oNUwvMjAyNTA1MTYvcnUtY2VudHJhbDEvczMvYXdzNF9yZXF1ZXN0In0seyJYLUFtei1EYXRlIjoiMjAyNTA1MTZUMjEwMjE1WiJ9LHsia2V5IjoiZmlsZS50********',
    'X-Amz-Signature': '2a8be28a4e2a72de98bd258a8362dd895dd0fdb1886a1764e7085282********'
  }
}
```

Используя полученные компоненты, отправьте HTTP-запрос на загрузку файла методом POST:

```bash
curl \
  --request POST \
  --form "key=new-prefix/sample-object.txt" \
  --form "x-amz-algorithm=AWS4-HMAC-SHA256" \
  --form "x-amz-credential=YCAJE98uTrKJwAtqw********/20250516/{{ region-id }}/s3/aws4_request" \
  --form "x-amz-date=20250516T145901Z" \
  --form "policy=eyJleHBpcmF0aW9uIjogIjIwMjUtMDUtMTZUMTU6NTk6MDFaIiwgImNvbmRpdGlvbnMiOiBbWyJjb250ZW50LWxlbmd0aC1yYW5nZSIsIDEsIDUyNDI4ODBdLCB7ImJ1Y2tldCI6ICJhbHRhcmFza2luLXRlc3Rlci1idWNrZXQifSwgeyJrZXkiOiAiZmlsZS50eHQifSwgeyJ4LWFtei1hbGdvcml0aG0iOiAiQVdTNC1ITUFDLVNIQTI1NiJ9LCB7IngtYW16LWNyZWRlbnRpYWwiOiAiWUNBSkU5OHVUcktKd0F0cXdySEpYTmg1TC8yMDI1MDUxNi9ydS1jZW50cmFsMS9zMy9hd3M0X3JlcXVlc3QifSwgeyJ4LWFtei1kYXRlIjogIjIwMjUwNTE2VDE0NTkw********" \
  --form "x-amz-signature=c2e1783095d20d89a7683fc582527740541de16156569d9950cfb1b7********" \
  --form "file=@sample-object.txt" \
  https://{{ s3-storage-host }}/my-sample-bucket
```

Где `@sample-object.txt` — путь к файлу, который нужно загрузить.

В результате файл будет загружен в бакет, если размер файла не превышает заданное в коде значение. Если файл больше установленного максимума, сервис вернет ошибку:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Error>
    <Code>EntityTooLarge</Code>
    <Message>Your proposed upload exceeds the maximum allowed object size.</Message>
    <Resource>/</Resource>
    <RequestId>5575e8faa94e02b2</RequestId>
    <MaxSizeAllowed>5242880</MaxSizeAllowed>
    <ProposedSize>15728640</ProposedSize>
</Error>
```