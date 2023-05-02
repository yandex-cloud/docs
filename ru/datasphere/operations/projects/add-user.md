# Добавить пользователя в проект

{% include [select-user](../../../_includes/datasphere/organization-users.md) %}

{% list tabs %}

- Консоль управления

  1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}

  1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}**.

  1. {% include [select-user](../../../_includes/datasphere/select-from-list.md) %}

     Если нужного пользователя нет в списке, нажмите **{{ ui-key.yc-ui-datasphere.common.copy-link }}** и отправьте пользователю скопированную ссылку удобным вам способом.

     Пользователь станет участником проекта после того, как примет приглашение и перейдет по ссылке.

{% endlist %}