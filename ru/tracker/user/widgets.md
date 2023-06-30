# Виджеты

Виджеты — небольшие карточки с полезной информацией. Это могут быть списки задач, статистика их выполнения, сводные таблицы или заметки. Содержимое виджетов генерируется автоматически. Список задач, на основе которого формируется виджет, задается с помощью [фильтра](create-filter.md). Примеры виджетов для дашборда службы поддержки можно найти в разделе [{#T}](../support-process-dashboards.md).

## Задачи {#tasks}

![](../../_assets/tracker/widgets/filter.png)

Виджет позволяет просматривать список задач, удовлетворяющих определенному фильтру. С помощью таких виджетов вы можете на одной странице просматривать, например, задачи определенной очереди или задачи, над которыми вы сейчас работаете.

Чтобы настроить виджет, задайте его параметры:

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.hint-name }}** — название, которое отображается в заголовке виджета.
- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-per-page }}** — количество задач, которые отображаются на одной странице виджета. Если задач окажется больше, вы сможете воспользоваться переключателем страниц в нижней части виджета.
- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}** — фильтр, на основе которого формируется список задач. Вы можете задать фильтр с помощью [прямой ссылки, имени](create-filter.md) или [языка запросов](query-filter.md).
- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-fields }}** — поля задач, которые отображаются в списке. Вы можете добавить несколько полей. Чтобы удалить поле, нажмите на значок **х**.

## {{ ui-key.startrek.blocks-desktop_dashboard-create-zone.note-title }} {#note}

![](../../_assets/tracker/widgets/note.png)

Записывайте свои идеи и делайте пометки прямо на дашборде. Вы можете делать записи простым текстом или использовать [разметку](markup.md).

## {{ ui-key.startrek.blocks-desktop_dashboard-create-zone.table-title }} {#summary-table}

![](../../_assets/tracker/widgets/table.png)

Простая сводная таблица, которая позволяет просматривать статистику задач по двум любым параметрам. На пересечениях таблицы приводится количество задач, удовлетворяющих параметрам. С помощью такой таблицы вы можете, например, отслеживать количество и статусы задач определенной группы исполнителей.

Чтобы настроить виджет, задайте его параметры:

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.hint-name }}** — название, которое отображается в заголовке виджета.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}**. Статистика собирается по задачам, удовлетворяющим определенному фильтру. Вы можете задать фильтр с помощью [прямой ссылки, имени](create-filter.md) или [языка запросов](query-filter.md).

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-x-axis }}** — параметр, по которому строятся столбцы таблицы.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-y-axis }}** — параметр, по которому строятся строки таблицы.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-on-first-page }}** — максимальное количество строк таблицы, которые отображаются в виджете. Если строк окажется больше, вы сможете воспользоваться кнопкой **{{ ui-key.startrek.ui_components_dashboard_TableWidget.show-all }}** в нижней части виджета.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-sort }}** — порядок сортировки строк таблицы.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-show-sum }}** — если опция включена, таблица содержит сумму значений по строкам и столбцам.


## {{ ui-key.startrek.blocks-desktop_dashboard-create-zone.table-sum-title }} {#summary-table-with-totals}

![](../../_assets/tracker/widgets/table-with-sum.png)

Особый вид сводной таблицы по двум параметрам. В отличие от простой сводной таблицы, на пересечениях приводится не число задач, а сумма значений третьего параметра. С помощью такой таблицы вы можете, например, отслеживать время, которое исполнители затратили на работу над различными компонентами очереди.

Чтобы настроить виджет, задайте его параметры:

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.hint-name }}** — название, которое отображается в заголовке виджета.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}**. Статистика собирается по задачам, удовлетворяющим определенному фильтру. Вы можете задать фильтр с помощью [прямой ссылки, имени](create-filter.md) или [языка запросов](query-filter.md).

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-x-axis }}** — параметр, по которому строятся столбцы таблицы.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-y-axis }}** — параметр, по которому строятся строки таблицы.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-sum }}** — параметр, сумма значений которого приводится на пересечениях.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-on-first-page }}** — максимальное количество строк таблицы, которые отображаются в виджете. Если строк окажется больше, вы сможете воспользоваться кнопкой **{{ ui-key.startrek.ui_components_dashboard_TableWidget.show-all }}** в нижней части виджета.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.sort-row }}** — порядок сортировки строк таблицы.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.sort-column }}** — порядок сортировки столбцов таблицы.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-show-sum }}** — если опция включена, таблица содержит сумму значений по строкам и столбцам.


