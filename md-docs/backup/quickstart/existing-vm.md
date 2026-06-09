# Как начать работать с {{ backup-full-name }} на существующей ВМ


Прежде чем начать работу с {{ backup-name }}, убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md) и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`.

Убедитесь также, что у вас есть [виртуальная машина](../../compute/concepts/vm.md) {{ compute-full-name }}. В этой инструкции вы подключите к {{ backup-name }} виртуальную машину под управлением ОС [Linux](https://ru.wikipedia.org/wiki/Linux). Если у вас нет виртуальной машины, воспользуйтесь инструкцией [{#T}](new-vm.md).

{% cut "В стоимость ресурсов для резервного копирования ВМ входят:" %}

* плата за [вычислительные ресурсы](../../compute/concepts/vm-platforms.md) и [диски](../../compute/concepts/disk.md) ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за защищенные ВМ и хранение резервных копий (см. [тарифы {{ backup-full-name }}](../pricing.md)).

{% endcut %}

Чтобы начать работать с {{ backup-name }}:

1. [Подготовьте инфраструктуру](#deploy-infrastructure).
1. [Активируйте {{ backup-name }}](#activate-provider).
1. [Установите агент {{ backup-name }}](#connect-vm).
1. [Привяжите ВМ к политике резервного копирования](#add-policy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте инфраструктуру {#deploy-infrastructure}

1. В [облачной сети](../../vpc/concepts/network.md#network) с подключаемой к {{ backup-name }} виртуальной машиной [создайте](../../vpc/operations/security-group-create.md) группу безопасности со следующими [правилами](../../vpc/concepts/security-groups.md#security-groups-rules) для исходящего трафика:

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
    --- | --- | --- | ---
    `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.193.0/24`
    `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.204.0/24`
    `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24`
    `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.201.181.0/24`
    `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `178.176.128.0/24`
    `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.193.0/24`
    `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.204.0/24`
    `7770-7800` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24`
    `8443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24`
    `44445` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `51.250.1.0/24`
    
    
    
    {% note tip %}
    
    При установке [агента {{ backup-name }}](../concepts/agent.md) на ВМ или сервер {{ baremetal-name }} может понадобиться доустановить отсутствующие компоненты ПО из интернета. Для этого добавьте в [группу безопасности](../../vpc/concepts/security-groups.md) следующее правило для исходящего трафика:
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
    После установки агента {{ backup-name }} вы можете удалить это правило.
    
    Для доступа к ВМ по протоколу [SSH](../../compute/operations/vm-connect/ssh.md) добавьте следующее правило для входящего трафика:
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
    
    {% endnote %}

1. Назначьте подключаемой к {{ backup-name }} ВМ созданную [группу безопасности](../../vpc/concepts/security-groups.md):

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно подключить ВМ к {{ backup-name }}.
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** и выберите нужную ВМ.
      1. В блоке **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}** добавьте группу безопасности в [сетевой интерфейс](../../compute/concepts/network.md) ВМ:
      
          * В правом верхнем углу блока нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
          * В открывшемся окне в поле **{{ ui-key.yacloud.compute.instance.edit-network-interface.field_security-groups-ids }}** выберите созданную ранее группу безопасности.
          * Нажмите **{{ ui-key.yacloud.common.save }}**.
      
      1. Если у ВМ нет [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses), то в секции **{{ ui-key.yacloud.compute.instance.overview.section_network }}** в правом верхнем углу блока нужного сетевого интерфейса нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**. В открывшемся окне:
      
          * В поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** выберите `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}`, чтобы автоматически получить IP-адрес, или `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}`, чтобы выбрать зарезервированный адрес из списка.
          * (Опционально) Если в поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** вы выбрали `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}`, включите опцию **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_ddos-protection-provider }}**. Подробнее см. в разделе [{#T}](../../vpc/ddos-protection/index.md).
          * Если в поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** вы выбрали `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}`, выберите IP-адрес, который хотите привязать к ВМ. IP-адрес и ВМ должны находиться в одной [зоне доступности](../../overview/concepts/geo-scope.md).
          * Нажмите **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.button_submit }}**.
      
          Вместо назначения ВМ публичного IP-адреса вы можете привязать к подсети с ВМ [таблицу маршрутизации](../../vpc/concepts/routing.md#rt-vm), разрешающую доступ в интернет через [NAT-шлюз](../../vpc/concepts/gateways.md) или пользовательский маршрутизатор.

    {% endlist %}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../security/index.md#backup-user) `backup.user` или выше. 
1. Привяжите к подключаемой к {{ backup-name }} ВМ созданный [сервисный аккаунт](../../iam/concepts/users/service-accounts.md):

    {% note info %}
    
    К виртуальной машине можно привязать только один сервисный аккаунт.
    
    {% endnote %}
    
    Чтобы привязать сервисный аккаунт к ВМ, необходимо иметь разрешение на использование этого сервисного аккаунта. Это разрешение входит в роли [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user), [editor](../../iam/roles-reference.md#editor) и выше.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно подключить ВМ к {{ backup-name }}.
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** и в открывшемся списке выберите нужную ВМ.
      1. В правом верхнем углу страницы нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
      1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}** выберите сервисный аккаунт с ролью `backup.user` или выше.
      1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

    {% endlist %}

## Активируйте {{ backup-name }} {#activate-provider}

Чтобы активировать сервис, у вас должна быть _минимальная_ [роль](../security/index.md#backup-user) `backup.user` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создавать резервные копии ВМ или серверов {{ baremetal-name }}.

Активация сервиса запускает работу провайдера резервного копирования. Подробнее о провайдере резервного копирования и передаваемых ему данных см. в разделе [{#T}](../concepts/index.md#providers).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно подключить ВМ к {{ backup-name }}.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Если сервис {{ backup-name }} еще не активирован, нажмите **{{ ui-key.yacloud.backup.button_action-activate }}**.

      Если кнопки **{{ ui-key.yacloud.backup.button_action-activate }}** нет и вам доступно создание ВМ с подключением к {{ backup-name }}, значит, сервис уже активирован. Переходите к следующему шагу.

{% endlist %}

## Установите агент {{ backup-name }} {#connect-vm}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по SSH.
1. Установите агент {{ backup-name }} на ВМ. Для этого в терминале Linux выполните команду:

    {% list tabs group=operating_system %}

    - Ubuntu {#ubuntu}

      ```bash
      sudo apt update && \
      sudo apt install -y jq && \
      curl https://{{ s3-storage-host }}/backup-distributions/agent_installer.sh | sudo bash
      ```

      Результат:

      ```text
      ...
      Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
      ```

    - CentOS {#centos}

      ```bash
      sudo yum install epel-release -y && \
      sudo yum update -y && \
      sudo yum install jq -y && \
      curl https://{{ s3-storage-host }}/backup-distributions/agent_installer.sh | sudo bash
      ```

      Результат:

      ```text
      ...
      Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
      ```

    {% endlist %}

    {% note info %}

    В случае появления ошибки `Failed to parse cloudbackup from instance attributes IAM token and instance registration id are empty, unable to provide authorization` убедитесь, что к ВМ [привязан](../operations/connect-vm-linux.md#connect-sa-to-vm) сервисный аккаунт с [ролью](../security/index.md#backup-user) `backup.user` или выше.

    {% endnote %}

## Привяжите ВМ к политике резервного копирования {#add-policy}

После установки агента ВМ будет добавлена в сервис **{{ backup-name }}** на вкладку ![machines](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_instances }}**, и ее можно будет [привязать](../operations/policy-vm/attach-and-detach-vm.md) к [политике резервного копирования](../concepts/policy.md) {{ backup-name }}.

1. Убедитесь, что агент {{ backup-name }} установлен:
   
   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором активирован сервис.
     1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. Выберите нужную ВМ.
     1. Убедитесь, что в блоке **{{ ui-key.yacloud.compute.instance.overview.backup-overview.title_backup-section }}** в поле **{{ ui-key.yacloud.backup.field_vm-instances }}** отображается значение `{{ ui-key.yacloud.compute.backup-integration.label_instance-backup-status-no-applications }}`.
   
   {% endlist %}
1. Привяжите ВМ к политике резервного копирования:
   
   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором активирован сервис и где находится нужная виртуальная машина.
     1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
     1. На панели слева выберите ![policies](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
     1. Выберите одну из политик, созданных по умолчанию. При необходимости нажмите кнопку **{{ ui-key.yacloud.backup.button_create-policy }}**, чтобы создать новую политику.
     1. В блоке **{{ ui-key.yacloud.backup.title_linked-recourses }}** на вкладке **{{ ui-key.yacloud.backup.value_vm-recourses }}** нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.backup.button_attach-instance }}**.
     1. В открывшемся окне выберите нужную ВМ из списка и нажмите **{{ ui-key.yacloud_billing.backup.button_attach-instance-submit }}**.
   
   {% endlist %}
   
   В результате виртуальная машина будет привязана к политике резервного копирования, а ее резервные копии начнут создаваться по расписанию, заданному в политике.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. Если для ВМ были созданы резервные копии, [удалите](../operations/backup-vm/delete.md) их.
1. [Удалите](../operations/delete-vm.md) ВМ из {{ backup-name }}.

## Что дальше {#what-is-next}

* [Узнайте об особенностях сервиса](../concepts/index.md)
* [Посмотрите другие инструкции по работе с сервисом](../operations/index.md)

#### См. также {#see-also}

* [Чем отличается резервная копия от снапшота](../../glossary/snapshot.md#backup-vs-snapshot)
* [{#T}](../../compute/operations/disk-control/create-snapshot.md)

* [{#T}](index.md)