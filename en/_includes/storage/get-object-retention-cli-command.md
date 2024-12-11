Make sure the object lock settings were updated:

```bash
yc storage s3api get-object-retention \
  --bucket <bucket_name> \
  --key <object_key> \
  --version-id <version_ID>
```

Where:

* `--bucket`: Name of your bucket.
* `--key`: Object key.
* `--version-id`: Object version ID.