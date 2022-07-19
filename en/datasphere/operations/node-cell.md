# Creating a node from a Python code cell

To deploy a cell as a microservice, you need a [checkpoint](projects/checkpoints.md).

{% note info %}

If your project uses packages and libraries that are not included in the [list of pre-installed software](../concepts/preinstalled-packages.md), [configure the node environment](node-customization.md) using a Docker image.

{% endnote %}

{% note warning %}

{% include [pricing nodes](../../_includes/datasphere/nodes-pricing-warn.md) %}

{% endnote %}

1. Open the ![Checkpoints](../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints** tab and save the checkpoint prepared for deployment.

1. Open the notebook and select the cell to be deployed.

1. Right-click to open the popup menu and select **Deploy selected cell**.

1. In the dialog box, enter the following:
   * In the **Name** field, enter the name of the node.
   * In the **Select checkpoint to use for deployment** drop-down list, select the desired checkpoint.
   * Under **Output variables** and **Input variables**, set the names and types of output and input variables for automatic API generation. You can add variables by clicking **Add new**.
   * In the **Instance count** field, enter the number of VMs in the node.

1. Click **Create** to create a node.

When you create a node, you'll see its ID at the bottom of the window. You can view all your created nodes on the ![Node](../../_assets/datasphere/node.svg) **Nodes** tab.
