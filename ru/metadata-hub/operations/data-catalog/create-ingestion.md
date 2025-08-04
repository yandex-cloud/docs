# Создание загрузки данных

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором вы хотите создать загрузку.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.data-catalog.label_ingestions }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-ingestion-action }}**.
  1. Задайте параметры загрузки:

      * В поле **{{ ui-key.yacloud.common.name }}** задайте уникальное имя загрузки.
      * (Опционально) Добавьте описание загрузки.
      * Выберите или создайте источник данных.
      * В блоке **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.title }}**:

         * Выберите расписание запуска загрузки:

            {% include [schedule](../../../_includes/metadata-hub/schedule-ingestion.md) %}

         * (Опционально) В блоке **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.data_filters.title }}** с помощью регулярных выражений укажите, какие базы данных и объекты баз данных необходимо включить или исключить из загрузки.

         {% include [metadata-profiling](../../../_includes/metadata-hub/metadata-profiling.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
