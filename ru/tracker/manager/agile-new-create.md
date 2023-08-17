# Как создать доску в {{ tracker-name }}

## Создание простой доски {#basic}

**{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.board-type--simple }}** подходит любым командам и позволяет распределять задачи по колонкам в зависимости от их статуса.

Чтобы создать простую доску:

1. На панели слева нажмите **{{ ui-key.startrek.ui_components_NavigationBar.boards }}** → **{{ ui-key.startrek.blocks-desktop_page-agile-boards.create }}**.

1. Выберите тип доски **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.board-type--simple }}** и нажмите **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.submit-btn }}**. Будет создана доска с названием <q>Новая доска</q>. Это поле на доске доступно для редактирования, так что вы сможете его скорректировать и изменить название.

На доске уже добавлены несколько колонок со статусами **Открыт**, **В работе** и **Закрыт**. Можно удалить эти колонки, добавить другие или создать произвольные, не привязанные к статусам задач.

После [добавления на доску задач](agile-new-set-board.md#add-task) вы сможете настроить отображение карточек задач, группировать и фильтровать задачи, а также перемещать их между колонками. На простой доске доступно [подключение бэклога](backlog.md#add-backlog) — доска преобразуется к виду доски **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.board-type--scrum }}**. Обратный переход невозможен.

## Создание доски с бэклогом и спринтами {#backlog-and-sprints}

Доска **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.board-type--scrum }}** предназначена для Agile-команд и позволяет формировать [бэклог](backlog.md), управлять [спринтами](create-agile-sprint.md), [оценивать сложность задач](poker.md) и анализировать [диаграмму сгорания задач](burndown-diagram.md).

Чтобы создать доску с бэклогом и спринтами:

1. На панели слева нажмите **{{ ui-key.startrek.ui_components_NavigationBar.boards }}** → **{{ ui-key.startrek.blocks-desktop_page-agile-boards.create }}**.

1. Выберите тип доски **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.board-type--scrum }}** и нажмите **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.submit-btn }}**. Будет создана доска с названием <q>Новая доска</q>. Это поле на доске доступно для редактирования, так что вы сможете его скорректировать и изменить название.

Доска состоит из трех вкладок:
* Бэклог — чтобы сформировать бэклог задач и создавать спринты;
* Доска — для распределения задач из бэклога [по статусам](agile-new-columns.md#status) или [произвольным колонкам](agile-new-columns.md#user-columns) (эта вкладка аналогична **Простой доске**);
* Диаграмма сгорания — показывает скорость выполнения задач и оставшийся объем работы в течение спринта.

После [добавления задач в бэклог](backlog.md#add-new-backlog) вы сможете планировать спринты, настраивать отображение карточек задач, группировать и фильтровать задачи на доске, а также анализировать скорость выполнения задач.
