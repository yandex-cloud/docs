# Creating a node

You can deploy an individual notebook cell or a third-party [Docker image](../../../container-registry/concepts/docker-image.md) as an independent service using [nodes](../../concepts/resource-model.md#resources).

{% note warning %}

{% include [pricing nodes](../../../_includes/datasphere/nodes-pricing-warn.md) %}

{% endnote %}

If your project uses packages and libraries that are not included in the [list of pre-installed software](../../concepts/preinstalled-packages.md), first [configure the node environment](node-customization.md) using a Docker image.

## Node from a model {#from-model}


1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. In the top-right corner, click **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. Enter a name for the node in the **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}** field.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**, specify the resource type: **{{ ui-key.yc-ui-datasphere.common.model }}**.
1. In the **{{ ui-key.yc-ui-datasphere.common.models }}** field, select the saved [model](../../concepts/models/index.md) and specify the input data if needed.

   {% note info %}

   When deploying [PyTorch models](../../concepts/models/index.md#supported-types), {{ ml-platform-name }} cannot automatically provide the input and output parameters.

   If you are setting the input data, make sure to specify the output data as well. When the input data is set manually for any model type, {{ ml-platform-name }} cannot automatically provide the output data.

   {% endnote %}

   For XGBoost models and LightGBM models, the names and types of input and output parameters remain unchanged:
   * Input parameters: `input__0` of the `TYPE_FP32` type, vector length: [N]. For example, if N=32, specify `[32]` in the **{{ ui-key.yc-ui-datasphere.common.dimension }}** field.
   * Output parameters: `output__0` of the `TYPE_FP32` type, scalar value. In the **{{ ui-key.yc-ui-datasphere.common.dimension }}** field, specify `[1]`.

   {% note tip %}

   To create a node from XGBoost and LightGBM models saved in {{ ml-platform-name }} before April 8, 2024, re-save them to the [model](../../concepts/models/index.md) resource.

   {% endnote %}

1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}**, select the folder to create new resources in.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}**, select the [configuration](../../concepts/configurations.md) of [instance](../../concepts/deploy/index.md) computing resources, the [availability zone](../../../overview/concepts/geo-scope.md), and the ID of the [subnet](../../../vpc/concepts/network.md#subnet) to host the instance in.
1. In the **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.maintenance-limit }}** field, specify how many of the node's instances can be stopped for maintenance at the same time.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.acl }}**, click ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.new-node.add-acl }}** and specify the [IDs of the folders](../../../resource-manager/operations/folder/get-id.md) to allow connections to the node from. By default, the ID of the folder owned by the user creating the node is specified.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

To view all created nodes:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.

## Node from a Docker image {#from-docker}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. In the top-right corner, click **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. Enter a name for the node in the **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}** field.
1. (Optional) In the **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.Description }}** field, enter a description of the node.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**, select the resource to base your node on: **{{ ui-key.yc-ui-datasphere.common.docker }}**.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.source }}**, select the container registry. You can select {{ container-registry-name }} or any other registry. For {{ container-registry-name }}, specify:
   * **{{ ui-key.yc-ui-datasphere.new-node.title.docker-image }}** in the `{{ registry }}/<registry_ID>/<image_ID>:<tag>` format.
   * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.user-name }}** will automatically get the `json_key` value.
   * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.password-secret }}**: In the project settings, select the [secret](../../concepts/secrets.md) containing the file with the [authorized key](../../../iam/concepts/authorization/key.md) for the service account from the list.

   To use an image from another Docker image storage, select the **{{ ui-key.yc-ui-datasphere.common.other }}** type and fill the remaining fields with the values required for connection to your registry.

1. Optionally, under **{{ ui-key.yc-ui-datasphere.new-node.title.runtime-options }}**, set the disk size available in the Docker image.

1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.endpoint }}**:
   * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.type }}**: Select the node connection protocol: **HTTP** (**HTTP/2**) or **gRPC**.
   * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.port }}**: Specify the port for connecting to the node.
   * **{{ ui-key.yc-ui-datasphere.common.timeout }}**: Set the session duration in seconds.
   * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.idle-timeout }}**: Set the idle time before disconnecting from the node, in seconds.
1. (Optional) Under **{{ ui-key.yc-ui-datasphere.new-node.title.telemetry }}**:
   * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**: Select the telemetry service (**{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.prometheus }}** or **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.yandex-monitoring }}**).
   * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.http-path }}**: Specify the address to send telemetry data to.
   * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.port }}**: Specify the port to send telemetry data to.
1. (Optional) Under **{{ ui-key.yc-ui-datasphere.new-node.title.healthcheck }}**:
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.type }}**: Protocol to perform node health checks through (**HTTP** or **gRPC**).
   * **{{ ui-key.yc-ui-datasphere.common.port }}**: Port that node health checks are performed from.
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.path }}**: Path to the resource to check.
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.timeout }}**: Check duration in seconds.
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.interval }}**: Interval between checks in seconds.
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.fails-threshold }}**: Allowed number of failed checks.
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.passes-threshold }}**: Required number of successful checks.
1. (Optional) Under **{{ ui-key.yc-ui-datasphere.new-node.title.runtime-options }}**, set the total memory available in the Docker image.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}**, select the folder to create new resources in.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}**:
   * **{{ ui-key.yc-ui-datasphere.node-page.instance-spec }}**: Select a [configuration](../../concepts/configurations.md) of the [instance's](../../concepts/deploy/index.md) computing resources.
   * **{{ ui-key.yc-ui-datasphere.node-page.provisioning.distribution-by-zones }}**: Add an [availability zone](../../../overview/concepts/geo-scope.md) and the ID of the [subnet](../../../vpc/concepts/network.md#subnet) to host the instance in.
   * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.maintenance-limit }}**: Specify how many of the node's instances can be stopped for maintenance at the same time.
   * **{{ ui-key.yc-ui-datasphere.new-node.additional-disk.title }}**: Optionally, add an additional disk for the instance. If you selected multiple instances, a disk will be created for each one.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.acl }}**, click ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.new-node.add-acl }}** and specify the [IDs of the folders](../../../resource-manager/operations/folder/get-id.md) to allow connections to the node from. By default, the ID of the folder owned by the user creating the node is specified.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

To view all created nodes:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.

#### See also {#see-also}

* [{#T}](node-customization.md)
* [{#T}](node-update.md)
* [{#T}](node-delete.md)
* [{#T}](alias-create.md)
* [{#T}](../../tutorials/node-from-docker.md)
* [{#T}](../../tutorials/node-from-model.md)