{% list tabs group=instructions %}

- {{ datalens-name }} interface {#datalens}

  1. Go to [{{ datalens-name }}]({{ link-datalens-main }}).
  1. In the left-hand panel, select ![image](../../_assets/console-icons/thunderbolt.svg) **Connections** and click **Create connection**.
  1. Select **{{ yq-name }}**. In the window that opens, set the below parameters as follows:
      * **Cloud and folder**: Select the cloud and folder where you created the rest of the resources.
      * **Service account**: `forms-integration-sa`
  1. Click **Save changes**. In the window that opens, specify `forms-datalens-connection` as the connection name, then click **Create**.
  1. Go back to the [{{ datalens-name }}]({{ link-datalens-main }}) main page and click **Create dataset**.
  1. In the connection panel, click ![icon](../../_assets/console-icons/plus.svg) **Add** and select the `forms-datalens-connection` connection.
  1. Under **Tables**, select the table and drag it to your {{ datalens-name }} workspace.
      After loading, the data from the table will appear in the **Preview** panel.
  1. Click **Save** and enter `forms-integration-dataset` as the dataset name, then click **Create**.

{% endlist %}
