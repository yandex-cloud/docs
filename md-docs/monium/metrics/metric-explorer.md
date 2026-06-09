# Посмотреть метрики в {{ metrics-name }}

В разделе **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** вы можете настраивать отображение метрик и анализировать показатели инфраструктуры и приложений в реальном времени.

Графики, которые вы создаете в этом разделе, не сохраняются и подходят для оперативного мониторинга. Если вам нужно периодически возвращаться к графикам, сохраните их на [дашборд](#add-to-dashboard).

## Построить графики по метрикам {#add-graph}

Графики по метрикам {{ prometheus-name }} — в разделе [{#T}](../operations/prometheus/querying/monitoring.md).

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
  1. Вверху на шкале времени задайте промежуток поиска данных.
  1. Для поиска метрик приложений в строке запроса укажите:
       
      * `project = <идентификатор_проекта>` — выберите проект, заданный в параметре `x-monium-project` в конфигурации передачи телеметрии приложения.
      
          Это может быть проект облака (`cloud__<идентификатор_облака>`), каталога (`folder__<идентификатор_каталога>`) или другой [проект](../collector/project.md#project-create).
      * `cluster = <имя_кластера>` — выберите имя инсталляции, в которой запущено ваше приложение. Если кластер не задан, то по умолчанию `cluster = default`.
      * `service = <имя_сервиса>` — имя вашего приложения или сервиса. Может передаваться в переменной окружения `OTEL_SERVICE_NAME`.
      
        Если нужных меток нет в подсказках, их можно ввести вручную. Но, скорее всего, в систему не поступали данные с такими метками. Решение возможных проблем см. в разделе [{#T}](../collector/troubleshooting.md).
  
  1. Для поиска метрик ресурсов {{ yandex-cloud }} в строке запроса укажите:
  
      * `project = folder__<идентификатор_каталога>` — идентификатор каталога, в котором находится ресурс {{ yandex-cloud }}.
      * `cluster = default`.
      * `service = <__имя_сервиса__>`, например, `__application-load-balancer__`, `__cdn__`, `__iam__`.
      * Метки нужного ресурса. Например, для сервиса {{ iam-name }} можно указать сервисный аккаунт — `service_account = <имя_сервисного_аккаунта>`.
  
  1. Чтобы посмотреть все доступные метки для уже введенного запроса, в строке запроса справа нажмите ![view](../../_assets/console-icons/folder-open.svg). Если нужной метки нет в списке, значит значения для нее не передавались в систему или уже удалены по [TTL](../concepts/common-ttl.md). Вы можете ввести метку вручную, но график отображаться не будет.

     Вы можете выбирать [метрики и метки](../concepts/data-model.md) курсором в выпадающих списках в строке запроса, либо вводить первые буквы названия метки с клавиатуры.
   
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

Вы можете настроить время для отображения метрик несколькими способами:

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  * Вверху раздела **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** нажмите:
    * **Последний час** — в выпадающем списке можно настроить дату и время;
    * **<** или **>** — перейти по временной шкале на час назад или вперед;
    * **1h**, **1d**, **1w**, **1M** — показать на графике метрики за последний час, день, неделю или месяц. В поле рядом можно ввести собственный интервал времени. Например, `15m`.
  * На панели графика справа вверху нажмите **+** или **–**;
  * Выделите область на графике и нажмите **{{ ui-key.yacloud_monitoring.tooltip.actions.go-to-window }}**.

{% endlist %}

## Настроить отображение на графике {#set-graph}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. На панели графика справа вверху нажмите ![image](../../_assets/console-icons/gear.svg).
  1. В разделе **{{ ui-key.yacloud_monitoring.wizard.tab.general }}** настройте заголовок графика и описание.
  1. В разделе **{{ ui-key.yacloud_monitoring.wizard.tab.visualization }}** настройте:
     1. **{{ ui-key.yacloud_monitoring.wizard.vis.chart-type }}** — выберите один из вариантов отображения метрик: линейный график, закрашенные области, столбчатую диаграмму, отображение метрик точками, круговую диаграмму или плитку.
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
     * **{{ ui-key.yacloud_monitoring.wizard.group-by.limit-field-title }}** — количество верхних или нижних значений на графике;
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
  1. Нажмите **Скопировать**. Ссылка на график будет скопирована в буфер обмена.

{% endlist %}

## Создать алерт по запросу {#create-alert}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. Выберите метрики и [постройте график](#add-graph).
  1. На панели запроса справа вверху нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Создать алерт по запросу** или **{{ ui-key.yacloud_monitoring.querystring.action.create-alert-from-all-queries }}**.
  1. Укажите [параметры алерта](../operations/alert/create-alert.md).
  1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}