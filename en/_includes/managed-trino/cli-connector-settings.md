* `--cluster-id`: ID of the cluster where you are creating your {{ TR }} catalog. You can request the cluster ID with a [list of clusters](../../managed-trino/operations/cluster-list.md#list-clusters).
* `--metastore-hive-uri`: URI for connection to the {{ metastore-name }} cluster in `thrift://<cluster_IP_address>:<port>` format.

  To find out the {{ metastore-name }} cluster IP address, select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}** in the [management console]({{ link-console-main }}) and then select ![image](../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}** in the left-hand panel.

* `--filesystem-native-s3`: [{{ objstorage-full-name }}](../../storage/quickstart/index.md).
* `--filesystem-external-s3-aws-access-key`: ID of AWS-compatible static access key.
* `--filesystem-external-s3-aws-secret-key`: Secret key of AWS-compatible static access key.
* `--filesystem-external-s3-aws-endpoint`: File storage endpoint, e.g., `storage.yandexcloud.net`.
* `--filesystem-external-s3-aws-region`: File storage region, e.g., `ru-central1`.

  {% note info %}

  Specify either the `--filesystem-native-s3` flag to use an {{ objstorage-name }}, or flags of the `--filesystem-external-s3-aws` group to use an external storage.

  {% endnote %}