# Получение списка доменов и поддоменов

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором созданы домены.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/globe.svg) **Домены**.

{% endlist %}

## Настройка списка доменов {#setting-list-domains}

С помощью консоли управления можно найти домены по их идентификатору или имени, отсортировать домены по имени, а также настроить отображение колонок в списке.

Чтобы найти домены, введите идентификатор или имя домена в поисковой строке над списком доменов.

Чтобы отсортировать домены по имени, нажмите на заголовок колонки **{{ ui-key.yacloud.common.name }}**. Домены будут отсортированы в алфавитном порядке. Второе нажатие на тот же заголовок сменит направление сортировки. Третье нажатие отменит сортировку.

Чтобы настроить отображение колонок:

1. В строке заголовков колонок нажмите кнопку ![image](../../../_assets/console-icons/gear.svg). Откроется список всех колонок.
1. Выполните в списке колонок нужные действия:

    * Чтобы скрыть ненужные колонки, снимите для них отметки.
    * Чтобы отобразить скрытые колонки, отметьте их.
    * Чтобы изменить порядок колонок, слева от названия колонки нажмите ![image](../../../_assets/console-icons/grip.svg) и перетяните колонку вверх или вниз на нужную позицию в списке.

1. Нажмите кнопку **Применить**.
