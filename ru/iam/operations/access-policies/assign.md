---
title: Создать политику авторизации для ресурса
description: Из статьи вы узнаете, как создать политику авторизации {{ iam-full-name }} для каталога, облака или организации на основе шаблона политики.
---

# Создание политики авторизации для ресурса

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{% include [access-policies-instruction-intro](../../../_includes/iam/access-policies-instruction-intro.md) %}

Вы можете создать политику авторизации для [каталога](#folder), [облака](#cloud) или [организации](#organization).

{% note info %}

{% include [access-policies-roles](../../../_includes/iam/access-policies-roles.md) %}

{% endnote %}

## Создать политику авторизации для каталога {#folder}

{% include [access-policies-assign-folder](../../../_includes/iam/access-policies-assign-folder.md) %}

## Создать политику авторизации для облака {#cloud}

{% include [access-policies-assign-cloud](../../../_includes/iam/access-policies-assign-cloud.md) %}

## Создать политику авторизации для организации {#organization}

{% include [access-policies-assign-org](../../../_includes/iam/access-policies-assign-org.md) %}

Все шаблоны политик авторизации [без дополнительных параметров](../../concepts/access-control/access-policies.md#fixed) назначаются на ресурсы одинаково. О том, как назначить на ресурс шаблон политики [с дополнительными параметрами](../../concepts/access-control/access-policies.md#customizable), читайте в разделе [{#T}](#examples).

## Примеры {#examples}

### Создать политику serverless.restrictPrivateNetworkInvocation для каталога {#serverless-restrictPrivateNetworkInvocation}

[Политика](../../concepts/access-control/access-policies.md#serverless-restrictPrivateNetworkInvocation) `serverless.restrictPrivateNetworkInvocation` ограничивает возможность вызова [функций](../../../functions/concepts/function.md) и [контейнеров](../../../serverless-containers/concepts/container.md) с [внутренних IP-адресов](../../../vpc/concepts/address.md#internal-addresses) {{ vpc-full-name }} заданными явно [облачными сетями](../../../vpc/concepts/network.md#network) или определенными IP-адресами в них.

{% include [access-policies-private-endpoint-notice](../../../_includes/iam/access-policies-private-endpoint-notice.md) %}

Чтобы назначить шаблон политики `serverless.restrictPrivateNetworkInvocation` на каталог:

{% list tabs group=instructions %}

- CLI {#cli}

  **Без ограничения по IP-адресам**

  ```bash
  yc resource-manager folder bind-access-policy \
    --name "my-folder" \
    --access-policy-template-id=serverless.restrictPrivateNetworkInvocation \
    --parameters '"allowed_vpc_network_ids=[<идентификатор_сети_1>,<идентификатор_сети_2>,<идентификатор_сети_3>]","src_ip_restricted_network_ids=[]","allowed_src_ips=[]"'
  ```

  Где `allowed_vpc_network_ids` — список идентификаторов облачных сетей, из которых разрешен вызов функций и контейнеров. Вызов функций и контейнеров будет разрешен с любых IP-адресов в [подсетях](../../../vpc/concepts/network.md#subnet), входящих в указанные облачные сети. При этом к функции/контейнеру должна быть привязана облачная сеть, входящая в указанный список.

  Для параметра можно передать нулевое значение — в этом случае необходимо задать ограничение по IP-адресам в параметрах `src_ip_restricted_network_ids` и `allowed_src_ips`.

  В результате применения политики в каталоге `my-folder` с внутренних IP-адресов можно будет вызывать только те функции/контейнеры, к которым привязаны облачные сети с идентификаторами `<идентификатор_сети_1>`, `<идентификатор_сети_2>` и `<идентификатор_сети_3>`, и только с IP-адресов подсетей, относящихся к этим облачным сетям.

  **С ограничением по IP-адресам**

  ```bash
  yc resource-manager folder bind-access-policy \
    --name "my-folder" \
    --access-policy-template-id=serverless.restrictPrivateNetworkInvocation \
    --parameters '"allowed_vpc_network_ids=[]","src_ip_restricted_network_ids=[<идентификатор_сети_1>,<идентификатор_сети_2>,<идентификатор_сети_3>]","allowed_src_ips=[10.1.2.0/24,172.16.17.0/28,192.168.1.2/32]"'
  ```

  Где:

  * `src_ip_restricted_network_ids` — список идентификаторов облачных сетей, из которых возможен вызов функций и контейнеров, с дополнительным ограничением разрешенных IP-адресов. Вызов функций и контейнеров будет разрешен с конкретных IP-адресов, входящих в указанные облачные сети и явно заданных в параметре `allowed_src_ips`. При этом к функции/контейнеру должна быть привязана облачная сеть, входящая в указанный список.
  * `allowed_src_ips` — список внутренних IP-адресов или диапазонов IP-адресов в нотации [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация), с которых разрешен вызов функций и контейнеров.

      Указанные IP-адреса должны принадлежать облачным сетям, заданным в параметре `src_ip_restricted_network_ids`.

  В результате применения политики в каталоге `my-folder` с внутренних IP-адресов можно будет вызывать только те функции/контейнеры, к которым привязаны облачные сети с идентификаторами `<идентификатор_сети_1>`, `<идентификатор_сети_2>` и `<идентификатор_сети_3>`, и только с IP-адресов, относящихся одновременно к этим облачным сетям и к диапазонам `10.1.2.0/24`, `172.16.17.0/28` и `192.168.1.2/32`.

{% endlist %}

{% note info %}

Если параметр `allowed_vpc_network_ids` имеет ненулевое значение, то список IP-адресов, заданный параметрами `src_ip_restricted_network_ids` и `allowed_src_ips`, будет проигнорирован.

{% endnote %}

### Создать политику serverless.restrictPublicInvocation для каталога {#serverless-restrictPublicInvocation}

[Политика](../../concepts/access-control/access-policies.md#serverless-restrictPublicInvocation) `serverless.restrictPublicInvocation` ограничивает возможность вызова [функций](../../../functions/concepts/function.md) и [контейнеров](../../../serverless-containers/concepts/container.md) с [публичных IP-адресов](../../../vpc/concepts/address.md#internal-addresses).

Чтобы назначить шаблон политики `serverless.restrictPublicInvocation` на каталог:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc resource-manager folder bind-access-policy \
    --name "my-folder" \
    --access-policy-template-id=serverless.restrictPublicInvocation \
    --parameters '"allowed_src_ips=[198.51.100.104/29,192.0.2.4/30]"'
  ```

  Где `allowed_src_ip` — список публичных IP-адресов или диапазонов IP-адресов в нотации [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация), с которых разрешен вызов функций и контейнеров.

  В результате применения политики в каталоге `my-folder` с использованием публичных IP-адресов функции/контейнеры можно будет вызывать только с IP-адресов, относящихся к диапазонам `198.51.100.104/29` и `192.0.2.4/30`.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/access-control/access-policies.md)
* [{#T}](./list.md)
* [{#T}](./view-assigned.md)
* [{#T}](./revoke.md)