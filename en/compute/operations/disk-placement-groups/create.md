# Creating a disk placement group

Create a [placement group](../../concepts/disk-placement-group.md) for non-replicated disks.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a disk placement group.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/group-placement-pic.svg) **Placement groups**.
   1. Open the **Non-replicated disk placement groups** tab.
   1. Click **Create non-replicated disk placement** group.
   1. Enter a name for the group.

      {% include [name-format](../../../_includes/name-format.md) %}

   1. If required, add a group description.
   1. Specify the [availability zone](../../../overview/concepts/geo-scope.md).
      
      {% if product == "yandex-cloud" %}
      
      {% include [nrd-az](../../../_includes/compute/nrd-az.md) %}
      
      {% endif %}
      
   1. Click **Create**.

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI commands to create a disk placement group:

      ```bash
      yc compute disk-placement-group create --help
      ```

   1. Create a group in the default folder:

      ```bash
      yc compute disk-placement-group create \
      --name first-group \
      --description "first disk placement group"
      ```

      This will create a disk placement group named `first-group` with the description `first disk placement group`.

   1. Get a list of disk placement groups in the default folder:

      ```bash
      yc compute disk-placement-group list
      ```

      Result:

      ```text
      +----------------------+-------------+---------------+--------+
      |          ID          |    NAME     |     ZONE      | STATUS |
      +----------------------+-------------+---------------+--------+
      | epd4sug6keskb72ub9m7 | first-group | {{ region-id }}-b | READY  |
      +----------------------+-------------+---------------+--------+
      ```

   1. Get information about the group created:

      ```bash
      yc compute disk-placement-group get \
      --name first-group
      ```

      Result:

      ```text
      id: epd4sug6keskb72ub9m7
      folder_id: w3qrbj9swotyns6oiyny
      created_at: "2021-03-23T12:49:59Z"
      name: first-group
      description: first disk placement group
      zone_id: {{ region-id }}-b
      status: READY
      spread_placement_strategy: {}
      ```

{% endlist %}
