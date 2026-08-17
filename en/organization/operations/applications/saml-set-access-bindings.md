---
title: How to grant access to a SAML app in {{ org-full-name }}
description: In this article, you will learn how to set up access to a SAML app in {{ org-full-name }}.
---

# Setting up access to an SAML app in {{ org-full-name }}


To grant access to a [SAML app](../../concepts/applications/saml.md), assign [roles](../../../iam/concepts/access-control/roles.md) to subjects. [Learn](../../security/index.md#roles-list) what roles the service has and assign the required ones.

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [app-set-access-bindings-ui](../../../_includes/organization/app-set-access-bindings-ui.md) %}

- CLI {#cli}

  {% include [set-access-bindings-cli](../../../_includes/iam/set-access-bindings-cli.md) %}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the CLI command for assigning roles for a SAML application:

      ```bash
      yc organization-manager idp application saml application set-access-bindings --help
      ```

   1. Get a list of SAML apps and their IDs:

      ```bash
      yc organization-manager idp application saml application list --organization-id <organization_ID>
      ```

      Where `--organization-id` is the [ID of the organization](../organization-get-id.md) you need the list of SAML apps for.

   1. Get the ID of the [user](../../../organization/operations/users-get.md), [service account](../../../iam/operations/sa/get-id.md), or group to which you are assigning roles for the SAML application.
   1. Use the `yc organization-manager idp application saml application set-access-bindings` command to assign the following roles:

      ```bash
      yc organization-manager idp application saml application set-access-bindings \
        --id <app_ID> \
        --access-binding role=<role>,subject=<subject_type>:<subject_ID>
      ```

      Where:

      * `--id`: ID of the SAML application to grant access to.
      * `role`: ID of the role you need to assign.
      * `subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      Provide a separate `--access-binding` parameter for each role. Here is an example:

      ```bash
      yc organization-manager idp application saml application set-access-bindings \
        --id <app_ID> \
        --access-binding role=<role1>,service-account-id=<service_account_ID> \
        --access-binding role=<role2>,service-account-id=<service_account_ID> \
        --access-binding role=<role3>,service-account-id=<service_account_ID>
      ```

- API {#api}

  {% include [set-access-bindings-api](../../../_includes/iam/set-access-bindings-api.md) %}

  Use the [Application.SetAccessBindings](../../idp/application/saml/api-ref/Application/setAccessBindings.md) REST API method for the [Application](../../idp/application/saml/api-ref/Application/index.md) resource or the [ApplicationService/SetAccessBindings](../../idp/application/saml/api-ref/grpc/Application/setAccessBindings.md) gRPC API call.

  Provide the following in the request:

  * Role in the `accessBindings[].roleId` parameter.
  * ID of the [subject](../../../iam/concepts/access-control/index.md#subject) getting the role for the SAML application in the `accessBindings[].subject.id` parameter.
  * Type of the subject getting the role for the SAML application in the `accessBindings[].subject.type` parameter.

      {% cut "Subject designations" %}

      {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

      {% endcut %}

{% endlist %}