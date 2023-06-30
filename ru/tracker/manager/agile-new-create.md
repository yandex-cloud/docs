# Как создать доску в {{ tracker-name }}

## Создать доску

Чтобы создать новую доску задач:

1. На верхней панели Tracker выберите **{{ ui-key.startrek.blocks-desktop_m-head.menu-agile }}** → **{{ ui-key.startrek.blocks-desktop_b-head.new-agile-board }}**.

   {% note info %}

   В [бета-версии нового интерфейса {{ tracker-full-name }}](../user/personal.md#sec_beta) на панели слева выберите ![](../../_assets/tracker/svg/boards.svg)&nbsp;**{{ ui-key.startrek.ui_components_NavigationBar.boards }}**, затем нажмите **{{ ui-key.startrek.blocks-desktop_page-agile-boards.create }}**.

   {% endnote %}

1. Выберите тип доски **{{ ui-key.startrek.blocks-desktop_agile-form-modal.board-type--default }}**, затем включите опцию **{{ ui-key.startrek.blocks-desktop_agile-form-modal.new-board-ad-control }}**. 

1. Введите название доски и нажмите кнопку **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.submit-btn }}**.

1. [Добавьте](./agile-new-use.md#from-board) задачи на доску:

    * Чтобы добавить первую задачу на доску, нажмите кнопку **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardEmptyScreen.empty-screen--new-issue }}**. Вы можете выбрать существующую задачу или создать новую. Добавить задачу можно из любой доступной вам очереди.

    * Чтобы добавить сразу несколько задач с определенными параметрами, используйте [фильтр](./agile-new-use.md#from-bulk) или выполните [импорт](./agile-new-use.md#import) задач.
    
        {% note info %}

		Импорт задач выполняется разово. Для обновления списка задач на доске снова выполните импорт.
		
		На доску можно добавить не более 2000 задач.

        {% endnote %}

1. Если требуется, [настройте колонки и внешний вид карточки задачи](agile-new-set.md).

## Создать доску для проекта

[Создайте проект в бета-версии нового интерфейса {{ tracker-full-name }}](./create-project.md) и добавьте в него задачи. Для такого проекта будет автоматически создана новая доска задач. Все задачи проекта будут отображаться на доске.
