---
title: Как удалить выделенную публичную подсеть в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете удалить выделенную публичную подсеть в {{ baremetal-full-name }}.
---

# Удалить выделенную публичную подсеть

[Выделенная публичная подсеть](../concepts/public-network.md#public-subnet) тарифицируется с момента создания. Минимальный срок аренды составляет один месяц, поэтому удалить подсеть в течение первого месяца после ее заказа нельзя.

{% note warning %}

Удаление выделенной публичной подсети необратимо. После удаления IP-адреса подсети вернутся в общий пул адресов сервиса {{ baremetal-full-name }} и могут быть переназначены другим пользователям.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит публичная подсеть.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.baremetal.label_public-subnets_v16CV }}**.
  1. В строке с нужной подсетью нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды для удаления [выделенной публичной подсети](../concepts/public-network.md#public-subnet):

     ```bash
     yc baremetal public-subnet delete --help
     ```

  1. Получите список выделенных публичных подсетей в каталоге по умолчанию:

     ```bash
     yc baremetal public-subnet list
     ```

  1. Удалите подсеть:

     ```bash
     yc baremetal public-subnet delete <идентификатор_или_имя_подсети>
     ```

     Где `<идентификатор_или_имя_подсети>` — идентификатор или имя удаляемой выделенной публичной подсети.

- API {#api}

  Чтобы удалить выделенную публичную подсеть, воспользуйтесь методом REST API [delete](../api-ref/PublicSubnet/delete.md) для ресурса [PublicSubnet](../api-ref/PublicSubnet/index.md) или вызовом gRPC API [PublicSubnetService/Delete](../api-ref/grpc/PublicSubnet/delete.md).

  Выполните команду:

  ```bash
  curl -X DELETE \
    -H "Authorization: Bearer <IAM-токен>" \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/publicSubnets/<идентификатор_подсети>"
  ```

  Где:

  * `<IAM-токен>` — IAM-токен для аутентификации.
  * `<идентификатор_подсети>` — идентификатор удаляемой выделенной публичной подсети. Чтобы узнать идентификатор, воспользуйтесь [инструкцией](reserve-public-subnet.md).

  Результат:

  ```json
  {
    "id": "ly5hcnsbx3l4********",
    "description": "Public subnet delete",
    "createdAt": "2025-12-14T14:42:58.375290Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-14T14:42:58.375290Z",
    "done": true,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.DeletePublicSubnetMetadata",
      "publicSubnetId": "ly52xefxa2hi********"
    },
    "response": {
      "@type": "type.googleapis.com/google.protobuf.Empty"
    }
  }
  ```

  Отслеживайте статус операции по полю `done`.

{% endlist %}
