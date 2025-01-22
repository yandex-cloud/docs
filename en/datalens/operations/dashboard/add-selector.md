# Adding a selector to a dashboard


Before adding a selector, make sure you have the `{{ permission-write }}` or `{{ permission-admin }}` permission for the dashboard. For more information, see [{#T}](../../security/manage-access.md).


To add a [selector](../../dashboard/selector.md) to a dashboard:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and select the dashboard you need.
1. At the top of the page, click **Edit**.
1. In the panel at the bottom of the page, choose **Selector**.

   
   ![image](../../../_assets/datalens/operations/widget-select.png =500x118)


1. Under **Selector settings** choose the source and specify the selector parameters:

   {% list tabs %}

   - Based on dataset

     * **Dataset**: Dataset with data for the selector. You can choose a dataset from the list of objects or provide a link. This is a required field.
     * **Field**: Dataset field with selector values. It can be either a dimension or a measure (for more information, see [{#T}](../../dataset/data-model.md#field)). This is a required field.
     * **Header**: Used to pick a selector when establishing a link with other widgets. This option allows you to manage how the header appears on the dashboard. By default, with this option enabled, the header text is taken from the field title in the [dataset](../../dataset/index.md).
     * **Header position**: Enables setting the header position, which can be either left (default) or top. It is not available for the **Checkbox** selector type.
     * **Inner title**: Allows specifying text inside a selector. For example, you can use it to display an operation inside a selector. Not available for the **Checkbox** selector type.
    
   {% endlist %}
