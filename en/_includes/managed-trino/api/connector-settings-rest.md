* `filesystem`: File storage type. Available options:

    * `s3`: [{{ objstorage-full-name }}](../../../storage/quickstart/index.md).
    * `externalS3`: External storage. You need to specify additional parameters for this one:

        * `awsAccessKey`: ID of AWS-compatible static access key.
        * `awsSecretKey`: Secret key of AWS-compatible static access key.
        * `awsEndpoint`: File storage endpoint, e.g., `storage.yandexcloud.net`.
        * `awsRegion`: File storage region, e.g., `ru-central1`.

* `metastore.hive.uri`: URI for connection to the {{ metastore-name }} cluster in `thrift://<cluster_IP_address>:<port>` format.

    To find out the {{ metastore-name }} cluster IP address, select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}** in the [management console]({{ link-console-main }}) and then select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}** in the left-hand panel.
