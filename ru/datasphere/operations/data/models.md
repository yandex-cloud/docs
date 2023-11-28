# Работа с моделями

[Модели](../../concepts/models/index.md) позволяют хранить и выгружать результаты вычислений в проектах {{ ml-platform-name }}.

{% note info %}

Модели доступны только в проектах [в режиме {{ dd }}](../../concepts/project.md#dedicated).

{% endnote %} 

## Создать модель {#create}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Откройте проект [в режиме {{ dd }}](../../concepts/project.md#dedicated).
1. Выберите или создайте ноутбук с кодом, который создаст переменную модели в памяти. 
1. Запустите код в ноутбуке на выбранной конфигурации.
1. На панели справа выберите ![models](../../../_assets/console-icons/nodes-right.svg). В появившемся окне нажмите **Создать модель**.
1. Выберите имя переменной, из которой вы хотите создать модель. 
1. Введите имя модели и при необходимости добавьте описание. 
1. Нажмите кнопку **Создать**.
   
   Новая модель появится в списке доступных моделей проекта. Создание модели может занять некоторое время.

## Загрузить модель {#load}

Вы можете загрузить сохраненную модель в состояние интерпретатора ноутбука и использовать ее в своих вычислениях:

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Откройте проект [в режиме {{ dd }}](../../concepts/project.md#dedicated).
1. На панели справа выберите ![models](../../../_assets/console-icons/nodes-right.svg). В появившемся окне выберите модель, которую вы хотите загрузить, и нажмите ![options](../../../_assets/console-icons/ellipsis.svg). 
1. Выберите ![load](../../../_assets/datasphere/jupyterlab/load.svg)**Загрузить**.
1. Введите имя переменной, в которую вы хотите загрузить модель, и нажмите **Загрузить**. 

   После окончания загрузки модель будет доступна в коде в переменной, которую вы ввели.

## Удалить модель {#delete}

Вы можете удалить модель в интерфейсе {{ jlab }}Lab и в разделе **Ресурсы** на странице проекта.

{% list tabs %}

- {{ jlab }}Lab

1. В интерфейсе {{ jlab }}Lab на панели справа выберите ![models](../../../_assets/console-icons/nodes-right.svg). 
1. В списке моделей выберите ту, которую вы хотите удалить, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите ![delete](../../../_assets/datasphere/jupyterlab/delete-red.svg)**Удалить**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.submit }}**.

- Ресурсы проекта

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![model](../../../_assets/console-icons/nodes-right.svg)**Модель**.
1. В списке моделей выберите ту, которую хотите удалить.
1. На странице просмотра модели нажмите **Еще** и выберите ![delete](../../../_assets/datasphere/jupyterlab/delete-red.svg)**{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.submit }}**.

{% endlist %}