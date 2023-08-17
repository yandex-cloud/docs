# Собирать статистику по обращениям

Руководителям и сотрудникам службы поддержки для работы нужна различная информация о текущих задачах и статистика по решенным обращениям. В {{ tracker-name }} вы можете просматривать полезную информацию и статистику на дашборде. Для этого [создайте дашборд](user/create-dashboard.md#section_cv2_ck3_pz) и добавьте на него [виджеты](user/widgets.md#section_ll1_zdp_pz) — списки задач, таблицы и графики, которые строятся автоматически по заданным фильтрам.

Например, руководитель может добавить на свой дашборд список обращений без исполнителя и статистику открытых и решенных обращений за определенный период. Сотруднику службы поддержки будет полезен список задач, в которых он назначен исполнителем, и список задач без исполнителя, которые нужно взять в работу.

Рассмотрим примеры виджетов для службы поддержки:

### Список моих задач {#widget-my-tickets}

На личный дашборд сотрудника службы поддержки добавьте виджет со списком задач, в которых он назначен исполнителем:

1. На странице дашборда нажмите ![](../_assets/tracker/icon-settings.png) → **{{ ui-key.startrek.blocks-desktop_b-page-dashboard.edit-button }}**.

1. Добавьте виджет типа **{{ ui-key.startrek.blocks-desktop_dashboard-create-zone.filter-title }}**.

1. В поле **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}** выберите **{{ ui-key.startrek.blocks-desktop_b-filter.type-query }}** и введите [текст запроса](user/query-filter.md#query-format):

    ```
    Queue: "<название очереди>" AND Assignee: me() AND Resolution: empty()
    ```

    Этот фильтр найдет в заданной очереди незакрытые задачи, в которых вы назначены исполнителем.

1. Чтобы отобразить в списке задач [таймер правил SLA](#sla), в поле **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-x-axis }}** добавьте параметр **{{ ui-key.startrek-backend.types.types.sla.settings }}**.

    ![](../_assets/tracker/support-widget-my-tickets.png)

1. Сохраните виджет.

### Список задач без исполнителя {#widget-no-assignee}

Чтобы сотрудники службы поддержки могли быстро найти обращения, у которых нет исполнителя, и взять их в работу, добавьте на дашборд список таких задач:

1. На странице дашборда нажмите ![](../_assets/tracker/icon-settings.png) → **{{ ui-key.startrek.blocks-desktop_b-page-dashboard.edit-button }}**.

1. Добавьте виджет типа **{{ ui-key.startrek.blocks-desktop_dashboard-create-zone.filter-title }}**.

1. В поле **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}** выберите **{{ ui-key.startrek.blocks-desktop_b-filter.type-query }}** и введите [текст запроса](user/query-filter.md#query-format):

    ```
    Queue: "<название очереди>" AND Assignee: empty()
    ```

    Этот фильтр найдет в заданной очереди задачи, у которых нет исполнителя.

1. Чтобы отобразить в списке задач [таймер правил SLA](#sla), в поле **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-x-axis }}** добавьте параметр **{{ ui-key.startrek-backend.types.types.sla.settings }}**.

    ![](../_assets/tracker/support-widget-no-assignee.png)

1. Сохраните виджет.

### Таблица с количеством задач по исполнителям {#widget-worker-tasks}

Чтобы получить статистику о том, какое количество задач было назначено на сотрудников за последние 30 дней, добавьте на дашборд виджет с таблицей:

1. На странице дашборда нажмите ![](../_assets/tracker/icon-settings.png) → **{{ ui-key.startrek.blocks-desktop_b-page-dashboard.edit-button }}**.

1. Добавьте виджет типа **{{ ui-key.startrek.blocks-desktop_dashboard-create-zone.table-title }}**.

1. В поле **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}** выберите **{{ ui-key.startrek.blocks-desktop_b-filter.type-query }}** и введите [текст запроса](user/query-filter.md#query-format):

    ```
    Queue: "<название очереди>" AND Created: >= today() - 30d
    ```

    Этот фильтр найдет в заданной очереди все задачи, созданные за последние 30 дней.

1. В поле **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-x-axis }}** выберите **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.field-status }}**, а в поле **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-y-axis }}** выберите **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.field-assignee }}**. Тогда в ячейках таблицы будет отображаться количество задач с определенным статусом у каждого исполнителя.

1. Чтобы отображать в таблице сумму по столбцам и строкам, включите опцию **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-show-sum }}**.

    ![](../_assets/tracker/support-widget-worker-tasks.png)

1. Сохраните виджет.

### Статистика открытых и решенных обращений {#widget-created-resolved}

Чтобы наблюдать за динамикой создания и решения обращений, добавьте на дашборд график:

1. На странице дашборда нажмите ![](../_assets/tracker/icon-settings.png) → **{{ ui-key.startrek.blocks-desktop_b-page-dashboard.edit-button }}**.

1. Добавьте виджет типа **{{ ui-key.startrek.blocks-desktop_dashboard-create-zone.created-vs-resolved-title }}**.

1. В поле **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}** выберите **{{ ui-key.startrek.blocks-desktop_b-filter.type-query }}** и введите [текст запроса](user/query-filter.md#query-format):

    ```
    Queue: "<название очереди>"
    ```

    Этот фильтр найдет все задачи в заданной очереди.

1. В поле **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-group-by }}** выберите **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.group-day }}** и укажите количество дней, которое будет отображаться на графике.

1. Чтобы отображать на графике общее количество созданных и решенных обращений, включите опцию **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-show-sum }}**. 

    ![](../_assets/tracker/support-widget-created-resolved.png)

1. Сохраните виджет.

### Статистика обращений по темам {#widget-components}

Если вы используете компоненты для [группировки задач по темам](#group), вы можете построить диаграмму количества задач с разными компонентами:

1. На странице дашборда нажмите ![](../_assets/tracker/icon-settings.png) → **{{ ui-key.startrek.blocks-desktop_b-page-dashboard.edit-button }}**.

1. Добавьте виджет типа **{{ ui-key.startrek.blocks-desktop_dashboard-create-zone.issues-title }}**.

1. В поле **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}** выберите **{{ ui-key.startrek.blocks-desktop_b-filter.type-query }}** и введите [текст запроса](user/query-filter.md#query-format):

    ```
    Queue: "<название очереди>"
    ```

    Этот фильтр найдет все задачи в заданной очереди.

1. В поле **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-field }}** выберите **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.field-components }}**. 

    ![](../_assets/tracker/support-widget-components.png)

1. Сохраните виджет.