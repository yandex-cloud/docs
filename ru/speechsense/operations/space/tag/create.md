# Создать тег пространства

Для создания [тега](../../../concepts/tags.md) пространства нужна роль `{{ roles-speechsense-admin }}` или `{{ roles-speechsense-editor }}` в пространстве. Тег можно [создать с нуля](#new-tag) или [продублировать](#duplicate) уже существующий.

## Создать тег пространства {#new-tag}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство.
1. На вкладке **Теги** нажмите кнопку ![icon](../../../../_assets/console-icons/tag.svg) **Создать тег**.
1. Укажите название тега.
1. (Опционально) Задайте описание тега.
1. {% include [select-tag-color](../../../../_includes/speechsense/tag/select-tag-color.md) %}
1. {% include [select-critical-tag](../../../../_includes/speechsense/tag/select-critical-tag.md) %}
1. {% include [specify-keywords](../../../../_includes/speechsense/tag/specify-keywords.md) %}
1. {% include [select-exact-match](../../../../_includes/speechsense/tag/select-exact-match.md) %}
1. {% include [specify-distance-between-words](../../../../_includes/speechsense/tag/specify-distance-between-words.md) %}
1. (Опционально) Выключите опцию **Доступен во всех проектах пространства**.

   По умолчанию опция включена, в результате тегом можно управлять во всех проектах пространства.

1. Нажмите кнопку **Создать тег**.

Теперь тег доступен в проектах, но по умолчанию он деактивирован в них, поэтому пока не применяется к диалогам. Чтобы тег назначался на диалоги, [активируйте его](../../project/tag/change.md#activate-tag) в нужных проектах и [присвойте канал тегу](../../project/tag/change.md#tag-channel). Подробнее об устройстве тегов см. в разделе [{#T}](../../../concepts/tags.md#attach).

## Продублировать тег пространства {#duplicate}

При дублировании настройки исходного тега присваиваются новому тегу, после чего можно изменить нужные настройки. Это удобно, если хотите создать тег с настройками, похожими на настройки созданного ранее тега.

Чтобы продублировать тег пространства:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем на вкладку **Теги**.
1. {% include [duplicate](../../../../_includes/speechsense/tag/duplicate.md) %}
1. {% include [change-settings-when-duplicating](../../../../_includes/speechsense/tag/change-settings-when-duplicating.md) %}
1. Нажмите кнопку **Создать тег**.
