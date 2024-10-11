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

      Если у вас несколько организаций, вы можете [переключаться](./manage-organizations.md#switch-to-another-org) между ними. Для этого в левом верхнем углу экрана рядом с названием текущей организации нажмите значок ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужную организацию.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. Чтобы посмотреть список доступных организаций, выполните команду:

      ```bash
      yc organization-manager organization list
      ```

      Результат:

      ```text
      +----------------------+-----------------------------+-------------------------+--------+
      |          ID          |            NAME             |          TITLE          | LABELS |
      +----------------------+-----------------------------+-------------------------+--------+
      | bpf1smsil5q0******** | org1-technical-name         | Organization One        |        |
      | bpf2c65rqcl8******** | org2-technical-name         | Organization Two        |        |
      | bpfaidqca8vd******** | org3-technical-name         | Organization Three      |        |
      +----------------------+-----------------------------+-------------------------+--------+
      ```

      Из поля `ID` скопируйте идентификатор нужной организации.

- API {#api}

    Воспользуйтесь методом REST API [list](../../organization/api-ref/Organization/list.md) для ресурса [Organization](../../organization/api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/List](../../organization/api-ref/grpc/organization_service.md#List).

{% endlist %}