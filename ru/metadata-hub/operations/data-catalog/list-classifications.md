# Получение списка классификаций

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором созданы классификации.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/tag.svg) **{{ ui-key.yacloud.data-catalog.label_tags-and-classification }}**.

{% endlist %}

## Настройка списка классификаций {#setting-list-classifications}

С помощью консоли управления можно найти классификации по их идентификатору или имени, отсортировать классификации по имени, а также настроить отображение колонок в списке.

Чтобы найти классификацию, введите ее идентификатор или имя в поисковой строке над списком классификаций.

Чтобы отсортировать классификации по имени, нажмите на заголовок колонки **{{ ui-key.yacloud.common.name }}**. Классификации будут отсортированы в алфавитном порядке. Второе нажатие на тот же заголовок сменит направление сортировки. Третье нажатие отменит сортировку.

{% include [display-columns](../../../_includes/metadata-hub/display-columns.md) %}
