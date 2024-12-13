---
title: Добавление схемы в существующий субъект
description: Следуя данной инструкции, вы сможете добавить схему в субъект.
---

# Добавление схемы в существующий субъект

{% include notitle [preview](../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно добавить схему в субъект.
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/layout-cells.svg) **{{ schema-registry-name }}**.
  1. Выберите пространство имен, в котором находятся ваши схемы.
  1. На панели слева выберите ![image](../../_assets/console-icons/branches-down.svg) **Схемы**.
  1. Нажмите кнопку **Загрузить схему**.
  1. Выберите способ загрузки схемы — в существующий субъект.
  1. В поле **Имя** выберите субъект из списка.
  1. Задайте формат схемы [Protobuf](https://protobuf.dev/), [Avro](https://avro.apache.org/) или [JSON Schema](https://json-schema.org/) и прикрепите файл.
  1. Если схема ссылается на другую схему, то нажмите ![add](../../_assets/console-icons/plus.svg) и введите имя [референса](../../metadata-hub/concepts/schema-registry.md#reference), имя субъекта, под которым зарегистрирована схема для ссылки, и версию субъекта, которая содержит схему для референса.
  1. Чтобы применить [нормализацию схем данных](https://docs.confluent.io/platform/current/schema-registry/fundamentals/serdes-develop/index.html#schema-normalization), включите настройку **Нормализация**.
  1. Если вы хотите пропустить проверку совместимости схем, включите соответствующую настройку.
  1. Нажмите кнопку **Загрузить схему**.

{% endlist %}
