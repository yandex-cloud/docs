---
title: Как изменить кластер {{ metastore-full-name }}
description: Следуя данной инструкции, вы сможете изменить кластер {{ metastore-full-name }}.
---

# Изменение кластера {{ metastore-full-name }}

{% include [Preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно изменить кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
  1. В строке с нужным кластером нажмите на значок ![options](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:
  
        1. Измените имя и описание кластера.
        1. Удалите или добавьте новые [метки {{ yandex-cloud }}](../../../resource-manager/concepts/labels.md).
        1. Выберите другой [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) или создайте новый с ролью `{{ roles.metastore.integrationProvider }}`.
        1. Измените версию {{ metastore-name }}.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите другую [группу безопасности](configure-security-group.md) или создайте новую.
  1. В блоке **{{ ui-key.yacloud.metastore.label_resource-preset }}** измените конфигурацию вычислительных ресурсов кластера. Доступные конфигурации:

        * **standard** — 2 vCPU и 8 ГБ RAM.
        * **cpu-optimized** — 2 vCPU и 4 ГБ RAM.

  1. В блоке **{{ ui-key.yacloud.logging.label_title }}** включите или выключите запись логов. Если логирование включено:
      * Укажите, в какую лог-группу или каталог будут записываться логи.
      * Выберите минимальный уровень логирования. 
      
      Подробнее см. в разделе [Передача логов кластера](logging.md).
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** включите или выключите защиту кластера от удаления.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.

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
