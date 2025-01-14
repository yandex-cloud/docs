---
title: Изменить размер хранилища проекта
description: В этой статье вы узнаете, как изменить размер хранилища проекта.
---

# Изменить размер хранилища проекта

{% note info %}

Вы можете изменить размер хранилища проекта, если у вас есть [роль](../../security/index.md) `{{ roles-datasphere-project-admin }}` в проекте или роль `{{ roles-datasphere-communities-admin }}` в сообществе проекта.

Изменение размера хранилища проекта может быть [ограничено](../community/manage-community-config.md) в настройках сообщества.

{% endnote %}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Информация о размере хранилища проекта доступна на странице проекта на вкладке **{{ ui-key.yc-ui-datasphere.project-page.tab.overview }}** в блоке **{{ ui-key.yc-ui-datasphere.project-page.project-disk }}**. Нажмите значок ![pencil](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-datasphere.common.resize }}**.
1. Укажите желаемый размер — целое число.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.resize }}**.
1. Проект можно будет открыть, когда завершится изменение размера хранилища.

{% note warning %}

Хранилище проекта используется не только для хранения файлов, но и для нужд файловой системы и другого технического обеспечения.

{% endnote %}
