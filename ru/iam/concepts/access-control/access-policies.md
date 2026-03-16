---
title: Политики авторизации в {{ iam-full-name }}
description: Из статьи вы узнаете, что такое политики авторизации в {{ iam-full-name }} и как их использовать при управлении ресурсами {{ yandex-cloud }}.
---

# Политики авторизации

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

_Политики авторизации_ (политики) — это механизм контроля доступа {{ iam-full-name }}, который позволяет управлять разрешениями на выполнение определенных операций с [ресурсами {{ yandex-cloud }}](../../../overview/roles-and-resources.md). Политики дополняют систему [ролей](./roles.md) и позволяют сделать [управление доступом](./index.md) более гибким.

Политики авторизации создаются для [ресурсов](#resources) на основе [шаблонов](#supported-policies) политик авторизации.

## Взаимосвязь политик авторизации и ролей {#policy-role-interrelation}

Политики авторизации работают по принципу явного запрета (в отличие от [ролей](./roles.md), которые работают по принципу явных разрешений). При этом политики и роли взаимосвязаны следующим образом:

* Чтобы операция могла быть выполнена, она должна быть одновременно разрешена ролью и не запрещена политикой авторизации. При этом проверка прав доступа выполняется в следующей последовательности:

    1. Система проверяет наличие роли, необходимой для выполнения операции. Если такая роль отсутствует, то операция блокируется, а дальнейшие проверки не выполняются.
    1. Если необходимая роль найдена, то проверяется наличие явного запрета на выполнение операции в политиках авторизации. Если запрет найден, то операция блокируется, в противном случае — выполняется.
* Политики авторизации не заменяют роли, а дополняют их. Независимо от заданных политик авторизации, для выполнения операций требуются соответствующие роли.
* {% include [access-policies-roles](../../../_includes/iam/access-policies-roles.md) %}

## Ресурсы, для которых создаются политики авторизации {#resources}

Политики авторизации можно [создать](../../operations/access-policies/assign.md) для следующих ресурсов:

* [организация](../../../organization/concepts/organization.md) — политика применяется к ресурсам во всех облаках и каталогах в пределах организации;
* [облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud) — политика применяется к ресурсам во всех каталогах в пределах облака;
* [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) — политика применяется только к ресурсам в определенном каталоге.

Политики авторизации, созданные на верхних уровнях [иерархии ресурсов {{ yandex-cloud }}](../../../resource-manager/concepts/resources-hierarchy.md), [наследуются](../../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) нижестоящими уровнями.

Для одного ресурса можно создать одновременно несколько политик.

## Шаблоны политик авторизации {#supported-policies}

Одни шаблоны политик авторизации при их назначении на ресурс требуют указания дополнительных параметров, другие — не требуют.

### Шаблоны без дополнительных параметров {#fixed}

Следующие шаблоны политик авторизации не содержат дополнительных параметров и вводят безусловные ограничения на соответствующие действия:

* [iam.denyServiceAccountCreation](#iam-denyServiceAccountCreation)
* [iam.denyServiceAccountAccessKeysCreation](#iam-denyServiceAccountAccessKeysCreation)
* [iam.denyServiceAccountApiKeysCreation](#iam-denyServiceAccountApiKeysCreation)
* [iam.denyServiceAccountAuthorizedKeysCreation](#iam-denyServiceAccountAuthorizedKeysCreation)
* [iam.denyServiceAccountFederatedCredentialsCreation](#iam-denyServiceAccountFederatedCredentialsCreation)
* [iam.denyServiceAccountCredentialsCreation](#iam-denyServiceAccountCredentialsCreation)
* [iam.denyServiceAccountImpersonation](#iam-denyServiceAccountImpersonation)
* [organization.denyMemberInvitation](#organization-denyMemberInvitation)
* [organization.denyUserListing](#organization-denyUserListing)

#### iam.denyServiceAccountCreation {#iam-denyServiceAccountCreation}

Политика запрещает создавать [сервисные аккаунты](../users/service-accounts.md). 

#### iam.denyServiceAccountAccessKeysCreation {#iam-denyServiceAccountAccessKeysCreation}

Политика запрещает создавать [статические ключи доступа](../authorization/access-key.md) сервисных аккаунтов.

#### iam.denyServiceAccountApiKeysCreation {#iam-denyServiceAccountApiKeysCreation}

Политика запрещает создавать [API-ключи](../authorization/api-key.md) сервисных аккаунтов.

#### iam.denyServiceAccountAuthorizedKeysCreation {#iam-denyServiceAccountAuthorizedKeysCreation}

Политика запрещает создавать [авторизованные ключи](../authorization/key.md) сервисных аккаунтов.

#### iam.denyServiceAccountFederatedCredentialsCreation {#iam-denyServiceAccountFederatedCredentialsCreation}

Политика запрещает привязывать сервисные аккаунты к [федерациям сервисных аккаунтов](../workload-identity.md).

#### iam.denyServiceAccountCredentialsCreation {#iam-denyServiceAccountCredentialsCreation}

Политика запрещает:

* создавать любые [аутентификационные данные](../authorization/index.md) для сервисных аккаунтов (кроме [IAM-токена](../authorization/iam-token.md));
* привязывать сервисные аккаунты к [федерациям сервисных аккаунтов](../workload-identity.md).

#### iam.denyServiceAccountImpersonation {#iam-denyServiceAccountImpersonation}

Политика запрещает использовать [имперсонацию](../access-control/impersonation.md).

#### organization.denyMemberInvitation {#organization-denyMemberInvitation}

Политика запрещает отправлять новым пользователям с [аккаунтом](../users/accounts.md#passport) на Яндексе [приглашения в организацию](../../../organization/operations/add-account.md#useraccount). Политика может быть создана только для [организации](../../../organization/concepts/organization.md).

#### organization.denyUserListing {#organization-denyUserListing}

Политика запрещает просматривать список пользователей [организации](../../../organization/concepts/organization.md). Политика может быть создана только для [организации](../../../organization/concepts/organization.md).

### Шаблоны с дополнительными параметрами {#customizable}

Следующие шаблоны политик авторизации позволяют изменять вводимые ограничения с помощью дополнительных параметров:

* [serverless.restrictPrivateNetworkInvocation](#serverless-restrictPrivateNetworkInvocation)
* [serverless.restrictPublicInvocation](#serverless-restrictPublicInvocation)

#### serverless.restrictPrivateNetworkInvocation {#serverless-restrictPrivateNetworkInvocation}

{% include [access-policies-private-endpoint-notice](../../../_includes/iam/access-policies-private-endpoint-notice.md) %}

Политика ограничивает возможность вызова [функций](../../../functions/concepts/function.md) и [контейнеров](../../../serverless-containers/concepts/container.md) с [внутренних IP-адресов](../../../vpc/concepts/address.md#internal-addresses) {{ vpc-full-name }} заданными явно [облачными сетями](../../../vpc/concepts/network.md#network) или определенными IP-адресами в них.

К функции/контейнеру должна быть привязана облачная сеть из списка, заданного в параметрах политики.

Дополнительные параметры:

* `allowed_vpc_network_ids` — список облачных сетей, в которых с любых внутренних IP-адресов разрешен вызов функций/контейнеров.

    Параметр `allowed_vpc_network_ids` имеет приоритет над другими параметрами: если для него задано ненулевое значение, то значения параметров `src_ip_restricted_network_ids` и `allowed_src_ips` будут игнорироваться политикой.
* `src_ip_restricted_network_ids` — список облачных сетей, в которых вызов функций/контейнеров разрешен только с внутренних IP-адресов, заданных в параметре `allowed_src_ips`.
* `allowed_src_ips` — список внутренних IP-адресов или диапазонов IP-адресов в нотации [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация), которые относятся к сетям, заданным в параметре `src_ip_restricted_network_ids`, и с которых разрешен вызов функций и контейнеров.

См. также [примеры назначения шаблона политики](../../operations/access-policies/assign.md#serverless-restrictPrivateNetworkInvocation).

#### serverless.restrictPublicInvocation {#serverless-restrictPublicInvocation}

Политика `serverless.restrictPublicInvocation` ограничивает возможность вызова [функций](../../../functions/concepts/function.md) и [контейнеров](../../../serverless-containers/concepts/container.md) с [публичных IP-адресов](../../../vpc/concepts/address.md#internal-addresses).

Дополнительные параметры:

* `allowed_src_ip` — список публичных IP-адресов или диапазонов IP-адресов в нотации [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация), с которых разрешен вызов функций и контейнеров.

См. также [пример назначения шаблона политики](../../operations/access-policies/assign.md#serverless-restrictPublicInvocation).

#### См. также {#see-also}

* [{#T}](./roles.md)
* [{#T}](../../operations/access-policies/list.md)
* [{#T}](../../operations/access-policies/assign.md)
* [{#T}](../../operations/access-policies/view-assigned.md)
* [{#T}](../../operations/access-policies/revoke.md)