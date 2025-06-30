# Изменение загрузки данных

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором вы хотите изменить загрузку.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/book.svg) **Загрузки**.
  1. В списке загрузок нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужной загрузкой и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры загрузки:

     * В поле **{{ ui-key.yacloud.common.name }}** задайте новое уникальное имя загрузки.
     * (Опционально) Измените описание загрузки.
     * Выберите новый источник данных.
     * В блоке **Конфигурация загрузки**:

       * Измените расписание запуска загрузки:

          {% include [schedule](../../../_includes/metadata-hub/schedule-ingestion.md) %}

       * (Опционально) В блоке **Фильтры данных** с помощью регулярных выражений укажите, какие базы данных и объекты баз данных необходимо включить или исключить из загрузки.

       {% include [metadata-profiling](../../../_includes/metadata-hub/metadata-profiling.md) %}

  1. Нажмите **{{ ui-key.yacloud.common.apply }}**.

{% endlist %}
