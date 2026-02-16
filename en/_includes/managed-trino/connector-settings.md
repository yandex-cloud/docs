  * **URI**: URI for connection to the {{ metastore-name }} cluster in `thrift://<cluster_IP_address>:9083` format.

    To find out the IP address of your {{ metastore-name }} cluster:
      1. Go to the [resource folder]({{ link-console-main }}) page.
      1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
      1. In the left-hand panel, select ![image](../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.

    {% include [metastore version](metastore-version-catalog-create.md) %}

  * **File storage**: File storage type. The available options are [{{ objstorage-full-name }}](../../storage/quickstart/index.md) and external storage.

    For external storage, specify:

      * **Access key ID**: ID of an AWS-compatible static access key.
      * **Secret key**: Secret key of an AWS-compatible static access key.
      * **Endpoint**: File storage endpoint, e.g., `storage.yandexcloud.net`.
      * **Region**: File storage region, e.g., `ru-central1`.
