# Запуск и остановка загрузки


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


Загрузки запускаются автоматически по тому расписанию, которое вы установили для них при [создании](create-ingestion.md) или [изменении](update-ingestion.md). Вы можете запустить или остановить загрузку, если в ее расписании указано **{{ ui-key.data-catalog.console.form.cron.Cron.none.title }}**.

## Запустить загрузку {#start-ingestion}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно запустить загрузку.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. Выберите каталог метаданных, в котором нужно запустить загрузку, затем на панели слева выберите ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.data-catalog.label_ingestions }}**.
  1. В списке загрузок нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужной загрузкой и выберите пункт **{{ ui-key.yacloud.common.start }}**.

{% endlist %}

## Остановить загрузку {#stop-ingestion}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. Выберите каталог, в котором нужно остановить загрузку, затем на панели слева выберите ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.data-catalog.label_ingestions }}**.
  1. В списке загрузок нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужной загрузкой в статусе **{{ ui-key.yacloud.data-catalog.label_ingestion-status-Running }}** и выберите пункт **{{ ui-key.yacloud.common.stop }}**.

{% endlist %}
