---
title: Посмотреть метрики ваших сервисов или приложений в {{ metrics-name }}
description: С помощью инструкции вы сможете посмотреть детальные графики метрик ваших сервисов или приложений.
---

# Посмотреть метрики в {{ metrics-name }}

В разделе **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** вы можете настраивать отображение метрик и анализировать показатели инфраструктуры и приложений в реальном времени.

Графики, которые вы создаете в этом разделе, не сохраняются и подходят для оперативного мониторинга. Если вам нужно периодически возвращаться к графикам, сохраните их на [дашборд](#add-to-dashboard).

## Построить графики по метрикам {#add-graph}

Графики по метрикам {{ prometheus-name }} — в разделе [{#T}](../operations/prometheus/querying/monitoring.md).

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите ![alt](../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.all-panel.menu.category.explore }}** → ![alt](../../_assets/console-icons/rectangle-pulse.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
  1. Вверху на шкале времени задайте промежуток поиска данных.
  1. Для поиска метрик приложений в строке запроса укажите:
       
      {% include [application-labels](../../_includes/monium/application-labels.md) %}
  
  1. Для поиска метрик ресурсов {{ yandex-cloud }} в строке запроса укажите:
  
      {% include [yc-resource-labels](../../_includes/monium/yc-resource-labels-metrics.md) %}

      {% note info %}

      Если удалить ресурс {{ yandex-cloud }} (например, виртуальную машину) и создать новый ресурс с тем же именем, поиск по имени будет показывать метрики только нового ресурса. Метрики предыдущего ресурса остаются доступны до истечения [TTL](../concepts/common-ttl.md#ttl-metrics), но только при поиске по его идентификатору `resource_id`.

      {% endnote %}
  
  1. Чтобы посмотреть доступные метки для введенного запроса, справа в строке запроса нажмите ![view](../../_assets/console-icons/folder-open.svg).

     Если нужной метки нет, проверьте [временной интервал поиска](../concepts/querying.md#time-range-filtering). Данные с этой меткой могли не поступать или быть удалены по [TTL](../concepts/common-ttl.md). Метку можно ввести вручную, но график появится только при наличии данных за выбранный интервал.

     Выбирайте [метрики и метки](../concepts/data-model.md) в выпадающих списках строки запроса или вводите первые буквы названия метки.
   
     Чтобы посмотреть подсказки по горячим клавишам строки запросов, нажмите ![view](../../_assets/console-icons/keyboard.svg) **Cmd/Ctrl + Enter**.

  1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.button.apply-and-parse }}**.

  1. Чтобы отобразить на графике модифицированную метрику, в строке ![image](../../_assets/monitoring/function.svg) выберите [функции](../concepts/querying.md#functions).
  
  1. Чтобы отобразить на графике еще одну метрику, нажмите кнопку **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}** и введите значения метрик и меток.
   
     Если какие-либо запросы — промежуточные и нужны для вычисления другого запроса, скройте их на графике. Для этого нажмите ![image](../../_assets/monitoring/concepts/visualization/chart-query-hide.svg) рядом с запросом.

     Если для каждого запроса нужно построить отдельный график, включите настройку **{{ ui-key.yacloud_monitoring.wizard.one-graph-per-query.label }}** и выберите количество графиков в ряду.
  
  1. Чтобы временно скрыть графики для определенных меток, внизу выберите **{{ ui-key.yacloud_monitoring.wizard.tab.pivot-table }}** и отключите ненужные графики.
  1. Чтобы просмотреть значения метрик в табличном виде, внизу выберите **{{ ui-key.yacloud_monitoring.wizard.tab.table }}**.

{% endlist %}

## Выбрать промежуток времени {#set-time}

Выбранный интервал влияет на [поиск метрик](../concepts/querying.md#time-range-filtering) и подсказки в строке запроса. Чтобы найти метрику, запись которой прекратилась, выберите период с ее данными. При загрузке исторических данных соблюдайте [порядок записи точек](../concepts/querying.md#backfill).

Вы можете настроить время для отображения метрик несколькими способами:

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  * Вверху раздела **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** нажмите:
    * **{{ ui-key.yacloud_monitoring.component.range-date-picker.preset-last-hour }}** — в выпадающем списке можно настроить дату и время;
    * **<** или **>** — перейти по временной шкале на час назад или вперед;
    * **1h**, **1d**, **1w**, **1M** — показать на графике метрики за последний час, день, неделю или месяц. В поле рядом можно ввести собственный интервал времени. Например, `15m`.
  * На панели графика справа вверху нажмите **+** или **–**;
  * Выделите область на графике и нажмите **{{ ui-key.yacloud_monitoring.tooltip.actions.go-to-window }}**.

{% endlist %}

## Настроить отображение на графике {#set-graph}

Выберите тип графика и задайте его параметры. Доступные настройки зависят от типа графика.

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. Над графиком справа нажмите **Тип графика** и в выберите график в одной из групп:

     * **Временные ряды** — **{{ ui-key.yacloud_monitoring.wizard.chart.line }}**, **{{ ui-key.yacloud_monitoring.wizard.chart.area }}**, **{{ ui-key.yacloud_monitoring.wizard.chart.column }}**, **{{ ui-key.yacloud_monitoring.wizard.chart.points }}**.
     * **Агрегации** — **{{ ui-key.yacloud_monitoring.wizard.chart.pie }}**, **{{ ui-key.yacloud_monitoring.wizard.chart.tiles }}**, **Столбцы**.

  1. Чтобы открыть настройки графика, нажмите ![image](../../_assets/console-icons/gear.svg).
  1. В разделе **{{ ui-key.yacloud_monitoring.wizard.tab.general }}** настройте заголовок графика и описание.
  1. В разделе **{{ ui-key.yacloud_monitoring.wizard.tab.visualization }}** настройте:
     1. **{{ ui-key.yacloud_monitoring.wizard.vis.color-scheme }}** — [цвета линий](../concepts/visualization/widget.md#color-schemes) на графике.

        Чтобы линии с одинаковым названием на разных графиках всегда были одного цвета, выберите пункт **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-hash }}**.

        Чтобы линии, которые превышают пороговые значения, обозначались цветом этого порога, выберите пункт **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-thresholds }}** и настройте пороги.

     1. **{{ ui-key.yacloud_monitoring.wizard.vis.normalize }}** — привести все данные к диапазону от `0%` до `100%`.
     1. **{{ ui-key.yacloud_monitoring.wizard.vis.interpolate-key-value }}** — выбрать способ заполнения недостающих данных между двумя точками: по прямой линии между точками, по известной точке слева или по известной точке справа.
  1. В разделах **{{ ui-key.yacloud_monitoring.wizard.axes.primary-y }}** и **{{ ui-key.yacloud_monitoring.wizard.axes.secondary-y }}** настройте подпись, масштаб, минимальное и максимальное значения графика, единицы измерения и количество знаков в дробной части.
  1. В разделе **{{ ui-key.yacloud_monitoring.wizard.tab.downsampling }}** настройте механизм [агрегации данных при чтении](../concepts/decimation.md#reading-decimation).
  1. В разделе **{{ ui-key.yacloud_monitoring.wizard.tab.thresholds }}** задайте одно или несколько значений. По ним на графике будут построены прямые линии. Они помогут определить, какие метрики выше или ниже пороговых значений. Для каждой линии можно выбрать свой цвет или оставить цвет по умолчанию.
  1. После настройки графика закройте панель настроек. Все изменения отображаются на графике сразу.

{% endlist %}

## Настроить график «Столбцы» {#bar-chart}

Тип **Столбцы** позволяет сравнивать агрегированные значения метрик по категориям. Например, можно сгруппировать ошибки по кодам ответа, а внутри каждого кода — по хостам.

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. Выберите метрики и [постройте график](#add-graph).
  1. Над графиком справа нажмите **Тип графика** и в группе **Агрегации** выберите ![image](../../_assets/console-icons/chart-bar.svg) **Столбцы**.
  1. Нажмите ![image](../../_assets/console-icons/gear.svg) и откройте раздел **{{ ui-key.yacloud_monitoring.wizard.tab.visualization }}**.
  1. В поле **Группировать по** выберите метку для категорий. Например, `code` создаст категории для кодов ответа `500`, `503`, `504`.
  1. В поле **Разбить группу по** выберите метку для подгрупп. Например, `host` разделит каждую категорию на столбцы для хостов `host-1`, `host-2`.

     В обоих полях можно оставить автоматический выбор меток по данным.

  1. В поле **{{ ui-key.yacloud_monitoring.wizard.vis.aggregation-key-value }}** выберите среднее, минимум, максимум, последнее значение, сумму или количество точек.

     Для каждого столбца сначала суммируются значения метрик в каждой точке времени. Затем к полученному временному ряду применяется выбранная агрегация за весь период.

  1. В поле **Сортировка** выберите сортировку по значениям столбцов или категориям, по возрастанию или убыванию. По умолчанию категории отсортированы по возрастанию: числовые — как числа, остальные — лексикографически.
  1. В поле **Ориентация** выберите вертикальный или горизонтальный вид столбцов.
  1. В поле **Расположение столбцов** выберите расположение внутри категории: рядом или с накоплением.
  1. Закройте панель настроек. Все изменения применяются сразу.

{% endlist %}

Легенда показывает группы столбцов, а модификации применяются к отдельным столбцам. Чтобы посмотреть статистику и метки столбца, изменить его видимость или цвет, откройте **{{ ui-key.yacloud_monitoring.wizard.tab.pivot-table }}**.

Чтобы окрашивать столбцы по агрегированным значениям, выберите цветовую схему **{{ ui-key.yacloud_monitoring.wizard.vis.scheme-thresholds }}** и задайте пороги.

При [разбивке графика по меткам](#repeated-graphs) выбранная агрегация также используется для отбора наибольших или наименьших значений.

## Изучить значения на графике {#graph-exploring}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  Чтобы посмотреть легенду для графика:

  1. На панели графика вверху справа нажмите ![image](../../_assets/console-icons/ellipsis.svg).
  1. Выберите **{{ ui-key.yacloud_monitoring.wizard.settings-select.show-legend }}**.
  1. Чтобы выделить определенный график, в легенде наведите курсор на его название.

  Чтобы посмотреть легенду и статистику для конкретной временной точки:

  1. Наведите курсор или нажмите на нужную точку на графике.
  1. В окне информации посмотрите значения различных меток в этот момент времени.
  1. Чтобы отсортировать значения по столбцу, нажмите на этот столбец.
  1. Чтобы открыть отдельный график для какого-либо значения, нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_monitoring.tooltip.actions.go-to-line }}**.
  1. Чтобы окно информации не закрывалось при выборе другой точки, нажмите **Cmd+Click** или **Ctrl+Click**.

     Так вы сможете открыть на графике несколько окон и сравнить значения метрик в разные моменты времени. Чтобы расположить окна в нужном порядке, наведите курсор на значок ![image](../../_assets/console-icons/grip.svg) и перетащите окно.

  Чтобы посмотреть легенду и статистику для временного промежутка:

  1. Выделите область на графике.
  1. В окне информации посмотрите статистику по метрикам в выбранном промежутке.
  1. При необходимости отсортируйте значения по минимальному, максимальному, среднему и другим параметрам.
  1. Чтобы открыть отдельный график для какого-либо значения, нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_monitoring.tooltip.actions.go-to-line }}**.

