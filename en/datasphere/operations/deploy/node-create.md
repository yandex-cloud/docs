# Creating a node

You can deploy an individual cell of a notebook or third-party [Docker image](../../../container-registry/concepts/docker-image.md) as an independent service using [nodes](../../concepts/resource-model.md#resources).

{% note warning %}

{% include [pricing nodes](../../../_includes/datasphere/nodes-pricing-warn.md) %}

{% endnote %}

If your project uses packages and libraries that are not included in the [list of pre-installed software](../../concepts/preinstalled-packages.md), first [configure the node environment](node-customization.md) using a Docker image.

## Create a node {#create-node}

1. {% include [include](../../../_includes/datasphere/ui-before-begin.md) %}
1. Select the cell to deploy as a node and run it (press **Shift** + **Enter**). This will automatically create a [checkpoint](../projects/checkpoints.md) in the project.

   {% note info %}

   If you are working in [automatic state save mode](../../concepts/save-state.md#auto-save), you need to force a state save. To do this, press **Cmd** + **K** or **Ctrl** + **K** and [create a checkpoint](../projects/checkpoints.md#create).

   {% endnote %}

1. Pin the checkpoint:
   1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
   1. Under **Resources**, select **Checkpoint**.
   1. In the list, choose the last added checkpoint named `Cell run` and make sure it contains the appropriate node.
   1. In the upper-right corner, click ![Pin](../../../_assets/datasphere/pin.svg) **Pin**.
   1. In the window that appears, enter the checkpoint name and click **Pin**.
1. Create a node:
   1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
   1. In the upper-right corner, click **Create resource**. In the window that opens, select **Node**.
   1. Specify the basic node parameters:
      * **Type**: Resource that a node is based on (**Cell** or **Docker image**).
      * **Name**: Node name.
      * (Optional) **Description**: Node description.
   1. Depending on the node type, specify other parameters:

      {% list tabs %}

      - Cell

         * In the **Checkpoint** field, select the previously created checkpoint.
         * Under **Input variables** and **Output variables**, set the names and types of input and output variables for automatic {% if lang == "ru" and audience != "internal" %}[API](../../../glossary/rest-api.md){% else %}API{% endif %} generation. You can add variables by clicking ![Add](../../../_assets/plus.svg) **Add**.
         * (Optional) If a [nonstandard environment](node-customization.md) is used for running a cell code, specify the path to an image inside your project under **System Docker image**. Click **Show additional parameters** and set the following:
            * **Username**: `json_key`.
            * **Password secret**: [Secret](../../concepts/secrets.md) with a password for your container registry.

      - Docker image

         * Under **Docker image**, specify the path to the image in {{container-registry-name}}. Click **Show additional parameters** and set the following:
            * **Username**: `json_key`.
            * **Password secret**: [Secret](../../concepts/secrets.md) with a password for your container registry. See [{#T}](node-customization.md).
         * Under **Endpoint**:
            * **Type**: Select the node connection protocol: **HTTP** (**HTTP/2**) or **gRPC**.
            * **Port**: Specify the port for connecting to the node.
            * **Timeout**: Set the session duration in seconds.
            * **Idle timeout**: Set the idle time before disconnecting from the node, in seconds.
         * (optional) Under **Telemetry**:
            * **Type**: Select the telemetry service (**Prometheus** or **Yandex Monitoring**).
            * **HTTP path**: Specify the address to send telemetry data to.
            * **Port**: Specify the port to send telemetry data to.
         * (optional) Under **Check**:
            * **Type**: Protocol to perform node health checks through (**HTTP** or **gRPC**).
            * **Port**: Port that node health checks are performed from.
            * **Path**: Path to the resource to check.
            * **Timeout**: Check duration in seconds.
            * **Interval**: Interval between checks in seconds.
            * **Failed checks**: Allowed number of failed checks.
            * **Checks passed**: Required number of successful checks.

      {% endlist %}

   1. Under **Folder**, select the folder to create new resources in.
   1. Under **Maintenance**, select the [configuration](../../concepts/configurations.md) of the [instance](../../concepts/deploy/index.md) computing resources, the [availability zone](../../../overview/concepts/geo-scope.md), and the ID of the [subnet](../../../vpc/concepts/network.md#subnet) to host the instance in.
   1. Under **ACL**, click ![Add](../../../_assets/plus.svg) **Add ACL** and specify the [IDs of the folders](../../../resource-manager/operations/folder/get-id.md) to allow connections to the node from. By default, the ID of the folder owned by the user creating the node is specified.
   1. Click **Create**.

To view all created nodes:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **Resources**, select **Node**.

## Examples {#examples}

### Deploying a random number generator node from a cell {#randomizer}

Let's look at an example of creating an API endpoint that takes a number range as its input and returns a random integer.

1. [Create a project](../projects/create.md) in **{{ ml-platform-name }}** and open it.
1. Create a notebook by selecting **File** → **New** → **Notebook** from the menu.
1. Declare the input parameters and do not override them in the service code. To do this, create a cell with the following code:

   ```python
   input_data = dict(left_bound=1, right_bound=10)
   ```

1. Select and run the cell with the code by choosing **Run** → **Run Selected Cells** from the menu, or pressing **Shift** + **Enter**.
1. Describe the service that will handle the API calls. Create a new cell with the code:

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

   This will automatically create a checkpoint in the project.
1. Pin the checkpoint:
   1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
   1. Under **Resources**, select **Checkpoints**.
   1. In the list, choose the last added checkpoint named `Cell run` and make sure it contains the appropriate node.
   1. In the upper-right corner, click ![Pin](../../../_assets/datasphere/pin.svg) **Pin**.
   1. In the window that appears, enter a name for the checkpoint, such as `randomizer-checkpoint`, and click **Pin**.
1. Create a node:
   1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
   1. In the upper-right corner, click **Create resource**. In the window that opens, select **Node**.
   1. Specify the node parameters:
      * **Type**: **Cell**.
      * **Name**: Node name like `randomizer-node`.
      * In the **Checkpoint** field, select the checkpoint named `randomizer-checkpoint`.
      * Under **Input variables**, click ![Add](../../../_assets/plus.svg) **Add** and create a variable with the following parameters:
         * **Name**: `input_data`.
         * **Type**: `dict`.
      * Under **Output variables**, click ![Add](../../../_assets/plus.svg) **Add** and create a variable with the following parameters:
         * **Name**: `output_data`.
         * **Type**: `dict`.
   1. Under **Folder**, select your folder.
   1. Under **Maintenance**, select:
      * **Instance configuration**: `c1.4`.
      * **Availability zone**: `{{region-id}}-a`.
      * **Subnet ID**: Specify the ID of the subnet available in your folder. If you don't have a subnet, [create](../../../vpc/operations/subnet-create.md) one.
   1. Click **Create**.
1. Get the node ID:
   1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
   1. Under **Resources**, select **Node**.
   1. Select the created node and copy its ID (it is in the format `xxxxxxxxxxxxxxxxxxxx`).
1. [Get an IAM token](../../../iam/operations/iam-token/create.md) used for authentication in the API.
1. Install the [cURL](https://curl.se/) utility for sending REST API requests.
1. Start a terminal and select a POST request to the API of the service you created. Such as:

   ```bash
   curl -X POST 'https://datasphere.{{ api-host }}/datasphere/v1/nodes/<node ID>:execute' \
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
   * `<IAM token>`: IAM token used for authentication.
   * `<folder ID>`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) where the node was created.

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

   For details, see [{#T}](node-api.md).
1. Edit the `left_bound` and the `right_bound` request parameters. Send several API requests and make sure that random numbers from the specified range are returned.

#### See also {#see-also}

* [{#T}](node-customization.md)
* [{#T}](node-api.md)
* [{#T}](node-update.md)
* [{#T}](node-delete.md)
* [{#T}](alias-create.md)
* [{#T}](../../tutorials/node-from-docker.md)
