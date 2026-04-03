---
title: Getting a list of available access policy templates
description: In this tutorial, you will learn how to get a list of {{ iam-full-name }} access policy templates you can assign for {{ yandex-cloud }} resources.
---

# Getting a list of supported access policy templates

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{% include [access-policies-instruction-intro](../../../_includes/iam/access-policies-instruction-intro.md) %}

To get a list of [supported](../../concepts/access-control/access-policies.md#supported-policies) access policy templates:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Run this command:

  ```bash
  yc iam access-policy-template list
  ```

  Result:

  ```text
  +----------------------------------------------------+---------------------------------------------------------+--------------------------------+
  |                         ID                         |                          NAME                           |          DESCRIPTION           |
  +----------------------------------------------------+---------------------------------------------------------+--------------------------------+
  | iam.denyServiceAccountAccessKeysCreation           | iam-deny-service-account-access-keys-creation           | Deny creation of service       |
  |                                                    |                                                         | account access keys            |
  | iam.denyServiceAccountApiKeysCreation              | iam-deny-service-account-api-keys-creation              | Deny creation of service       |
  |                                                    |                                                         | account api keys               |
  | iam.denyServiceAccountAuthorizedKeysCreation       | iam-deny-service-account-authorized-keys-creation       | Deny creation of service       |
  |                                                    |                                                         | account authorized keys        |
  | iam.denyServiceAccountCreation                     | iam-deny-service-account-creation                       | Deny creation of service       |
  |                                                    |                                                         | accounts                       |
  | iam.denyServiceAccountCredentialsCreation          | iam-deny-service-account-credentials-creation           | Deny creation of service       |
  |                                                    |                                                         | account credentials            |
  | iam.denyServiceAccountFederatedCredentialsCreation | iam-deny-service-account-federated-credentials-creation | Deny creation of service       |
  |                                                    |                                                         | account federated credentials  |
  | iam.denyServiceAccountImpersonation                | iam-deny-service-account-impersonation                  | Deny impersonation into the    |
  |                                                    |                                                         | service account                |
  | organization.denyMemberInvitation                  | organization-deny-member-invitation                     | Deny invitation of new members |
  |                                                    |                                                         | to the organization            |
  | organization.denyUserListing                       | organization-deny-user-listing                          | Deny listing of users in the   |
  |                                                    |                                                         | organization                   |
  | serverless.restrictPrivateNetworkInvocation        | serverless-restrict-private-network-invocation          | Restrict serverless functions  |
  |                                                    |                                                         | and containers invocation from |
  |                                                    |                                                         | private vpc networks (by vpc   |
  |                                                    |                                                         | network ids and/or by private  |
  |                                                    |                                                         | vpc addresses)                 |
  | serverless.restrictPublicInvocation                | serverless-restrict-public-invocation                   | Restrict serverless functions  |
  |                                                    |                                                         | and containers invocation      |
  |                                                    |                                                         | from public ip addresses by    |
  |                                                    |                                                         | whitelist                      |
  +----------------------------------------------------+---------------------------------------------------------+--------------------------------+
  ```

- API {#api}

  Use the [list](../../../iam/api-ref/AccessPolicyTemplate/list.md) REST API method for the [AccessPolicyTemplate](../../../iam/api-ref/AccessPolicyTemplate/index.md) resource or the [AccessPolicyTemplateService/List](../../../iam/api-ref/grpc/AccessPolicyTemplate/list.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/access-control/access-policies.md)
* [{#T}](./assign.md)
* [{#T}](./view-assigned.md)
* [{#T}](./revoke.md)