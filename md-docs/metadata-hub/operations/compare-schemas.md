# Сравнение схем в субъекте



{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}



{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно сравнить схемы.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
  1. Выберите пространство имен, в котором находятся ваши схемы.
  1. На панели слева выберите ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.schema-registry.label_subjects }}**.
  1. Выберите субъект, для которого хотите сравнить схемы.
  1. В блоке **{{ ui-key.yacloud.schema-registry.label_versions }}** выберите две схемы одного типа, например `JSON`, и нажмите кнопку ![image](../../_assets/console-icons/scales-unbalanced.svg) **{{ ui-key.yacloud.schema-registry.label_compare }}**.
  1. В окне сравнения версий выберите режим отображения: **{{ ui-key.yacloud.schema-registry.label_compare-mode-side-by-side }}** или **{{ ui-key.yacloud.schema-registry.label_compare-mode-single }}**. Добавления будут выделены зеленым цветом, а удаления — красным.

{% endlist %}