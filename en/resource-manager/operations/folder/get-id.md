# Getting the folder ID

{% list tabs %}

- Management console

   1. Select the folder on the management console [home page]({{ link-console-cloud }}). This page displays information about all the folders in the selected cloud.{% if product == "yandex-cloud" %} If necessary, [switch to another cloud](../cloud/switch-cloud.md).{% endif %}

   1. You can retrieve the folder ID from the folder page URL in the management console:
      ```
      {{ link-console-main }}/folders/b1gd129pp9ha0vnvf5g7
      ```

      Where `b1gd129pp9ha0vnvf5g7` is the folder ID.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   If you know the folder name, get its ID using the `get` command:

   ```bash
   yc resource-manager folder get my-folder
   ```

   Result:

   ```
   id: b1gd129pp9ha0vnvf5g7
   ...
   ```

   If you don't, get a list of folders with IDs for the default cloud:

   ```bash
   yc resource-manager folder list
   ```

   Result:

   ```
   +----------------------+--------------------+------------------+--------+
   |          ID          |        NAME        |      LABELS      | STATUS |
   +----------------------+--------------------+------------------+--------+
   | b1gd129pp9ha0vnvf5g7 | my-folder          |                  | ACTIVE |
   | b1g66mft1vopnevbn57j | default            |                  | ACTIVE |
   +----------------------+--------------------+------------------+--------+
   ```

   To view the list of folders in a different cloud, specify the folder ID in `cloud-id`:

   ```bash
   yc resource-manager folder list --cloud-id b1glku4lgd6g31h5onqs
   ```

- API

   To get the list of folders with IDs, use the [list](../../api-ref/Folder/list.md) method for the [Folder](../../api-ref/Folder/index.md) resource.

{% endlist %}
