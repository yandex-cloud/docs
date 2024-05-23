1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
1. В поле **{{ ui-key.yacloud.common.name }}** введите имя [ВМ](../../compute/concepts/vm.md): `ci-tutorial-gitlab`.
1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**. В открывшемся окне выберите образ [{{ GL }}](/marketplace/products/yc/gitlab) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** укажите следующую конфигурацию:
   * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `4`.
   * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
   * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `8 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
   * Выберите, к какой [подсети](../../vpc/concepts/network.md#subnet) подключить ВМ. Если нужной [сети](../../vpc/concepts/network.md#network) или подсети нет, создайте их с помощью кнопок **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.

     {% include [GL CIDR Warning](../../_includes/managed-gitlab/cidr-note.md) %}

   * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:
    * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.

      {% note alert %}

      Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

      {% endnote %}

    * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Пару ключей для подключения по SSH необходимо создать самостоятельно, см. [раздел о подключении к ВМ по SSH](../../compute/operations/vm-connect/ssh.md).
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING` и запустится {{ GL }}, настройте его.