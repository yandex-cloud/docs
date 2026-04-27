---
title: Deleting an identity federation in {{ org-full-name }}
description: In this tutorial, you will learn how to delete an identity federation in {{ org-full-name }}.
---

# Deleting an identity federation

{% note info %}

To delete an identity federation, the user must have the `organization-manager.organizations.owner` [role](../security/index.md#organization-manager-organizations-owner).

{% endnote %}

To delete an identity federation:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ cloud-center }}]({{ cloud-center-link }}) with an administrator or organization owner account.
  1. In the left-hand panel, select ![VectorSquare](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.
  1. Next to the identity federation, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the command for deleting a {{ org-full-name }} user group:

      ```bash
      yc organization-manager federation saml delete --help
      ```

  1. Get a list of federations in the organization:

     ```bash
     yc organization-manager federation saml list \
       --organization-id <organization_ID>
     ```

     Where `--organization-id` is the [ID of the organization](organization-get-id.md) you need the list of federations for.
  
  1. To delete an identity federation, run this command:

      ```bash
      yc organization-manager federation saml delete <federation_name_or_ID>
      ```

- API {#api}

    Use the [Federation.delete](../saml/api-ref/Federation/delete.md) REST API method for the [Federation](../saml/api-ref/Federation/index.md) resource or the [FederationService/Delete](../saml/api-ref/grpc/Federation/delete.md) gRPC API call.

{% endlist %}