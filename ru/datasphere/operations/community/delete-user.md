---
title: "Как удалить пользователя из сообщества"
description: "Из статьи вы узнаете, как удалить пользователя из сообщества в {{ ml-platform-name }}."
---

# Удалить пользователя из сообщества

{% note info %}

Вы можете удалить пользователя, только если в сообществе у вас есть роль `{{ roles-datasphere-communities-admin }}`.

{% endnote %}

1. {% include [ui-find-community](../../../_includes/datasphere/ui-find-community.md) %}
1. Выберите сообщество, из которого вы хотите удалить пользователей.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.members }}**.
1. Напротив нужного пользователя нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.member.remove }}**.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.submit }}**.
1. Если вы добавляли пользователя с помощью ссылки, то ее необходимо пересоздать:
    * Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
    * Внизу открывшегося окна нажмите **{{ ui-key.yc-ui-datasphere.invite-link.reset-invitation-link }}** ⟶ **{{ ui-key.yc-ui-datasphere.invite-link.reset-link }}**.
