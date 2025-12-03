  * **URI**: URI for connection to the {{ metastore-name }} cluster in `thrift://<cluster_IP_address>:9083` format.

    To find out the {{ metastore-name }} cluster IP address, select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}** in the [management console]({{ link-console-main }}) and then select ![image](../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}** in the left-hand panel.

    {% include [metastore version](metastore-version-catalog-create.md) %}

  * **File storage**: File storage type. The available options are [{{ objstorage-full-name }}](../../storage/quickstart/index.md) and external storage.

    For external storage, specify:

      * **Access key ID**: ID of an AWS-compatible static access key.
      * **Secret key**: Secret key of an AWS-compatible static access key.
      * **Endpoint**: File storage endpoint, e.g., `storage.yandexcloud.net`.
      * **Region**: File storage region, e.g., `ru-central1`.
