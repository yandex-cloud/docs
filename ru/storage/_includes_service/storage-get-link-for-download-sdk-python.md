Пример генерирует подписанный URL для скачивания объекта `object-for-share` из бакета `bucket-with-objects`. URL действителен в течение 100 секунд.

```python
# coding=utf-8

import boto3
from botocore.client import Config


ENDPOINT = "https://{{ s3-storage-host }}"

ACCESS_KEY = "JK38EXAMP********"
SECRET_KEY = "ExamP1eSecReTKeykdo********"

session = boto3.Session(
     aws_access_key_id=ACCESS_KEY,
     aws_secret_access_key=SECRET_KEY,
     region_name="{{ region-id }}",
)
s3 = session.client(
     "s3", endpoint_url=ENDPOINT, config=Config(signature_version="s3v4")
)

presigned_url = s3.generate_presigned_url(
     "get_object",
     Params={"Bucket": "bucket-with-objects", "Key": "object-for-share"},
     ExpiresIn=100,
)

print(presigned_url)
```