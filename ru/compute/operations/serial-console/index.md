---
title: Управление доступом к серийной консоли в {{ compute-full-name }}
description: Следуя данной инструкции, вы научитесь включать и выключать доступ к серийной консоли виртуальных машин {{ compute-full-name }}.
---

# Управлять доступом к серийной консоли

[Серийная консоль](../../concepts/serial-console.md) позволяет получить доступ к [виртуальной машине](../../concepts/vm.md) вне зависимости от состояния [сети](../../../vpc/concepts/network.md#network) или операционной системы.

{% include [serial-console-roles](../../../_includes/compute/serial-console-roles.md) %}

По умолчанию доступ к серийной консоли виртуальных машин {{ compute-name }} запрещен.

{% include [sc-warning](../../../_includes/compute/serial-console-warning.md) %}

## Разрешить доступ к серийной консоли {#enable}

Вы можете разрешить доступ к серийной консоли как при создании новой виртуальной машины, так и изменив существующую ВМ.

### Создать новую ВМ с разрешенным доступом к серийной консоли {#turn-on-for-new-instance}

Чтобы разрешить доступ к серийной консоли при создании новой виртуальной машины на основе публичного [образа](../images-with-pre-installed-software/get-list.md) из [{{ marketplace-full-name }}](../../../marketplace/index.yaml):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![server](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из [образов](../../concepts/image.md) {{ marketplace-full-name }}.
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выберите одну из готовых конфигураций или создайте свою.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../../vpc/concepts/network.md#network) из списка.

          * У каждой сети должна быть как минимум одна [подсеть](../../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
          * Если сети нет, нажмите **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите способ назначения адреса `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}.
      * Выберите [подходящие группы безопасности](../../../vpc/concepts/security-groups.md). Если оставить поле пустым, то виртуальной машине будет автоматически назначена группа безопасности по умолчанию.
  1. {% include [section-access](../../../_includes/compute/create/section-access.md) %}
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ:

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

  1. Разверните блок **{{ ui-key.yacloud.compute.instances.create.section_additional }}** и в поле **{{ ui-key.yacloud.compute.instance.overview.field_serial-port-enable }}** включите опцию **{{ ui-key.yacloud.compute.instances.create.value_serial-port-enable }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  ВМ появится в списке. При создании ВМ назначаются [IP-адрес](../../../vpc/concepts/address.md) и [имя хоста](../../../vpc/concepts/address.md#fqdn) (FQDN).

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. [Подготовьте](../vm-connect/ssh.md#creating-ssh-keys) пару ключей (открытый и закрытый) для [SSH-доступа](../../../glossary/ssh-keygen.md) на ВМ.
  2. Создайте ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию. В приведенном примере будет создана ВМ на основе публичного [образа](../images-with-pre-installed-software/get-list.md) из [{{ marketplace-full-name }}](../../../marketplace/index.yaml) на базе операционной системы [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-2404-lts-oslogin):

      ```bash
      yc compute instance create \
        --name sample-instance \
        --zone {{ region-id }}-a \
        --network-interface subnet-id=<идентификатор_подсети>,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2404-lts-oslogin,auto-delete=true \
        --metadata enable-oslogin=false,serial-port-enable=1,ssh-keys='<имя_пользователя>:<публичный_SSH-ключ>'
      ```

      Где:

      * `--name` — имя ВМ. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

          {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет создана виртуальная машина.
      * `--network-interface` — сетевые настройки создаваемой ВМ:

          * `subnet-id` — [идентификатор подсети](../../../vpc/operations/subnet-get-info.md) в зоне доступности, в которой создается виртуальная машина.
      * `--metadata` — [метаданные](../../concepts/vm-metadata.md) виртуальной машины:

          * `enable-oslogin` — параметр, отвечающий за доступ к ВМ по [{{ oslogin }}](../../../organization/concepts/os-login.md). Возможные значения:

              * `true` — чтобы включить доступ к ВМ по {{ oslogin }}. В этом случае доступ по SSH-ключу, заданному через метаданные, будет невозможен.
              * `false` — чтобы отключить доступ к ВМ по {{ oslogin }}. Доступ к ВМ будет возможен только по SSH-ключу, заданному через метаданные.
          * `serial-port-enable=1` — параметр, разрешающий доступ к ВМ через серийную консоль.
          * `ssh-keys` — имя локального пользователя ВМ и содержимое [публичного SSH-ключа](../vm-connect/ssh.md#creating-ssh-keys), с которым этот пользователь сможет подключаться к ВМ по SSH.

      Подробнее о команде `yc compute instance create` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/create.md).

{% endlist %}

### Разрешить доступ к серийной консоли для существующей ВМ {#turn-on-for-current-instance}

Чтобы разрешить доступ к серийной консоли для существующей виртуальной машины:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная виртуальная машина.

  1. Перейдите в сервис **{{ compute-name }}**.

  1. На панели слева выберите ![server](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.

  1. В списке виртуальных машин в строке с нужной ВМ нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне:

     1. Разверните блок **{{ ui-key.yacloud.compute.instances.create.section_additional }}** и в поле **{{ ui-key.yacloud.compute.instance.overview.field_serial-port-enable }}** включите опцию **{{ ui-key.yacloud.compute.instances.create.value_serial-port-enable }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Измените ВМ, указав в команде ее [имя или идентификатор](../vm-info/get-info.md#outside-instance):

      ```bash
      yc compute instance update <имя_или_идентификатор_ВМ> \
        --metadata enable-oslogin=<true|false>,serial-port-enable=1,ssh-keys='<имя_пользователя>:<публичный_SSH-ключ>'
      ```

      Где `--metadata` — [метаданные](../../concepts/vm-metadata.md) виртуальной машины:

      * `enable-oslogin` — параметр, отвечающий за доступ к ВМ по [{{ oslogin }}](../../../organization/concepts/os-login.md). Возможные значения:

          * `true` — чтобы включить доступ к ВМ по {{ oslogin }}. В этом случае доступ по SSH-ключу, заданному через метаданные, будет невозможен.
          * `false` — чтобы отключить доступ к ВМ по {{ oslogin }}. Доступ к ВМ будет возможен только по SSH-ключу, заданному через метаданные.
      * `serial-port-enable=1` — параметр, разрешающий доступ к ВМ через серийную консоль.
      * `ssh-keys` — имя локального пользователя ВМ и содержимое [публичного SSH-ключа](../vm-connect/ssh.md#creating-ssh-keys), с которым этот пользователь сможет подключаться к ВМ по SSH.

     Подробнее о команде `yc compute instance update` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/update.md).

{% endlist %}

## Запретить доступ к серийной консоли {#disable}

По умолчанию доступ к серийной консоли для всех вновь создаваемых виртуальных машин {{ compute-name }} запрещен.

Чтобы запретить доступ к серийной консоли для существующей виртуальной машины:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная виртуальная машина.

  1. Перейдите в сервис **{{ compute-name }}**.

  1. На панели слева выберите ![server](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.

  1. В списке виртуальных машин в строке с нужной ВМ нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне:

     1. Разверните блок **{{ ui-key.yacloud.compute.instances.create.section_additional }}** и в поле **{{ ui-key.yacloud.compute.instance.overview.field_serial-port-enable }}** отключите опцию **{{ ui-key.yacloud.compute.instances.create.value_serial-port-enable }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Измените ВМ, указав в команде ее [имя или идентификатор](../vm-info/get-info.md#outside-instance):

      ```bash
      yc compute instance update <имя_или_идентификатор_ВМ> \
        --metadata enable-oslogin=<true|false>,serial-port-enable=0,ssh-keys='<имя_пользователя>:<публичный_SSH-ключ>'
      ```

      Где `--metadata` — [метаданные](../../concepts/vm-metadata.md) виртуальной машины:

      * `enable-oslogin` — параметр, отвечающий за доступ к ВМ по [{{ oslogin }}](../../../organization/concepts/os-login.md). Возможные значения:

          * `true` — чтобы включить доступ к ВМ по {{ oslogin }}. В этом случае доступ по SSH-ключу, заданному через метаданные, будет невозможен.
          * `false` — чтобы отключить доступ к ВМ по {{ oslogin }}. Доступ к ВМ будет возможен только по SSH-ключу, заданному через метаданные.
      * `serial-port-enable=0` — параметр, запрещающий доступ к ВМ через серийную консоль.
      * `ssh-keys` — имя локального пользователя ВМ и содержимое [публичного SSH-ключа](../vm-connect/ssh.md#creating-ssh-keys), с которым этот пользователь сможет подключаться к ВМ по SSH.

      Подробнее о команде `yc compute instance update` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/update.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/serial-console.md)
* [{#T}](./connect-ssh.md)
* [{#T}](./windows-sac.md)
