# Управление привязками

[Привязки](../concepts/glossary.md#binding) содержат информацию о соединении, формате и схеме данных. В одном запросе можно использовать несколько разных привязок.

## Создать привязку {#create}

Чтобы создать привязку:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать привязку.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-binding-add.create-binding.button-text }}**.
1. В блоке **{{ ui-key.yql.yq-binding-form.connection-parameters.title }}**:
   1. Выберите тип соединения, для которого нужно создать привязку: `{{ ui-key.yql.yq-connection.action_datastreams }}` или `{{ ui-key.yql.yq-connection.action_object-storage }}`.
   1. Выберите или создайте новое соединение.
1. В блоке **{{ ui-key.yql.yq-binding-form.binding-parameters.title }}**:
   1. Введите имя и описание привязки. Требования к имени:

      {% include [name-format](../_includes/connection-name-format.md) %}

   1. Для типа соединения {{ yds-short-name }} выберите или создайте новый поток данных.
      Для типа соединения {{ objstorage-short-name }} укажите путь к бакету.
   1. (Опционально) Выберите алгоритм сжатия.
   1. Выберите формат привязки к данным.
   1. Добавьте колонки:
      * Введите имя колонки.
      * Выберите тип колонки.
      * При необходимости включите опцию **{{ ui-key.yql.yq-binding-form.field-type-required.title }}**.
1. Нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.

## Получить информацию о привязке {#get-info}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создана привязка.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
1. В строке с именем нужной привязки нажмите кнопку ![info](../../_assets/console-icons/circle-info.svg).
   Под списком привязок появится информация о нужной привязке:
   **{{ ui-key.yql.yq-binding-info.general.section-header }}**:

     * Пути к данным.
     * Формат данных.
     * Сжатие.

   **{{ ui-key.yql.yq-binding-form.binding-fields.title }}**: список колонок привязки к данным и их типы.

   **{{ ui-key.yql.yq-binding-info.connection-parameters.section-header }}**:

      * Тип.
      * Информация об источнике.
      * Аутентификация.

   **{{ ui-key.yql.yq-common-meta-section.meta.section-header }}**:

      * Идентификатор.
      * Время создания.
      * Автор.

## Изменить привязку {#update}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно изменить привязку.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
1. В строке с именем нужной привязки нажмите кнопку ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yql.yq-binding-actions.edit-binding.menu-item-text }}**.
1. Укажите новые параметры привязки к данным. Информацию в блоке **{{ ui-key.yql.yq-binding-form.connection-parameters.title }}** изменить нельзя.
1. Нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-modify.button-text }}**.

## Удалить привязку {#delete}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно удалить привязку.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
1. В строке с именем нужной привязки нажмите кнопку ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yql.yq-binding-actions.delete-binding.menu-item-text }}**.
1. Подтвердите удаление.
