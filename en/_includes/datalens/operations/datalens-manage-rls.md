{% list tabs %}

- In the dataset

  1. Open the dataset.
  1. On the right of the row, click ![image](../../../_assets/datalens/horizontal-ellipsis.svg) and select **Permissions**.
  1. Enter the value of the field and users in the specified format and click **Save**.

      ```yaml
      'value_1': user_1, user_2
      'value_2': user_3
      ```

      For example, to configure access to the `first-company` value for the `Company name` field:

      {% if audience == "internal" %}

      ```yaml
      'first-company': login-to-access-your-row-data
      ```

      {% else %}

      ```yaml
      'first-company': login-to-access-your-row-data@yandex.ru
      ```

      {% endif %}

  1. Save the dataset.

- In the source

  1. Add to the source a field that will store user IDs and be used for filtering. You can add this field to a new table and join it using the `JOIN` operator.
  1. Add the field to the dataset.
  1. Open the dataset.
  1. On the right of the row, click ![image](../../../_assets/datalens/horizontal-ellipsis.svg) and select **Permissions**.
  1. In the permission settings, add `userid:userid` to the field and click **Save**.
  1. Save the dataset.

  {% cut "Example" %}

  Let's create a dashboard based on sales data by four regions (West, East, North, and South). Regional managers should only have access to their own data, and the company's chief executive to all data.

  1\. Let's define user IDs.
  2\. In the source, create an additional table named `MANAGER_ID` with the region related to the user ID. If multiple regions are available for the same ID, then list all unique pairs:

  | REGION | MANAGER_NAME | MANAGER_ID |
  |--------|--------------|-------------------|
  | West | Arkady | 19287318273912873 |
  | East | Vasily | 92877912837318927 |
  | North | Olga | 02993284928374346 |
  | South | Dmitry | 10836293849237642 |
  | West | Maxim | 71726123712891283 |
  | East | Maxim | 71726123712891283 |
  | North | Maxim | 71726123712891283 |
  | South | Maxim | 71726123712891283 |

  3\. Let's add the table to the dataset.
  4\. To do this, we'll make a `JOIN` by the `REGION` field.
  5\. Then set up RLS by the `MANAGER_ID` field and add `userid:userid`.

  To change the access control settings, update the data in the source table.

  {% endcut %}

{% endlist %}
