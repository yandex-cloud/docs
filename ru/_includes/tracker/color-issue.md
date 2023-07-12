По умолчанию все полосы задач на диаграмме отображаются в голубом цвете. Чтобы настроить для задач разные цвета:

1. Над временной шкалой справа нажмите ![](../../_assets/tracker/svg/gantt-settings-button.svg)&nbsp;**{{ ui-key.startrek.ui_components_Gantt.timeline-config }}**.
1. В блоке **{{ ui-key.startrek-backend.fields.issue.paletteColor }}** вы можете назначение цвета вручную прямо на диаграмме или настроить цвета в зависимости от параметров задачи.

   {% list tabs %}

   - Назначать вручную

     1. Отметьте пункт **{{ ui-key.startrek.ui_components_Gantt.color-type-by-manual }}**.
     1. Нажмите **{{ ui-key.startrek.blocks-desktop_b-filter.apply }}**.
     1. Выберите задачу в списке слева от диаграммы и нажмите ![](../../_assets/horizontal-ellipsis.svg) **{{ ui-key.startrek.ui_components_Gantt_IssueActionsCell.issue-action-menu-title }}**.
     1. Выберите цвет.

     ![](../../_assets/tracker/three-dots-menu.png)

   - По параметрам задачи

     1. Отметьте пункт **{{ ui-key.startrek.ui_components_Gantt.color-type-by-parameter }}**. 
     1. Укажите параметр, значениям которого вы будете назначать цвет.
     1. Нажмите **{{ ui-key.startrek.blocks-desktop_b-filter.apply }}**.

   {% endlist %}

{% note info %}

Если вы оставили цвет по умолчанию, назначение цветов в ![](../../_assets/horizontal-ellipsis.svg) **{{ ui-key.startrek.ui_components_Gantt_IssueActionsCell.issue-action-menu-title }}** будет недоступно.

{% endnote %}
