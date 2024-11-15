# Создать сервисного агента

С помощью [сервисного агента](../../../iam/concepts/service-control.md#service-agent) вы сможете работать с другими сервисами, например обновлять токены для авторизации из ноутбуков {{ ml-platform-name }}.

Сервисный агент — это специальный сервисный аккаунт, от имени которого проекты {{ ml-platform-name }} будут выполнять действия в других сервисах {{ yandex-cloud }}. Если сервисный агент включен в сообществе, он будет доступен для всех его проектов.

{% note info %}

Чтобы включить сервисного агента в сообществе {{ ml-platform-name }}, понадобится [роль](../../security/index.md) `{{ roles-datasphere-communities-editor }}` или выше.

Для управления доступом сервисов к ресурсам необходима роль [администратора](../../../resource-manager/security/index.md#resource-manager-admin) или [владельца](../../../resource-manager/security/index.md#resource-manager-clouds-owner) облака.

{% endnote %}

{% include [cli-install](../../../_includes/cli-install.md) %}

1. Чтобы разрешить сервисному агенту работать в {{ ml-platform-name }}, попросите администратора или владельца вашего облака выполнить команду в {{ yandex-cloud }} CLI:

   ```bash
   yc iam service-control enable datasphere --cloud-id <идентификатор_облака>
   ```

   Где `--cloud-id` — [идентификатор облака](../../../resource-manager/operations/cloud/get-id.md), с которым вы будете работать в сообществе {{ ml-platform-name }}.

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роли, необходимые для работы с выбранным сервисом. Подробнее о необходимых ролях см. в разделе Управление доступом соответствующего сервиса.

    Чтобы отправлять запросы в ноды из ноутбука, назначьте сервисному аккаунту роль `{{ roles-datasphere-user }}`.       

1. {% include [ui-find-community](../../../_includes/datasphere/ui-find-community.md) %}
1. Выберите сообщество, для которого вы хотите создать сервисного агента.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.settings-key-value }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.settings.title }}** нажмите **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.add-service-account.button }}**.
1. В открывшемся окне выберите сервисный аккаунт и нажмите **{{ ui-key.yc-ui-datasphere.common.add }}**.

{% note info %}

Чтобы управлять сообществом через API, [добавьте](add-user.md) сервисный аккаунт в список участников сообщества. Чтобы отправлять запросы в ноду из ноутбука или работать с проектом через API, добавьте сервисный аккаунт в списки участников сообщества и [проекта](../projects/add-user.md).

{% endnote %}
