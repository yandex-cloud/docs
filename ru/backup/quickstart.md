# Как начать работать с {{ backup-name }}

{{ backup-name }} — сервис для создания резервных копий и восстановления ресурсов {{ yandex-cloud }} и данных на них.

Вы можете создавать резервные копии [виртуальных машин](../compute/concepts/vm.md) {{ compute-name }} c [поддерживаемыми операционными системами](concepts/vm-connection.md#os).

{% include [requirements](../_includes/backup/requirements.md) %}

Чтобы начать работать с {{ backup-name }}:
1. [Активируйте сервис](#activate-provider).
1. [Настройте сервисный аккаунт](#prepare-service-account).
1. [Создайте ВМ](#vm-create).
1. [Привяжите ВМ к политике резервного копирования](#add-policy).

## Активируйте сервис {#activate-provider}

{% note info %}

Минимальная роль в [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder), необходимая для [активации сервиса](concepts/index.md#providers), — `backup.editor` (см. [описание роли](security/index.md#backup-editor)).

{% endnote %}

Чтобы активировать сервис:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите активировать сервис.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.backup.button_action-activate }}**.

{% endlist %}

## Настройте сервисный аккаунт {#prepare-service-account}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором активирован сервис.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта](../iam/concepts/users/service-accounts.md). Требования к формату имени:

      {% include [name-format](../_includes/name-format.md) %}

  1. Нажмите кнопку ![plus-sign](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роль](security/index.md#backup-editor) `backup.editor`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Создайте ВМ {#vm-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором активирован сервис.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      1. Введите имя и описание ВМ.
      1. Выберите [зону доступности](../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      1. Выберите [облачную сеть](../vpc/concepts/network.md#network) и [подсеть](../vpc/concepts/network.md#subnet), к которым нужно подключить ВМ. Если сети нет, нажмите ![plus-sign](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}**:
          1. В открывшемся окне укажите имя сети и каталог, в котором она будет создана.
          1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

              У каждой сети должна быть как минимум одна подсеть. Если подсети нет, создайте ее, выбрав ![plus-sign](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
      1. Настройте [сетевой доступ](concepts/vm-connection.md#vm-network-access) для ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:
      1. Выберите сервисный аккаунт с ролью `backup.editor`.
      1. В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
      1. В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа.

          Пару ключей для подключения по [SSH](../glossary/ssh-keygen.md) необходимо создать самостоятельно, см. [{#T}](../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}** включите опцию подключения ВМ к сервису {{ backup-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

Подробности см. в [{#T}](../compute/operations/index.md#vm-create).

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
      1. В блоке **{{ ui-key.yacloud.backup.label_linked-instances }}** нажмите кнопку ![plus-sign](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.backup.button_attach-instance }}**.
      1. Выберите нужную ВМ из списка и нажмите кнопку **{{ ui-key.yacloud.backup.button_attach-instance-submit }}**.

    {% endlist %}

    Также вы можете привязать ВМ к политике резервного копирования в сервисе {{ compute-name }}:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором активирован сервис.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. Выберите нужную ВМ.
      1. В блоке **{{ ui-key.yacloud.backup.title_backup }}** в поле **{{ ui-key.yacloud.backup.label_policies }}** нажмите кнопку **{{ ui-key.yacloud.common.select }}**.
      1. Выберите одну из политик, созданных по умолчанию, и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

    {% endlist %}

#### Что дальше {#what-is-next}

* [Узнайте об особенностях сервиса](concepts/index.md).
* [Посмотрите другие инструкции по работе с сервисом](operations/index.md).
