```json
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": "*",
    "Action": "*",
    "Resource": [
      "arn:aws:s3:::<bucket_name>/*",
      "arn:aws:s3:::<bucket_name>"
    ],
    "Condition": {
      "StringEquals": {
        "yc:private-endpoint-id": "<connection_ID>"
      }
    }
  }
}
```

Where:

* `<bucket_name>`: Name of the bucket in {{ objstorage-name }} to apply the access policy to, e.g., `my-s3-bucket`.
* `<connection_ID>`: Service connection ID (Private Endpoint), e.g., `enpd7rq1s3f5********`.