# Viewing and deleting incomplete uploads



## Issue description {#case-description}

You need to view or delete incomplete uploads in the following situations:
- You see an incomplete upload in the console.
- The volume of uploaded files mismatch the total volume in the bucket.

## Solution {#case-resolution}

Recently, we added the option to view and delete incomplete uploads [directly from the console](https://cloud.yandex.ru/docs/storage/operations/objects/deleting-multipart).

You can check for incomplete multipart uploads with the command:

```
aws --endpoint https://storage.yandexcloud.net s3api list-multipart-uploads --bucket <bucket_name>
```

To cancel them, use the `abort-multipart-upload` command:

```
aws --endpoint https://storage.yandexcloud.net s3api abort-multipart-upload --bucket <bucket_name> --key <object_key> --upload-id <upload_id>
```

You can also [use CyberDuck](https://docs.cyberduck.io/protocols/s3/#multipart-uploads).

