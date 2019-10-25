# Getting a list of aliases

You can only get a list of aliases for all devices in the registry. To do this, you need the unique ID or name of the registry. For more information, see [{#T}](../../registry/registry-list.md).

{% list tabs %}

- CLI

    {% include [cli-install](../../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

    Get a list of aliases for all devices in the registry:

    ```
    $ yc iot registry list-device-topic-aliases my-registry
    +----------+----------------------------------------+----------------------+
    |  ALIAS   |              TOPIC PREFIX              |      DEVICE ID       |
    +----------+----------------------------------------+----------------------+
    | commands | $devices/arenak5ciqss6pbas6js/commands | arenak5ciqss6pbas6js |
    +----------+----------------------------------------+----------------------+
    ```

{% endlist %}

