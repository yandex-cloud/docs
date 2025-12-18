# How to view and delete incomplete uploads



## Case description {#case-description}

You need to view or delete incomplete uploads in the following situations:

* You see an incomplete download in the [management console]({{ link-console-main }}).
* The size of uploaded files mismatches the total size in the bucket.

## Solution {#case-resolution}

Now, you can view and delete incomplete uploads [directly from the console](../../../storage/operations/objects/deleting-multipart.md).

You can check for incomplete multipart uploads using this command:

```
aws --endpoint https://storage.yandexcloud.net s3api list-multipart-uploads --bucket <bucket_name>
```

To cancel them, run the `abort-multipart-upload` command:

```
aws --endpoint https://storage.yandexcloud.net s3api abort-multipart-upload --bucket <bucket_name> --key <object_key> --upload-id <upload_id>
```

You can also [use CyberDuck](https://docs.cyberduck.io/protocols/s3/#multipart-uploads).