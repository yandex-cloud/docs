The `yandex_query_magic` package provides _magic commands_ for working in {{ jlab }}. Install it to send queries to {{ yq-name }}. Paste the code into the `yq-storage.ipynb` notebook cells.

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Install the `yandex_query_magic` package:

   ```python
   %pip install yandex_query_magic
   ```

1. Once the installation is complete, from the top panel, select **Kernel** ⟶ **Restart kernel...**.

1. Upload the extension:

   ```python
   %load_ext yandex_query_magic
   ```

1. Configure the connection by specifying the `data-folder` ID and the name of the authorized key secret:

   ```sql
   %yq_settings --folder-id <folder_ID> --env-auth yq_access_key
   ```

1. Run a test query to {{ yq-name }}:

   ```sql
   %yq select "Hello, world!"
   ```
