1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте группу ВМ](#create-vms).
1. [Загрузите файлы сайта](#upload-files).
1. [Создайте сетевой балансировщик](#create-load-balancer).
1. [Протестируйте отказоустойчивость](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).



## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [load-balancer-website-paid-resources](../_tutorials_includes/load-balancer-website/paid-resources.md) %}


### Подготовьте окружение {#configure-env}

* [Создайте](../../vpc/operations/network-create.md) облачную сеть с именем `nlb-network` и [подсети](../../vpc/operations/subnet-create.md).
* [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с именем `nlb-sa` и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему роль `{{ roles-editor }}`.
* [Создайте](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) пару ключей SSH.


## Создайте группу ВМ {#create-vms}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}** и нажмите кнопку **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_base }}**:

      * Укажите имя группы ВМ, например `nlb-vm-group`.
      * Выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) `nlb-sa`.

  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** выберите зоны доступности `{{ region-id }}-a` и `{{ region-id }}-b`, чтобы обеспечить отказоустойчивость хостинга.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** и укажите конфигурацию базовой ВМ:

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** откройте вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**. Выберите продукт:

          * [LEMP](/marketplace/products/yc/lemp) для Linux, Nginx, {{ MY }}, PHP.
          * [LAMP](/marketplace/products/yc/lamp) для Linux, Apache, {{ MY }}, PHP.

          Нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** укажите:

          * **{{ ui-key.yacloud.compute.disk-form.field_type }}** — `{{ ui-key.yacloud.compute.value_disk-type-network-hdd }}`.
          * **{{ ui-key.yacloud.compute.disk-form.field_size }}** — `3 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** откройте вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** и укажите: 

          * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `{{ ui-key.yacloud.mdb.forms.resource_presets_field_gen_v3 }}`.
          * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
          * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `20%`.
          * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

          * Выберите облачную сеть `nlb-network` и ее подсети.
          * В поле **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** выберите `{{ ui-key.yacloud.compute.instances.create.value_address-auto }}`.

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:

          * В поле **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** выберите сервисный аккаунт для привязки к ВМ.
          * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** укажите имя пользователя.
          * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа.

      1. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_scale }}** укажите размер группы ВМ — `2`.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_ylb }}** выберите опцию **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** и укажите имя группы: `nlb-tg`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  Создание группы ВМ может занять несколько минут. Когда все ВМ перейдут в [статус](../../compute/concepts/vm-statuses.md) `RUNNING`, вы можете [загрузить на них файлы сайта](#upload-files).

{% endlist %}


## Загрузите файлы сайта {#upload-files}

{% include [load-balancer-website-upload-files](../_tutorials_includes/load-balancer-website/upload-files.md) %}


## Создайте сетевой балансировщик {#create-load-balancer}

При создании сетевого балансировщика нужно добавить [обработчик](../../network-load-balancer/concepts/listener.md), на котором балансировщик будет принимать трафик, подключить [целевую группу](../../network-load-balancer/concepts/target-resources.md), созданную вместе с группой ВМ, и настроить в ней проверку состояния ресурсов.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется создать балансировщик.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}** и нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
  1. Укажите имя балансировщика, например `nlb-1`.
  1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}**:
  
      1. Нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}** и укажите параметры:

          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}** — `nlb-listener`.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}** — `80`.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}** — `80`.

      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

  1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}**:

      1. Нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}** и выберите [созданную ранее](#create-vms) целевую группу `nlb-tg`. Если группа одна, она будет выбрана автоматически.
      1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check }}** нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}** и укажите:

          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-name }}** — `health-check-1`.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}** — количество успешных проверок, после которого ВМ будет считаться готовой к приему трафика: `5`.
          * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}** — количество проваленных проверок, после которого на ВМ перестанет подаваться трафик: `5`.

      1. Нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

После создания сетевого балансировщика, [протестируйте отказоустойчивость](#test).

## Протестируйте отказоустойчивость {#test}

{% include [load-balancer-website-test](../_tutorials_includes/load-balancer-website/test.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу хостинга и перестать платить за созданные ресурсы:
1. [Удалите](../../network-load-balancer/operations/load-balancer-delete.md) сетевой балансировщик.
1. [Удалите](../../compute/operations/instance-groups/delete.md) группу ВМ.
1. [Удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.