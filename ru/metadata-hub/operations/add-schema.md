---
title: Добавление схемы в существующий субъект
description: Следуя данной инструкции, вы сможете добавить схему в субъект.
---

# Добавление схемы в существующий субъект



{% include notitle [preview](../../_includes/note-preview.md) %}



Вы можете загрузить схему в существующий субъект [на странице этого субъекта](#from-subject-page) или [на странице со списком схем](#from-schema-list).

## Добавить схему на странице субъекта {#from-subject-page}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно добавить схему в субъект.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
  1. Выберите пространство имен, в котором находится нужный субъект.
  1. На панели слева выберите ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.schema-registry.label_subjects }}**.
  1. Нажмите на имя нужного субъекта, а затем в правом верхнем углу нажмите кнопку ![add](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.schema-registry.label_upload-schema-action }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.component.dyn-string-field.button-upload_file }}** и прикрепите файл.
  1. Если схема ссылается на другую схему, то нажмите ![add](../../_assets/console-icons/plus.svg) и введите имя [референса](../../metadata-hub/concepts/schema-registry.md#reference), имя субъекта, под которым зарегистрирована схема для ссылки, и версию субъекта, которая содержит схему для референса.
  1. Чтобы применить [нормализацию схем данных](https://docs.confluent.io/platform/current/schema-registry/fundamentals/serdes-develop/index.html#schema-normalization), включите настройку **Нормализация**.
  1. Если вы хотите пропустить проверку совместимости схем, включите соответствующую настройку.
  1. Нажмите кнопку **{{ ui-key.yacloud.schema-registry.label_upload-schema-action }}**.

{% endlist %}

## Добавить схему на странице со списком схем {#from-schema-list}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно добавить схему в субъект.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
  1. Выберите пространство имен, в котором находится нужный субъект.
  1. На панели слева выберите ![image](../../_assets/console-icons/branches-down.svg) **{{ ui-key.yacloud.schema-registry.label_schemas }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.schema-registry.label_upload-schema-action }}**.
  1. Выберите способ загрузки схемы — в существующий субъект.
  1. В поле **Имя** выберите субъект из списка.
  1. Нажмите кнопку **{{ ui-key.yacloud.component.dyn-string-field.button-upload_file }}** и прикрепите файл.
  1. Если схема ссылается на другую схему, то нажмите ![add](../../_assets/console-icons/plus.svg) и введите имя [референса](../../metadata-hub/concepts/schema-registry.md#reference), имя субъекта, под которым зарегистрирована схема для ссылки, и версию субъекта, которая содержит схему для референса.
  1. Чтобы применить [нормализацию схем данных](https://docs.confluent.io/platform/current/schema-registry/fundamentals/serdes-develop/index.html#schema-normalization), включите настройку **Нормализация**.
  1. Если вы хотите пропустить проверку совместимости схем, включите соответствующую настройку.
  1. Нажмите кнопку **{{ ui-key.yacloud.schema-registry.label_upload-schema-action }}**.

{% endlist %}
