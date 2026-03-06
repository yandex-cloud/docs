Before using the examples, save the required authentication data to environment variables:

```bash
export AWS_ACCESS_KEY_ID="<static_key_ID>"
export AWS_SECRET_ACCESS_KEY="<secret_key>"
export AWS_DEFAULT_REGION="{{ region-id }}"
export AWS_REGION="{{ region-id }}"
export AWS_ENDPOINT_URL="https://{{ s3-storage-host }}"
```

Where:
* `AWS_ACCESS_KEY_ID`: Static access key [ID](../../iam/concepts/authorization/access-key.md#key-id).
* `AWS_SECRET_ACCESS_KEY`: [Secret key](../../iam/concepts/authorization/access-key.md#private-key).

The code in the examples generates a signed URL to upload an object with a specified [key](../concepts/object.md#key) into a specified bucket. The URL you get is valid for one hour.

In this example, the size of the uploaded object is limited and cannot exceed the 5 MB value set in the code.

[Install](https://docs.aws.amazon.com/sdk-for-go/v2/developer-guide/getting-started.html#install-the-aws-sdk-for-go-v2) AWS SDK for Go and run this code:

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

  bucket := "<bucket_name>"
  key := "<uploaded_object_key>"
  max_size = 5 * 1024 * 1024;  // Maximum size of uploaded object in bytes

  req, err := psClient.PresignPostObject(
    context.TODO(),
    &s3.PutObjectInput{
      Bucket: &bucket,
      Key:    &key,
    },
    func(opts *s3.PresignPostOptions) {
      opts.Expires = time.Hour // Link validity period
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

Where:
* `bucket`: [Name of the bucket](../concepts/bucket.md#naming) to upload the file to.
* `key`: [Key](../concepts/object.md#key) to assign to the object in the bucket, e.g., `new-prefix/sample-object.txt`.
* `max_size`: Maximum allowed size of the uploaded file in bytes.

Result:

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

Use the components you obtained to send an HTTP POST request to upload the file:

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

Where `@sample-object.txt` is the path to the file you need to upload.

As a result, the file will be uploaded to the bucket if not exceeding in size the value specified in the code. If the file is larger than the set maximum, an error will be returned:

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