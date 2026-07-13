You can use the AWS CLI to generate a pre-signed URL for downloading an object. By running this command:

```bash
aws s3 presign s3://<bucket_name>/<object_key> \
  --expires-in <link_lifetime> \
  --endpoint-url "https://{{ s3-storage-host }}/"
```

To generate the link properly, make sure to provide the `--endpoint-url` parameter pointing to the {{ objstorage-name }} hostname. For detailed information, see [this section on features specific to the AWS CLI](../tools/aws-cli.md#specifics).