{% endlist %}

## Посмотреть метрики в числовом виде {#view-source}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. Чтобы посмотреть числовые значения метрик, под графиком нажмите кнопку **{{ ui-key.yacloud_monitoring.wizard.tab.table }}**.

     Будет показан список данных для всех временных точек, для которых получены метрики. Чтобы отобразить данные за другой период, вверху выберите нужный промежуток времени.

  1. Чтобы посмотреть статистику по метрикам, например минимальное и максимальное значения или сумму, нажмите кнопку **{{ ui-key.yacloud_monitoring.wizard.tab.pivot-table }}**.

  1. Чтобы сохранить данные сводной таблицы, справа нажмите **{{ ui-key.yacloud_monitoring.wizard.legend.copy-as-csv }}**.

{% endlist %}
   
## Разбить график по определенному параметру {#repeated-graphs}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. Выберите метрики и [постройте график](#add-graph).
  1. Под графиком нажмите кнопку **{{ ui-key.yacloud_monitoring.wizard.button.top-by }}**.
  1. Выберите параметры, по которым нужно построить графики:
     * **{{ ui-key.yacloud_monitoring.wizard.group-by.label-field-title }}** — параметр, по которому нужно построить дополнительные графики. Это могут быть графики для разных сервисов, хостов или процессоров — токенов, которые выбраны в запросе;
     * **{{ ui-key.yacloud_monitoring.wizard.group-by.limit-field-title }}** — количество наибольших или наименьших значений на графике;
     * **{{ ui-key.yacloud_monitoring.wizard.group-by.sort-by }}** — сортировка по минимальному, максимальному или среднему значению выбранного параметра;
     * **{{ ui-key.yacloud_monitoring.wizard.select.charts-count.label }}** — количество графиков в одной строке.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.wizard.group-by.execute }}**.

