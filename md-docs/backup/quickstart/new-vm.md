# Как начать работать с {{ backup-full-name }} на новой ВМ


Прежде чем начать работу с {{ backup-name }}, убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md) и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`.

В этой инструкции вы создадите и подключите к {{ backup-name }} виртуальную машину под управлением ОС [Linux](https://ru.wikipedia.org/wiki/Linux). Если вам не нужно создавать новую виртуальную машину и вы хотите подключить к {{ backup-name }} существующую ВМ, воспользуйтесь инструкцией [{#T}](existing-vm.md).

{% cut "В стоимость ресурсов для резервного копирования ВМ входят:" %}

* плата за [вычислительные ресурсы](../../compute/concepts/vm-platforms.md) и [диски](../../compute/concepts/disk.md) ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за защищенные ВМ и хранение резервных копий (см. [тарифы {{ backup-full-name }}](../pricing.md)).

{% endcut %}

Чтобы начать работать с {{ backup-name }}:

1. [Подготовьте инфраструктуру](#deploy-infrastructure).
1. [Создайте ВМ](#vm-create).
1. [Привяжите ВМ к политике резервного копирования](#add-policy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте инфраструктуру {#deploy-infrastructure}

1. Если у вас еще нет облачной сети, [создайте](../../vpc/operations/network-create.md) ее.
1. Если в вашей [облачной сети](../../vpc/concepts/network.md#network) нет подсети, [создайте](../../vpc/operations/subnet-create.md) ее.
1. В вашей облачной сети [создайте](../../vpc/operations/security-group-create.md) группу безопасности со следующими [правилами](../../vpc/concepts/security-groups.md#security-groups-rules) для исходящего трафика:

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

## Создайте ВМ {#vm-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать ВМ с подключением к {{ backup-name }}.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из [образов](../../compute/concepts/image.md) с [поддерживаемой операционной системой](../concepts/vm-connection.md#os), например [Ubuntu 20.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоках **{{ ui-key.yacloud.compute.instances.create.section_storages }}** и **{{ ui-key.yacloud.compute.instances.create.section_platform }}** задайте желаемые параметры ВМ.

      Минимальные характеристики ВМ и серверов {{ baremetal-name }} для установки и корректной работы агента {{ backup-name }}:
      
      * Объем свободного места на диске:
      
        * Для ВМ с ОС Linux — 2 ГБ.
        * Для ВМ с ОС Windows — 1,2 ГБ.
      
      * Объем памяти (RAM) — при резервном копировании требуется 1 ГБ RAM на каждый ТБ резервной копии. Объем используемой памяти зависит от объема и типа данных, обрабатываемых [агентом {{ backup-name }}](../concepts/agent.md).
      
      {% note tip %}
      
      Установка агента {{ backup-name }} является ресурсоемкой операцией. Если вы хотите использовать ВМ в минимально возможной конфигурации или, например, ВМ с [уровнем производительности vCPU](../../compute/concepts/performance-levels.md) ниже 100%, рекомендуем на время установки агента {{ backup-name }} увеличить ресурсы ВМ.
      
      {% endnote %}
      
      Для ускорения [резервного копирования](../operations/backup-vm/create.md) данных и их [восстановления](../operations/backup-vm/recover.md) из резервных копий [агент {{ backup-name }}](../concepts/agent.md) может потреблять значительные объемы оперативной памяти (RAM) защищаемого ресурса — [виртуальной машины](../../compute/concepts/vm.md) или [сервера {{ baremetal-name }}](../../baremetal/concepts/servers.md). При этом агент может использовать всю доступную память, что в некоторых случаях приводит к сбоям в работе других служб защищаемого ресурса и невозможности завершить процесс резервного копирования или восстановления данных.
      
      Чтобы предотвратить возникновение таких сбоев, [ограничьте](../operations/limit-agent-memory-usage.md) объем данных, кешируемых агентом в оперативной памяти.
      
      {% note info %}
      
      Ограничение использования оперативной памяти агентом {{ backup-name }} может привести к снижению скорости выполнения операций резервного копирования и восстановления данных.
      
      {% endnote %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите подсеть, [подготовленную ранее](#deploy-infrastructure).
      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.

          Вместо назначения ВМ публичного IP-адреса вы можете привязать к [подсети](../../vpc/concepts/network.md#subnet) с ВМ [таблицу маршрутизации](../../vpc/concepts/routing.md#rt-vm), разрешающую доступ в интернет через [NAT-шлюз](../../vpc/concepts/gateways.md) или пользовательский маршрутизатор.

      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите группу безопасности, [настроенную ранее](#deploy-infrastructure).

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:
  
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).

      Если в вашем профиле нет сохраненных SSH-ключей, нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**, чтобы добавить новый ключ.
  1. Включите опцию **{{ ui-key.yacloud.compute.components.BackupSection.section_backup_1MXwy }}** и в поле **{{ ui-key.yacloud.backup.title_select-vm-backup-policies-row }}** выберите [политику](../concepts/policy.md) резервного копирования, которая будет использоваться {{ backup-name }} для работы с ВМ.
     
     Если у вас нет политики резервного копирования, нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать ее.
     
     Чтобы создать новую ВМ с подключением к {{ backup-name }}, вашему аккаунту должна быть назначена [роль](../security/index.md#backup-user) `backup.user` или выше на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы создаете ВМ.
     
     {% note info %}
     
     Если у вашего аккаунта нет назначенной роли `backup.user` или выше, вы можете подключить ВМ к {{ backup-name }} с помощью [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), которому назначена такая роль. 
     
     Для этого разверните блок **{{ ui-key.yacloud.compute.instances.create.section_additional }}** и в поле **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** выберите подходящий сервисный аккаунт. При необходимости [создайте](../../iam/operations/sa/create.md) новый сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../security/index.md#backup-user) `backup.user`.
     
     {% endnote %}
     
     {% note tip %}
     
     Установка агента {{ backup-name }} является ресурсоемкой операцией. Если вы хотите использовать ВМ в минимально возможной конфигурации или, например, ВМ с [уровнем производительности vCPU](../../compute/concepts/performance-levels.md) ниже 100%, рекомендуем на время установки агента {{ backup-name }} увеличить ресурсы ВМ.
     
     {% endnote %}
     
     Подробнее читайте в разделе [{#T}](../concepts/vm-connection.md).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

Подробнее о создании ВМ см. в разделе [{#T}](../../compute/operations/index.md#vm-create).

## Привяжите ВМ к политике резервного копирования {#add-policy}

Когда ВМ перейдет в статус `Running`, на нее начнет устанавливаться агент {{ backup-name }}. Установка займет от 5 до 10 минут.

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
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ из {{ compute-name }}.

## Что дальше {#what-is-next}

* [Узнайте об особенностях сервиса](../concepts/index.md)
* [Посмотрите другие инструкции по работе с сервисом](../operations/index.md)

#### См. также {#see-also}

* [Чем отличается резервная копия от снапшота](../../glossary/snapshot.md#backup-vs-snapshot)
* [{#T}](../../compute/operations/disk-control/create-snapshot.md)

* [{#T}](existing-vm.md)