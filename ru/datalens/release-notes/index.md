---
title: История изменений в {{ datalens-full-name }} в мае 2025
description: Ознакомьтесь с историей изменений в {{ datalens-full-name }} за май 2025.
---

# История изменений в {{ datalens-full-name }} в мае 2025


* [Изменения базовых возможностей](#base)
* [Изменения, доступные в тарифном плане Business](#business)

## Изменения базовых возможностей {#base}

### Экспорт и импорт воркбуков {#workbooks-export-import}

Добавили в {{ datalens-short-name }} [экспорт и импорт воркбуков](../workbooks-collections/export-and-import.md). Теперь можно переносить [воркбуки](../workbooks-collections/index.md) между инсталляциями с помощью инструментов экспорта и импорта. Например, вы сможете экспортировать готовый воркбук, с его настройками и связями, из облачного {{ datalens-full-name }} в инсталляцию [open source](https://datalens.tech).

### {{ datalens-short-name }} Gallery {#gallery}

Добавили [раздел]({{ link-datalens-main }}/gallery) с готовыми дашбордами для вдохновения и решения бизнес-задач. Примеры понравившихся работ можно развернуть у себя — и не только в облаке, но и в любом окружении, даже внутри корпоративного контура.




### Изменения в чартах {#charts-changes}

В [визарде](../concepts/chart/dataset-based-charts.md) и [QL-чартах](../concepts/chart/ql-charts.md) добавили [настройку](../concepts/chart/settings.md#common-settings) для [сохранения пробелов и переносов](../visualization-ref/table-chart.md#spaces-and-line-breaks) строк в таблице.

### Изменения в интерфейсе {#interface-changes}

Обновили внешний вид страницы [выбора тарифного плана](../settings/service-plan.md#change-service-plan) с описанием возможностей.

### Старт в {{ datalens-short-name }} {#start-video}

Устранили проблему просмотра ознакомительного видео, доступного при нажатии на панели слева ![image](../../_assets/console-icons/circle-question.svg) → **Старт в {{ datalens-short-name }}**.


### Исправления в чартах {#charts-fixes}



Исправили переносы заголовков и значений в столбцах [таблицы](../visualization-ref/table-chart.md) для некоторых браузеров.


### Изменения в виджетах {#widget-changes}

* Добавили автофокус на поле ввода текста для виджетов [Заголовок](../dashboard/widget.md#title) и [Текст](../dashboard/widget.md#text) при добавлении или редактировании виджетов на [дашборде](../concepts/dashboard.md).
* В визуальном редакторе в текстовых виджетах дашборда и в чартах [Markdown](../charts/editor/widgets/markdown.md) в Editor добавили кнопку копирования в буфер обмена содержимого [блока кода](../dashboard/markdown.md#code).

### Отмена и восстановление изменений в дашбордах {#undo-redo}

При редактировании [дашборда](../concepts/dashboard.md) теперь можно отменить или повторно выполнить внесенные изменения в пределах текущей версии:

* для отмены изменений нажмите значок ![image](../../_assets/console-icons/arrow-uturn-ccw-left.svg) в верхней правой части экрана или сочетание клавиш **Ctrl** (**Cmd**) + **Z**;
* для восстановления изменений нажмите значок ![image](../../_assets/console-icons/arrow-uturn-cw-right.svg) или сочетание клавиш **Ctrl** (**Cmd**) + **Shift** + **Z**.


## Изменения, доступные в тарифном плане Business {#business}

### Изменения в Editor {#editor-changes}

* В [Advanced-чарт](../charts/editor/widgets/advanced.md) добавили метод [Editor.updateParams](../charts/editor/methods.md#update-params).
* Добавили дополнительные атрибуты и теги для метода [Editor.generateHtml](../charts/editor/methods.md#gen-html).
* В [Markdown](../charts/editor/widgets/markdown.md) чартах в Editor теперь доступны Controls.
* Исправили диалог сравнения ревизий для чартов в Editor.

