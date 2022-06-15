# Getting the folder ID

{% list tabs %}

- Management console
  1. Open the folder page. You can select a folder on the [Home page]({{ link-console-main }}) of the management console. This page displays folders for the selected cloud.If necessary, [switch to another cloud](../cloud/switch-cloud.md).
  1. Get the folder ID from the URL of the folder page in the management console:

      ```
      {{ link-console-main }}/folders/b1gd129pp9ha0vnvf5g7
      ```

      `b1gd129pp9ha0vnvf5g7` is the folder ID.

- CLI

  If you know the folder name, get its ID using the `get` command:

  ```
  yc resource-manager folder get my-folder

  id: b1gd129pp9ha0vnvf5g7
  ...
  ```

  If you don't, get a list of folders with IDs for the default cloud:

  ```
  yc resource-manager folder list

  +----------------------+--------------------+------------------+--------+
  |          ID          |        NAME        |      LABELS      | STATUS |
  +----------------------+--------------------+------------------+--------+
  | b1gd129pp9ha0vnvf5g7 | my-folder          |                  | ACTIVE |
  | b1g66mft1vopnevbn57j | default            |                  | ACTIVE |
  +----------------------+--------------------+------------------+--------+
  ```

  To view the list of folders in a different cloud, specify the folder ID in `cloud-id`:

  ```
  yc resource-manager folder list --cloud-id b1glku4lgd6g31h5onqs
  ```

- API

  To get the list of folders and IDs, use the [list](../../api-ref/Folder/list.md) method for the [Folder](../../api-ref/Folder/index.md) resource.

{% endlist %}

