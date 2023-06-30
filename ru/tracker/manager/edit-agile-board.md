# Изменить и удалить доску

## Отредактировать доску {#board-settings}

1. Перейдите на страницу доски.

1. В правой верхней части страницы нажмите кнопку ![](../../_assets/tracker/edit-agile.png).

1. Настройте основные параметры доски:

    Параметр | Описание
    -------- | --------
    **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.name }}** | Название доски.
    **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.use-ranking }}** | Если опция включена, порядок задач на доске можно менять с помощью перетаскивания.
    **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.default-queue }}** | Ключ очереди. Вы сможете создавать задачи в этой очереди прямо на странице доски.
    **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.filter-title }}** | Настройки фильтра, с помощью которого на доску автоматически добавляются задачи с заданными параметрами. Фильтр можно задать одним из способов:<br/><ul><li>На вкладке **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.filter-type-conditions }}** задайте параметры отбора.</li><li>На вкладке **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.filter-type-query }}** задайте условия при помощи языка запросов.</li></ul>
    **Тип доски** | После [создания доски](create-agile-board.md) изменить ее тип невозможно.

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin.tab-title--columns }}** и настройте внешний вид и параметры колонок доски:

    - Создать новую колонку — нажмите кнопку **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardAddColumnButton.new-column-button }}** справа от списка всех колонок доски.

    - Переименовать колонку — нажмите кнопку ![](../../_assets/tracker/button-edit.png) справа от названия колонки. Чтобы сохранить изменения, нажмите ![](../../_assets/tracker/approve-checkmark.png).

    - Изменить положение колонки на доске — перетащите колонку в нужное место.

    - Задать максимальное число задач, которое может содержаться в колонке — введите число в поле **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_columns.issues-limit }}**.

    - Изменить статусы, которым соответствуют колонки — перетащите блок со статусом из другой колонки или из списка **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_columns.status-list-title }}**.

    - Удалить статус из колонки — нажмите на значок ![](../../_assets/tracker/delete-agile-status.png) рядом с названием статуса.

    - Удалить колонку — нажмите кнопку ![](../../_assets/tracker/delete-agile-column.png).

1. Для доски типа **{{ ui-key.startrek.components_QueuePresetOnboarding.preset-name--scrum-development-preset }}** перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_poker.title }}** и [настройте шкалу оценки задач](planning-poker.md#section_scale).

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.save-btn }}**.


## Настроить внешний вид карточки {#sec_layout}

Внешний вид карточки задачи можно настроить, чтобы видеть на доске важные для вас параметры задачи или быстро искать задачи с определенными тегами и компонентами по цветам.

#### Выбрать поля задачи {#card_fields}

По умолчанию на карточке задачи отображаются значения обязательных полей: ключ, название, исполнитель и некоторые другие. Чтобы настроить отображение дополнительных полей на карточке задачи:

1. На странице доски в правом верхнем углу нажмите кнопку ![](../../_assets/tracker/edit-agile.png).

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.title }}**.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.action_add-field }}** и выберите поля задачи, которые нужно добавить на карточку.

    Пример карточки задачи с добавленными полями отображается в правом верхнем углу страницы.

1. Чтобы удалить дополнительное поле с карточки, справа от названия поля нажмите значок ![](../../_assets/tracker/delete-agile-column.png).

    Чтобы удалить все дополнительные поля, внизу страницы нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.action_remove-all }}**.

    Обязательные поля удалить нельзя.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.save-btn }}**.

#### Выделить цветом теги и компоненты

Чтобы задачи с определенными тегами и компонентами были хорошо заметны на доске, вы можете настроить выделение тегов и компонентов цветными ярлыками:

1. На странице доски в правом верхнем углу нажмите кнопку ![](../../_assets/tracker/edit-agile.png).

1. Перейдите на вкладку **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.title }}**.

1. Чтобы настроить цветные ярлыки для тегов: 

    1. [Добавьте](#card_fields) поле **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.field-tags }}**, если его нет в списке.

    1. Под полем **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.field-tags }}** нажмите **{{ ui-key.startrek.blocks-desktop_st-tokens-chooser.choose-from-list-button }}**.

    1. Во всплывающем окне начните вводить название тега. Появится список найденных тегов.

    1. В списке выберите теги, которые вы хотите отмечать цветными ярлыками. Для выбранных тегов будут автоматически назначены цвета.

    1. Чтобы изменить цвет тега, на ярлыке нажмите значок ![](../../_assets/tracker/edit-tag.png) и выберите цвет. 

    1. Чтобы удалить цветной тег, на ярлыке нажмите значок ![](../../_assets/tracker/edit-tag.png) и выберите **{{ ui-key.startrek.blocks-desktop_st-color-tokens.delete-btn }}**.

    Пример карточки задачи с цветными тегами отображается в правом верхнем углу страницы.

1. Настройте цветные ярлыки для компонентов так же, как для тегов.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.save-btn }}**.

## Удалить доску {#section_qfj_wz1_cgb}

Если доска задач вам больше не нужна, вы можете ее удалить. При этом все задачи, которые были на доске, сохраняются.

* Доску может удалить только ее создатель. Если он уволится, доску можно переименовать.

* Нельзя удалить техническую доску, созданную служебным аккаунтом.

Чтобы удалить доску:

1. Перейдите на страницу доски.

1. В правой верхней части страницы нажмите кнопку ![](../../_assets/tracker/edit-agile.png).

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.delete-btn }}** в нижней части страницы.

1. Подтвердите удаление.




