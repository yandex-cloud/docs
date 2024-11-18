### Transfer failure with the `mapper_parsing_exception` error {#data-types}

Error message:

```text
mapper_parsing_exception failed to parse field [details.tags] of type [text]
```

The transfer is aborted due to incompatible data types at source and target.

**Solution:** Move the data to a new {{ OS }} index with the `details` field type changed to `flat_object`.

1. Deactivate the transfer.

1. Create a new index in {{ OS }}:

    ```bash
    curl \
    --user <{{ OS }}_username>:<password> \
    --header 'Content-Type: application/json' \
    --request PUT 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/<new_index_name>/_settings' \
    --data '{"index.mapping.total_fields.limit": 2000}'
    ```

1. Change the `details` field type:

    ```bash
    curl \
    --user <{{ OS }}_username>:<password> \
    --header 'Content-Type: application/json' \
    --request PUT 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/<new_index_name>/_mapping' \
    --data '
        {
            "properties": {
                "details": {
                    "type": "flat_object"
                }
            }
        }'
    ```    

1. Move the data from the source index to the new one:

    ```bash
    curl \
    --user <{{ OS }}_username>:<password> \
    --header 'Content-Type: application/json' \
    --request POST 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/_reindex' \
    --data '
        {
        "source":{
            "index":"<source_index_name>"
        },
        "dest":{
            "index":"<new_index_name>"
        }
        }'
    ```

1. Delete the source index:

    ```bash
    curl \
    --user <{{ OS }}_username>:<password> \
    --header 'Content-Type: application/json' \
    --request DELETE 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/<source_index_name>'
    ```

1. Assign an alias to the new index:

    ```bash
    curl \
    --user <{{ OS }}_username>:<password> \
    --header 'Content-Type: application/json' \
    --request POST 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/_aliases' \
    --data '
        {
        "actions": [
            {
            "add": {
                "index": "<new_alias_name>",
                "alias": "<source_alias_name>"
            }
            }
        ]
        }'
    ```
