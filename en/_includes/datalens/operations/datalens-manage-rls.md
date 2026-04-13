{% list tabs %}

- In the dataset

  1. Open the dataset.
  1. Navigate to the **Fields** tab.
  1. On the right side of the row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **Access permissions**.
  1. Enter the value of the field and users in the specified format and click **Save**.

      ```yaml
      'value_1': user_1, user_2
      'value_2': user_3
      ```

      For example, to configure access to all rows with the `first-company` value in the `Company name` field:

      
      ```yaml
      'first-company': login-to-access-your-row-data@yandex.ru
      ```


   1. Save the dataset.

- In the source

  1. In the source, add a field with the {{ datalens-short-name }} user IDs to use for filtering. You can add this field to a new table and join it using the `JOIN` operator.
  1. Add a field with user IDs to the dataset:
     
     * If you added a field to an existing table, go to the **Fields** tab in the dataset and click **Update fields** at the top of the screen. The user ID field will appear in the list.
     * If you added a field to a new table, join it using the `JOIN` operator. To do this, go to the **Sources** tab in the dataset and drag the new table to the workspace. The table will automatically link with the existing table. If required, adjust the [link](../../../datalens/dataset/create-dataset.md#links) between tables and [remove](../../../datalens/dataset/create-dataset.md#field-operations) duplicate fields left over from joining tables.

  1. Configure field access permissions:
     
     1. In the dataset, go to the **Fields** tab.
     1. Find the field with user IDs. On the right side of the row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **Access permissions**.
     1. In the access permissions settings, add `userid:userid` to the field and click **Save**.

  1. Save the dataset.

  {% cut "Example" %}

  Let's create a dashboard based on sales data by four regions (West, East, North, and South). Regional managers should only have access to their own data, while the company's CEO, to all data.

  1\. Define {{ datalens-short-name }} user IDs.
  2\. In the source, create a table named `MANAGER_ID`, where the region is mapped to the user ID. If a single ID is associated with multiple regions, add all unique pairs:

    | REGION | MANAGER_NAME | MANAGER_ID        |
    |--------|--------------|-------------------|
    | West  | Arkady      | 19287318273912873 |
    | East | Vasily      | 92877912837318927 |
    | North  | Olga        | 02993284928374346 |
    | South     | Dmitry      | 10836293849237642 |
    | West  | Maxim       | 71726123712891283 |
    | East | Maxim       | 71726123712891283 |
    | North  | Maxim       | 71726123712891283 |
    | South     | Maxim       | 71726123712891283 |

  3\. Open the dataset and add the new table: on the **Sources** tab, drag the table to the workspace.
  4\. Make sure the `JOIN` is based on the `REGION` field.

     ![image](../../../_assets/datalens/security/rls-join.png =403x205)

  5\. Based on the `MANAGER_ID` field, customize RLS and add `userid:userid`.

     ![image](../../../_assets/datalens/security/rls-userid.png =364x187)

  Each user will only see data for regions they have access to.

  To change the access control settings, update the data in the source table.

  {% endcut %}

{% endlist %}
