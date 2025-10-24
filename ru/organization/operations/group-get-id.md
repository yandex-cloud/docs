---
title: Получить идентификатор группы {{ yandex-cloud }}
description: С помощью этой инструкции вы узнаете, как получить идентификатор группы {{ yandex-cloud }}.
---

# Получить идентификатор группы

Всем группам в {{ yandex-cloud }} присваивается уникальный идентификатор. Зная идентификатор группы, вы можете выполнять различные операции как с самой группой, так и с пользователями внутри нее.

Чтобы узнать идентификатор группы:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ cloud-center }}]({{ cloud-center-link }}).
  1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.
  1. В строке с нужной группой справа от идентификатора нажмите значок ![copy](../../_assets/console-icons/copy.svg), чтобы скопировать его.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. {% include [get-federation-id-cli](../../_includes/organization/get-group-id-cli.md) %}

- API {#api}

  Воспользуйтесь методом REST API [list](../../organization/api-ref/Group/list.md) для ресурса [Group](../../organization/api-ref/Group/index.md) или вызовом gRPC API [GroupService/List](../../organization/api-ref/grpc/Group/list.md).

{% endlist %}