---
title: "Как изменить настройки проекта в {{ ml-platform-full-name }}"
description: "Следуя данной инструкции, вы сможете изменить настройки проекта." 
---

# Изменить настройки проекта

На странице редактирования проекта вы можете изменить его имя и описание, задать ограничения потребления и настроить интеграцию с другими сервисами {{ yandex-cloud }}:

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Чтобы изменить имя или описание проекта, нажмите значок ![pencil](../../../_assets/console-icons/pencil-to-line.svg) справа от его текущего имени. В открывшемся окне укажите **{{ ui-key.yc-ui-datasphere.edit-project-page.name }}** и при необходимости **{{ ui-key.yc-ui-datasphere.edit-project-page.description }}** проекта, затем нажмите **{{ ui-key.yc-ui-datasphere.common.save }}**.
1. Для изменения других настроек перейдите на вкладку **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}**. 
1. Нажмите кнопку **![pencil](../../../_assets/console-icons/pencil-to-line.svg) {{ ui-key.yc-ui-datasphere.common.edit }}** в нужном блоке настроек.

   * В блоке **{{ ui-key.yc-ui-datasphere.common.general }}** в поле **{{ ui-key.yc-ui-datasphere.edit-project-page.dedicated-vm-inactivity-timeout }}** укажите время, через которое выделенная ВМ будет остановлена и удалена из проекта, если на ней не будет вычислений.

   * В блоке **{{ ui-key.yc-ui-datasphere.edit-project-page.advanced-settings }}**:

     * **{{ ui-key.yc-ui-datasphere.project-page.settings.default-folder }}** — укажите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию для хранения логов работы [нод](../../concepts/deploy/index.md#node).
     * **{{ ui-key.yc-ui-datasphere.project-page.settings.service-account }}** — укажите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), от имени которого {{ ml-platform-name }} будут создавать кластеры {{ dataproc-name }} и выполнять другие действия в сервисах {{ yandex-cloud }}. Сервисный аккаунт должен иметь необходимые [роли](../../../iam/concepts/access-control/roles).
     * **{{ ui-key.yc-ui-datasphere.project-page.settings.subnet }}** — укажите [подсеть](../../../vpc/concepts/network.md#subnet) в [зоне доступности](../../../overview/concepts/geo-scope.md) `{{ region-id }}-a`, если она нужна для связи с другими сервисами {{ yandex-cloud }}. Вместе с подсетью обязательно укажите сервисный аккаунт с ролью `{{ roles-vpc-user }}`. Чтобы доступ в интернет и к репозиториям pip в проекте сохранился, указанная подсеть должна иметь настроенный [NAT-шлюз](../../../vpc/concepts/gateways.md), а сервисный аккаунт — роль `vpc.gateways.user`.

     {% include [subnet-create](../../../_includes/subnet-create.md) %}

     * **{{ ui-key.yc-ui-datasphere.edit-project-page.security-group }}** — укажите [группу безопасности](../../../vpc/concepts/security-groups.md), если они используются в вашей организации.
     * **{{ ui-key.yc-ui-datasphere.edit-project-page.dataproc-cluster }}** — если необходимо, выберите [кластер](../../../data-proc/operations/cluster-create.md).

   * В блоке **{{ ui-key.yc-ui-datasphere.project-page.settings.limits }}** вы можете [задать ограничения](restrictions.md) для проекта.

   * Нажмите **{{ ui-key.yc-ui-datasphere.common.save }}**.

#### См. также {#see-also}

* [{#T}](restrictions.md)
* [{#T}](install-dependencies.md)
* [{#T}](control-compute-resources.md)
* [{#T}](../user-images.md)

