You can use the AWS CLI to generate a pre-signed URL for downloading an object. To do this, run this command:

```bash
aws s3 presign s3://<bucket_name>/<object_key> \
  --expires-in <link_lifetime> \
  --endpoint-url "https://{{ s3-storage-host }}/"
```

To generate the link properly, make sure to provide the `--endpoint-url` parameter pointing to the {{ objstorage-name }} hostname. For detailed information, see [this section covering the AWS CLI specifics](../tools/aws-cli.md#specifics).