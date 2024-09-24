---
title: "Изменение настроек субъекта"
description: "Следуя данной инструкции, вы сможете изменить настройки субъекта."
---

# Изменение настроек субъекта

{% include notitle [preview](../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно изменить настройки субъекта.
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/layout-cells.svg) **{{ schema-registry-name }}** / **Пространство имён**.
  1. Выберите пространство имен, в котором вы хотите изменить субъект.
  1. На панели слева выберите ![image](../../_assets/console-icons/layers-3-diagonal.svg) **Субъекты**.
  1. Выберите субъект, который хотите изменить.
  1. На странице с настройками субъекта в правом верхнем углу нажмите ![image](../../_assets/console-icons/pencil.svg) **Изменить**.
  1. Отредактируйте [настройки](create-subject.md) или [добавьте схему](add-schema.md). Затем нажмите **Сохранить изменения**.

{% endlist %}

{% note warning %}

Изменение типа схемы может привести к некорректной проверке совместимости версий схем. 

{% endnote %}
