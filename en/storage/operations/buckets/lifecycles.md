---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Managing lifecycles of object in buckets

{{ objstorage-name }} lets you manage [lifecycles](../../concepts/lifecycles.md) for objects in buckets.

{% list tabs %}

- Management console
    1. In the management console, go to the bucket you want to configure object lifecycles for.
    2. In the left pane, select **Lifecycle**.
    3. Click **Configure**.
    4. On the page that opens, you can add, remove, and edit configuration rules. For a detailed description of the configuration fields, see [{#T}](../../s3/api-ref/lifecycles/xml-config.md).

    {% note info %}

    In the management console, you can't use a single rule to set the criteria for deleting objects or changing the object storage class. Use a separate rule for each type of criteria.

    {% endnote %}

- AWS CLI

    To upload a configuration via the AWS CLI:

    1. Define the object lifecycle configuration in JSON format. For example:

        ```
        {
            "Rules": [
                {
                    "ID": "DeleteOldBackups",
                    "Filter": {
                        "Prefix": "backup/"
                    },
                    "Status": "Enabled",
                    "Expiration": {
                            "Days": 180
                    }
                }
            ]
        }
        ```

        When you're done, you can save your configuration as a file, like `lifecycles.json`.

    2. Upload the configuration to a bucket, like `backup-bucket`:

        ```
        aws s3api put-bucket-lifecycle-configuration \
            --bucket backup-bucket \
            --lifecycle-configuration file://lifecycles.json \
            --endpoint-url=https://{{ s3-storage-host }}
        ```

{% endlist %}

