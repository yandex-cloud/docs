1. See the description of the CLI command for setting up static website hosting in a bucket:

    ```bash
    yc storage bucket update --help
    ```
    
1. Create a hosting configuration file in JSON format. Here is an example:
    
    ```json
    {
      "index": "index.html",
      "error": "error404.html"
    }
    ```

    Where:

    * `index`: Absolute path to the website home page file.

      {% include [static-site-index-restriction](static-site-index-restriction.md) %}

    * `error`: Absolute path to the file the user will see in case of `4xx` errors.

1. Run this command:

    ```bash
    yc storage bucket update --name <bucket_name> \
      --website-settings-from-file <path_to_file>
    ```
    
    Where:
    * `--name`: Bucket name.
    * `--website-settings-from-file`: Path to the hosting configuration file.

    Result:

    ```text
    name: my-bucket
    folder_id: b1gjs8dck8bv********
    default_storage_class: STANDARD
    versioning: VERSIONING_SUSPENDED
    max_size: "10737418240"
    acl: {}
    created_at: "2022-12-14T08:42:16.273717Z"
    ```

To make sure the bucket description now contains the hosting settings, run this command:

```bash
yc storage --name <bucket_name> bucket get --full
```

Result:

```text
website_settings:
  index: index.html
  error: error404.html
  redirect_all_requests: {}
```