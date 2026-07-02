[Документация Yandex Cloud](../../../index.md) > [Yandex MetaData Hub](../../index.md) > Data Catalog > Пошаговые инструкции > Термины > Удаление термина

# Удаление термина


{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}


Перед удалением термина [удалите](delete-term-child.md) все его дочерние термины.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **Data Catalog**.
  1. В открывшемся списке выберите каталог метаданных, в котором вы хотите удалить термин.
  1. На панели слева выберите ![image](../../../_assets/console-icons/book.svg) **Термины и глоссарии** и выберите глоссарий, который содержит нужный термин.
  1. В списке терминов нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужным термином и выберите **Удалить**.

      {% note tip %}
      
      Чтобы найти термин, введите его идентификатор или имя в поисковой строке над списком терминов.
      
      {% endnote %}

  1. В открывшемся окне нажмите кнопку **Удалить**.

{% endlist %}