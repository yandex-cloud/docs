* `use_metadata_service`: Controls agent authentication in the {{ yandex-cloud }} API using an [IAM token](../../../iam/concepts/authorization/iam-token.md) and enables the agent to obtain IAM tokens via the VM [metadata service](../../../compute/concepts/vm-metadata.md).

    The possible values are:

    * `true`: Synchronization agent will use the VM metadata service to obtain the service account IAM tokens for authentication in the {{ yandex-cloud }} API The `cloud_credentials_file_path` value will be ignored.

        To obtain IAM tokens, the agent must run on a {{ compute-full-name }} VM instance to which a service account with the [relevant access permissions](../../../organization/concepts/ad-sync/index.md#yc-setup) is attached.
    * `false`: The synchronization agent will not obtain IAM tokens; to authenticate in the {{ yandex-cloud }} API, it will use the authorized key specified in `cloud_credentials_file_path`.