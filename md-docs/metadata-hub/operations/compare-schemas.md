# Сравнение схем в субъекте



{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}



{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно сравнить схемы.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/layout-cells.svg) **Schema Registry**.
  1. Выберите пространство имен, в котором находятся ваши схемы.
  1. На панели слева выберите ![image](../../_assets/console-icons/layers-3-diagonal.svg) **Субъекты**.
  1. Выберите субъект, для которого хотите сравнить схемы.
  1. В блоке **Версии** выберите две схемы одного типа, например `JSON`, и нажмите кнопку ![image](../../_assets/console-icons/scales-unbalanced.svg) **Сравнить**.
  1. В окне сравнения версий выберите режим отображения: **Две версии** или **Последняя версия**. Добавления будут выделены зеленым цветом, а удаления — красным.

{% endlist %}