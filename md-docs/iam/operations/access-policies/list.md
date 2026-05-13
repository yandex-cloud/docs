# Получение списка поддерживаемых шаблонов политик авторизации

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}

[Политики авторизации](../../concepts/access-control/access-policies.md) — это механизм контроля доступа Yandex Identity and Access Management, который позволяет управлять разрешениями на выполнение определенных операций с [ресурсами Yandex Cloud](../../../overview/roles-and-resources.md). Политики авторизации создаются на основе [шаблонов](../../concepts/access-control/access-policies.md#supported-policies) и дополняют систему [ролей](../../concepts/access-control/roles.md), делая [управление доступом](../../concepts/access-control/index.md) более гибким.

Чтобы получить список [поддерживаемых шаблонов](../../concepts/access-control/access-policies.md#supported-policies) политик авторизации:

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

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

  Воспользуйтесь методом REST API [list](../../api-ref/AccessPolicyTemplate/list.md) для ресурса [AccessPolicyTemplate](../../api-ref/AccessPolicyTemplate/index.md) или вызовом gRPC API [AccessPolicyTemplateService/List](../../api-ref/grpc/AccessPolicyTemplate/list.md).

{% endlist %}

#### См. также {#see-also}

* [Политики авторизации](../../concepts/access-control/access-policies.md)
* [Создание политики авторизации для ресурса](assign.md)
* [Просмотр политик авторизации, созданных для ресурса](view-assigned.md)
* [Удаление политики авторизации](revoke.md)