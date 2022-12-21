1. {% if product == "yandex-cloud" %}On the {{ datalens-full-name }} homepage, click **Create dataset**.{% endif %}{% if product == "cloud-il" %}Open the {{ datalens-short-name }} [homepage]({{ link-datalens-main }}).{% endif %}
   {% if product == "cloud-il" %}1. Go to the [workbook](../../../datalens/concepts/index.md#workbooks-and-collections) to create a dashboard in. If you don't have a workbook, create one:
   1. Click **Create** → **Create workbook**.
   1. Enter a name for the workbook.
   1. Click **Create**.{% endif %}
      {% if product == "cloud-il" %}1. On the workbook page, click **Create** → **Dataset** in the upper-right corner.{% endif %}
1. On the left side of the screen, click **![image](../../../_assets/plus-sign.svg) Add**.
1. Select a connection. If there are no connections in the list, [create one](../../../datalens/concepts/connection.md).
1. Select the tables to become the data source for the dataset and click **Save** in the upper-right corner.

   {% note warning %}

   * The maximum number of tables in a single dataset is 32.
   * The maximum number of fields in a single dataset is 1200.

   {% endnote %}

1. Enter the dataset  name and click **Create**. The dataset appears in the list.