## {{ ui-key.startrek.blocks-desktop_dashboard-create-zone.time-since-title }} {#events}

![](../../_assets/tracker/widgets/events.png)

На графике отображается статистика _событий_, произошедших с задачами за определенный период времени. Вы можете выбрать одно из событий:

- Работа над задачей завершена. Событие определяется по параметру **{{ ui-key.startrek-backend.fields.issue.end-key-value }}**.

- Работа над задачей начата. Событие определяется по параметру **{{ ui-key.startrek-backend.fields.issue.start-key-value }}**.

- Последнее обновление задачи.

- Последний комментарий под задачей.

- Задача переведена в статус **{{ ui-key.startrek-backend.applinks.samsara.status.resolved }}**.

- Задача создана.

Чтобы настроить виджет, задайте параметры:

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.hint-name }}** — название, которое отображается в заголовке виджета.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}**. Статистика собирается по задачам, удовлетворяющим определенному фильтру. Вы можете задать фильтр с помощью [прямой ссылки, имени](create-filter.md) или [языка запросов](query-filter.md).

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-field }}** — выберите событие, которое отслеживается в статистике.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-group-by }}** — выберите шаг и укажите период для сбора статистики.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-is-cumulative }}** — если опция включена, в каждом последующем шаге учитываются данные, накопленные за предыдущие.


## {{ ui-key.startrek.blocks-desktop_dashboard-create-zone.issues-title }} {#issues-stat}

![](../../_assets/tracker/widgets/stat.png)

Виджет отображает распределение задач по значениям определенного параметра.

Чтобы настроить виджет, задайте параметры:

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.hint-name }}** — название, которое отображается в заголовке виджета.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}**. Статистика собирается по задачам, удовлетворяющим определенному фильтру. Вы можете задать фильтр с помощью [прямой ссылки, имени](create-filter.md) или [языка запросов](query-filter.md).

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-on-first-page }}** — максимальное количество строк диаграммы, которые отображаются в виджете. Если строк окажется больше, вы сможете воспользоваться кнопкой **{{ ui-key.startrek.ui_components_dashboard_TableWidget.show-all }}** в нижней части виджета.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-field }}** — параметр задач, по которому собирается статистика.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-sort }}** — порядок сортировки столбцов диаграммы.


{% note info %}

Не рекомендуется использовать в поле **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-field }}** значение **{{ ui-key.startrek.ui_components_dashboard.summary-field-name }}**, так как виджеты с такими настройками скоро будут отключены. [Подробнее](../faq.md#section_del_widget).

{% endnote %}

## {{ ui-key.startrek.blocks-desktop_dashboard-create-zone.created-vs-resolved-title }} {#created-and-resolved}

![](../../_assets/tracker/widgets/create-resolve.png)

График позволяет сравнить количество созданных и закрытых задач. Вы можете указать период и шаг для сбора статистики.

Чтобы настроить виджет, задайте параметры:

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.hint-name }}** — название, которое отображается в заголовке виджета.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}**. Статистика собирается по задачам, удовлетворяющим определенному фильтру. Вы можете задать фильтр с помощью [прямой ссылки, имени](create-filter.md) или [языка запросов](query-filter.md).

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-group-by }}** — выберите шаг и укажите период для сбора статистики.

- **Отображать тренд** — если опция включена, под графиком отображается линия тренда.

- **Суммировать значения** — если опция включена, в каждом последующем шаге учитываются данные, накопленные за предыдущие.

- **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.versions }}** — если опция включена, на графике отображаются версии, к которым относятся задачи.


