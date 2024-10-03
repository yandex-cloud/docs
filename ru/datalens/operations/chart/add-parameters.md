---
title: Как добавить параметры в настройках чарта на дашборде в {{ datalens-full-name }}
description: Следуя данной инструкции, вы сможете добавить параметры в настройках чарта на дашборде.
---

# Добавление параметров в настройках чарта на дашборде

Чтобы установить [параметр](../../dashboard/dashboard_parameters.md):


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. На панели слева нажмите ![image](../../../_assets/console-icons/layout-cells-large.svg) **Дашборды** и выберите нужный дашборд. Если у вас нет дашборда, [создайте его](../dashboard/create.md).
1. В правом верхнем углу нажмите кнопку **Редактировать**.
1. Выберите чарт, для которого хотите установить новый параметр.
1. В правом верхнем углу чарта нажмите ![image](../../../_assets/console-icons/gear.svg).

   ![image](../../../_assets/datalens/parameters/chart-settings-open.svg)

1. В открывшемся окне нажмите ![image](../../../_assets/console-icons/chevron-down.svg) **Параметры**.
1. Внизу списка нажмите ![image](../../../_assets/console-icons/plus.svg) **Добавить параметр**.
1. В столбце **Название** установите имя (ключ) параметра.
1. В столбце **Значение** нажмите ![image](../../../_assets/console-icons/plus.svg) и установите значение параметра. Вы можете установить несколько значений.

   ![image](../../../_assets/datalens/parameters/chart-add-parameters.svg)

1. Нажмите кнопку **Сохранить**.
1. В правом верхнем углу редактирования дашборда нажмите **Сохранить**.

{% cut "Чарт на дашборде без параметра" %}

![image](../../../_assets/datalens/parameters/dashboard.svg)

{% endcut %}

{% cut "Чарт на дашборде с параметром" %}

![image](../../../_assets/datalens/parameters/dashboard-with-parameter.svg)

{% endcut %}

#### Примеры параметров с интервалами {#parameter-interval-examples}

{% cut "Пример добавления параметра с интервалом дат" %}

Чтобы установить [интервал](../../dashboard/dashboard_parameters.md#interval) дат и времени с `03-08-2018 09:00:00` по `10-08-2018 10:00:00`, укажите для параметра значение `__interval_2018-08-03T09:00:00_2018-08-10T10:00:00`.

![image](../../../_assets/datalens/parameters/date-interval-example.png)

{% endcut %}

{% cut "Пример добавления параметра с относительной датой" %}

Чтобы взять интервал дат и времени с начала последней недели 2018 года по сегодняшний день, укажите для параметра значение `__interval_2018-12-23___relative_+0d`. 

![image](../../../_assets/datalens/parameters/iso-date.png)

Чтобы привести статистику на начало года, замените `__relative_-0d` на `__relative_-0y_sy`.

{% note info %}

Если не указаны приведения, то для единиц измерения от дня и выше время приводится к началу дня (`00:00:00.000`), а для единиц измерения меньше дня используется текущее время.

{% endnote %}

{% endcut %}