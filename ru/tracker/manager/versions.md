# Версии

Обычно версии используются для задач разработки и помогают группировать задачи, относящиеся к одной версии продукта. Значения версий можно настроить на странице очереди.

Чтобы присвоить задаче версию, на странице задачи заполните поля **{{ ui-key.startrek-backend.fields.issue.affectedVersions-key-value }}** или **{{ ui-key.startrek-backend.fields.issue.fixVersions-key-value }}**.

Поле **{{ ui-key.startrek-backend.fields.issue.affectedVersions-key-value }}** используется для того, чтобы указывать, в какой версии продукта или пакета найдена ошибка.

Поле **{{ ui-key.startrek-backend.fields.issue.fixVersions-key-value }}** используется для планирования работы. С помощью этого поля задачи разделяют по версиям продукта или релизам.

## Создать версию {#create-version}

Чтобы создать новую версию:

1. Откройте страницу очереди.

1. В правом верхнем углу страницы выберите ![](../../_assets/horizontal-ellipsis.svg) **Действия над очередью** → ![](../../_assets/tracker/svg/versions.svg) **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_versions }}**.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page.btnAdd }}**.

1. Введите **{{ ui-key.startrek.blocks-desktop_b-page_type_versions.name }}** версии.

1. При необходимости укажите даты начала и завершения и заполните описание версии. Эти поля носят информационный характер.

1. Нажмите кнопку **{{ ui-key.startrek.components_FormButtons.create }}**.

## Изменить версию {#edit-version}

Чтобы изменить существующую версию:

1. Откройте страницу очереди.

1. В правом верхнем углу страницы выберите ![](../../_assets/horizontal-ellipsis.svg) **Действия над очередью** → ![](../../_assets/tracker/svg/versions.svg) **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_versions }}**.

1. Наведите курсор на версию.

1. Выберите ![](../../_assets/tracker/svg/settings-old.svg) → **{{ ui-key.startrek.blocks-desktop_b-page.actionEdit }}**.

1. Внесите изменения и нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page.btnUpdate }}**.

## Статусы версий {#version-statuses}

Любая версия может находиться в одном из статусов:

- **Открытая** — обычно так помечают версии, работа над которыми еще ведется.

- **Релизная** — продукт с этой версией выпущен в релиз.

- **Архивированная** — поддержка этой версии прекращена.

По умолчанию на вкладке **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_versions }}** отображаются только открытые версии. Вы можете изменить режим отображения с помощью быстрых фильтров над списком версий.

Не забывайте изменять статусы версий на актуальные, чтобы вы и ваши коллеги всегда были в курсе состояния версий.

Чтобы изменить статус версии:

1. Откройте страницу очереди.

1. В правом верхнем углу страницы выберите ![](../../_assets/horizontal-ellipsis.svg) **Действия над очередью** → ![](../../_assets/tracker/svg/versions.svg) **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_versions }}**.

1. Наведите курсор на версию.

1. Нажмите на значок ![](../../_assets/tracker/svg/settings-old.svg) и выберите статус.

## Подписаться на версию {#subscribe-version}

Если вы хотите получать уведомления об изменениях задач, связанных с определенной версией, вы можете подписаться на нее:

1. Откройте [страницу очереди](../user/queue.md).

1. В правом верхнем углу страницы выберите ![](../../_assets/horizontal-ellipsis.svg) **Действия над очередью** → ![](../../_assets/tracker/svg/versions.svg) **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_versions }}**.

1. Наведите курсор на версию.

1. Выберите ![](../../_assets/tracker/svg/settings-old.svg) → **{{ ui-key.startrek.blocks-desktop_b-page.actionFollow }}**.

Если вы все сделали правильно, рядом с номером версии появится значок ![](../../_assets/tracker/subscribtion.png)

## Просмотреть задачи версии {#section_l31_brz_xz}

Вы можете просмотреть список задач, относящихся к определенной версии:

1. Откройте страницу очереди.

1. В правом верхнем углу страницы выберите ![](../../_assets/horizontal-ellipsis.svg) **Действия над очередью** → ![](../../_assets/tracker/svg/versions.svg) **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_versions }}**.

1. Нажмите на номер версии.
