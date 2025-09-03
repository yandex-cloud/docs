# Создание домена


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором вы хотите создать домен.
  1. На панели слева выберите ![image](../../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.data-catalog.label_domains }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-domain-action }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** задайте уникальное имя домена.
  1. (Опционально) Добавьте описание домена.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
