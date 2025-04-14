{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [desktop](../../cloud-desktop/concepts/desktops-and-groups.md).
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Click **{{ ui-key.yacloud.vdi.button_desktop-create }}**.
  1. Select a desktop group.
  1. Specify your desktop subnet.

      {% note info %}

      Make sure to [configure a NAT gateway](../../vpc/operations/create-nat-gateway.md) in this subnet, so your desktop will have internet access.

      {% endnote %}

  1. Specify the desktop user.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  1. See the description of the [CLI](../../cli/index.yaml) command for creating a [desktop](../../cloud-desktop/concepts/desktops-and-groups.md):

      ```bash
      yc desktops desktop create --help
      ```

  1. Select a [desktop group](../../cloud-desktop/concepts/desktops-and-groups.md):

      {% include [desktops-group-list](desktops-group-list.md) %}

  1. Create a desktop:

      ```bash
      yc desktops desktop create \
        --desktop-group-id <desktop_group_ID> \
        --user-account-id <user_ID>
      ```

      Where:

      * `--desktop-group-id`: Desktop group ID.
      * `--user-account-id`: Desktop user ID.

      {% include [create-desktop-cli-result](create-desktop-cli-result.md) %}

- API {#api}

  Use the [create](../../cloud-desktop/api-ref/Desktop/create.md) REST API method for the [Desktop](../../cloud-desktop/api-ref/Desktop/index.md) resource or the [DesktopService/Create](../../cloud-desktop/api-ref/grpc/Desktop/create.md) gRPC API call.

{% endlist %}
