You can restrict access to a bucket at the service level. This will make access to the bucket possible only from {{ vpc-short-name }} service connections.

{% note warning %}

With this option on, the bucket will not be accessible from the public network. There is a separate option enabling bucket access via the [management console]({{ link-console-main }}). See also [Server side copy](#server-side-copy).

{% endnote %}

### Allowing bucket access only from {{ vpc-short-name }} service connections at the service level {#enable-service-restriction}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you configured the {{ vpc-short-name }} service connection.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ objstorage-name }}**.
  1. Select the bucket from the list.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Under **{{ ui-key.yacloud.storage.form.BucketSettingsFormSection.field_label-strict-mode_2ttnd }}**, enable **{{ ui-key.yacloud.storage.form.BucketSettingsFormSection.field_description-strict-mode_9cpMe }}**.
  1. In the **{{ ui-key.yacloud.storage.form.Service_onnectionsField.field_lable-service-connections_iGyHa }}** field, specify the ID of the service connection you created.
  1. Optionally, enable **{{ ui-key.yacloud.storage.form.BucketSettingsFormSection.field_force-cloud-console-access_5bS8y }}**. This option enables you to access the bucket from the management console even if access is allowed only via {{ vpc-short-name }} service connections. When this option is disabled, you can only access the bucket via the API or CLI.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [include](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Create additional DNS [resource records](../../dns/concepts/resource-record.md) to override the public FQDN of the service to which the connection is created. To do this, enable a special {{ vpc-short-name }} service connection parameter:

      ```bash
      yc vpc private-endpoint update \
        --id <service_connection_ID> \
        --private-dns-records-enabled
      ```

  1. Update the bucket settings by specifying the parameters for access only from {{ vpc-short-name }} service connections:

      ```bash
      yc storage bucket update \
        --name <bucket_name> \
        --enable-private-endpoints true \
        --private-endpoints <service_connection_ID> \
        --private-endpoints-force-cloudconsole-access true
      ```

      Where:
      * `--name`: Bucket name.
      * `--enable-private-endpoints`: Parameter for access to the bucket only from {{ vpc-short-name }} service connections. If you do not set this parameter, the bucket will be accessible from both the public network and {{ vpc-short-name }} service connections.
      * `--private-endpoints`: List of IDs of {{ vpc-short-name }} service connections to allow access from.

        {% note warning %}

        If you do not specify the IDs of {{ vpc-short-name }} service connections, the bucket will not be accessible from anywhere. However, you can still [disable](#disable) the restrictions for access only from {{ vpc-short-name }} service connections.

        {% endnote %}

      * `--private-endpoints-force-cloudconsole-access`: This parameter enables bucket access from the management console even if access is allowed only via {{ vpc-short-name }} service connections. This is an optional parameter. When this option is disabled, you can only access the bucket via the API or CLI.

- API {#api}

  To allow bucket access only from {{ vpc-short-name }} service connections at the service level, use the [update](../../storage/api-ref/Bucket/update.md) REST API method for the [Bucket](../../storage/api-ref/grpc/Bucket/index.md) resource or the [Bucket/Update](../../storage/api-ref/grpc/Bucket/update.md) gRPC API call.

{% endlist %}

### Restoring bucket access from a public network {#disable}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you configured the {{ vpc-short-name }} service connection.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ objstorage-name }}**.
  1. Select the bucket from the list.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Under **{{ ui-key.yacloud.storage.form.BucketSettingsFormSection.field_label-strict-mode_2ttnd }}**, disable **{{ ui-key.yacloud.storage.form.BucketSettingsFormSection.field_description-strict-mode_9cpMe }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  Update the bucket settings:

  ```bash
  yc storage bucket update \
    --name <bucket_name> \
    --enable-private-endpoints false
  ```

  Where:
  * `--name`: Bucket name.
  * `--enable-private-endpoints`: Parameter for access to the bucket only from {{ vpc-short-name }} service connections.

    {% note tip %}

    After you remove the restriction for access only from {{ vpc-short-name }} service connections, the list of service connections provided earlier in the `--private-endpoints` parameter remains in the bucket settings. If you choose to restrict access again, you do not have to provide the list one more time.

    {% endnote %}

- API {#api}

  To allow bucket access only from {{ vpc-short-name }} service connections at the service level, use the [update](../../storage/api-ref/Bucket/update.md) REST API method for the [Bucket](../../storage/api-ref/grpc/Bucket/index.md) resource or the [Bucket/Update](../../storage/api-ref/grpc/Bucket/update.md) gRPC API call.

{% endlist %}