---
title: Getting {{ yandex-cloud }} organization ID
description: In this guide, you will learn how to get {{ yandex-cloud }} organization ID.
---

# Getting organization ID

In {{ yandex-cloud }}, each organization gets a unique ID. With this ID, you can perform all kinds of operations with the organization itself and the resources created inside it.

To find out the organization ID:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ cloud-center }}]({{ cloud-center-link }}).

      On the {{ cloud-center }} home page that opens, there is general info about your organization. 

  1. You can find the organization ID below the organization's name in the center of the screen. Click ![copy](../../_assets/console-icons/copy.svg) to the right of the ID to copy it.

      If you have more than one organization, you can [switch](./manage-organizations.md#switch-to-another-org) between them. To do this, click ![chevron-down](../../_assets/console-icons/chevron-down.svg) next to the name of the current organization in the top-left corner of the screen and select another one.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. To view a list of organizations available to you, run this command:

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