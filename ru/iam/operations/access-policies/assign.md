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

Все шаблоны политик авторизации [без параметров](../../concepts/access-control/access-policies.md#fixed) назначаются на ресурсы одинаково. О том, как назначить на ресурс шаблон политики [с параметрами](../../concepts/access-control/access-policies.md#customizable), читайте в разделе [{#T}](#examples).

## Примеры {#examples}

### Создать политику авторизации для каталога на основе шаблона serverless.containers.restrictNetworkAccess {#serverless-containers-restrictNetworkAccess}

[Политика](../../concepts/access-control/access-policies.md#serverless-containers-restrictNetworkAccess) `serverless.containers.restrictNetworkAccess` запрещает вызов [контейнеров](../../../serverless-containers/concepts/container.md) {{ serverless-containers-full-name }} и управление ими с любых адресов, за исключением заданных явно IP-адресов или [облачных сетей](../../../vpc/concepts/network.md#network) {{ vpc-full-name }}.

Чтобы назначить шаблон политики `serverless.containers.restrictNetworkAccess` на каталог:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc resource-manager folder bind-access-policy \
    --name my-folder \
    --access-policy-template-id=serverless.containers.restrictNetworkAccess \
    --parameters '"allowed_src_ips=[<диапазон_адресов_1>,<диапазон_адресов_2>,<диапазон_адресов_3>]","allowed_vpc_network_ids=[<идентификатор_сети_1>,<идентификатор_сети_2>,<идентификатор_сети_3>]"'
  ```

  Где:
  
  * `--parameters` — параметры политики авторизации:

      {% note alert %}

      Ограничения, задаваемые в параметрах, применяются с логикой `ИЛИ`. 

      {% endnote %}

      * `allowed_src_ips` — список IP-адресов или диапазонов IP-адресов в нотации [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация), с которых будет разрешен вызов контейнеров и управление ими.

          Если вы не хотите задавать список IP-адресов или диапазонов IP-адресов, передайте в параметре пустой список: `"allowed_src_ips=[]"`.
      * `allowed_vpc_network_ids` — список идентификаторов [облачных сетей](../../../vpc/concepts/network.md#network), в которых разрешен вызов контейнеров и управление ими через настроенное [сервисное подключение](../../../vpc/concepts/private-endpoint.md).

          Если вы не хотите задавать список идентификаторов облачных сетей, передайте в параметре пустой список: `"allowed_vpc_network_ids=[]"`.

{% endlist %}


#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/access-control/access-policies.md)
* [{#T}](./list.md)
* [{#T}](./view-assigned.md)
* [{#T}](./revoke.md)