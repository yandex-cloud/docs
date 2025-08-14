---
title: Создание глоссария
description: Следуя данной инструкции, вы сможете создать глоссарий в каталоге метаданных.
---

# Создание глоссария


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором вы хотите создать глоссарий.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_terms-and-glossaries }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-glossary-action }}**.
  1. Задайте параметры глоссария:

      * В поле **{{ ui-key.yacloud.common.name }}** задайте уникальное имя глоссария.
      * (Опционально) Добавьте описание глоссария.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
