For a one-off synchronization, run this command:

```bash
aws s3 sync <local_folder_path> s3://<bucket_name> \
--endpoint-url=https://{{ s3-storage-host }} \
--delete
```

Where:

* `--endpoint-url`: {{ objstorage-name }} endpoint.
* `--delete`: Flag to delete files from the bucket when they are deleted from the local folder.

This command copies all contents from your local folder to the S3 bucket by moving only new and modified files.