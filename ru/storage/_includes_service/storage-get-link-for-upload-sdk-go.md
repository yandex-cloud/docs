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

[Установите](https://docs.aws.amazon.com/sdk-for-go/v2/developer-guide/getting-started.html#install-the-aws-sdk-for-go-v2) AWS SDK для Go и выполните код:

```go
package main

import (
  "context"
  "fmt"
  "log"
  "time"

  "github.com/aws/aws-sdk-go-v2/config"
  "github.com/aws/aws-sdk-go-v2/service/s3"
)

func main() {
  cfg, err := config.LoadDefaultConfig(context.TODO())
  if err != nil {
    log.Fatal(err)
  }

  client := s3.NewFromConfig(cfg)

  psClient := s3.NewPresignClient(client)

  bucket := "<имя_бакета>"
  key := "<ключ_загружаемого_объекта>"
  max_size := 5 * 1024 * 1024  // Максимальный размер загружаемого объекта в байтах

  req, err := psClient.PresignPostObject(
    context.TODO(),
    &s3.PutObjectInput{
      Bucket: &bucket,
      Key:    &key,
    },
    func(opts *s3.PresignPostOptions) {
      opts.Expires = time.Hour // Срок действия ссылки
      opts.Conditions = []interface{}{
        []interface{}{"content-length-range", 1, max_size},
      }
    },
  )
  if err != nil {
    log.Fatal(err)
  }

  fmt.Printf("url: %v\n", req.URL)
  fmt.Println("values:")
  for k, v := range req.Values {
    fmt.Printf("%v=%v\n", k, v)
  }
}
```

Где:
* `bucket` — [имя бакета](../concepts/bucket.md#naming), в который загружается файл.
* `key` — [ключ](../concepts/object.md#key), который будет присвоен объекту в бакете. Например: `new-prefix/sample-object.txt`.
* `max_size` — максимально допустимый размер загружаемого файла в байтах.

Результат:

```text
url: https://my-sample-bucket.{{ s3-storage-host }}
values:
X-Amz-Algorithm=AWS4-HMAC-SHA256
X-Amz-Date=20250516T152552Z
X-Amz-Credential=YCAJE98uTrKJwAtqw********/20250516/{{ region-id }}/s3/aws4_request
X-Amz-Signature=9371b1924dd468a9be6b57868565ad5f99cdc7edc3b56589bea3dbfa********
key=new-prefix/sample-object.txt
policy=eyJjb25kaXRpb25zIjpbeyJYLUFtei1BbGdvcml0aG0iOiJBV1M0LUhNQUMtU0hBMjU2In0seyJidWNrZXQiOiJhbHRhcmFza2luLXRlc3Rlci1idWNrZXQifSx7IlgtQW16LUNyZWRlbnRpYWwiOiJZQ0FKRTk4dVRyS0p3QXRxd3JISlhOaDVMLzIwMjUwNTE2L3J1LWNlbnRyYWwxL3MzL2F3czRfcmVxdWVzdCJ9LHsiWC1BbXotRGF0ZSI6IjIwMjUwNTE2VDE1MjU1MloifSxbImNvbnRlbnQtbGVuZ3RoLXJhbmdlIiwxLDUyNDI4ODBdLHsia2V5IjoiZmlsZS50eHQifV0sImV4cGlyYXRpb24iOiIyMDI1LTA1LTE2VDE2OjI1********
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