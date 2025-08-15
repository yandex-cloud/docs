# Working with models

[Models](../../concepts/models/index.md) enable storing and exporting computation results within {{ ml-platform-name }} projects.

## Creating a model {#create}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Open your project.
1. Select or create a notebook containing code to initialize a model variable in the system memory.
1. Run the code in the notebook with the selected configuration.
1. In the right-hand panel, select ![models](../../../_assets/console-icons/nodes-right.svg). In the window that opens, click **Create model**.
1. Select the name of the variable to build your model from.
1. Give your model a name and add a description as needed.
1. Click **Create**.

   The new model will appear in the list of available project models. Creating a model may take some time.

## Loading a model {#load}

You can load the saved model into the notebook interpreter state and use it in your computations:

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Open your project.
1. In the right-hand panel, select ![models](../../../_assets/console-icons/nodes-right.svg). In the window that opens, select the model to load and click ![options](../../../_assets/console-icons/ellipsis.svg).
1. Select ![load](../../../_assets/datasphere/jupyterlab/load.svg) **Load**.
1. Enter the name of the variable to load the model into and click **Load**.

   Once loaded, the model will be available in your code via the variable you provided.

## Deleting a model {#delete}

You can delete a model in the {{ jlab }}Lab interface or on the project page under **Resources**.

{% list tabs %}

- {{ jlab }}Lab

   1. Open the {{ jlab }}Lab interface and select ![models](../../../_assets/console-icons/nodes-right.svg) in the right-hand panel.
   1. In the list of models, select the one you want to delete, click ![options](../../../_assets/console-icons/ellipsis.svg) and then ![delete](../../../_assets/datasphere/jupyterlab/delete-red.svg) **Delete**.
   1. Click **{{ ui-key.yc-ui-datasphere.common.submit }}**.

- Project resources

   1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
   1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![model](../../../_assets/console-icons/nodes-right.svg) **Model**.
   1. In the list of models, select the one you want to delete.
   1. On the model view page, click **More** and select ![delete](../../../_assets/datasphere/jupyterlab/delete-red.svg) **{{ ui-key.yc-ui-datasphere.common.delete }}**.
   1. Click **{{ ui-key.yc-ui-datasphere.common.submit }}**.

{% endlist %}

{% include [deletion-time](../../../_includes/datasphere/deletion-time.md) %}
