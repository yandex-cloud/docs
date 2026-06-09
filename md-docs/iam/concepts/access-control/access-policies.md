# Политики авторизации

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}

_Политики авторизации_ (политики) — это механизм контроля доступа Yandex Identity and Access Management, который позволяет управлять разрешениями на выполнение определенных операций с [ресурсами Yandex Cloud](../../../overview/roles-and-resources.md). Политики дополняют систему [ролей](roles.md) и позволяют сделать [управление доступом](index.md) более гибким.

Политики авторизации создаются для [ресурсов](#resources) на основе [шаблонов](#supported-policies) политик авторизации.

## Взаимосвязь политик авторизации и ролей {#policy-role-interrelation}

Политики авторизации работают по принципу явного запрета (в отличие от [ролей](roles.md), которые работают по принципу явных разрешений). При этом политики и роли взаимосвязаны следующим образом:

* Чтобы операция могла быть выполнена, она должна быть одновременно разрешена ролью и не запрещена политикой авторизации. При этом проверка прав доступа выполняется в следующей последовательности:

    1. Система проверяет наличие роли, необходимой для выполнения операции. Если такая роль отсутствует, то операция блокируется, а дальнейшие проверки не выполняются.
    1. Если необходимая роль найдена, то проверяется наличие явного запрета на выполнение операции в политиках авторизации. Если запрет найден, то операция блокируется, в противном случае — выполняется.
* Политики авторизации не заменяют роли, а дополняют их. Независимо от заданных политик авторизации, для выполнения операций требуются соответствующие роли.
* Управлять политиками авторизации может пользователь, которому назначена одна из следующих ролей:
  
  * [`resource-manager.admin`](../../../resource-manager/security/index.md#resource-manager-admin) или [`admin`](../../roles-reference.md#admin) на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) или [облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud), чтобы управлять политиками авторизации соответственно на уровне каталога или облака;
  * [`organization-manager.admin`](../../../organization/security/index.md#organization-manager-admin) или [`admin`](../../roles-reference.md#admin) на [организацию](../../../organization/concepts/organization.md), чтобы управлять политиками авторизации на уровне организации.

## Ресурсы, для которых создаются политики авторизации {#resources}

Политики авторизации можно [создать](../../operations/access-policies/assign.md) для следующих ресурсов:

* [организация](../../../organization/concepts/organization.md) — политика применяется к ресурсам во всех облаках и каталогах в пределах организации;
* [облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud) — политика применяется к ресурсам во всех каталогах в пределах облака;
* [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) — политика применяется только к ресурсам в определенном каталоге.

Политики авторизации, созданные на верхних уровнях [иерархии ресурсов Yandex Cloud](../../../resource-manager/concepts/resources-hierarchy.md), [наследуются](../../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) нижестоящими уровнями.

Для одного ресурса можно создать одновременно несколько политик.

## Шаблоны политик авторизации {#supported-policies}

Одни шаблоны политик авторизации при их назначении на ресурс требуют указания параметров, другие — не требуют.

### Шаблоны без параметров {#fixed}

Следующие шаблоны политик авторизации не содержат параметров и вводят безусловные ограничения на соответствующие действия:

* [backup.denyActivation](#backup-denyActivation)
* [backup.denyRemoveProtection](#backup-denyRemoveProtection)
* [iam.denyServiceAccountAccessKeysCreation](#iam-denyServiceAccountAccessKeysCreation)
* [iam.denyServiceAccountApiKeysCreation](#iam-denyServiceAccountApiKeysCreation)
* [iam.denyServiceAccountAuthorizedKeysCreation](#iam-denyServiceAccountAuthorizedKeysCreation)
* [iam.denyServiceAccountCreation](#iam-denyServiceAccountCreation)
* [iam.denyServiceAccountCredentialsCreation](#iam-denyServiceAccountCredentialsCreation)
* [iam.denyServiceAccountFederatedCredentialsCreation](#iam-denyServiceAccountFederatedCredentialsCreation)
* [iam.denyServiceAccountImpersonation](#iam-denyServiceAccountImpersonation)
* [organization.denyMemberInvitation](#organization-denyMemberInvitation)
* [organization.denyUserListing](#organization-denyUserListing)

#### backup.denyActivation {#backup-denyActivation}

Политика запрещает подключать [защищаемые ресурсы](../../../backup/concepts/index.md) к сервису Yandex Cloud Backup, а также привязывать и отвязывать их от [политик резервного копирования](../../../backup/concepts/policy.md).

#### backup.denyRemoveProtection {#backup-denyRemoveProtection}

Политика запрещает изменять и удалять [политики резервного копирования](../../../backup/concepts/policy.md) Yandex Cloud Backup, отвязывать [защищаемые ресурсы](../../../backup/concepts/index.md) от таких политик, а также удалять [резервные копии](../../../backup/concepts/backup.md) защищаемых ресурсов.

#### iam.denyServiceAccountAccessKeysCreation {#iam-denyServiceAccountAccessKeysCreation}

Политика запрещает создавать [статические ключи доступа](../authorization/access-key.md) сервисных аккаунтов.

#### iam.denyServiceAccountApiKeysCreation {#iam-denyServiceAccountApiKeysCreation}

Политика запрещает создавать [API-ключи](../authorization/api-key.md) сервисных аккаунтов.

#### iam.denyServiceAccountAuthorizedKeysCreation {#iam-denyServiceAccountAuthorizedKeysCreation}

Политика запрещает создавать [авторизованные ключи](../authorization/key.md) сервисных аккаунтов.

#### iam.denyServiceAccountCreation {#iam-denyServiceAccountCreation}

Политика запрещает создавать [сервисные аккаунты](../users/service-accounts.md).

#### iam.denyServiceAccountCredentialsCreation {#iam-denyServiceAccountCredentialsCreation}

Политика запрещает:

* создавать любые [аутентификационные данные](../authorization/index.md) для сервисных аккаунтов (кроме [IAM-токена](../authorization/iam-token.md));
* привязывать сервисные аккаунты к [федерациям сервисных аккаунтов](../workload-identity.md).

#### iam.denyServiceAccountFederatedCredentialsCreation {#iam-denyServiceAccountFederatedCredentialsCreation}

Политика запрещает привязывать сервисные аккаунты к [федерациям сервисных аккаунтов](../workload-identity.md).

#### iam.denyServiceAccountImpersonation {#iam-denyServiceAccountImpersonation}

Политика запрещает использовать [имперсонацию](impersonation.md).

#### organization.denyMemberInvitation {#organization-denyMemberInvitation}

Политика запрещает отправлять новым пользователям с [аккаунтом](../users/accounts.md#passport) на Яндексе [приглашения в организацию](../../../organization/operations/add-account.md#useraccount). Политика может быть создана только для [организации](../../../organization/concepts/organization.md).

#### organization.denyUserListing {#organization-denyUserListing}

Политика запрещает просматривать список пользователей [организации](../../../organization/concepts/organization.md). Политика может быть создана только для [организации](../../../organization/concepts/organization.md).

### Шаблоны с параметрами {#customizable}

Следующие шаблоны политик авторизации позволяют настраивать вводимые ограничения с помощью параметров:

{% note tip %}

Подробнее о том, как создавать политики авторизации на основе шаблонов с параметрами, читайте в разделе [Создание политики авторизации для ресурса](../../operations/access-policies/assign.md#examples).

{% endnote %}

* [serverless.containers.restrictNetworkAccess](#serverless-containers-restrictNetworkAccess)
* [serverless.containers.restrictResourceVPCNetwork](#serverless-containers-restrictResourceVPCNetwork)
* [serverless.functions.restrictNetworkAccess](#serverless-functions-restrictNetworkAccess)
* [serverless.functions.restrictResourceVPCNetwork](#serverless-functions-restrictResourceVPCNetwork)
* [serverless.mcpGateways.restrictNetworkAccess](#serverless-mcpGateways-restrictNetworkAccess)
* [serverless.mcpGateways.restrictResourceVPCNetwork](#serverless-mcpGateways-restrictResourceVPCNetwork)
* [serverless.responses.restrictNetworkAccess](#serverless-responses-restrictNetworkAccess)
* [serverless.workflows.restrictNetworkAccess](#serverless-workflows-restrictNetworkAccess)
* [serverless.workflows.restrictResourceVPCNetwork](#serverless-workflows-restrictResourceVPCNetwork)

#### serverless.containers.restrictNetworkAccess {#serverless-containers-restrictNetworkAccess}

Политика запрещает вызов [контейнеров](../../../serverless-containers/concepts/container.md) Yandex Serverless Containers и управление ими с любых адресов, за исключением заданных явно IP-адресов или [облачных сетей](../../../vpc/concepts/network.md#network) Yandex Virtual Private Cloud.

Настраиваемые параметры (применяются с логикой `ИЛИ`):

* `allowed_src_ips` — список IP-адресов или диапазонов IP-адресов в нотации [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация), с которых разрешен вызов контейнеров и управление ими.
* `allowed_vpc_network_ids` — список идентификаторов облачных сетей, в которых разрешен вызов контейнеров и управление ими через настроенное [сервисное подключение](../../../vpc/concepts/private-endpoint.md).

#### serverless.containers.restrictResourceVPCNetwork {#serverless-containers-restrictResourceVPCNetwork}

Политика запрещает привязку к [контейнерам](../../../serverless-containers/concepts/container.md) Yandex Serverless Containers любых [облачных сетей](../../../vpc/concepts/network.md#network) за исключением заданных явно.

Настраиваемый параметр:

* `allowed_vpc_network_ids` — список идентификаторов облачных сетей, которые можно привязывать к контейнерам.

#### serverless.functions.restrictNetworkAccess {#serverless-functions-restrictNetworkAccess}

Политика запрещает вызов [функций](../../../functions/concepts/function.md) Yandex Cloud Functions и управление ими с любых адресов, за исключением заданных явно IP-адресов или [облачных сетей](../../../vpc/concepts/network.md#network) Yandex Virtual Private Cloud.

Настраиваемые параметры (применяются с логикой `ИЛИ`):

* `allowed_src_ips` — список IP-адресов или диапазонов IP-адресов в нотации [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация), с которых разрешен вызов функций и управление ими.
* `allowed_vpc_network_ids` — список идентификаторов облачных сетей, в которых разрешен вызов функций и управление ими через настроенное [сервисное подключение](../../../vpc/concepts/private-endpoint.md).

#### serverless.functions.restrictResourceVPCNetwork {#serverless-functions-restrictResourceVPCNetwork}

Политика запрещает привязку к [функциям](../../../functions/concepts/function.md) Yandex Cloud Functions любых [облачных сетей](../../../vpc/concepts/network.md#network) за исключением заданных явно.

Настраиваемый параметр:

* `allowed_vpc_network_ids` — список идентификаторов облачных сетей, которые можно привязывать к функциям.

#### serverless.mcpGateways.restrictNetworkAccess {#serverless-mcpGateways-restrictNetworkAccess}

Политика запрещает вызов [MCP-серверов](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/mcp-hub/#servers) MCP Hub и управление ими с любых адресов, за исключением заданных явно IP-адресов или [облачных сетей](../../../vpc/concepts/network.md#network) Yandex Virtual Private Cloud.

Настраиваемые параметры (применяются с логикой `ИЛИ`):

* `allowed_src_ips` — список IP-адресов или диапазонов IP-адресов в нотации [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация), с которых разрешен вызов MCP-серверов и управление ими.
* `allowed_vpc_network_ids` — список идентификаторов облачных сетей, в которых разрешен вызов MCP-серверов и управление ими через настроенное [сервисное подключение](../../../vpc/concepts/private-endpoint.md).

#### serverless.mcpGateways.restrictResourceVPCNetwork {#serverless-mcpGateways-restrictResourceVPCNetwork}

Политика запрещает привязку к [MCP-серверам](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/mcp-hub/#servers) MCP Hub любых [облачных сетей](../../../vpc/concepts/network.md#network) за исключением заданных явно.

Настраиваемый параметр:

* `allowed_vpc_network_ids` — список идентификаторов облачных сетей, которые можно привязывать к MCP-серверам.

#### serverless.responses.restrictNetworkAccess {#serverless-responses-restrictNetworkAccess}

Политика запрещает вызов методов [Responses API](https://aistudio.yandex.ru/docs/ru/ai-studio/responses/) Yandex AI Studio с любых адресов, за исключением заданных явно IP-адресов или [облачных сетей](../../../vpc/concepts/network.md#network) Yandex Virtual Private Cloud.

Настраиваемые параметры (применяются с логикой `ИЛИ`):

* `allowed_src_ips` — список IP-адресов или диапазонов IP-адресов в нотации [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация), с которых разрешен вызов методов Responses API.
* `allowed_vpc_network_ids` — список идентификаторов облачных сетей, в которых разрешен вызов методов Responses API через настроенное [сервисное подключение](../../../vpc/concepts/private-endpoint.md).

#### serverless.workflows.restrictNetworkAccess {#serverless-workflows-restrictNetworkAccess}

Политика запрещает запуск [рабочих процессов](../../../serverless-integrations/concepts/workflows/workflow.md) Yandex Serverless Integrations и управление ими с любых адресов, за исключением заданных явно IP-адресов или [облачных сетей](../../../vpc/concepts/network.md#network) Yandex Virtual Private Cloud.

Настраиваемые параметры (применяются с логикой `ИЛИ`):

* `allowed_src_ips` — список IP-адресов или диапазонов IP-адресов в нотации [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация), с которых разрешен запуск рабочих процессов и управление ими.
* `allowed_vpc_network_ids` — список идентификаторов облачных сетей, в которых разрешен запуск рабочих процессов и управление ими через настроенное [сервисное подключение](../../../vpc/concepts/private-endpoint.md).

#### serverless.workflows.restrictResourceVPCNetwork {#serverless-workflows-restrictResourceVPCNetwork}

Политика запрещает привязку к [рабочим процессам](../../../serverless-integrations/concepts/workflows/workflow.md) Yandex Serverless Integrations любых [облачных сетей](../../../vpc/concepts/network.md#network) за исключением заданных явно.

Настраиваемый параметр:

* `allowed_vpc_network_ids` — список идентификаторов облачных сетей, которые можно привязывать к рабочим процессам.

#### См. также {#see-also}

* [Роли](roles.md)
* [Получение списка поддерживаемых шаблонов политик авторизации](../../operations/access-policies/list.md)
* [Создание политики авторизации для ресурса](../../operations/access-policies/assign.md)
* [Просмотр политик авторизации, созданных для ресурса](../../operations/access-policies/view-assigned.md)
* [Удаление политики авторизации](../../operations/access-policies/revoke.md)