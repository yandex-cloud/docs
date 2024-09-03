# Как начать работать с {{ backup-full-name }}

{{ backup-name }} — сервис для создания резервных копий и восстановления ресурсов {{ yandex-cloud }} и данных на них.

Создайте [виртуальную машину](../compute/concepts/vm.md) {{ compute-full-name }} с подключением к {{ backup-name }} и привяжите ее к [политике резервного копирования](./concepts/policy.md).

Подробности о минимальных характеристиках ВМ и поддерживаемых операционных системах см. в разделе [{#T}](./concepts/vm-connection.md).

Чтобы начать работать с {{ backup-name }}:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy-infrastructure).
1. [Активируйте {{ backup-name }}](#activate-provider).
1. [Создайте ВМ](#vm-create).
1. [Привяжите ВМ к политике резервного копирования](#add-policy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов для резервного копирования ВМ входят:
* плата за [вычислительные ресурсы](../compute/concepts/vm-platforms.md) и [диски](../compute/concepts/disk.md) ВМ (см. [тарифы {{ compute-full-name }}](../compute/pricing.md));
* плата за защищенные ВМ и хранение резервных копий (см. [тарифы {{ backup-full-name }}](./pricing.md)).

## Создайте инфраструктуру {#deploy-infrastructure}

### Подготовьте сеть {#network-setup}

Вы можете использовать существующие [облачную сеть](../vpc/concepts/network.md#network) и [подсеть](../vpc/concepts/network.md#subnet) или создать новые.

{% cut "Создать новую облачную сеть с подсетями" %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы хотите создать ВМ с подключением к {{ backup-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите имя сети. Требования к имени:

      {% include [name-format](../_includes/name-format.md) %}

  1. Оставьте включенной опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.

{% endlist %}

{% endcut %}

Подробности см. в разделе [{#T}](../vpc/operations/network-create.md).

### Настройте группу безопасности {#sg-setup}

Вы можете использовать существующую [группу безопасности](../vpc/concepts/security-groups.md) или создать новую.

{% cut "Создать новую группу безопасности" %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы хотите создать ВМ с подключением к {{ backup-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. Введите имя группы безопасности.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите сеть, к которой будет относиться группа безопасности.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

{% endcut %}

Добавьте в группу безопасности [правила](../vpc/concepts/security-groups.md#security-groups-rules) для исходящего трафика ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы хотите создать ВМ с подключением к {{ backup-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
  1. Напротив группы безопасности, в которую вы хотите добавить правила, нажмите ![image](../_assets/console-icons/ellipsis.svg) и выберите ![image](../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** перейдите на вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** и нажмите **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
  1. Последовательно добавьте следующие правила для исходящего трафика:

      {% include [outgoing-traffic](../_includes/backup/outgoing-rules.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

Подробности см. в разделе [{#T}](../vpc/operations/security-group-create.md).

### Настройте сервисный аккаунт {#prepare-service-account}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать ВМ с подключением к {{ backup-name }}.
  1. В верхней части страницы перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта](../iam/concepts/users/service-accounts.md). Требования к формату имени:

      {% include [name-format](../_includes/name-format.md) %}

  1. Нажмите ![plus-sign](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роль](./security/index.md#backup-editor) `backup.editor`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

Подробности см. в разделе [{#T}](../iam/operations/sa/create.md).

## Активируйте {{ backup-name }} {#activate-provider}

Чтобы активировать сервис, у вас должна быть _минимальная_ [роль](security/index.md#backup-editor) `backup.editor` на [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать ВМ с подключением к {{ backup-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать ВМ с подключением к {{ backup-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Если сервис {{ backup-name }} еще не активирован, нажмите **{{ ui-key.yacloud.backup.button_action-activate }}**.

      Если кнопки **{{ ui-key.yacloud.backup.button_action-activate }}** нет, и вам доступно создание ВМ с подключением к {{ backup-name }}, значит, сервис уже активирован. Переходите к следующему шагу.

{% endlist %}

## Создайте ВМ {#vm-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать ВМ с подключением к {{ backup-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}** и нажмите **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:

      1. Введите имя ВМ. Требования к имени:

          {% include [name-format](../_includes/name-format.md) %}

      1. Выберите [зону доступности](../overview/concepts/geo-scope.md), в которой будет находиться ВМ.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите одну из [поддерживаемых операционных систем](./concepts/vm-connection.md#os), например [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts).

  1. В блоках **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** и **{{ ui-key.yacloud.compute.instances.create.section_platform }}** задайте желаемые параметры ВМ.

      {% include [vm-requirements](../_includes/backup/vm-requirements.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите подсеть, [подготовленную ранее](#network-setup).
      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
          
          Вместо назначения ВМ публичного IP-адреса вы можете привязать к подсети с ВМ [таблицу маршрутизации](../vpc/concepts/routing.md#rt-vm), разрешающую доступ в интернет через [NAT-шлюз](../vpc/concepts/gateways.md) или пользовательский маршрутизатор.

      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите группу безопасности, [настоенную ранее](#sg-setup).

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:

      1. Выберите сервисный аккаунт, [созданный ранее](#prepare-service-account).
      1. В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
      1. В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа.

          Пару ключей для подключения по [SSH](../glossary/ssh-keygen.md) необходимо создать самостоятельно, см. [{#T}](../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}**:

      {% include [backup-enable](../_includes/compute/backup-enable.md) %}

  1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

Подробности см. в разделе [{#T}](../compute/operations/index.md#vm-create).

## Привяжите ВМ к политике резервного копирования {#add-policy}

{% include [agent-installation-timespan](../_includes/backup/agent-installation-timespan.md) %}

1. Убедитесь, что агент {{ backup-name }} установлен:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором активирован сервис.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. Выберите нужную ВМ.
      1. Убедитесь, что в блоке **{{ ui-key.yacloud.backup.title_backup }}** в поле **{{ ui-key.yacloud.backup.field_vm-instances }}** отображается значение `{{ ui-key.yacloud.backup.label_create }}`.

    {% endlist %}

    {% include [vm-list](../_includes/backup/vm-list.md) %}

    {% include [agent-installation-failure](../_includes/backup/agent-installation-failure.md) %}

1. Привяжите ВМ к политике резервного копирования:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором активирован сервис.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
      1. Перейдите на вкладку ![policies](../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
      1. Выберите одну из политик, созданных по умолчанию.
      1. В блоке **{{ ui-key.yacloud.backup.label_linked-instances }}** нажмите ![plus-sign](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.backup.button_attach-instance }}**.
      1. Выберите нужную ВМ из списка и нажмите **{{ ui-key.yacloud.backup.button_attach-instance-submit }}**.

    {% endlist %}

    Также вы можете привязать ВМ к политике резервного копирования в сервисе {{ compute-name }}:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором активирован сервис.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. Выберите нужную ВМ.
      1. В блоке **{{ ui-key.yacloud.backup.title_backup }}** в поле **{{ ui-key.yacloud.backup.label_policies }}** нажмите ![image](../_assets/console-icons/pencil.svg).
      1. Выберите одну из политик, созданных по умолчанию, и нажмите **{{ ui-key.yacloud.common.save }}**.

    {% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](./operations/delete-vm.md) ВМ из {{ backup-name }}.
1. [Удалите](../compute/operations/vm-control/vm-delete.md) ВМ из {{ compute-name }}.
1. Если для ВМ были созданы резервные копии, [удалите](./operations/backup-vm/delete.md) их. 

## Что дальше {#what-is-next}

* [Узнайте об особенностях сервиса](./concepts/index.md).
* [Посмотрите другие инструкции по работе с сервисом](./operations/index.md).