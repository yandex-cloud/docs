# Создать виртуальную машину Windows Server с подключением к {{ backup-name }}

Вы можете создавать резервные копии [виртуальных машин](../../compute/concepts/vm.md) {{ compute-name }} c [поддерживаемыми операционными системами на базе Windows](../concepts/vm-connection.md#windows).

{% include [requirements](../../_includes/backup/requirements.md) %}

## Перед началом работы {#before-you-begin}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с [ролью](../security/index.md#backup-editor) `backup.editor`.
1. [Настройте](../concepts/vm-connection.md#vm-network-access) сетевой доступ для ВМ.

## Создание ВМ {#creating-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите [операционную систему, поддерживаемую в {{ backup-name }}](../concepts/vm-connection.md#windows).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      1. Выберите подсеть, соответствующую выбранной зоне доступности.
      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
      1. Выберите [группу безопасности](../../vpc/concepts/security-groups.md), настроенную для работы с {{ backup-name }}.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ и описание ВМ. Требования к имени:

      {% include [name-format](../../_includes/name-format.md) %}

      {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}**:

      1. Выберите сервисный аккаунт с ролью `backup.editor`.
      1. Включите опцию **{{ ui-key.yacloud.compute.instances.create.section_backup }}**.
      1. (опционально) Выберите политику резервного копирования или нажмите **{{ ui-key.yacloud.common.create }}**, чтобы [создать](./policy-vm/create.md) новую политику.

  1. Укажите другие необходимые параметры ВМ.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  1. Выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc resource-manager folder list
      ```

      Результат:

      ```text
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
      | b0c6n43f9lgh******** | default-{{ region-id }}-d     | enpe3m3fa00u******** |                | {{ region-id }}-d     | [10.***.0.0/24] |
      | e2l2da8a20b3******** | default-{{ region-id }}-b     | enpe3m3fa00u******** |                | {{ region-id }}-b     | [10.***.0.0/24] |
      | e9bnlm18l70a******** | default-{{ region-id }}-a     | enpe3m3fa00u******** |                | {{ region-id }}-a     | [10.***.0.0/24] |
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      ```

  1. Создайте файл `init.ps1` со сценарием для установки на ВМ агента {{ backup-name }}:

      ```powershell
      #ps1_sysnative
      echo 'Starting to execute backup agent installation'
      Invoke-WebRequest https://{{ s3-storage-host }}/backup-distributions/agent_installer.ps1 -UseBasicParsing | Invoke-Expression
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

      * `--name` — имя ВМ.

        {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

      * `--zone` — [зона доступности](../../overview/concepts/geo-scope.md), которая соответствует выбранной подсети.
      * `subnet-name` — имя выбранной [подсети](../../vpc/concepts/network.md#subnet).
      * `security-group-ids` — идентификатор [группы безопасности](../../vpc/concepts/security-groups.md), настроенной для работы с {{ backup-name }}.
      * `image-id` — [идентификатор образа](../../compute/concepts/image.md) операционной системы. См. [список поддерживаемых ОС на базе Windows](../concepts/vm-connection.md#windows).
      * `size` — размер загрузочного диска.
      * `--cores` — [количество vCPU](../../compute/concepts/vm.md) ВМ.
      * `--core-fraction` — гарантированная доля vCPU в %.
      * `--memory` — [объем оперативной памяти](../../compute/concepts/vm.md) ВМ.
      * `--service-account-name` — имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) с ролью `backup.editor`.
      * `--user-data` — путь к созданному ранее файлу со сценарием для установки на ВМ агента {{ backup-name }}.

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

      ```text
      done (46s)
      id: abcdho6nspdk********
      folder_id: wasdcjs6be29********
      created_at: "2023-10-09T14:57:06Z"
      name: my-vm
      ...
      placement_policy: {}
      ```

      {% include [cli-metadata-variables-substitution-notice](../../_includes/compute/create/cli-metadata-variables-substitution-notice.md) %}

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
