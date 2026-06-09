# Отказоустойчивый сайт с балансировкой нагрузки через {{ network-load-balancer-full-name }} с помощью консоли управления


Чтобы создать [отказоустойчивый сайт с балансировкой нагрузки через {{ network-load-balancer-full-name }}](index.md) с помощью консоли управления {{ yandex-cloud }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте группу ВМ](#create-vms).
1. [Загрузите файлы сайта](#upload-files).
1. [Создайте сетевой балансировщик](#create-load-balancer).
1. [Протестируйте отказоустойчивость](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки сайта входит:

* плата за [диски](../../../compute/concepts/disk.md) и постоянно запущенные [ВМ](../../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../../compute/pricing.md));
* плата за использование динамических или статических [внешних IP-адресов](../../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../../vpc/pricing.md));
* плата за [сетевой балансировщик](../../../network-load-balancer/concepts/index.md) и балансировку трафика (см. [тарифы {{ network-load-balancer-name }}](../../../network-load-balancer/pricing.md)).


### Подготовьте окружение {#configure-env}

* [Создайте](../../../vpc/operations/network-create.md) облачную сеть с именем `nlb-network` и [подсети](../../../vpc/operations/subnet-create.md).
* [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт с именем `nlb-sa` и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роль `{{ roles-editor }}`.
* [Создайте](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) пару ключей SSH.


## Создайте группу ВМ {#create-vms}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления]({{ link-console-main }}).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}** и нажмите кнопку **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_base }}**:

      * Укажите имя группы ВМ, например `nlb-vm-group`.
      * Выберите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) `nlb-sa`.

  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** выберите зоны доступности `{{ region-id }}-a` и `{{ region-id }}-b`, чтобы обеспечить отказоустойчивость хостинга.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** и укажите конфигурацию базовой ВМ:

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** откройте вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**. Выберите продукт:

          * [LEMP](https://yandex.cloud/ru/marketplace/products/yc/lemp) для Linux, Nginx, {{ MY }}, PHP.
          * [LAMP](https://yandex.cloud/ru/marketplace/products/yc/lamp) для Linux, Apache, {{ MY }}, PHP.

          Нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** укажите:

          * **{{ ui-key.yacloud.compute.disk-form.field_type }}** — `{{ ui-key.yacloud.compute.value_disk-type-network-hdd_cw9XD }}`.
          * **{{ ui-key.yacloud.compute.disk-form.field_size }}** — `3 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** откройте вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** и укажите: 

          * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
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

  Создание группы ВМ может занять несколько минут. Когда все ВМ перейдут в [статус](../../../compute/concepts/vm-statuses.md) `RUNNING`, вы можете [загрузить на них файлы сайта](#upload-files).

{% endlist %}


## Загрузите файлы сайта {#upload-files}

Чтобы проверить работу веб-сервера, необходимо загрузить файлы сайта на каждую ВМ. Для примера вы можете использовать файл `index.html` из [архива](https://{{ s3-storage-host }}/doc-files/index.html.zip).

Для каждой ВМ в созданной группе выполните следующее:

1. [Узнайте](../../../compute/operations/vm-info/get-info.md) публичный IP-адрес нужной ВМ.
1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.
1. Выдайте права на запись для вашего пользователя на директорию `/var/www/html`:

    ```bash
    sudo chown -R "$USER":www-data /var/www/html
    ```

1. Загрузите на ВМ файлы сайта с помощью [протокола SCP](https://ru.wikipedia.org/wiki/SCP).

    {% list tabs group=operating_system %}

    - Linux/macOS {#linux-macos}

      Используйте утилиту командной строки `scp`:

      ```bash
      scp -r <путь_до_директории_с_файлами> <имя_пользователя_ВМ>@<IP-адрес_ВМ>:/var/www/html
      ```

    - Windows {#windows}

      С помощью программы [WinSCP](https://winscp.net/eng/download.php) скопируйте локальную директорию с файлами в директорию `/var/www/html` на ВМ.

    {% endlist %}


## Создайте сетевой балансировщик {#create-load-balancer}

При создании сетевого балансировщика нужно добавить [обработчик](../../../network-load-balancer/concepts/listener.md), на котором балансировщик будет принимать трафик, подключить [целевую группу](../../../network-load-balancer/concepts/target-resources.md), созданную вместе с группой ВМ, и настроить в ней проверку состояния ресурсов.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется создать балансировщик.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}** и нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
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

1. [Узнайте](../../../compute/operations/vm-info/get-info.md) публичный IP-адрес любой ВМ из созданной группы.
1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.
1. Остановите веб-сервис, чтобы сымитировать сбой в работе веб-сервера:

    {% list tabs %}

    - LAMP

      ```bash
      sudo service apache2 stop
      ```

    - LEMP

      ```bash
      sudo service nginx stop
      ```

    {% endlist %}

1. [Узнайте](../../../network-load-balancer/operations/load-balancer-list.md#get) IP-адрес обработчика.
1. Откройте сайт в браузере, используя адрес обработчика.

    Несмотря на сбой в работе одного из веб-серверов, подключение должно пройти успешно.

1. После завершения проверки снова запустите веб-сервис:

    {% list tabs %}

    - LAMP

        ```bash
        sudo service apache2 start
        ```

    - LEMP

        ```bash
        sudo service nginx start
        ```

    {% endlist %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу хостинга и перестать платить за созданные ресурсы:
1. [Удалите](../../../network-load-balancer/operations/load-balancer-delete.md) сетевой балансировщик.
1. [Удалите](../../../compute/operations/instance-groups/delete.md) группу ВМ.
1. [Удалите](../../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.

#### См. также {#see-also}

* [{#T}](terraform.md)