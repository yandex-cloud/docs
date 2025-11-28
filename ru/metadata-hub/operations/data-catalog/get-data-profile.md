---
title: Получение профиля данных
description: Следуя данной инструкции, вы сможете получить профиль данных в {{ data-catalog-full-name }}.
---

# Получение профиля данных

{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}

Вы можете получить профиль выбранного набора данных.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных.
  1. На панели слева выберите ![image](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}**.
  1. Выберите в списке строку с типом **Набор данных** и перейдите на вкладку **Профиль**.
    
      На вкладке отображается статистика по заданным параметрам профилирования.

      Чтобы посмотреть заданные параметры профилирования, нажмите кнопку **{{ ui-key.yacloud.metadata-hub.data-catalog.AssetProfiling.ProfileHeader.title_profile-parameters_26kSu }}**.

{% endlist %}