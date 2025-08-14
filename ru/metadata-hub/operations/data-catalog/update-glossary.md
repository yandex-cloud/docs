---
title: Изменение глоссария
description: Следуя данной инструкции, вы сможете изменить глоссарий в каталоге метаданных.
---

# Изменение глоссария


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором вы хотите изменить глоссарий.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_terms-and-glossaries }}**.
  1. В списке глоссариев нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужным глоссарием и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры глоссария:

      * В поле **{{ ui-key.yacloud.common.name }}** задайте новое уникальное имя глоссария.
      * (Опционально) Измените описание глоссария.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}
