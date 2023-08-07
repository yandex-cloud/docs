По умолчанию полосы задач на диаграмме раскрашены по цветам в зависимости от типа статуса задачи, который настраивается в [редакторе рабочих процессов](../../tracker/manager/workflow.md). 

![](../../_assets/tracker/color-by-type.png)

Чтобы выбрать другую цветовую схему:

1. Над временной шкалой справа нажмите ![](../../_assets/tracker/svg/gantt-settings-button.svg)&nbsp;**{{ ui-key.startrek.ui_components_Gantt.timeline-config }}**.
1. В блоке **{{ ui-key.startrek-backend.fields.issue.paletteColor }}** вы можете выбрать подходящий вариант цветовой схемы:

   {% list tabs %}

   - Назначать вручную
     
     С помощью этой опции вы сможете назначать цвета для задач прямо на диаграмме.

     1. Выберите **{{ ui-key.startrek.ui_components_Gantt.color-type-by-manual }}**.
     1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-filter.apply }}**.

     В списке слева от диаграммы выберите задачу и нажмите кнопку ![](../../_assets/horizontal-ellipsis.svg) **{{ ui-key.startrek.ui_components_Gantt_IssueActionsCell.issue-action-menu-title }}**. Откроется палитра, из которой вы сможете назначить задаче цвет.

     ![](../../_assets/tracker/three-dots-menu.png)

   - По параметрам задачи

     Опция пригодится, если нужно различать задачи по некоторому параметру, например, очереди или тегу.

     1. Выберите **{{ ui-key.startrek.ui_components_Gantt.color-type-by-parameter }}**. 
     1. Укажите параметр, значениям которого вы будете назначать цвет.
     1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-filter.apply }}**.
  
   - Однотонный

     Полосы всех задач на диаграмме будут отображаться в голубом цвете.

     1. Выберите **{{ ui-key.startrek.ui_components_Gantt.color-type-monochrome }}**.
     1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-filter.apply }}**.

   {% endlist %}
