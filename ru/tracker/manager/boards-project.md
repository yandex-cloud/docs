# Доска задач

Каждый проект в {{ tracker-name }} имеет доску задач типа <q>{{ ui-key.startrek.blocks-desktop_agile-form-modal.board-type--default }}</q>. Такая доска позволяет распределить задачи по колонкам в зависимости от их статуса, но не поддерживает такие [методологии Agile](../glossary.md#rus-g), как Скрам и Канбан.

Чтобы перейти к доске задач проекта:

1. На панели слева в разделе ![](../../_assets/tracker/svg/project.svg)&nbsp;**{{ ui-key.startrek.blocks-desktop_b-queues-info.projects }}** выберите проект.

1. Перейдите на вкладку **{{ ui-key.startrek.ui_components_projects_HeaderTabs.board-tab }}**.

{% note info %}

Вы также можете открыть доску задач проекта в разделе ![](../../_assets/tracker/svg/boards.svg) **{{ ui-key.startrek.ui_components_NavigationBar.boards }}** на панели слева. По умолчанию такая доска имеет название <q>Доска проекта `<название проекта>`</q>.

{% endnote %}

## Создать доску проекта {#create-board}

Доска задач проекта создается автоматически при создании проекта. Если в проекте нет доски задач (например, когда она была [удалена](#delete-board) вручную), вы можете ее создать:

1. На странице проекта в правом верхнем углу нажмите ![](../../_assets/horizontal-ellipsis.svg) **{{ ui-key.startrek.ui_components_ProjectMenu.title }}**.

1. Выберите **{{ ui-key.startrek.ui_components_ProjectMenu.create-board }}**.

Подробнее о всех доступных операциях читайте в разделах [{#T}](./agile-new-set-board.md) и [{#T}](./agile-new-issues.md).

## Добавить задачи на доску {#add-tickets}

Все задачи проекта автоматически отображаются на доске, связанной с этим проектом. Вы можете добавить задачи на доску одним из способов:

* [Добавить задачу на доску проекта](./agile-new-set-board.md#add-task). 

* [Добавить задачу в проект](./create-project.md#add-tickets).

{% note info %}

Если добавить задачу на доску проекта, она автоматически будет добавлена в проект. Если удалить задачу с доски проекта, она также будет удалена из проекта.

{% endnote %}

## Удалить доску {#delete-board}

Чтобы удалить доску проекта:

1. На странице проекта в правом верхнем углу нажмите ![](../../_assets/horizontal-ellipsis.svg) **{{ ui-key.startrek.ui_components_ProjectMenu.title }}**.

1. Выберите **{{ ui-key.startrek.ui_components_ProjectMenu.remove-board }}**.

