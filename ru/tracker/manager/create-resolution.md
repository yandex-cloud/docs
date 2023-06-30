# Настроить резолюции

Резолюция — это атрибут задачи, который обозначает причину ее закрытия. Например, задача может быть закрыта, потому что она выполнена (резолюция <q>{{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }}</q>) или потому что она дублирует другую задачу (резолюция <q>{{ ui-key.startrek-backend.applinks.samsara.resolution.duplicate }}</q>).


## Создать резолюцию {#create-resolution}

{% note warning %}

Создавать новые резолюции может только [администратор](../role-model.md). Созданную резолюцию нельзя удалить или отредактировать.

{% endnote %}

По умолчанию в {{ tracker-name }} доступны наиболее популярные резолюции. Если подходящей резолюции среди них нет, создайте новую:

1. Убедитесь, что вы авторизованы в {{ tracker-full-name }} как [администратор](../role-model.md).

1. На панели справа выберите ![](../../_assets/tracker/svg/admin.svg) **{{ ui-key.startrek.blocks-desktop_b-page-queue.cp }}** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.tracker-settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_page-admin.tab-title--resolutions }}**.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_page-admin-tab.create--resolutions }}**.

1. Заполните поля и нажмите **{{ ui-key.startrek.blocks-desktop_b-form-new-component.button-create }}**.


## Удалить резолюцию из очереди {#delete-resolution}

{% note warning %}

Нельзя удалить резолюцию, если в очереди есть задачи, которые ее используют. 

{% endnote %}

1. С помощью фильтров [найдите все задачи очереди](quick-filters.md), которые содержат удаляемую резолюцию. Затем поменяйте для задач резолюцию или измените их статус.  

1. Откройте страницу очереди.

1. В верхнем правом углу нажмите ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--types }}**.

1. Удалите резолюцию в тех типах задач, где резолюция выбрана.