---
title: Получить список доступных шаблонов политик авторизации
description: Из статьи вы узнаете, как получить список шаблонов политик авторизации {{ iam-full-name }}, которые доступны вам для назначения на ресурсы {{ yandex-cloud }}.
---

# Получение списка поддерживаемых шаблонов политик авторизации

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{% include [access-policies-instruction-intro](../../../_includes/iam/access-policies-instruction-intro.md) %}

Чтобы получить список [поддерживаемых шаблонов](../../concepts/access-control/access-policies.md#supported-policies) политик авторизации:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Выполните команду:

  ```bash
  yc iam access-policy-template list
  ```

  Результат:

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

  Воспользуйтесь методом REST API [list](../../../iam/api-ref/AccessPolicyTemplate/list.md) для ресурса [AccessPolicyTemplate](../../../iam/api-ref/AccessPolicyTemplate/index.md) или вызовом gRPC API [AccessPolicyTemplateService/List](../../../iam/api-ref/grpc/AccessPolicyTemplate/list.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/access-control/access-policies.md)
* [{#T}](./assign.md)
* [{#T}](./view-assigned.md)
* [{#T}](./revoke.md)