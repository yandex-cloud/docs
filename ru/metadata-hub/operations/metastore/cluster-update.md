---
title: Как изменить кластер {{ metastore-full-name }}
description: Следуя данной инструкции, вы сможете изменить кластер {{ metastore-full-name }}.
---

# Изменение кластера {{ metastore-full-name }}

{% include [Preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы изменить настройки кластера {{ metastore-name }}:

  1. Посмотрите описание команды CLI для изменения кластера:
 
      ```bash
      {{ yc-metastore }} cluster update --help
      ```

  1. Передайте список настроек, которые хотите изменить, в команде изменения кластера:

      ```bash
      {{ yc-metastore }} cluster update <имя_или_идентификатор_кластера> \
         --new-name <имя_кластера> \
         --description <описание_кластера> \
         --labels <список_меток> \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --version <версия> \
         --security-group-ids <идентификаторы_групп_безопасности> \
         --resource-preset-id <идентификатор_вычислительных_ресурсов> \
         --maintenance-window type=<тип_технического_обслуживания>,`
                              `day=<день_недели>,`
                              `hour=<час_дня> \
         --deletion-protection \
         --log-enabled \
         --log-folder-id <идентификатор_каталога> \
         --log-min-level <уровень_логирования>
      ```
      Где:

      * `--new-name` — новое имя кластера.

      {% include [CLI cluster parameters description, part 1](../../../_includes/metadata-hub/metastore-cluster-parameters-cli-part-1.md) %}

      {% include [CLI cluster parameters description, part 2](../../../_includes/metadata-hub/metastore-cluster-parameters-cli-part-2.md) %}

      Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}