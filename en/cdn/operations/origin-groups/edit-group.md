# Editing origin groups

## Editing a group {#editing-groups}

To edit an [origin group](../../concepts/origins.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a resource group.
   1. Select **{{ cdn-short-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/cdn/origin-groups.svg) **Origin groups**.
   1. Select the group you wish to edit.
   1. In the top right-hand corner, click ![image](../../../_assets/pencil.svg) **Edit**.
   1. Make the necessary changes.
   1. Click **Save**.

- CLI

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI origin group edit command below:

      ```bash
      yc cdn origin-group update --help
      ```

   1. Get a list of all origin groups in the default folder:

      ```bash
      yc cdn origin-group list --format yaml
      ```

      Result:

      ```bash
      - id: "90209"
        folder_id: b1g86q4m5vej8lkljme5
        name: test-group-1
      ...
          origin_group_id: "90208"
          source: www.a1.com
          enabled: true
      ```

   1. Edit the settings of the origin group by specifying the group ID:

      ```bash
      yc cdn origin-group update --id <origin group ID> \
        --name <new group name> \
        --origin source=<new origin IP address or domain name>,enabled=true \
        --origin source=<new origin IP address or domain name>,enabled=true,backup=true
      ```

      Where `origin`: The origin specification:
      * `source`: The new origin IP address or domain name.
      * `enabled`: Flag indicating whether an origin is enabled.
      * `backup`: Flag indicating whether an origin is a backup.

      Result:

      ```bash
      id: "90209"
      folder_id: b1g86q4m5vej8lkljme5
      name: test-group-22
      ...
        origin_group_id: "90209"
        source: www.site1.com
        enabled: true
      ```

      For more information about the `yc cdn origin-group update` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/origin-group/update.md).

{% endlist %}

## Removing one origin from a group {#group-source-deletion}

To remove an origin from an origin group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a resource group.
   1. Select **{{ cdn-short-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/cdn/origin-groups.svg) **Origin groups** and click the name of the group to delete an origin from.
   1. Select the desired origin and click **Delete** on the bottom panel.

      {% note info %}

      You can only delete a backup origin.

      {% endnote %}

   1. In the window that opens, click **Delete**.

{% endlist %}

## Removing multiple origins from a group {#summ-group-source-deletion}

To remove multiple origins from a group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a resource group.
   1. Select **{{ cdn-short-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/cdn/origin-groups.svg) **Origin groups** and click the name of the group to delete origins from.
   1. Select the desired origins and click **Delete** on the bottom panel.

      {% note info %}

      You can only delete backup origins.

      {% endnote %}

   1. In the window that opens, click **Delete**.

{% endlist %}