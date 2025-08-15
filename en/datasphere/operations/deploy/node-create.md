# Creating a node

You can deploy an individual notebook cell or a third-party [Docker image](../../../container-registry/concepts/docker-image.md) as a standalone service using [nodes](../../concepts/resource-model.md#resources).

{% note warning %}

{% include [pricing nodes](../../../_includes/datasphere/nodes-pricing-warn.md) %}

{% endnote %}

If your project uses packages and libraries that are not included in the [list of pre-installed software](../../concepts/preinstalled-packages.md), first [configure your node environment](node-customization.md) using a Docker image.

## Node from a model {#from-model}


1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. In the top-right corner, click **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. Enter a name for the node in the **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}** field.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**, specify the resource type: **{{ ui-key.yc-ui-datasphere.common.model }}**.
1. In the **{{ ui-key.yc-ui-datasphere.common.models }}** field, select the saved [model](../../concepts/models/index.md) and specify the inputs, if required.

   {% note info %}

   When deploying [PyTorch models](../../concepts/models/index.md#supported-types), {{ ml-platform-name }} cannot automatically infer the input and output parameters.

   If you are setting the inputs, make sure to specify the outputs as well. When you set the inputs manually for any model type, {{ ml-platform-name }} cannot automatically infer the outputs.

   {% endnote %}

   For XGBoost and LightGBM models, the names and types of input and output parameters remain unchanged:
   * Input parameters: `input__0` of the `TYPE_FP32` type, vector with the [N] length. For example, if N=32, specify `[32]` in the **{{ ui-key.yc-ui-datasphere.common.dimension }}** field.
   * Output parameters: `output__0` of the `TYPE_FP32` type, scalar value. In the **{{ ui-key.yc-ui-datasphere.common.dimension }}** field, specify `[1]`.

   {% note tip %}

   To create a node from XGBoost and LightGBM models saved in {{ ml-platform-name }} before April 8, 2024, re-save them to the [model](../../concepts/models/index.md) resource.

   {% endnote %}

1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}**, select the folder for the new resources.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}**, select the [configuration](../../concepts/configurations.md) of [instance](../../concepts/deploy/index.md) computing resources, [availability zone](../../../overview/concepts/geo-scope.md), and the ID of the [subnet](../../../vpc/concepts/network.md#subnet) to host the instance.
1. In the **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.maintenance-limit }}** field, specify the maximum number of node instances that can be shut down for maintenance at the same time.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.acl }}**, click ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.new-node.add-acl }}** and specify the [IDs of the folders](../../../resource-manager/operations/folder/get-id.md) allowed to connect to the node. The folder ID of the user creating the node is specified by default.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

To view all created nodes:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.

## Node from a Docker image {#from-docker}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. In the top-right corner, click **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. Enter a name for the node in the **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}** field.
1. Optionally, in the **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.Description }}** field, enter a description for the node.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**, select the resource to base your node on: **{{ ui-key.yc-ui-datasphere.common.docker }}**.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.source }}**, select the container registry. You can select {{ container-registry-name }} or any other registry. For {{ container-registry-name }}, specify:
   * **{{ ui-key.yc-ui-datasphere.new-node.title.docker-image }}** in the following format: `{{ registry }}/<registry_ID>/<image_ID>:<tag>`.
   * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.user-name }}** will automatically get the `json_key` value.
   * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.password-secret }}**: In the project settings, select the [secret](../../concepts/secrets.md) containing the file with the [authorized key](../../../iam/concepts/authorization/key.md) for the service account from the list.

   To use an image from another Docker image storage, select the **{{ ui-key.yc-ui-datasphere.common.other }}** type and fill the remaining fields with the values required for connection to your registry.

1. Optionally, under **{{ ui-key.yc-ui-datasphere.new-node.title.runtime-options }}**, set the disk size available in the Docker image.

1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.endpoint }}**:
   * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.type }}**: Select a node connection protocol, **HTTP** (**HTTP/2**) or **gRPC**.
   * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.port }}**: Specify the port for connecting to the node.
   * **{{ ui-key.yc-ui-datasphere.common.timeout }}**: Set the session timeout, in seconds.
   * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.idle-timeout }}**: Set the idle time before disconnecting from the node, in seconds.
1. Optionally, under **{{ ui-key.yc-ui-datasphere.new-node.title.telemetry }}**:
   * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**: Select the telemetry service, **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.prometheus }}** or **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.yandex-monitoring }}**.
   * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.http-path }}**: Specify the address to send telemetry data to.
   * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.port }}**: Specify the port to send telemetry data to.
1. Optionally, under **{{ ui-key.yc-ui-datasphere.new-node.title.healthcheck }}**:
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.type }}**: Node health check protocol, **HTTP** or **gRPC**.
   * **{{ ui-key.yc-ui-datasphere.common.port }}**: Port used for node health checks.
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.path }}**: Path to the resource to check.
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.timeout }}**: Check duration, in seconds.
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.interval }}**: Interval between checks, in seconds.
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.fails-threshold }}**: Allowed number of failed checks.
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.passes-threshold }}**: Required number of successful checks.
1. Optionally, under **{{ ui-key.yc-ui-datasphere.new-node.title.runtime-options }}**, set the total memory available in the Docker image.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}**, select the folder for the new resources.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}**:
   * **{{ ui-key.yc-ui-datasphere.node-page.instance-spec }}**: Select a [configuration](../../concepts/configurations.md) of the [instance](../../concepts/deploy/index.md) computing resources.
   * **{{ ui-key.yc-ui-datasphere.node-page.provisioning.distribution-by-zones }}**: Add an [availability zone](../../../overview/concepts/geo-scope.md) and the ID of the [subnet](../../../vpc/concepts/network.md#subnet) to host the instance.
   * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.maintenance-limit }}**: Specify the maximum number of node instances that can be shut down for maintenance at the same time.
   * **{{ ui-key.yc-ui-datasphere.new-node.additional-disk.title }}**: Optionally, add a secondary disk for the instance. If you selected multiple instances, a disk will be created for each one.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.acl }}**, click ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.new-node.add-acl }}** and specify the [IDs of the folders](../../../resource-manager/operations/folder/get-id.md) allowed to connect to the node. The folder ID of the user creating the node is specified by default.
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
