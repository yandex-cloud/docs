# Creating a node from a Python code cell

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

To deploy a cell as a microservice, you need a [checkpoint](projects/checkpoints.md).

{% note info %}

If your project uses packages and libraries that are not included in the [list of pre-installed software](../concepts/preinstalled-packages.md), [configure the node environment](node-customization.md) using a {% if lang == "ru" %}[Docker image](/blog/posts/2022/03/docker-containers){% else %}Docker image{% endif %}.

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

If you no longer need the deployed node, [delete it](node-delete.md).

## Examples {#examples}

### Deploying a random number generator node {#randomizer}

Let's look at an example of creating an API endpoint that takes a number range as its input and returns a random integer.

1. [Create a project](../operations/projects/create) in **{{ ml-platform-name }}** and open it.
1. Create a notebook by selecting **File** → **New** → **Notebook** from the menu.
1. Declare the input parameters and do not override them in the service code. To do this, create a cell with the following code:

   ```python
   input_data = dict(left_bound=1, right_bound=10)
   ```

1. Highlight the cell containing the code and run it by selecting **Run** → **Run Selected Cells** from the menu

   {% note tip %}

   You can run cells by pressing **Shift+Enter**.

   {% endnote %}

1. Define the service that will handle the API calls. Create a new cell with the code:

   ```python
   from random import randint
   from random import seed

   seed()

   def generate_value(input_data):
       return dict(generated_value=randint(
           input_data["left_bound"],
           input_data["right_bound"]
       ))

   output_data = generate_value(input_data)
   print(output_data)
   ```

1. Run the cell. The expected result from the code is a string in the following format:

   ```json
   {'generated_value': <integer from 1 to 10>}
   ```

1. [Save the checkpoint](../operations/projects/checkpoints.md#pin).

1. Call the context menu for the cell with the service code and select **Deploy selected cell**.
1. In the resulting form, enter the node settings:

   * **Name**: Enter a name for the node.
   * **Select checkpoint to use for deployment**: Select the previously saved checkpoint.
   * **Output variables**: Click **Add new** and create a variable with the following parameters:

      * **name**: `output_data`.
      * **type**: `dict`.

   * **Required input variables**: Click **Add new** and create a variable with the following parameters:

      * **name**: `input_data`.
      * **type**: `dict`.

   * **Instance count**: Specify the number of hosts to run the notebook cell. The minimum value is `2`.

1. Click **Create**.
1. In the left-hand menu, click ![Node](../../_assets/datasphere/node.svg) **Nodes**.
1. Wait for the created node's status to change to **HEALTHY**. Update the page to find out the node's current status.
1. Select the node and copy its ID from the right-hand side of the page (it is in the format `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx`).
1. Start a terminal and select a POST request to the API of the service you created. Such as:

   ```bash
   curl -X POST 'https://datasphere.{{ api-host }}/datasphere/v1/nodes/<node_id>:execute' \
        -H 'Authorization: Bearer <IAM token>' \
        -H 'Content-Type: application/json' \
        --data-raw '{
           "folder_id": "<folder ID>",
           "input": {
             "input_data": {
               "left_bound": 1,
               "right_bound": 10
             }
           }
         }'
   ```

   Where:

   * `<node ID>`: Previously retrieved node ID.
   * `<IAM token>`: [IAM token](../../iam/operations/iam-token/create.md).
   * `<folder ID>`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) where the project and the node were created.

   The response should contain a random number from the specified range of 1 to 10:

   ```json
   {
     "output": {
       "output_data": {
         "generated_value": 6
       }
     }
   }
   ```

1. Edit the `left_bound` and the `right_bound` request parameters. Send several API requests and make sure that random numbers from the specified range are returned.

#### See also {#see-also}

* [{#T}](node-customization.md).
* [{#T}](node-api.md)
* [{#T}](node-delete.md).
