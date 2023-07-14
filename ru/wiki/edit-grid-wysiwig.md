# Отредактировать таблицу в новом редакторе

## Общие настройки {#general-settings}

Чтобы изменить [таблицу](pages-types.md#grid), откройте ее и в правом верхнем углу нажмите кнопку ![](../_assets/wiki/svg/wysiwyg/grid-settings.svg) **{{ ui-key.yacloud.common.table-config }}**. Выберите действие:

  * [Настроить столбцы](#column-transfer);
  * [Сортировка по умолчанию](#sort-line);
  * Копировать код вставки;
  * Загрузить данные из файла:
    * в формате CSV; 
    * в формате TXT.
  * Скачать таблицу: 
    * в формате XLS;
    * в формате DOCX; 
    * в формате CSV.
  * Удалить таблицу.

## Редактировать содержимое ячеек таблицы {#edit-cell}

{% include [edit table cells](../_includes/edit-cells.md) %}

Каждый раз, когда вы сохраняете таблицу, ее копия помещается в [историю изменений](history.md). С помощью истории вы всегда сможете просмотреть все прежние версии таблицы, сравнить их друг с другом или вернуться к любой из них.

## Настроить параметры столбцов таблицы {#column-params}

1. В верхней ячейке столбца нажмите значок ![](../_assets/wiki/svg/actions-icon.svg) и выберите ![](../_assets/wiki/svg/grid-settings.svg) **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-options.settings }}**. 

1. Во всплывающем окне измените параметры столбца:

   * В поле сверху введите **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-widget.name }}** столбца.
    
    * Поле **Уникальный идентификатор** заполнится автоматически. При необходимости вы можете изменить его вручную.

    * В раскрывающемся списке выберите допустимый [тип данных](#data-types) для ячеек столбца. После сохранения тип данных изменить нельзя.

    * В поле **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-code-form.width }}** укажите ширину столбца или оставьте значение по умолчанию — `{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-width-controll.auto }}`.

    * Чтобы добавить описание столбца, нажмите **Добавить описание**. Чтобы увидеть описание столбца, наведите указатель на значок ![](../_assets/wiki/svg/column-description.svg). Текст появится во всплывающем окне.
    
    * Чтобы сделать ячейки столбца обязательными к заполнению, включите опцию **Обязательный для заполнения**.

    * Для столбцов с типом данных **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.checkbox }}** включите опцию **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.mark_made }}**. В этом случае строки, отмеченные чекбоксом, отображаются серыми.
    
1. Нажмите кнопку **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-settings.save }}**, чтобы сохранить изменения.

Чтобы изменить ширину столбца, зажмите боковую границу и переместите влево или вправо. Изменение ширины отобразится сразу у всех пользователей, которые просматривают таблицу в данный момент.

{% note info %}

Минимальное значение ширины столбца составляет 200 px.

{% endnote %}

## Переместить столбец внутри таблицы {#column-transfer}

Чтобы переместить столбец:

1. В правом верхнем углу таблицы нажмите значок ![](../_assets/wiki/svg/grid-settings.svg).

1. В настройках таблицы выберите ![](../_assets/wiki/svg/table-settings.svg) **Настроить столбцы**.

1. В списке выберите название столбца, нажмите значок ![](../_assets/wiki/svg/moving.svg) и перетащите. Выбрать несколько столбцов для переноса нельзя.

## Добавить и удалить столбцы {#edit-column}

Чтобы добавить столбец:

1. В правом верхнем углу таблицы нажмите значок ![](../_assets/wiki/svg/add.svg).

1. Настройте параметры столбца:
    
    * В поле сверху введите **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-widget.name }}** столбца.
    
    * Поле **Уникальный идентификатор** заполнится автоматически. При необходимости вы можете изменить его вручную.

    * В раскрывающемся списке выберите допустимый [тип данных](#data-types) для ячеек столбца. После сохранения тип данных изменить нельзя.

    * В поле **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-code-form.width }}** укажите ширину столбца или оставьте значение по умолчанию — `{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-width-controll.auto }}`.

    * Чтобы добавить описание столбца, нажмите **Добавить описание**. Чтобы увидеть описание столбца, наведите указатель на значок ![](../_assets/wiki/svg/column-description.svg). Текст появится во всплывающем окне.
    
    * Чтобы сделать ячейки столбца обязательными к заполнению, включите опцию **Обязательный для заполнения**.

    * Для столбцов с типом данных **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.checkbox }}** включите опцию **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.mark_made }}**. В этом случае строки, отмеченные чекбоксом, отображаются серыми.

