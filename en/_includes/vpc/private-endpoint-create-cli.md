{% include [include](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. View the description of the CLI command to create a service connection:

    ```bash
    yc vpc private-endpoint create --help
    ```

1. Create a service connection to {{ objstorage-short-name }} in the default folder:

    ```bash
    yc vpc private-endpoint create \
      --name s3-vpc-link \
      --description "Private Endpoint to the Object Storage" \
      --network-name default-net \
      --object-storage 
    ```

    Where:

    * `--name`: (Optional) Service connection name.
    * `--description`: (Optional) Service connection description.
    * `--network-name`: Name of the [cloud network](../../vpc/concepts/network.md#network) the service connection will be created in. You can also use the [network ID](../../vpc/operations/network-get-info.md) in the `--network-id` parameter.
    * `--object-storage`: Service connection to {{ objstorage-short-name }}. Other service connection types are not available yet.

    When creating a service connection, you can use the following additional parameters:

    * `--address-spec`: (Optional) Parameters in the `key=value` format for the internal IP address which will be assigned to the service connection:
      * `address`: (Optional) Private IP address for the service connection. If no IP address is provided, a random one will be assigned from the specified subnet’s range.
      * `subnet-id`: (Optional) [ID of the subnet](../../vpc/operations/subnet-get-info.md) to provide an IP address for the service connection. If no subnet ID is provided, a random internal IP address will be assigned from the range of one of the subnets in the cloud network.

        {% note info %}

        To create a service connection, you should have at least one subnet in your network.

        {% endnote %}

    * `--private-dns-records-enabled`: (Optional) Parameter to create additional DNS [resource records](../../dns/concepts/resource-record.md) to override the public FQDN of the service to which the connection is created.

      Depending on whether the parameter is enabled, the following resource records will be created automatically for access to {{ objstorage-name }}:
      * The parameter is _not used_:

        Name | Type | Value
        --- | --- | ---
        storage.pe.yandexcloud.net | A | <internal_IP_address_of_service_connection>
        *.storage.pe.yandexcloud.net | A | <internal_IP_address_of_service_connection>

      * The parameter is _used_:

        Name | Type | Value
        --- | --- | ---
        storage.pe.yandexcloud.net | A | <internal_IP_address_of_service_connection>
        *.storage.pe.yandexcloud.net | A | <internal_IP_address_of_service_connection>
        {{ s3-storage-host }} | A | <internal_IP_address_of_service_connection>
        *.{{ s3-storage-host }} | A | <internal_IP_address_of_service_connection>

1. Make sure the service connection is created:

    ```bash
    yc vpc private-endpoint list
    ```
    
    The command result will be as follows:

    ```text
    +----------------------+-------------+--------------------------------+
    |          ID          |    NAME     |          DESCRIPTION           |
    +----------------------+-------------+--------------------------------+
    | enpd7rq************* | s3-vpc-link | Private Endpoint to the Object |
    |                      |             | Storage                        |
    +----------------------+-------------+--------------------------------+
    ```

Learn how to get the parameters of the service connection you created in [{#T}](../../vpc/operations/private-endpoint-get-info.md).