# Getting a list of aliases

To get a list of aliases, you need the unique ID or name of the registry. For more information, see [{#T}](../../registry/registry-list.md).

{% list tabs %}

- Management console

   To view the list of aliases:
   1. In the [management console]({{ link-console-main }}), select the folder to get the list of aliases in.
   1. Select **{{ iot-name }}**.
   1. Select the desired registry from the list.
   1. In the left part of the window, select **Devices**.
   1. Select the desired device from the list.
   1. On the **Overview** page, go to the **Aliases** section.

- CLI

    {% include [cli-install](../../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

    You can only get a list of aliases for all devices in the registry.

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

