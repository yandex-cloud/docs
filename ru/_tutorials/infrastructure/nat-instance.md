# Маршрутизация с помощью NAT-инстанса

_NAT-инстанс_ — специальная [виртуальная машина](../../compute/concepts/vm.md) с преднастроенными правилами маршрутизации и трансляции [IP-адресов](../../vpc/concepts/address.md).

В {{ yandex-cloud }} можно настроить связь нескольких ВМ с интернетом через NAT-инстанс с помощью [статической маршрутизации](../../vpc/concepts/static-routes.md). При этом будет использован только один публичный IP-адрес — тот, который присвоен NAT-инстансу.

Чтобы настроить маршрутизацию через NAT-инстанс:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте группу безопасности](#create-security-groups).
1. [Создайте тестовую ВМ](#create-vm).
1. [Создайте NAT-инстанс](#create-nat-instance).
1. [Настройте статическую маршрутизацию в облачной сети](#configure-static-route).
1. [Проверьте работу NAT-инстанса](#test-nat-instance).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Также инфраструктуру для NAT-инстанса можно развернуть через {{ TF }} с помощью [готового файла конфигурации](#terraform).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки NAT-инстанса входят:
* Плата за постоянно запущенные ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

### Подготовьте инфраструктуру {#deploy-infrastructure}

1. [Создайте облачную сеть](../../vpc/operations/network-create.md), например `my-vpc`.
1. В облачной [сети](../../vpc/concepts/network.md#network) [создайте подсети](../../vpc/operations/subnet-create.md), например:
   * `public-subnet`, в которой будет размещен NAT-инстанс.
   * `private-subnet`, в которой будет размещена тестовая ВМ.

## Создайте группу безопасности {#create-security-groups}

[Группы безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) содержат правила, которые разрешают обращаться к ВМ по SSH. В сценарии будет создана группа безопасности `nat-instance-sg`.

Чтобы создать группу безопасности:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Откройте вкладку ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
  1. Создайте группу безопасности:
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
     1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** укажите имя группы: `nat-instance-sg`.
     1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите сеть `my-vpc`.
     1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** создайте следующие правила по инструкции под таблицей:
   
        Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
        --- | --- | --- | --- | --- | ---
        Исходящий | `any` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        Входящий | `ssh` | `22` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        Входящий | `ext-http` | `80` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        Входящий | `ext-https` | `443` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

     1. Выберите вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** или **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
     1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** укажите один порт или диапазон портов, куда или откуда будет поступать трафик. Чтобы открыть все порты, нажмите **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_select-all-port-range }}**.
     1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** укажите нужный протокол или оставьте **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}**, чтобы разрешить передачу трафика по всем протоколам.
     1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** или **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** выберите `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` — правило будет применено к диапазону IP-адресов. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** укажите `0.0.0.0/0`.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**. Таким образом создайте все правила из таблицы.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- {{ TF }} {#tf}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Создайте тестовую виртуальную машину {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать тестовую ВМ.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
         * В поле **{{ ui-key.yacloud.compute.instances.create.field_name }}** введите имя ВМ, например `test-vm`.
         * В поле **{{ ui-key.yacloud.compute.instances.create.field_zone }}** выберите зону доступности, где находится подсеть `private-subnet`.
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из образов и версию операционной системы на базе Linux.
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
         * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите подсеть для тестовой ВМ, например `private-subnet`.
         * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите **{{ ui-key.yacloud.component.compute.network-select.switch_none }}**.
         * В поле **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** выберите **{{ ui-key.yacloud.component.compute.network-select.switch_auto }}**.
         * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите созданную ранее группу `nat-instance-sg`.
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
         * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
         * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла с публичным [SSH-ключом](../../glossary/ssh-keygen.md). Пару ключей для подключения по SSH необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

           {% note info %}

           Сохраните ключи в директории по умолчанию и используйте для них стандартные имена, например `id_ed25519` или `id_rsa`.

           {% endnote %}

   1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   Сохраните имя пользователя, закрытый SSH-ключ и внутренний IP-адрес тестовой ВМ.

- {{ TF }} {#tf}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Создайте NAT-инстанс {#create-nat-instance}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать NAT-инстанс.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
         * В поле **{{ ui-key.yacloud.compute.instances.create.field_name }}** введите имя ВМ для NAT-инстанса, например `nat-instance`.
         * В поле **{{ ui-key.yacloud.compute.instances.create.field_zone }}** выберите зону доступности, где находится подсеть `public-subnet`.
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и выберите образ [NAT-инстанс](/marketplace/products/yc/nat-instance-ubuntu-18-04-lts).
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
         * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите подсеть для NAT-инстанса, например `public-subnet`.
         * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
         * В поле **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
         * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите созданную ранее группу `nat-instance-sg`.
   1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
         * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
         * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла с публичным [SSH-ключом](../../glossary/ssh-keygen.md). Пару ключей для подключения по SSH необходимо создать самостоятельно.

           {% note info %}

           Сохраните ключи в директории по умолчанию и используйте для них стандартные имена, например `id_ed25519` или `id_rsa`.

           {% endnote %}

   1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   Сохраните имя пользователя, закрытый SSH-ключ, внутренний и публичный IP-адреса NAT-инстанса.

- {{ TF }} {#tf}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Настройте статическую маршрутизацию {#configure-static-route}

{% note info %}

При создании NAT-инстанса автоматически настраивается только один сетевой интерфейс. Остальные интерфейсы можно включить вручную. Назначьте каждому новому интерфейсу IP-адрес и пропишите для него маршрут в таблице маршрутизации. В каждой подсети корректным шлюзом будет первый IP-адрес. Например, для подсети `192.168.0.128/25` первым адресом в подсети будет — `192.168.0.129`.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте таблицу маршрутизации и добавьте в нее статический маршрут:
     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать статический маршрут.
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
     1. На панели слева выберите ![route-tables](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
     1. В поле **{{ ui-key.yacloud.vpc.route-table-form.field_name }}** задайте имя таблицы маршрутизации, например `nat-instance-route`. Требования к имени:

        {% include [name-format](../../_includes/name-format.md) %}

     1. В поле **{{ ui-key.yacloud.vpc.route-table-form.field_network-id }}** выберите сеть, например `my-vpc`.
     1. В блоке **{{ ui-key.yacloud.vpc.route-table-form.section_static-routes }}** нажмите **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
     1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** введите `0.0.0.0/0`.
     1. В поле **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** выберите `{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}`.
     1. В поле **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}** укажите внутренний IP-адрес NAT-инстанса. Нажмите кнопку **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.
  1. Привяжите таблицу маршрутизации к подсети, где находится тестовая ВМ, например `private-subnet`:
     1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
     1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) в строке подсети с тестовой ВМ и выберите **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
     1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.subnet.add-route-table.popup-route-table_field_route-table-id }}** выберите таблицу `nat-instance-route` и нажмите **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

- {{ TF }} {#tf}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

Созданный маршрут можно применять и к другим подсетям в той же сети, кроме подсети, где находится NAT-инстанс.

## Проверьте работу NAT-инстанса {#test-nat-instance}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к тестовой ВМ через внутренний IP-адрес, используя NAT-инстанс в роли джамп-хоста:

   ```bash
   ssh -J <имя_пользователя_NAT-инстанса>@<публичный_IP-адрес_NAT-инстанса> \
     <имя_пользователя_ВМ>@<внутренний_IP-адрес_ВМ>
   ```

   Также подключиться к тестовой ВМ можно с помощью перенаправления стандартного ввода-вывода (флаг `-W`) для «проброса» соединения через NAT-инстанс:

   ```bash
   ssh -o ProxyCommand="ssh -i <путь/имя_файла_ключа_NAT> -W %h:%p <имя_пользователя_NAT>@<публичный_IP-адрес_NAT>" \
     -i <путь/имя_файла_ключа_ВМ> <имя_пользователя_ВМ>@<внутренний_IP-адрес_ВМ>
   ```

   Используйте эту команду для подключения в следующих случаях:

   * на ВМ используется версия OpenSSH ниже 7.3;
   * ваши SSH-ключи хранятся в отличном от директории по умолчанию месте или имеют нестандартные имена.

1. Введите **yes** для подключения к NAT-инстансу и повторно введите **yes** для подключения к тестовой ВМ.

   {% note info %}

   При вводе **yes** команда может не отображаться в терминале, но сработает.

   {% endnote %}

1. Убедитесь, что тестовая ВМ получает доступ в интернет через публичный IP-адрес NAT-инстанса. Выполните команду:

   ```bash
   curl ifconfig.co
   ```

   Если команда вернет публичный IP-адрес NAT-инстанса, все настроено правильно.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите](../../compute/operations/vm-control/vm-delete.md) тестовую ВМ и NAT-инстанс.

## Как создать инфраструктуру с помощью {{ TF }} {#terraform}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Чтобы настроить маршрутизацию через NAT-инстанс с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовый архив {#ready}

     1. Создайте папку для файла с описанием инфраструктуры.
     1. Скачайте [архив](https://{{ s3-storage-host }}/doc-files/nat-instance-tf.zip) (2 КБ).
     1. Разархивируйте архив в папку. В результате в ней должны появиться конфигурационный файл `nat-instance.tf` и файл с пользовательскими данными `nat-instance.auto.tfvars`.

   - Вручную {#manual}

     1. Создайте папку для файла с описанием инфраструктуры.
     1. Создайте в папке конфигурационный файл `nat-instance.tf`:

        {% cut "nat-instance.tf" %}

        {% include [nat-instance-tf-config](../../_includes/routing/nat-instance-tf-config.md) %}

        {% endcut %}

     1. Создайте в папке файл с пользовательскими данными `nat-instance.auto.tfvars`:

        {% cut "nat-instance.auto.tfvars" %}

        {% include [nat-instance-tf-variables](../../_includes/routing/nat-instance-tf-variables.md) %}

        {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   * [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
   * [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
   * [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group)
   * [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image)
   * [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)
   * [yandex_vpc_route_table]({{ tf-provider-resources-link }}/vpc_route_table)
1. В файле `nat-instance.auto.tfvars` задайте пользовательские параметры:
    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
    * `vm_user` — имя пользователя ВМ.
    * `vm_user_nat` — имя пользователя ВМ с NAT.
    * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее см. [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Проверьте работу NAT-инстанса](#test-nat-instance).