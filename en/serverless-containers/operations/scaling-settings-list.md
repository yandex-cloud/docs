---
title: Viewing container scaling settings
description: Follow this guide to view container scaling settings.
---

# Viewing container scaling settings

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder with your container.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Select the container. Under **{{ ui-key.yacloud.serverless-containers.section-revisions }}**, the number of prepared instances will be displayed in the container revision line.

        Information about the number of container instances per availability zone and the number of concurrent container invocations per availability zone can be viewed by [getting](revision-info.md) details about the container revision.

- CLI {#cli}

    To view the container scaling settings, [get](revision-info.md) information about the container revision. The scaling settings will be displayed in the following parameters:

    * `min_instances`: Number of prepared container instances.
    * `zone_instances_limit`: Number of container instances per availability zone.
    * `zone_requests_limit`: Number of concurrent container invocations per availability zone.
  
- API {#api}

  To view container scaling settings, use the [getRevision](../containers/api-ref/Container/getRevision.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/GetRevision](../containers/api-ref/grpc/Container/getRevision.md) gRPC API call.

{% endlist %}

{% include [scaling](../../_includes/serverless-containers/see-also-scaling.md) %}