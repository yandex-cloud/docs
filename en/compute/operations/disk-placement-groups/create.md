# Creating a disk placement group

Create a [placement group](../../concepts/disk-placement-group.md) for non-replicated disks.

{% list tabs %}

* Management console

  1. In the management console, select the folder where you want to create a disk placement group.

  1. Select **{{ compute-name }}**.

  1. On the **Virtual machines** page, go to the **Placement groups** panel.

  1. Click the **Disk placement groups** tab.

  1. Click **Create group**.

  1. Enter group name.

      {% include [name-format](../../../_includes/name-format.md) %}

  1. If required, add a free-form group description.

  1. Click **Create**.

* CLI

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI commands to create a disk placement group:

      ```bash
      yc compute disk-placement-group create --help
      ```

  1. Create a group in the default folder:

      ```bash
      yc compute disk-placement-group create \
      --name first-group \
      --description "first disk placement group"
      ```

      This will create a disk placement group named `first-group` with the description `first disk placement group`.

  1. Get a list of disk placement groups in the default folder:

      ```bash
      yc compute disk-placement-group list
      ```

      Execution result:

      ```text
      +----------------------+-------------+---------------+--------+
      |          ID          |    NAME     |     ZONE      | STATUS |
      +----------------------+-------------+---------------+--------+
      | epd4sug6keskb72ub9m7 | first-group | ru-central1-b | READY  |
      +----------------------+-------------+---------------+--------+
      ```

  1. Get information about the group created:

      ```bash
      yc compute disk-placement-group get \
      --name first-group
      ```

      Execution result:

      ```text
      id: epd4sug6keskb72ub9m7
      folder_id: w3qrbj9swotyns6oiyny
      created_at: "2021-03-23T12:49:59Z"
      name: first-group
      description: first disk placement group
      zone_id: ru-central1-b
      status: READY
      spread_placement_strategy: {}
      ```

{% endlist %}

