You can restrict access to a bucket at the service level. This will make access to the bucket possible only from {{ vpc-short-name }} service connections.

{% note warning %}

With this option on, the bucket will not be accessible from the public network. Also, as currently implemented, no access to the bucket will be possible from the [management console]({{ link-console-main }}). See also [Server side copy](#server-side-copy).

{% endnote %}

To allow access to the bucket only from {{ vpc-short-name }} service connections at the service level:

{% list tabs group=instructions %}

- CLI {#cli}

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
        --private-endpoints <service_connection_ID>
      ```

      Where:
      * `--name`: Bucket name.
      * `--enable-private-endpoints`: Parameter for access to the bucket only from {{ vpc-short-name }} service connections. If you do not set this parameter, the bucket will be accessible from both the public network and {{ vpc-short-name }} service connections.
      * `--private-endpoints`: List of IDs of {{ vpc-short-name }} service connections to allow access from. 

        {% note warning %}

        If you do not specify the IDs of {{ vpc-short-name }} service connections, the bucket will not be accessible from anywhere. However, you can still [disable](#disable) the restrictions for access only from {{ vpc-short-name }} service connections.

        {% endnote %}

{% endlist %}

To restore access to the bucket from the public network: {#disable}

{% list tabs group=instructions %}

- CLI {#cli}

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

{% endlist %}