1. Выберите **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.add }}**.

Чтобы удалить столбец:

1. В верхней ячейке столбца нажмите значок ![](../_assets/wiki/svg/actions-icon.svg).

1. Нажмите кнопку **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-options.delete }}**.

### Типы данных {#data-types}

Укажите тип данных для ячеек в столбце таблицы:

* ![](../_assets/wiki/svg/type-text.svg) **Текст с форматированием**. Любой текст, оформленный с помощью [разметки Markdown](basic-markup.md).

* ![](../_assets/wiki/svg/type-number.svg) **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.number }}**. 

* ![](../_assets/wiki/svg/type-checkbox.svg) **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.checkbox }}**. Поле, в котором можно поставить отметку. Чтобы отметить всю строку, включите опцию **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.mark_made }}**. В этом случае строки, отмеченные чекбоксом, отображаются серыми.

* ![](../_assets/wiki/svg/type-date.svg) **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.date }}**.

* ![](../_assets/wiki/svg/type-list.svg) **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.list }}**. Поле для выбора одного значения из предложенных вариантов.

    Чтобы выбрать множественный список, включите опцию **Разрешить выбор нескольких вариантов**.

* ![](../_assets/wiki/svg/type-employee.svg) **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.employee }}**. Имя и фамилия сотрудника.
    
    Чтобы выбрать несколько сотрудников, включите опцию **Разрешить добавление нескольких пользователей**.

* ![](../_assets/wiki/svg/type-tracker.svg) **Задача в {{ tracker-name }}**. Ключ задачи, который будет работать как ссылка в {{ tracker-name }}.

* ![](../_assets/wiki/svg/type-task-parameters.svg) **Параметры задачи**. Параметры, отображаемые для типа данных ![](../_assets/wiki/svg/type-tracker.svg) **Задача в {{ tracker-name }}**.

{% note alert %}

Тип данных можно выбрать только при создании столбца. 

{% endnote %}

## Добавить и удалить строки {#edit-line}

* Чтобы создать новую строку, внизу таблицы нажмите ![](../_assets/wiki/svg/add.svg) **{{ ui-key.yacloud.component.table-input.popup_title }}**.

* Чтобы удалить строку, наведите на нее курсор и нажмите значок ![](../_assets/wiki/svg/delete-line.svg) **Удалить строку**.

## Переименовать таблицу {#rename-tab}

Чтобы переименовать таблицу, нажмите на название таблицы и введите новое.

## Отсортировать строки таблицы {#sort-line}

Чтобы отсортировать строки таблицы:
    
1. В верхней ячейке столбца нажмите ![](../_assets/wiki/svg/actions-icon.svg).

1. Выберите **Сортировать по убыванию** или **Сортировать по возрастанию**.

Чтобы добавить несколько фильтров:

1. В правом верхнем углу таблицы нажмите кнопку ![](../_assets/wiki/svg/wysiwyg/grid-settings.svg) **{{ ui-key.yacloud.common.table-config }}**.

1. Нажмите кнопку **Сортировка по умолчанию**.

1. Нажмите кнопку **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.add }}**:

1. В выпадающем списке выберите столбец и тип сортировки: **Сортировать по убыванию** или **Сортировать по возрастанию**.

1. Нажмите кнопку **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-settings.save }}**.

1. Добавьте остальные фильтры и нажмите кнопку **{{ ui-key.yacloud.common.apply }}**. В правом верхнем углу над таблицей появится кнопка **Настроена сортировка**.

Чтобы задать порядок сортировки, в списке фильтров нажмите значок ![](../_assets/wiki/svg/moving.svg) и перетащите. Выбрать несколько фильтров для переноса нельзя.


#### См. также

* [{#T}](create-grid.md)

* [{#T}](add-grid.md)

* [{#T}](import-page.md)
