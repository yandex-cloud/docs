# Удаление субъекта



{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}



{% note warning %}

Субъект удалится вместе со всеми загруженными в него схемами.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно удалить субъект.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
  1. Выберите пространство имен, в котором вы хотите удалить субъект.
  1. На панели слева выберите ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.schema-registry.label_subjects }}**.
  1. Справа от имени субъекта, который вы хотите удалить, нажмите ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}