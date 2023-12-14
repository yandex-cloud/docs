# Creating a node with Python code

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
   1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
   1. In the list, choose the last added checkpoint named `Cell run` and make sure it contains the appropriate node.
   1. In the top-right corner, click ![Pin](../../../_assets/datasphere/pin.svg) **{{ ui-key.yc-ui-datasphere.common.pin }}**.
   1. In the pop-up window, enter the checkpoint name and click **{{ ui-key.yc-ui-datasphere.common.pin }}**.
1. Create a node:
   1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
   1. In the top-right corner, click **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
   1. Specify the basic node parameters:
      * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**: Resource that a node is based on (**{{ ui-key.yc-ui-datasphere.common.cell }}** or **{{ ui-key.yc-ui-datasphere.common.docker }}**).
      * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}**: Node name.
      * (Optional) **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.Description }}**: Node description.
   1. Depending on the node type, specify other parameters:

      {% list tabs %}

      - Cell

         * In the **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}** field, select the previously created checkpoint.
         * Under **{{ ui-key.yc-ui-datasphere.new-node.title.input-variables }}** and **{{ ui-key.yc-ui-datasphere.new-node.title.output-variables }}**, set the names and types of input and output variables for automatic API generation. You can add variables by clicking ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.common.add-new }}**.
         * (Optional) If a [nonstandard environment](node-customization.md) is used for running a cell code, select **{{ ui-key.yc-ui-datasphere.new-node.user-custom }}** under **{{ ui-key.yc-ui-datasphere.new-node.title.kernel-docker-image }}** and specify:
            * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.user-name }}**: `json_key`.
            * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.password-secret }}**: [Secret](../../concepts/secrets.md) with a password for your container registry.

      - Docker image

         * Under **{{ ui-key.yc-ui-datasphere.new-node.title.docker-image }}**, specify the path to the image in {{container-registry-name}}. Click **{{ ui-key.yc-ui-datasphere.common.show-additional-parameters }}** and specify:
            * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.user-name }}**: `json_key`.
            * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.password-secret }}**: [Secret](../../concepts/secrets.md) with a password for your container registry. For more information, refer to [{#T}](node-customization.md).
         * Under **{{ ui-key.yc-ui-datasphere.new-node.title.endpoint }}**:
            * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.type }}**: Select the node connection protocol: **HTTP** (**HTTP/2**) or **gRPC**.
            * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.port }}**: Specify the port for connecting to the node.
            * **{{ ui-key.yc-ui-datasphere.common.timeout }}**: Set the session duration in seconds.
            * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.idle-timeout }}**: Set the idle time before disconnecting from the node, in seconds.
         * (optional) Under **{{ ui-key.yc-ui-datasphere.new-node.title.telemetry }}**:
            * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**: Select the telemetry service (**{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.prometheus }}** or **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.yandex-monitoring }}**).
            * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.http-path }}**: Specify the address to send telemetry data to.
            * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.port }}**: Specify the port to send telemetry data to.
         * (optional) Under **{{ ui-key.yc-ui-datasphere.new-node.title.healthcheck }}**:
            * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.type }}**: Protocol to perform node health checks through (**HTTP** or **gRPC**).
            * **{{ ui-key.yc-ui-datasphere.common.port }}**: Port that node health checks are performed from.
            * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.path }}**: Path to the resource to check.
            * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.timeout }}**: Check duration in seconds.
            * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.interval }}**: Interval between checks in seconds.
            * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.fails-threshold }}**: Allowed number of failed checks.
            * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.passes-threshold }}**: Required number of successful checks.

      {% endlist %}

   1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}**, select the folder to create new resources in.
   1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}**, select the [configuration](../../concepts/configurations.md) of [instance](../../concepts/deploy/index.md) computing resources, the [availability zone](../../../overview/concepts/geo-scope.md), and the ID of the [subnet](../../../vpc/concepts/network.md#subnet) to host the instance in.
   1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.acl }}**, click ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.new-node.add-acl }}** and specify the [IDs of the folders](../../../resource-manager/operations/folder/get-id.md) to allow connections to the node from. By default, the ID of the folder owned by the user creating the node is specified.
   1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

To view all created nodes:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.

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
   1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
   1. In the list, choose the last added checkpoint named `Cell run` and make sure it contains the appropriate node.
   1. In the top-right corner, click ![Pin](../../../_assets/datasphere/pin.svg) **{{ ui-key.yc-ui-datasphere.common.pin }}**.
   1. In the pop-up window, enter a name for the checkpoint, such as `randomizer-checkpoint`, and click **{{ ui-key.yc-ui-datasphere.common.pin }}**.
1. Create a node:
   1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
   1. In the top-right corner, click **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
   1. Specify the node parameters:
      * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**: **{{ ui-key.yc-ui-datasphere.common.cell }}**.
      * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}**: Node name, e.g., `randomizer-node`.
      * In the **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.checkpoint }}** field, select the checkpoint named `randomizer-checkpoint`.
      * Under **{{ ui-key.yc-ui-datasphere.new-node.title.input-variables }}**, click ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.common.add-new }}** and create a variable with the following parameters:
         * **{{ ui-key.yc-ui-datasphere.new-node.variables-form-placeholder.name }}**: `input_data`.
         * **{{ ui-key.yc-ui-datasphere.common.type }}**: `{{ ui-key.yc-ui-datasphere.node-page.type.dict }}`.
      * Under **{{ ui-key.yc-ui-datasphere.new-node.title.output-variables }}**, click ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.common.add-new }}** and create a variable with the following parameters:
         * **{{ ui-key.yc-ui-datasphere.new-node.variables-form-placeholder.name }}**: `output_data`.
         * **{{ ui-key.yc-ui-datasphere.common.type }}**: `{{ ui-key.yc-ui-datasphere.node-page.type.dict }}`.
   1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}**, select your folder.
   1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}**, select:
      * **{{ ui-key.yc-ui-datasphere.new-node.provisioning-form-label.instance-spec }}**: `c1.4`.
      * Under **{{ ui-key.yc-ui-datasphere.node-page.provisioning.distribution-by-zones }}**, click **{{ ui-key.yc-ui-datasphere.new-node.add-new-zone }}** and select `{{ region-id }}-a`.
         * In the menu that opens, click **{{ ui-key.yc-ui-datasphere.common.add-new }}** in the **{{ ui-key.yc-ui-datasphere.common.subnet }}** field.
         * In the window that opens, specify the ID of the subnet available in your folder. If you do not have a subnet, [create](../../../vpc/operations/subnet-create.md) one.
         * Click **{{ ui-key.yc-ui-datasphere.common.add }}**.
   1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. Get the node ID:
   1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
   1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
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

   For more information, see [{#T}](node-api.md).
1. Edit the `left_bound` and the `right_bound` request parameters. Send several API requests and make sure that random numbers from the specified range are returned.

#### See also {#see-also}

* [{#T}](node-customization.md)
* [{#T}](node-api.md)
* [{#T}](node-update.md)
* [{#T}](node-delete.md)
* [{#T}](alias-create.md)
* [{#T}](../../tutorials/node-from-docker.md)
* [{#T}](../../tutorials/node-from-cell.md)
