---
title: Getting a {{ yandex-cloud }} organization ID
description: In this guide, you will learn how to get a {{ yandex-cloud }} organization ID.
---

# Getting an organization ID

Each organization in {{ yandex-cloud }} is assigned a unique ID. With this ID, you can perform various operations with both the organization and its internal resources.

To find out the organization ID:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ cloud-center }}]({{ cloud-center-link }}).

      On the {{ cloud-center }} home page that opens, you can view general info about your organization. 

  1. You can find the organization ID below the organization name in the center of the screen. Click ![copy](../../_assets/console-icons/copy.svg) to the right of the ID to copy it.

      If you have multiple organizations, you can [switch](./manage-organizations.md#switch-to-another-org) between them. To do this, in the top-left corner, click ![chevron-down](../../_assets/console-icons/chevron-down.svg) next to the name of the current organization and select the one you need.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. To view a list of available organizations, run this command:

      ```bash
      yc organization-manager organization list
      ```

      Result:

      ```text
      +----------------------+-----------------------------+-------------------------+--------+
      |          ID          |            NAME             |          TITLE          | LABELS |
      +----------------------+-----------------------------+-------------------------+--------+
      | bpf1smsil5q0******** | org1-technical-name         | Organization One        |        |
      | bpf2c65rqcl8******** | org2-technical-name         | Organization Two        |        |
      | bpfaidqca8vd******** | org3-technical-name         | Organization Three      |        |
      +----------------------+-----------------------------+-------------------------+--------+
      ```

      Copy the ID of the organization you need from the `ID` field.

- API {#api}

    Use the [list](../../organization/api-ref/Organization/list.md) REST API method for the [Organization](../../organization/api-ref/Organization/index.md) resource or the [OrganizationService/List](../../organization/api-ref/grpc/Organization/list.md) gRPC API call.

{% endlist %}