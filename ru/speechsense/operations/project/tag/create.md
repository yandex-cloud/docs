# Создать тег

[Тег](../../../concepts/tags.md) можно создать только в [проекте](../../../concepts/resources-hierarchy.md#project). Для этого нужна роль `{{ roles-speechsense-admin }}` или `{{ roles-speechsense-editor }}` в проекте.

При создании тега доступны следующие варианты:

* [создать новый тег](#new-tag);
* [продублировать существующий тег](#duplicate);
* [добавить зависимый тег](#create-dependent-tag) для существующего тега.

## Создать тег {#new-tag}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. На вкладке **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** нажмите кнопку ![icon](../../../../_assets/console-icons/tag.svg) **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.
1. Укажите название тега.
1. (Опционально) Задайте описание тега.
1. (Опционально) Выберите [канал](../../../concepts/tags.md#attach) в зависимости от того, где {{ speechsense-name }} должен искать ключевые слова тега:

   * **{{ ui-key.yc-ui-talkanalytics.connections.fields.operator }}** — в речи или сообщениях оператора;
   * **{{ ui-key.yc-ui-talkanalytics.connections.fields.client }}** — в речи или сообщениях клиента.

   Вы можете выбрать один канал или оба канала.

1. {% include [select-tag-color](../../../../_includes/speechsense/tag/select-tag-color.md) %}
1. {% include [select-critical-tag](../../../../_includes/speechsense/tag/select-critical-tag.md) %}
1. В блоке **{{ ui-key.yc-ui-talkanalytics.tags.conditions }}**:

   1. В поле **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** перечислите фразы-триггеры. Каждую фразу укажите на отдельной строке. Если в диалоге присутствует фраза-триггер, этому диалогу присваивается тег.

      Вместе с перечисленными ключевыми словами вы также можете указать [словари](../../../concepts/dictionaries.md). Они содержат заранее подготовленный набор фраз-триггеров. Теги будут назначаться на диалоги, которые содержат фразы из списка в поле **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** и из указанных словарей. Чтобы использовать словари, нажмите кнопку ![icon](../../../../_assets/console-icons/book-open.svg) **{{ ui-key.yc-ui-talkanalytics.dictionaries.add-dictionary }}** и в выпадающем списке выберите нужные словари.

   1. {% include [select-exact-match](../../../../_includes/speechsense/tag/select-exact-match.md) %}
   1. {% include [specify-distance-between-words](../../../../_includes/speechsense/tag/specify-distance-between-words.md) %}

1. В блоке **{{ ui-key.yc-ui-talkanalytics.tags.exceptions }}**:

   1. В поле **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** перечислите [фразы-исключения](../../../concepts/tags.md#exclusion-phrases). Каждую фразу укажите на отдельной строке. Если в диалоге присутствует фраза-исключение, тег не срабатывает.

      {% cut "Пример" %}

      Например, создадим тег `Пожар` и добавим в него ключевую фразу `загорелась`.
      Тег сработает на фразе `Лампочка загорелась красным`, однако такая фраза не обозначает пожар. Это ложное срабатывание. Чтобы избавиться от него, добавим фразу-исключение `лампочка загорелась`.
      Теперь тег не сработает на фразе `Лампочка загорелась красным`, но сработает на фразе `Загорелся утюг`.

      {% endcut %}

      Вместе с перечисленными фразами вы также можете указать словари. Теги не будут назначаться на диалоги, которые содержат фразы из списка и из указанных словарей. Чтобы использовать словари, нажмите кнопку ![icon](../../../../_assets/console-icons/book-open.svg) **{{ ui-key.yc-ui-talkanalytics.dictionaries.add-dictionary }}** и в выпадающем списке выберите нужные словари.

   1. (Опционально) Выберите опцию **{{ ui-key.yc-ui-talkanalytics.tags.exact-match-key-value }}**.

      При поиске по диалогу {{ speechsense-name }} находит как ключевую фразу, так и родственные слова. Например, если в поле **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}** написать «отказ», {{ speechsense-name }} не присвоит тег диалогам со словами «отказался», «отказавшийся» и т. д. Если нужно игнорировать только конкретные фразы, включите опцию **{{ ui-key.yc-ui-talkanalytics.tags.exact-match-key-value }}**.

   1. (Опционально) В поле **{{ ui-key.yc-ui-talkanalytics.tags.words-between-key-value }}** укажите разрыв между словами во фразе-исключении, который допустим при поиске.

1. В блоке **{{ ui-key.yc-ui-talkanalytics.tags.binding-events-key-value }}** добавьте и настройте [ограничения тега](../../../concepts/tags.md#tag-limitations).

   Если выбрано ограничение **{{ ui-key.yc-ui-talkanalytics.tags.binding-events.silence-key-value }}**, задайте длительность паузы в секундах.

   Для каждого ограничения вы можете задать направление поиска и ограничить область поиска. По умолчанию размер области поиска максимальный — 1000 фраз.

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.

После создания тег активируется автоматически.

## Продублировать тег {#duplicate}

При дублировании настройки исходного тега присваиваются новому тегу, после чего можно изменить нужные настройки. Это удобно, если хотите создать тег с настройками, похожими на настройки созданного ранее тега.

Чтобы продублировать тег:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}**.
1. {% include [duplicate](../../../../_includes/speechsense/tag/duplicate.md) %}
1. {% include [change-settings-when-duplicating](../../../../_includes/speechsense/tag/change-settings-when-duplicating.md) %}
1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.

## Создать зависимый тег {#create-dependent-tag}

Для любого тега в проекте вы можете создать [зависимый тег](../../../concepts/tags.md#dependent-tags):

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. На вкладке **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** выберите нужный тег и нажмите кнопку ![icon](../../../../_assets/console-icons/ellipsis.svg).
1. В раскрывающемся списке выберите ![icon](../../../../_assets/console-icons/link.svg) **{{ ui-key.yc-ui-talkanalytics.tags.create-dependent-tag }}**.
1. [Задайте настройки](#new-tag) тега и нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.