Выбирайте разные значения параметров. Графики будут перестраиваться для выбранных значений.

{% endlist %}

## Добавить на дашборд и поделиться графиком {#add-to-dashboard}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  Чтобы добавить график на дашборд:

  1. Выберите метрики и [постройте график](#add-graph).
  1. Справа вверху нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_monitoring.wizard.wizard.mx.save-as }}**.
  1. Выберите проект, в котором находится или будет создан дашборд.
  1. Выберите существующий дашборд или нажмите **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.dash-picker.new-dashboard }}**.
  1. Введите название виджета для графика.
  1. Выберите один из вариантов добавления графика:
     * **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.add }}** — остаться в разделе **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**;
     * **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.add-and-go }}** — перейти в раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**. График в **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** не сохранится.

  Виджет на дашборде не будет связан с исходным графиком. Изменения в одном не повлияют на другой.

  Чтобы поделиться графиком:

  1. Выберите метрики и [постройте график](#add-graph).
  1. Справа вверху нажмите кнопку ![image](../../_assets/monitoring/concepts/visualization/share.svg).
  1. Настройте промежуток времени, который будет установлен на графике.
  1. Нажмите **{{ ui-key.yacloud_monitoring.component.share-form.action.copy-key-value }}**. Ссылка на график будет скопирована в буфер обмена.

{% endlist %}

## Создать алерт по запросу {#create-alert}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. Выберите метрики и [постройте график](#add-graph).
  1. На панели запроса справа вверху нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Создать алерт по запросу** или **{{ ui-key.yacloud_monitoring.querystring.action.create-alert-from-all-queries }}**.
  1. Укажите [параметры алерта](../operations/alert/create-alert.md).
  1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}
