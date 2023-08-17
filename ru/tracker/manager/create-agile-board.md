# Как создать доску в {{ tracker-name }}

Чтобы создать доску:

1. На верхней панели {{ tracker-name }} выберите **{{ ui-key.startrek.blocks-desktop_m-head.menu-agile }}** → **{{ ui-key.startrek.blocks-desktop_b-head.new-agile-board }}**.

1. Выберите тип доски:

    - **{{ ui-key.startrek.blocks-desktop_agile-form-modal.board-type--default }}** доска позволяет распределить задачи по колонкам в зависимости от их статуса.

        Выберите эту доску, если раньше вы не использовали Agile-инструменты и хотите попробовать.
		
		{% note info %}
		
		Чтобы создать доску задач с новым интерфейсом, включите опцию **{{ ui-key.startrek.blocks-desktop_agile-form-modal.new-board-ad-control }}**. О работе с новой версией досок читайте в разделе [{#T}](agile-new.md).
		
		{% endnote %}

    - Доска **{{ ui-key.startrek.blocks-desktop_onboarding-form.template-1 }}**, помимо отображения статусов задач, включает инструменты для управления [спринтами](agile.md#dlen_sprint), [оценки сложности задач](planning-poker.md) и [диаграмму сгорания задач](agile.md#dlen_burndown).

        Выберите эту доску, если работаете по методологии Скрам.

    - Доска **{{ ui-key.startrek.blocks-desktop_agile-form-modal.board-type--kanban }}** — похожа на простую доску, но все задачи в статусе **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.issue-status-open }}** автоматически попадают в колонку [**{{ ui-key.startrek.ui_components_agile_backlog_BacklogIssue.backlog-default-column }}**](agile.md#dlen_backlog).

        Выберите эту доску, если ваша команда работает с большим потоком задач, например в службе поддержки.

    {% note alert %}

    После создания доски изменить ее тип невозможно.

    {% endnote %}

1. Укажите название доски.

1. Чтобы на доску автоматически попадали задачи с определенными параметрами, включите опцию **Добавлять задачи автоматически** и задайте условия фильтра для отбора задач, которые должны отображаться на доске. Позже условия можно будет изменить.

    Например, вы можете указать очередь, чтобы все задачи из этой очереди автоматически попадали на доску.

    {% note info %}
    
    Фильтр с локальными полями задать при создании доски нельзя. Это можно будет сделать позже, на [странице редактирования](edit-agile-board.md#board-settings) с помощью [языка запросов](../user/query-filter.md).
    
    {% endnote %}

    Если не включить опцию **Добавлять задачи автоматически**, задачи на доску нужно будет [добавлять вручную](../user/agile.md#add-tasks).



1. Укажите очередь для создания задач. Это позволит быстро создавать задачи в этой очереди прямо на странице доски.

1. Нажмите кнопку **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.submit-btn }}**. Новая доска доступна в меню **{{ ui-key.startrek.blocks-desktop_m-head.menu-agile }}** на верхней панели {{ tracker-name }}.

1. Если требуется, [настройте колонки и внешний вид карточки задачи](edit-agile-board.md).




