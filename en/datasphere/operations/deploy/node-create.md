# Creating a node

You can deploy an individual notebook cell or a third-party [Docker image](../../../container-registry/concepts/docker-image.md) as an independent service using [nodes](../../concepts/resource-model.md#resources).

{% note warning %}

{% include [pricing nodes](../../../_includes/datasphere/nodes-pricing-warn.md) %}

{% endnote %}

If your project uses packages and libraries that are not included in the [list of pre-installed software](../../concepts/preinstalled-packages.md), first [configure the node environment](node-customization.md) using a Docker image.

## Node from models {#from-model}


1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. In the top-right corner, click **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. Enter the node name in the **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}** field.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**, specify the resource type: **{{ ui-key.yc-ui-datasphere.common.model }}**.
1. In the **{{ ui-key.yc-ui-datasphere.common.models }}** field, select the saved [model](../../concepts/models/index.md) and specify the input data if needed.

   {% note info %}

   When deploying [PyTorch models](../../concepts/models/index.md#supported-types), {{ ml-platform-name }} cannot automatically provide the input and output parameters.

   If you are setting the input data, make sure to specify the output data as well. When the input data is set manually for any model type, {{ ml-platform-name }} cannot automatically provide the output data.

   {% endnote %}

1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}**, select the folder to create new resources in.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}**, select the [configuration](../../concepts/configurations.md) of [instance](../../concepts/deploy/index.md) computing resources, the [availability zone](../../../overview/concepts/geo-scope.md), and the ID of the [subnet](../../../vpc/concepts/network.md#subnet) to host the instance in.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.acl }}**, click ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.new-node.add-acl }}** and specify the [IDs of the folders](../../../resource-manager/operations/folder/get-id.md) to allow connections to the node from. By default, the ID of the folder owned by the user creating the node is specified.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

To view all created nodes:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.

## Node from a Docker image {#from-docker}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. In the top-right corner, click **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. Specify the basic node parameters:
   * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**: Resource that a node is based on (**{{ ui-key.yc-ui-datasphere.common.cell }}** or **{{ ui-key.yc-ui-datasphere.common.docker }}**).
   * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}**: Node name.
   * (Optional) **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.Description }}**: Node description.
1. Set additional parameters:
   * Under **{{ ui-key.yc-ui-datasphere.new-node.title.docker-image }}**, specify the path to the image in {{ container-registry-name }}. Click **{{ ui-key.yc-ui-datasphere.common.show-additional-parameters }}** and specify:
     * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.user-name }}**: `json_key`.
     * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.password-secret }}**: [Secret](../../concepts/secrets.md) with a password for your container registry. See [{#T}](node-customization.md).
   * Under **{{ ui-key.yc-ui-datasphere.new-node.title.endpoint }}**:
     * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.type }}**: Select the node connection protocol: **HTTP** (**HTTP/2**) or **gRPC**.
     * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.port }}**: Specify the port for connecting to the node.
     * **{{ ui-key.yc-ui-datasphere.common.timeout }}**: Set the session duration in seconds.
     * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.idle-timeout }}**: Set the idle time before disconnecting from the node, in seconds.
   * (Optional) Under **{{ ui-key.yc-ui-datasphere.new-node.title.telemetry }}**:
     * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}**: Select the telemetry service (**{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.prometheus }}** or **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.yandex-monitoring }}**).
     * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.http-path }}**: Specify the address to send telemetry data to.
     * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.port }}**: Specify the port to send telemetry data to.
   * (Optional) Under **{{ ui-key.yc-ui-datasphere.new-node.title.healthcheck }}**:
     * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.type }}**: Protocol to perform node health checks through (**HTTP** or **gRPC**).
     * **{{ ui-key.yc-ui-datasphere.common.port }}**: Port that node health checks are performed from.
     * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.path }}**: Path to the resource to check.
     * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.timeout }}**: Check duration in seconds.
     * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.interval }}**: Interval between checks in seconds.
     * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.fails-threshold }}**: Allowed number of failed checks.

     * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.passes-threshold }}**: Required number of successful checks.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}**, select the folder to create new resources in.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}**, select the [configuration](../../concepts/configurations.md) of [instance](../../concepts/deploy/index.md) computing resources, the [availability zone](../../../overview/concepts/geo-scope.md), and the ID of the [subnet](../../../vpc/concepts/network.md#subnet) to host the instance in.
1. Under **{{ ui-key.yc-ui-datasphere.new-node.title.acl }}**, click ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.new-node.add-acl }}** and specify the [IDs of the folders](../../../resource-manager/operations/folder/get-id.md) to allow connections to the node from. By default, the ID of the folder owned by the user creating the node is specified.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

To view all created nodes:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.

#### See also {#see-also}

* [{#T}](node-customization.md)
* [{#T}](node-api.md)
* [{#T}](node-update.md)
* [{#T}](node-delete.md)
* [{#T}](alias-create.md)
* [{#T}](../../tutorials/node-from-docker.md)
* [{#T}](../../tutorials/node-from-model.md)
