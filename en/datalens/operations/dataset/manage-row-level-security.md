# Managing access to data rows in a dataset

To configure data row permissions:

1. Open the dataset.

1. On the right of the row, click ![image](../../../_assets/datalens/horizontal-ellipsis.svg) and select **Permissions**.

1. Enter the value of the field and users in the specified format and click **Save**.

   ```yaml
   '[value 1]': [user 1], [user 2]
   '[value 2]': [user 3]
   ```

   For example,

   ```yaml
   '2017-01-01': login-to-access-your-row-data@yandex.ru
   ```

1. Save the dataset.

{% include [rls-note](../../../_includes/datalens/datalens-rls-note.md) %}

