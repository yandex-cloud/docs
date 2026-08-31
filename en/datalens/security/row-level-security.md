# Row-level security (RLS)

RLS (_row-level security_) enables you to restrict data access for users or [user group]({{ link-docs }}/organization/concepts/groups) within a single dataset. For example, you can introduce data access control for different customers.

{% include [rls-note](../../_includes/datalens/datalens-rls-note.md) %}

You can introduce row-level access control either in a [dataset](#dataset-rls) or a [data source](#datasource-rls).

## Configuring RLS at the dataset level {#dataset-rls}

You can control access to any dataset dimension. Each [user](#user-rls) or [user group](#group-rls) can be granted permissions for an unlimited number of measure values.

With RLS, a query to a dataset passes through the following filter:

```sql
where dimension in (value_1, value_2 ... value_N)
```


## Configuring RLS at the data source level {#datasource-rls}

Configuring RLS at the dataset level requires editing the datatset every time the RLS settings change.

To avoid this, you can move the row-level security logic to the data source side:

1. Add a new field for storing the {{ datalens-short-name }} user ID to the source data. All requests to the source will be filtered by this field.

   
   
   Use [this link]({{ link-my-account }}profile) to look up your ID. If you need another user's ID, ask them to open the link and send you the ID.



1. For each source data row, specify the ID of the {{ datalens-short-name }} user who should get access to this row. If multiple users must have access to the same row, you can move the access control logic to a separate table and [join](../dataset/settings.md#multi-table) it to the main table at the dataset level.

1. In the dataset, configure access to the field containing user IDs:

   {% list tabs group=instructions %}

   - Interface {#interface_datalens}

     1. In the RLS settings window, on the **Tables** tab, click **Add rule**.
     1. Select **User IDs** for the `Who has access` parameter.
     
        {% cut "Configuring RLS by user ID" %}
        
        ![screenshot](../../_assets/datalens/security/rls-table-userid.png)

        {% endcut %}

     1. Click **Save**.
   
   - JSON {#json}
   
     1. In the RLS configuration window, set the RLS configuration in JSON format on the **JSON** tab:

        ```json
        [
          {
            "allowed_value": null,
            "pattern_type": "userid",
            "subject": {
              "subject_id": "",
              "subject_name": "userid",
              "subject_type": "userid"
            },
          }
        ]
        ```

     1. Click **Save**. Access will be granted to users whose IDs are specified in the field.

   {% endlist %}

1. Save the dataset.

{% note info %}

You can transfer the RLS logic to the source side for sources where the data structure can be changed. In Yandex Metrica and AppMetrica, the data structure is closed, so this method is not available.

{% endnote %}

## How to change permissions to a row in a dataset {#how-to-manage-rls}

To configure access permissions to data rows:

{% include [datalens-manage-rls-on-premises](../../_includes/datalens/operations/datalens-manage-rls-on-premises.md) %}
