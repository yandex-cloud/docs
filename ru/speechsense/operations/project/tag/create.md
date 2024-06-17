# Создать тег проекта

Для создания [тега](../../../concepts/tags.md) проекта нужна роль `{{ roles-speechsense-admin }}` или `{{ roles-speechsense-editor }}` в проекте. Тег можно [создать с нуля](#new-tag) или [продублировать](#duplicate) уже существующий.

## Создать тег проекта {#new-tag}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. На вкладке **Теги** нажмите кнопку ![icon](../../../../_assets/console-icons/tag.svg) **Создать тег**.
1. Укажите название тега.
1. (Опционально) Задайте описание тега.
1. {% include [select-tag-color](../../../../_includes/speechsense/tag/select-tag-color.md) %}
1. {% include [select-critical-tag](../../../../_includes/speechsense/tag/select-critical-tag.md) %}
1. {% include [specify-keywords](../../../../_includes/speechsense/tag/specify-keywords.md) %}
1. {% include [select-exact-match](../../../../_includes/speechsense/tag/select-exact-match.md) %}
1. {% include [specify-distance-between-words](../../../../_includes/speechsense/tag/specify-distance-between-words.md) %}
1. (Опционально) Выключите опцию **Активировать тег**. По умолчанию она включена.

   Активированный тег применяется ко всем новым диалогам, загруженным в проект после активации тега.

1. Нажмите кнопку **Создать тег**.

Поиск ключевых фраз может производиться не только по всему диалогу, но и в рамках отдельного канала: оператора или клиента. Чтобы {{ speechsense-name }} находил ключевые слова и привязывал теги в нужном канале, укажите его для нового тега:

1. В строке тега нажмите ![icon](../../../../_assets/console-icons/ellipsis.svg), затем ![icon](../../../../_assets/console-icons/arrow-right-arrow-left.svg) **Изменить канал**.
1. Укажите канал в зависимости от того, где {{ speechsense-name }} должен искать ключевые слова тега:

   * **Оператор и клиент** — во всем диалоге;
   * **Оператор** — только в речи или сообщениях оператора;
   * **Клиент** — только в речи или сообщениях клиента.

1. Нажмите кнопку **Сохранить**.

## Продублировать тег проекта {#duplicate}

При дублировании настройки исходного тега присваиваются новому тегу, после чего можно изменить нужные настройки. Это удобно, если хотите создать тег с настройками, похожими на настройки созданного ранее тега.

Чтобы продублировать тег проекта:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. Перейдите на вкладку **Теги**.
1. {% include [duplicate](../../../../_includes/speechsense/tag/duplicate.md) %}
1. {% include [change-settings-when-duplicating](../../../../_includes/speechsense/tag/change-settings-when-duplicating.md) %}
1. Нажмите кнопку **Создать тег**.
1. [Укажите канал тега](change.md#tag-channel).
