---
title: How to update an OIDC application in {{ org-full-name }}
description: Follow this guide to update an OIDC application in {{ org-name }}.
---

# Updating an OIDC application in {{ org-full-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

## Update the app's basic settings {#update-basic-settings}

To update the [OIDC app's](../../concepts/applications.md#oidc) basic settings:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the OIDC application.
  1. On the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:

      1. Change the app's name in the **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-name_kxMrU }}** field. The name must be unique within the organization and follow the naming requirements:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

      1. Change the app's description in the **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-description_fcXBi }}** field.
      1. Add new [labels](../../../resource-manager/concepts/labels.md) by clicking **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-labels_kc4MN }}** in the **{{ ui-key.yacloud.component.label-set.button_add-label }}** field. Click ![xmark](../../../_assets/console-icons/xmark.svg) to delete an existing label.
      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating an OIDC application:

     ```bash
     yc organization-manager idp application oauth application update --help
     ```
  
  1. Run this command:

     ```bash
     yc iam organization-manager idp application oauth application update \
       --id <app_ID> \
       --new-name <application_name> \
       --description <application_description> \
       --client-id <OAuth_client_ID> \
       --authorized-scopes <attribute>[,<attribute>] \
       --group-distribution-type all-groups \
       --labels <key>=<value>[,<key>=<value>]
     ```

     Where:

     * `--id`: OIDC app ID. This is a required parameter.
     * `--name`: New name for the OIDC app. The name must be unique within the organization and follow the naming requirements:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `--description`: New description for the OIDC app.
     * `--client-id`: ID of the new OAuth client.
     * `--authorized-scopes`: New user attributes that will be available to the service provider. Specify one or more attributes, comma-separated, in `<attribute1>,<attribute2>` format. Possible attributes:
       * `openid`: User ID. Required attribute.
       * `profile`: Additional user details, such as first name, last name, and avatar.
       * `email`: User email address.
       * `address`: User home address.
       * `phone`: User phone number.
       * `groups`: [User groups](../../concepts/groups.md) in the organization.

         {% note warning %}
         
         You need to specify the new user attributes in the [service provider configuration](#update-sp) first, using the `--scopes` parameters.
         
         {% endnote %}

     * `--group-distribution-type`: If you specified the `groups` attribute when creating or updating the OAuth client, update the user groups you want to send to your service provider. The possible values are:
       * `all-groups`: Service provider will get all groups the user belongs to.

          The maximum number of groups to change hands is 1,000. If the user belongs to more groups than this, only the first thousand will go to the service provider.
       * `assigned-groups`: Of all the user's groups, the service provider will only get the ones [explicitly specified](#users-and-groups).
       * `none`: Service provider will not get any of the groups the user belongs to.
     * `labels`: New list of [labels](../../../resource-manager/concepts/labels.md). You can specify one or more labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.

     Result:

     ```text
     id: ek0o663g4rs2********
     name: oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

- API {#api}

  Use the [Application.Update](../../idp/application/oauth/api-ref/Application/update.md) REST API method for the [Application](../../idp/application/oauth/api-ref/Application/index.md) resource or the [ApplicationService/Update](../../idp/application/oauth/api-ref/grpc/Application/update.md) gRPC API call.

{% endlist %}

## Update the service provider configuration {#update-sp}

To update the service provider configuration in an OIDC app:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. {% include [oidc-app-update-sp-settings](../../../_includes/organization/oidc-app-update-sp-settings.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for setting up the OAuth client:

     ```bash
     yc iam oauth-client update --help
     ```

  1. Run this command:

     ```bash
     yc iam oauth-client update \
       --id <OAuth_client_ID> \
       --new-name <new_name_for_OAuth_client> \
       --redirect-uris <address>[,<address>] \
       --scopes <attribute>[,<attribute>]
     ```

     Where:

     * `--id`: OAuth client ID.
     * `--new-name`: New name for the OAuth client.
     * `--scopes`: New user attributes that will be available to the service provider. Specify one or more attributes, comma-separated, in `<attribute1>,<attribute2>` format. Possible attributes:
       * `openid`: User ID. Required attribute.
       * `profile`: Additional user details, such as first name, last name, and avatar.
       * `email`: User email address.
       * `address`: User home address.
       * `phone`: User phone number.
       * `groups`: [User groups](../../concepts/groups.md) in the organization.

         {% note warning %}
         
         You also need to specify the new user attributes in the [app's basic settings](#update-basic-settings) using the `--authorized-scopes` parameters.
         
         {% endnote %}

     * `--redirect-uris`: Specify the new address or addresses you got from the service provider in `<address1>,<address2>` format.

     Result:

     ```text
     id: ajejklv8g9kh********
     name: my-oauth-client
     redirect_uris:
       - https://example2.com
       - https://example2.ru
     scopes:
       - openid
       - profile
     folder_id: b1g500m2195v********
     status: ACTIVE
     ```

- API {#api}

  Use the [OAuthClient.Update](../../../iam/api-ref/OAuthClient/update.md) REST API method for the [OAuthClient](../../../iam/api-ref/grpc/OAuthClient/index.md) resource or the [OAuthClientService/Update](../../../iam/api-ref/grpc/OAuthClient/update.md) gRPC API call.

{% endlist %}

## Updating an app's secret {#update-secret}

There is no way you can view or update an app’s [secret](../../concepts/applications.md#oidc-secret). Instead, you can generate a new one:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}
  1. Remember to provide the new secret in the settings on the service provider side. If you need help, refer to your service provider's documentation or support team.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating a new OIDC app secret:

     ```bash
     yc iam oauth-client-secret create --help
     ```

  1. Run this command:

     ```bash
     yc iam oauth-client-secret create --oauth-client-id <OAuth_client_ID>
     ```

     Result:

     ```text
     oauth_client_secret:
       id: aje0hjqp68u6********
       oauth_client_id: ajejklv8g9kh********
       masked_secret: yccs__9e1d5f6d5c****
       created_at: "2025-10-23T11:44:50.739768533Z"
     secret_value: yccs__9e1d5f6d5c********
     ```

     Remember to provide the new secret in the settings on the service provider side. If you need help, refer to your service provider's documentation or support team.

- API {#api}

  Use the [OAuthClientSecret.Create](../../../iam/api-ref/OAuthClientSecret/create.md) REST API method for the [OAuthClientSecret](../../../iam/api-ref/OAuthClientSecret/index.md) resource or the [OAuthClientSecretService/Create](../../../iam/api-ref/grpc/OAuthClientSecret/create.md) gRPC API call.

{% endlist %}

## Update the list of app users and groups {#users-and-groups}

Update the list of your [organization's](../../concepts/organization.md) users permitted to authenticate in an external app with an OIDC application:

{% include [oidc-app-update-users-groups](../../../_includes/organization/oidc-app-update-users-groups.md) %}

#### See also {#see-also}

* [{#T}](./oidc-create.md)
* [{#T}](./oidc-deactivate-remove.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#oidc)
* [{#T}](../manage-groups.md)