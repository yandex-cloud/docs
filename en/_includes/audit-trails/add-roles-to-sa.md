Assign roles to the service account:

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   * Assign the [`audit-trails.viewer` role](../../audit-trails/security/index.md#roles-list) for the cloud from whose resources you will collect audit logs:

      ```bash
      yc resource-manager cloud add-access-binding \
        --role audit-trails.viewer \
        --id <cloud_ID> \
        --service-account-id <service_account_ID>
      ```

      Where:

      * `--role`: Role being assigned.
      * `id`: [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) whose audit logs will be collected.
      * `--service-account-id`: Service account ID.

   * Assign the [`storage.uploader` role](../../storage/security/index.md#storage-uploader) to the folder to host the trail:

      ```
      yc resource-manager folder add-access-binding \
        --role storage.uploader \
        --id <folder_ID> \
        --service-account-id <service_account_ID>
      ```

      Where:

      * `--role`: Role being assigned.
      * `--id`: ID of the folder to host the trail.
      * `--service-account-id`: Service account ID.

{% endlist %}
