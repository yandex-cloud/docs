# Working with models

[Models](../../concepts/models/index.md) are designed for storing and exporting computation results in {{ ml-platform-name }} projects.

{% note info %}

Models are only available in projects in [{{ dd }} mode](../../concepts/project.md#dedicated).

{% endnote %}

## Creating a model {#create}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Open a project in [{{ dd }} mode](../../concepts/project.md#dedicated).
1. Select or create a notebook with the code that will create a model variable in RAM.
1. Run the code in the notebook using the selected configuration.
1. In the right-hand panel, select ![models](../../../_assets/console-icons/nodes-right.svg). In the window that opens, click **Create model**.
1. Select the name of the variable to create your model from.
1. Give your model a name and add a description if needed.
1. Click **Create**.

   The new model will appear in the list of available project models. Creating a model may take some time.

## Loading a model {#load}

You can load the saved model to the notebook's interpreter state and use it in your computations:

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Open a project in [{{ dd }} mode](../../concepts/project.md#dedicated).
1. In the right-hand panel, select ![models](../../../_assets/console-icons/nodes-right.svg). In the window that opens, select the model to load and click ![options](../../../_assets/console-icons/ellipsis.svg).
1. Select ![load](../../../_assets/datasphere/jupyterlab/load.svg)**Load**.
1. Specify the name of the variable to load the model to and click **Load**.

   Once loaded, the model will be available in the code in the variable you specified.

## Deleting a model {#delete}

You can delete a model in the {{ jlab }}Lab interface or on the project page under **Resources**.

{% list tabs %}

- {{ jlab }}Lab

1. Open the {{ jlab }}Lab interface and select ![models](../../../_assets/console-icons/nodes-right.svg) in the right-hand panel.
1. In the list of models, choose the one you want to delete, click ![options](../../../_assets/console-icons/ellipsis.svg), and select ![delete](../../../_assets/datasphere/jupyterlab/delete-red.svg)**Delete**.
1. Click **{{ ui-key.yc-ui-datasphere.common.submit }}**.

- Project resources

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![model](../../../_assets/console-icons/nodes-right.svg)**Model**.
1. In the list of models, select the one you want to delete.
1. On the view model page, click **More** and select ![delete](../../../_assets/datasphere/jupyterlab/delete-red.svg)**{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.submit }}**.

{% endlist %}