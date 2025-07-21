---
title: Изменение каталога {{ TR }}
description: Следуя этой инструкции, вы измените параметры каталога в кластере {{ mtr-name }}.
---

# Изменение каталога {{ TR }}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. На странице [каталога ресурсов]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Нажмите на имя нужного кластера.
    1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
    1. В строке с нужным каталогом нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.common.edit }}**.
    1. Измените параметры каталога {{ TR }} и нажмите кнопку **{{ ui-key.yacloud.common.update }}**.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените настройки каталога в блоке `yandex_trino_catalog`:

        ```hcl
        resource "yandex_trino_catalog" "<имя_каталога>" {
          ...
          <тип_коннектора> = {
            <настройки_каталога_{{ TR }}>
          }
        }
        ```

        [Подробнее о настройках каталога {{ TR }}](catalog-create.md#catalog-settings) для разных типов коннекторов.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}