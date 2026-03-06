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

[Install](https://github.com/boto/boto3/blob/develop/README.rst#quick-start) boto3 and run this code:

```python
import logging
import boto3
from botocore.exceptions import ClientError
import json


def create_presigned_post(bucket_name, object_name, max_size, expiration, fields=None):

    conditions = [["content-length-range", 1, max_size]]

    s3_client = boto3.client("s3")
    try:
        response = s3_client.generate_presigned_post(
            bucket_name,
            object_name,
            Fields=fields,
            Conditions=conditions,
            ExpiresIn=expiration,
        )
    except ClientError as e:
        logging.error(e)
        return None

    return response


def main():

    bucket_name = "<bucket_name>"
    object_name = "<uploaded_object_key>"
    max_size = 5 * 1024 * 1024  # Maximum size of uploaded object in bytes
    lifespan = 3600 # Link validity period in seconds

    response = create_presigned_post(bucket_name, object_name, max_size, lifespan)

    print("Signed link and data to upload created successfully:")
    print(json.dumps(response, indent=4))


if __name__ == "__main__":
    main()
```

Where:
* `bucket_name`: [Name of the bucket](../concepts/bucket.md#naming) to upload the file to.
* `object_name`: [Key](../concepts/object.md#key) to assign to the object in the bucket, e.g., `new-prefix/sample-object.txt`.
* `max_size`: Maximum allowed size of the uploaded file in bytes.

Result:

```json
Signed link and data to upload created successfully:
{
    "url": "https://{{ s3-storage-host }}/my-sample-bucket",
    "fields": {
        "key": "new-prefix/sample-object.txt",
        "x-amz-algorithm": "AWS4-HMAC-SHA256",
        "x-amz-credential": "YCAJE98uTrKJwAtqw********/20250516/{{ region-id }}/s3/aws4_request",
        "x-amz-date": "20250516T145901Z",
        "policy": "eyJleHBpcmF0aW9uIjogIjIwMjUtMDUtMTZUMTU6NTk6MDFaIiwgImNvbmRpdGlvbnMiOiBbWyJjb250ZW50LWxlbmd0aC1yYW5nZSIsIDEsIDUyNDI4ODBdLCB7ImJ1Y2tldCI6ICJhbHRhcmFza2luLXRlc3Rlci1idWNrZXQifSwgeyJrZXkiOiAiZmlsZS50eHQifSwgeyJ4LWFtei1hbGdvcml0aG0iOiAiQVdTNC1ITUFDLVNIQTI1NiJ9LCB7IngtYW16LWNyZWRlbnRpYWwiOiAiWUNBSkU5OHVUcktKd0F0cXdySEpYTmg1TC8yMDI1MDUxNi9ydS1jZW50cmFsMS9zMy9hd3M0X3JlcXVlc3QifSwgeyJ4LWFtei1kYXRlIjogIjIwMjUwNTE2VDE0NTkw********",
        "x-amz-signature": "c2e1783095d20d89a7683fc582527740541de16156569d9950cfb1b7********"
    }
}
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