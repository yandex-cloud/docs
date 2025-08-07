* `file_system`: File storage type. Available options:

    * `s3`: [{{ objstorage-full-name }}](../../../storage/quickstart/index.md).
    * `external_s3`: External storage. You need to specify additional parameters for this one:

        * `aws_access_key`: ID of AWS-compatible static access key.
        * `aws_secret_key`: Secret key of AWS-compatible static access key.
        * `aws_endpoint`: File storage endpoint, e.g., `storage.yandexcloud.net`.
        * `aws_region`: File storage region, e.g., `ru-central1`.

* `metastore.uri`: URI for connection to the {{ metastore-name }} cluster in `thrift://<cluster_IP_address>:<port>` format.

    To find out the {{ metastore-name }} cluster IP address, select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}** in the [management console]({{ link-console-main }}) and then select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}** in the left-hand panel.
