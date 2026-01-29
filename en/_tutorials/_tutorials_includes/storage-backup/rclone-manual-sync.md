For a one-off synchronization, run this command:

```bash
rclone sync <local_folder_path> <connection_name>:<bucket_name>
```

Where `sync` creates an exact copy, including deletion of files from the bucket when they are deleted from the local folder. To copy files without deletion, use the `copy` command.