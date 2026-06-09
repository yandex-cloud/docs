# Просмотр списка пространств имен



{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}



{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно изменить пространство имен.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.

  Нажмите ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) справа от выбранного пространства, чтобы [подключиться](connect-to-namespace.md), [отредактировать](update-name-space.md) или [удалить](delete-name-space.md) его.

  В списке пространств имен, помимо параметров, указанных при создании пространства, вы также можете найти и скопировать _идентификатор_ пространства имен для управления схемами данных в других сервисах {{ yandex-cloud }}.

{% endlist %}