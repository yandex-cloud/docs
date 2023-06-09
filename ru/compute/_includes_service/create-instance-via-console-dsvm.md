Чтобы создать виртуальную машину из публичного образа [DSVM](/marketplace/products/f2e4v304qn35mhilnsbc):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана виртуальная машина.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * Введите имя и описание ВМ. Требования к имени:

          {% include [name-format](../../_includes/name-format.md) %}

          {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

      * Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться виртуальная машина.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** на вкладке **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** выберите образ [DSVM](/marketplace/products/yc/dsvm).
  1. (опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** на вкладке **{{ ui-key.yacloud.compute.instances.create.section_disk }}** настройте загрузочный диск:
      * Выберите [тип диска](../concepts/disk.md#disks_types).
      * Укажите нужный размер диска.
    1. (опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** на вкладке **{{ ui-key.yacloud.compute.nfs.label_filesystems }}** подключите [файловое хранилище](../concepts/filesystem.md). Предварительно необходимо [создать](../operations/filesystem/create.md) хранилища.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
      * Выберите [платформу](../concepts/vm-platforms.md).
      * Укажите [гарантированную долю](../../compute/concepts/performance-levels.md) и необходимое количество vCPU и объем RAM.
      * При необходимости сделайте виртуальную машину [прерываемой](../concepts/preemptible-vm.md).
      * (опционально) Включите [программно-ускоренную сеть](../concepts/software-accelerated-network.md).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      * Укажите идентификатор подсети или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка. Можно выбрать зону поиска: в текущем каталоге или во всех каталогах. Если сети нет, нажмите кнопку ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:
          * В открывшемся окне укажите каталог, в котором будет располагаться новая сеть, и имя сети.
          * В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** выберите опцию **{{ ui-key.yacloud.component.vpc.create-network-dialog.field_is-default }}** — у каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet).
          * Нажмите кнопку **{{ ui-key.yacloud.component.vpc.create-network-dialog.button_create }}**.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите способ назначения адреса:
          * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` — чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}.
          * `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` — чтобы выбрать публичный IP-адрес из списка зарезервированных заранее статических адресов. Подробнее читайте в разделе [{#T}](../../vpc/operations/set-static-ip.md).
          * `{{ ui-key.yacloud.component.compute.network-select.switch_none }}` — чтобы не назначать публичный IP-адрес.
      * (опционально) При необходимости в поле **{{ ui-key.yacloud.component.compute.network-select.field_advanced }}** выберите опцию [защиты от DDoS-атак](../../vpc/ddos-protection/index.md).
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите [подходящие группы безопасности](../../vpc/concepts/security-groups.md).

        {% include [security-groups-note-vm](../../_includes/vpc/security-groups-note-vm.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на виртуальную машину:
      * (опционально) Выберите или создайте [сервисный аккаунт](../../iam/concepts/index.md#sa). Использование сервисного аккаунта позволяет гибко настраивать права доступа к ресурсам.
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [открытого ключа](../operations/vm-connect/ssh.md#creating-ssh-keys).
      * (опционально) При необходимости в поле **{{ ui-key.yacloud.compute.instances.create.field_access-advanced }}** разрешите доступ к [серийной консоли](../operations/index.md#serial-console).
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Виртуальная машина появится в списке. При создании виртуальной машине назначаются [IP-адрес](../../vpc/concepts/address) и [имя хоста](../../vpc/concepts/address.md#fqdn) (FQDN).

{% endlist %}
