# Создать виртуальную машину Windows Server с подключением к {{ backup-name }}

Сервис {{ backup-name }} поддерживает резервное копирование [виртуальных машин {{ compute-name }}](../../compute/concepts/vm.md) с операционными системами Windows Server 2019 и 2022. Подробнее см. в разделе [{#T}](../concepts/vm-connection.md#os).

## Перед началом работы {#before-you-begin}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с [ролью](../../iam/concepts/access-control/roles.md#backup-editor) `backup.editor`.
1. [Настройте](../concepts/vm-connection.md#vm-network-access) сетевой доступ для ВМ.

## Создание ВМ {#creating-vm}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/compute/vm-pic.svg) **{{ ui-key.yacloud.compute.switch_instances }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * Введите имя и описание ВМ. Требования к имени:

        {% include [name-format](../../_includes/name-format.md) %}

        {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

      * Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите образ с операционной системой Windows Server 2019 или 2022.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      1. Выберите подсеть, соответствующую выбранной зоне доступности.
      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
      1. Выберите группу безопасности, настроенную для работы с {{ backup-name }}.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.label_backup }}** включите опцию подключения ВМ к сервису {{ backup-name }}.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите сервисный аккаунт с ролью `backup.editor`.
  1. Укажите другие необходимые параметры ВМ.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI

  1. Выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc resource-manager folder list
      ```

      Результат:

      ```bash
      +----------------------+--------------------+------------------+--------+
      |          ID          |        NAME        |      LABELS      | STATUS |
      +----------------------+--------------------+------------------+--------+
      | wasdcjs6be29******** | my-folder          |                  | ACTIVE |
      | qwertys6be29******** | default            |                  | ACTIVE |
      +----------------------+--------------------+------------------+--------+
      ```

  1. Выберите [подсеть](../../vpc/concepts/network.md#subnet):

      ```bash
      yc vpc subnet list --folder-id <идентификатор_каталога>
      ```

      Результат:

      ```text
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      | b0c6n43f9lgh******** | default-{{ region-id }}-c     | enpe3m3fa00u******** |                | {{ region-id }}-c     | [10.***.0.0/24] |
      | e2l2da8a20b3******** | default-{{ region-id }}-b     | enpe3m3fa00u******** |                | {{ region-id }}-b | [10.***.0.0/24] |
      | e9bnlm18l70a******** | default-{{ region-id }}-a     | enpe3m3fa00u******** |                | {{ region-id }}-a | [10.***.0.0/24] |
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      ```

  1. Создайте файл `init.ps1` со сценарием для установки на ВМ агента {{ backup-name }}:

      ```powershell
      #ps1_sysnative
      echo 'Starting to execute backup agent installation'
      Invoke-WebRequest https://storage.yandexcloud.net/backup-distributions/agent_installer.ps1 -UseBasicParsing | Invoke-Expression
      ```

  1. Создайте ВМ:

      ```bash
      yc compute instance create \
        --folder-id <идентификатор_каталога> \
        --name <имя_ВМ> \
        --zone <зона_доступности> \
        --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4,security-group-ids=<идентификатор_группы_безопасности> \
        --create-boot-disk image-id=<идентификатор_образа>,size=<размер_загрузочного_диска> \
        --cores 2 \
        --core-fraction 100 \
        --memory 4 \
        --service-account-name <имя_сервисного_аккаунта> \
        --metadata-from-file user-data=<путь_к_файлу_со_сценарием>
      ```

      Где:
      * `name` — имя ВМ.

        {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

      * `zone` — [зона доступности](../../overview/concepts/geo-scope.md), которая соответствует выбранной подсети.
      * `subnet-name` — имя выбранной [подсети](../../vpc/concepts/network.md#subnet).
      * `security-group-ids` — идентификатор [группы безопасности](../../vpc/concepts/security-groups.md), настроенной для работы с {{ backup-name }}.
      * `image-id` — [идентификатор образа](../../compute/concepts/image.md) операционной системы.
      * `size` — размер загрузочного диска.
      * `cores` — [количество vCPU](../../compute/concepts/vm.md) ВМ.
      * `core-fraction` — гарантированная доля vCPU в %.
      * `memory` — [объем оперативной памяти](../../compute/concepts/vm.md) ВМ.
      * `service-account-name` — имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) с ролью `backup.editor`.
      * `user-data` — путь к созданному ранее файлу со сценарием для установки на ВМ агента {{ backup-name }}.

      В этом примере создается ВМ на базе Windows Server 2022:

      ```bash
      yc compute instance create \
        --name my-vm \
        --zone {{ region-id }}-b \
        --network-interface subnet-name=my-vpc-{{ region-id }}-b,nat-ip-version=ipv4,security-group-ids=abcd3570sbqg******** \
        --create-boot-disk image-id=fd890bh2sapn********,size=60 \
        --cores 2 \
        --core-fraction 100 \
        --memory 4 \
        --service-account-name backup-editor \
        --metadata-from-file user-data=init.ps1
      ```

      Результат:

      ```bash
      done (46s)
      id: abcdho6nspdk********
      folder_id: wasdcjs6be29********
      created_at: "2023-10-09T14:57:06Z"
      name: my-vm
      ...
      placement_policy: {}
      ```

{% endlist %}

{% include [agent-installation-timespan](../../_includes/backup/agent-installation-timespan-win.md) %}

{% include [agent-installation-failure](../../_includes/backup/agent-installation-failure-win.md) %}

{% include [vm-list](../../_includes/backup/vm-list.md) %}

#### См. также {#see-also}

* [{#T}](connect-vm-windows.md)
* [{#T}](connect-vm-linux.md)
* [Привязать виртуальную машину к политике резервного копирования](./policy-vm/update.md#update-vm-list)
* [{#T}](./backup-vm/recover.md)
* [{#T}](./backup-vm/delete.md)
* [{#T}](./policy-vm/create.md)
