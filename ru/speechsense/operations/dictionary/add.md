# Добавить словарь в тег

После того как вы [создали словарь](create.md), вы можете изменить [словарный тег](../../concepts/tags.md#dictionary-tags) и добавить в него [словарь](../../concepts/dictionaries.md). Тогда тег будет применяться к диалогам, которые содержат фразы-триггеры из словаря.

Словарь также можно добавить при [создании словарного тега](../project/tag/create-dictionary-tag.md#new-tag).

Для изменения тега проекта нужна роль `{{ roles-speechsense-admin }}` или `{{ roles-speechsense-editor }}` в проекте.

Чтобы добавить словарь в уже существующий тег:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. На вкладке **{{ ui-key.yc-ui-talkanalytics.tags.tags }}** нажмите на строку нужного тега.
1. В открывшемся окне, в поле **{{ ui-key.yc-ui-talkanalytics.tags.key-phrases-key-value }}**, нажмите кнопку ![icon](../../../_assets/console-icons/book-open.svg) **{{ ui-key.yc-ui-talkanalytics.dictionaries.add-dictionary }}**.
1. В выпадающем списке выберите нужные словари.
1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.apply }}**, затем — **{{ ui-key.yc-ui-talkanalytics.common.save }}**.
