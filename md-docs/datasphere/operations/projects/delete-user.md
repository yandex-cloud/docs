# Удалить пользователя из проекта

{% note info %}

Вы можете удалить пользователя, только если у вас есть роль `{{ roles-datasphere-project-admin }}` в проекте или роль `{{ roles-datasphere-communities-admin }}` в сообществе проекта.

{% endnote %}

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}**.
1. Напротив нужного пользователя нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.member.remove }}**.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.submit }}**.
1. Если вы добавляли пользователя с помощью ссылки, то ее необходимо пересоздать:
    * Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
    * Внизу открывшегося окна нажмите **{{ ui-key.yc-ui-datasphere.invite-link.reset-invitation-link }}** ⟶ **{{ ui-key.yc-ui-datasphere.invite-link.reset-link }}**.