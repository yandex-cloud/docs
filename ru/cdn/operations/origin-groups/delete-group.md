---
title: "Как удалить группу источников {{ cdn-full-name }}"
description: "Из статьи вы узнаете, как удалить группу источников {{ cdn-name }}."
---

# Удаление группы источников

## Удаление одной группы источников {#deletion-group-single}

Чтобы удалить [группу источников](../../concepts/origins.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать группу ресурсов.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}** и отметьте группу, которую хотите удалить.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.delete }}** на панели внизу.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления группы источников:

     ```bash
     yc cdn origin-group delete --help
     ```

  1. Получите список всех групп источников в каталоге по умолчанию:

     ```bash
     yc cdn origin-group list --format yaml
     ```

     Результат:

     ```text
     - id: "90209"
       folder_id: b1g86q4m5vej8lkljme5
       name: test-group-1
     ...
         origin_group_id: "90208"
         source: www.a1.com
         enabled: true
     ```

  1. Удалите группу источников в каталоге по умолчанию:

     ```bash
     yc cdn origin-group delete --id <идентификатор группы источников>
     ```

     Подробнее о команде `yc cdn origin-group delete` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/origin-group/delete.md).

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Если вы создавали группу источников с помощью {{ TF }}, вы можете удалить ее:
  1. В командной строке перейдите в папку, где расположен конфигурационный файл {{ TF }}.
  1. Удалите из конфигурационного файла описание нужной группы.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Удалите группу источников.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

- API

  Воспользуйтесь методом REST API [delete](../../api-ref/OriginGroup/delete.md) для ресурса [OriginGroup](../../api-ref/OriginGroup/index.md) или вызовом gRPC API [OriginGroupService/Delete](../../api-ref/grpc/origin_group_service.md#Delete).

{% endlist %}

## Удаление нескольких групп источников {#summ-deletion-groups}

Чтобы удалить несколько групп источников:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите удалить несколько групп ресурсов.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}** и отметьте группы, которые хотите удалить.

     Чтобы удалить все группы, выберите опцию в шапке таблицы рядом с полем **{{ ui-key.yacloud.cdn.column_name }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.delete }}** на панели внизу.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}