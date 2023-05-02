# Изменить настройки проекта

На странице редактирования проекта вы можете изменить его имя и описание, задать ограничения потребления и настроить интеграцию с другими сервисами {{ yandex-cloud }}:

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Чтобы изменить имя или описание проекта, нажмите значок ![pencil](../../../_assets/pencil-line.svg) справа от его текущего имени. В открывшемся окне укажите **{{ ui-key.yc-ui-datasphere.edit-project-page.name }}** и при необходимости **{{ ui-key.yc-ui-datasphere.edit-project-page.description }}** проекта, затем нажмите **{{ ui-key.yc-ui-datasphere.common.save }}**.
1. Для изменения других настроек перейдите на вкладку **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}**. 
1. Нажмите кнопку **![pencil](../../../_assets/pencil-line.svg) {{ ui-key.yc-ui-datasphere.common.edit }}** в нужном блоке настроек.

   * В блоке **{{ ui-key.yc-ui-datasphere.common.general }}**:

     * **{{ ui-key.yc-ui-datasphere.edit-project-page.period-of-inactivity }}** — укажите, как скоро перестанут выполняться ячейки с загрузкой CPU или GPU меньше 1% (по умолчанию — `{{ ui-key.yc-ui-datasphere.common.never }}`).
     * Включите опцию **{{ ui-key.yc-ui-datasphere.autosave-commit-mode.title }}**, если вы хотите выбрать режим [сохранения состояния](../../concepts/save-state.md#auto-save).
     * Нажмите **{{ ui-key.yc-ui-datasphere.common.save }}**.

   * В блоке **{{ ui-key.yc-ui-datasphere.edit-project-page.advanced-settings }}**:

     * **{{ ui-key.yc-ui-datasphere.project-page.settings.default-folder }}** — укажите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию для хранения логов работы [нод](../../concepts/deploy/index.md#node).
     * **{{ ui-key.yc-ui-datasphere.project-page.settings.service-account }}** — укажите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), от имени которого будут создаваться коннекторы S3 или кластеры {{ dataproc-name }}. Сервисный аккаунт должен иметь необходимые [роли](../../../iam/concepts/access-control/roles).
     * **{{ ui-key.yc-ui-datasphere.project-page.settings.subnet }}** — укажите [подсеть](../../../vpc/concepts/network.md#subnet), если она нужна для связи с другими сервисами {{ yandex-cloud }}. Вместе с подсетью обязательно укажите сервисный аккаунт с минимальной ролью `{{ roles-vpc-user }}`.

     {% include [subnet-create](../../../_includes/subnet-create.md) %}

     * **{{ ui-key.yc-ui-datasphere.edit-project-page.security-group }}** — укажите [группу безопасности](../../../vpc/concepts/security-groups.md), если они используются в вашей организации.
     * Нажмите **{{ ui-key.yc-ui-datasphere.common.save }}**.


#### См. также {#see-also}

* [{#T}](restrictions.md)
* [{#T}](install-dependencies.md)
* [{#T}](control-compute-resources.md)

