---
title: Отчеты в {{ datalens-full-name }}
description: Из статьи вы узнаете, что такое отчеты в {{ datalens-full-name }} и ознакомитесь с особенностями виджетов отчета.
---

# Отчеты в {{ datalens-name }}


{% include [business-note](../../_includes/datalens/datalens-functionality-available-business-note.md) %}


_Отчет_ — это многостраничный документ заданного формата, который можно использовать в качестве интерактивной презентации, а также экспортировать в PDF и распечатать. На страницы отчета можно добавлять [чарты](../concepts/chart/index.md), [текстовые блоки](../dashboard/widget.md#text), [заголовки](../dashboard/widget.md#title) и изображения.

Чтобы посмотреть пример отчета, разверните [демонстрационный дашборд](https://datalens.yandex.cloud/marketplace/f2eui5ar8omalpcg1j3r) из {{ datalens-short-name }} {{ marketplace-short-name }}. В развернутом воркбуке будет доступен пример отчета. Для вдохновения готовыми отчетами присоединяйтесь к [сообществу](https://t.me/YandexDataLens/113821/117093) в Telegram.

![report-page](../../_assets/datalens/report/demo_report.png)

В конструкторе отчетов выделяют следующие элементы:

1. Область предпросмотра страниц отчета. Здесь можно управлять страницами отчета: [добавлять, перемещать или удалять их](./report-operations.md#report-pages). Чтобы свернуть область предпросмотра, нажмите значок ![image](../../_assets/console-icons/arrow-left-from-line.svg). Вместо страниц будут отображаться их порядковые номера. Чтобы развернуть область предпросмотра и отобразить страницы, нажмите значок ![image](../../_assets/console-icons/arrow-right-to-line.svg).
1. Панель для [добавления виджетов](./report-operations.md#add-widget) в отчет.
1. Основные элементы управления:

   * ![icon](../../_assets/console-icons/gear.svg) **Настройки отчёта** — открывает окно [настроек отчета](./report-operations.md#report-settings).
   * ![icon](../../_assets/console-icons/play.svg) **Предпросмотр** — открывает полноэкранный режим просмотра отчета в формате документа или презентации.
   * Кнопка **Экспорт** — экспортирует отчет в формате `.pdf`.
   * Кнопка **Сохранить** — сохраняет отчет.
   * ![icon](../../_assets/console-icons/arrows-rotate-right.svg) — обновляет чарты отчета с примененными параметрами только на текущей странице.
   * ![icon](../../_assets/console-icons/hand-stop.svg) — перемещает станицу отчета относительно экрана. После повторного нажатия возвращает в режим перемещения виджетов.
   * ![icon](../../_assets/console-icons/magnifier-minus.svg) — уменьшает масштаб отображения отчета.
   * ![icon](../../_assets/console-icons/magnifier-plus.svg) — увеличивает масштаб отображения отчета.
   * ![icon](../../_assets/console-icons/square-dashed.svg) — сбрасывает масштаб отображения отчета и располагает его в центре экрана.
   * ![icon](../../_assets/console-icons/gear.svg) — открывает окно [настроек текущей страницы](./report-operations.md#page-settings).
   * ![icon](../../_assets/console-icons/funnel.svg) — открывает окно [настройки селекторов](./report-operations.md#add-selector) отчета.

1. Область для работы с содержимым текущей страницы отчета.

   ![report-page](../../_assets/datalens/report/report-page.png)

## Особенности виджетов отчета {#report-widget-features}

Поведение и настройки виджетов отчета отличаются от [виджетов дашборда](../dashboard/widget.md):

* Высота виджета задается в окне редактирования отчета. Автоматическая настройка высоты не поддерживается.
* Виджеты можно накладывать друг на друга, [перемещать их на передний или задний план](./report-operations.md#move-widget-front-or-back).
* Для любого виджета можно задать фон.
* При вставке скопированного с дашборда виджета для него устанавливаются настройки по умолчанию.
* В чартах не поддерживаются вкладки и настройка фильтрации.

#### Что дальше {#see-also}

* [{#T}](./report-operations.md)
