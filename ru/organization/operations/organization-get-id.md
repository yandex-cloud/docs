---
title: Получить идентификатор организации {{ yandex-cloud }}
description: С помощью этой инструкции вы узнаете, как получить идентификатор организации {{ yandex-cloud }}.
---

# Получить идентификатор организации

Всем организациям в {{ yandex-cloud }} присваивается уникальный идентификатор. Зная идентификатор организации, вы можете выполнять различные операции как с самой организацией, так и с созданными в ней ресурсами.

Чтобы узнать идентификатор организации:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ cloud-center }}]({{ cloud-center-link }}).

     На открывшейся главной странице сервиса {{ cloud-center }} приведены основные сведения о вашей организации. 

  1. Идентификатор организации указан под ее названием в центральной части экрана. Нажмите значок ![copy](../../_assets/console-icons/copy.svg) справа от идентификатора, чтобы скопировать его.

     {% include [switch-org-note](../../_includes/organization/switch-org-note.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. {% include [get-federation-id-cli](../../_includes/organization/get-federation-id-cli.md) %}

- API {#api}

  Воспользуйтесь методом REST API [list](../../organization/api-ref/Organization/list.md) для ресурса [Organization](../../organization/api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/List](../../organization/api-ref/grpc/Organization/list.md).

{% endlist %}