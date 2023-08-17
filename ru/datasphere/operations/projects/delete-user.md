---
title: "Как удалить пользователя из проекта"
description: "Из статьи вы узнаете, как удалить пользователя из проекта в {{ ml-platform-name }}."
---

# Удалить пользователя из проекта

{% note info %}

Вы можете удалить пользователя, только если у вас есть роль `{{ roles-datasphere-project-admin }}` в проекте или роль `{{ roles-datasphere-communities-admin }}` в сообществе проекта.

{% endnote %}

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}**.
1. Напротив нужного пользователя нажмите ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.member.remove }}**.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.submit }}**.