---
title: Как изменить группу источников {{ cdn-full-name }}
description: Из статьи вы узнаете, как изменить группу источников {{ cdn-name }}.
---

# Изменение группы источников

## Редактирование группы {#editing-groups}

Чтобы изменить [группу источников](../../concepts/origins.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать группу ресурсов.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}**.
  1. Выберите группу, которую хотите отредактировать.
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Внесите необходимые изменения.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для редактирования группы источников:

     ```bash
     yc cdn origin-group update --help
     ```

  1. Получите список всех групп источников в каталоге по умолчанию:

     ```bash
     yc cdn origin-group list --format yaml
     ```

     Результат:

     ```text
     - id: "90209"
       folder_id: b1g86q4m5vej********
       name: test-group-1
     ...
         origin_group_id: "90208"
         source: www.a1.com
         enabled: true
     ```

  1. Измените параметры группы источников, указав ее идентификатор:

     ```bash
     yc cdn origin-group update --id <идентификатор_группы_источников> \
       --name <новое_имя_группы> \
       --origin source=<IP-адрес_или_доменное_имя_нового_источника>,enabled=true \
       --origin source=<IP-адрес_или_доменное_имя_нового_источника>,enabled=true,backup=true
     ```

     Где `--origin` — спецификация источника:
     * `source` — IP-адрес или доменное имя нового источника.
     * `enabled` — флаг, указывающий, включен ли источник.
     * `backup` — флаг, указывающий, является ли источник резервным.

     Результат:

     ```text
     id: "90209"
     folder_id: b1g86q4m5vej********
     name: test-group-22
     ...
       origin_group_id: "90209"
       source: www.site1.com
       enabled: true
     ```

     Подробнее о команде `yc cdn origin-group update` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/origin-group/update.md).

- API {#api}

  Чтобы изменить группу источников, воспользуйтесь методом REST API [update](../../api-ref/OriginGroup/update.md) для ресурса [OriginGroup](../../api-ref/OriginGroup/index.md) или вызовом gRPC API [OriginGroupService/Update](../../api-ref/grpc/origin_group_service.md#Update).

{% endlist %}

## Удаление одного источника из группы {#group-source-deletion}

{% note info %}

Удалить можно только резервные источники.

{% endnote %}

Чтобы удалить источник из группы источников:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать группу ресурсов.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}** и нажмите на имя группы, из которой хотите удалить источник.
  1. Выберите нужный источник и нажмите кнопку **{{ ui-key.yacloud.common.delete }}** на панели внизу.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/Origin/delete.md) для ресурса [Origin](../../api-ref/Origin/index.md) или вызовом gRPC API [OriginService/Delete](../../api-ref/grpc/origin_service.md#Delete).

{% endlist %}

## Удаление нескольких источников из группы {#summ-group-source-deletion}

{% note info %}

Удалить можно только резервные источники.

{% endnote %}

Чтобы удалить несколько источников из группы:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать группу ресурсов.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}** и нажмите на имя группы, из которой хотите удалить источники.
  1. Выберите нужные источники и нажмите кнопку **{{ ui-key.yacloud.common.delete }}** на панели внизу.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}