---
title: Getting {{ yandex-cloud }} organization ID
description: In this guide, you will learn how to get {{ yandex-cloud }} organization ID.
---

# Getting organization ID

In {{ yandex-cloud }}, each organization gets a unique ID. With this ID, you can perform all kinds of operations with the organization itself and the resources created inside it.

To find out the organization ID:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ cloud-center }}]({{ cloud-center-link }}).

     On the {{ cloud-center }} home page that opens, there is general info about your organization. 

  1. You can find the organization ID below the organization's name in the center of the screen. Click ![copy](../../_assets/console-icons/copy.svg) to the right of the ID to copy it.

     {% include [switch-org-note](../../_includes/organization/switch-org-note.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. {% include [get-federation-id-cli](../../_includes/organization/get-federation-id-cli.md) %}

- API {#api}

  Use the [list](../../organization/api-ref/Organization/list.md) REST API method for the [Organization](../../organization/api-ref/Organization/index.md) resource or the [OrganizationService/List](../../organization/api-ref/grpc/Organization/list.md) gRPC API call.

{% endlist %}