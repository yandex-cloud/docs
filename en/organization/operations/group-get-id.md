---
title: Getting {{ yandex-cloud }} group ID
description: Follow this guide to get {{ yandex-cloud }} group ID.
---

# Getting group ID

{{ yandex-cloud }} assigns a unique ID to each group. With this ID, you can perform various operations with the group itself and the users belonging to it.

To find out the group ID:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ cloud-center }}]({{ cloud-center-link }}).
  1. In the left-hand panel, select ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.
  1. Click ![copy](../../_assets/console-icons/copy.svg) next to the group's ID to copy it.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. {% include [get-federation-id-cli](../../_includes/organization/get-group-id-cli.md) %}

- API {#api}

  Use the [list](../../organization/api-ref/Group/list.md) REST API method for the [Group](../../organization/api-ref/Group/index.md) resource or the [GroupService/List](../../organization/api-ref/grpc/Group/list.md) gRPC API call.

{% endlist %}