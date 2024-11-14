---
title: How to specify a cloud network to run a container in
description: Use this guide to specify a cloud network to run a container in.
---

# Specifying a cloud network to run a container in

You can specify a [cloud network](../../vpc/concepts/network.md#network) to run your container in.

{% include [network](../../_includes/functions/network.md) %}

{% list tabs group=instructions %}

- Management console {#console}
    
    1. In the [management console]({{ link-console-main }}), select the folder with your container.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Select the container.
    1. Go to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
    1. Under **{{ ui-key.yacloud.serverless-containers.section_parameters }}**, in the **{{ ui-key.yacloud.vpc.label_network }}** field, choose a cloud network to run your container in.
    1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- API {#api}

  To specify a cloud network to run your container in, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}

## See also

* [Networking in {{ serverless-containers-name }}](../concepts/networking.md).
