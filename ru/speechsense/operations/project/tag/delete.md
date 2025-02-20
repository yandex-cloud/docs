---
title: Удалить тег
description: Следуя данной инструкции, вы сможете удалить тег проекта.
---

# Удалить тег

Для удаления тега проекта нужна роль `{{ roles-speechsense-admin }}` или `{{ roles-speechsense-editor }}` в проекте.

## Удалить основной тег {#delete-tag}

При удалении основного тега удалятся все зависимые от него теги. {{ speechsense-name }} предупредит вас, если для удаляемого тега есть зависимые теги.

Чтобы удалить тег:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}**.
1. В строке нужного тега нажмите ![icon](../../../../_assets/console-icons/ellipsis.svg), затем ![icon](../../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yc-ui-talkanalytics.common.delete-key-value }}**.
1. Подтвердите удаление тега.

## Удалить зависимый тег {#delete-dependent-tag}

Чтобы удалить зависимый тег:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** и выберите нужный основной тег. В разворачивающемся списке будут перечислены зависимые теги.
1. В строке нужного зависимого тега нажмите ![icon](../../../../_assets/console-icons/ellipsis.svg), затем ![icon](../../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yc-ui-talkanalytics.common.delete-key-value }}**.
1. Подтвердите удаление тега.
