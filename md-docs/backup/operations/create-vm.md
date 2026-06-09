# Создать виртуальную машину на Linux с подключением к {{ backup-name }}

Вы можете создавать резервные копии [виртуальных машин](../../compute/concepts/vm.md) {{ compute-name }} c [поддерживаемыми операционными системами на базе Linux](../concepts/vm-connection.md#linux).

Для корректной работы [агента {{ backup-name }}](../concepts/agent.md) ВМ должна соответствовать [минимальным требованиям](../concepts/vm-connection.md#requirements).

## Перед началом работы {#before-you-begin}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с [ролью](../security/index.md#backup-user) `backup.user` или выше.

    При создании ВМ с помощью [консоли управления]({{ link-console-main }}) использовать сервисный аккаунт не обязательно. При этом пользователю, создающему ВМ, должна быть назначена [роль](../security/index.md#backup-user) `backup.user` или выше на каталог, в котором создается ВМ.

    {% note warning %}

    С 1 августа 2026 года роли [`compute.editor`](../../compute/security/index.md#compute-editor) и [`compute.admin`](../../compute/security/index.md#compute-admin) получают новый набор разрешений, позволяющий подключать виртуальные машины к сервису {{ backup-full-name }}, а также привязывать и отвязывать их от [политик резервного копирования](../concepts/policy.md).

    Если вы не планируете подключать ваши ресурсы к {{ backup-name }} и не хотите предоставлять вашим пользователям такие разрешения, вы можете заблаговременно отключить эти возможности с помощью [политики авторизации](../../iam/concepts/access-control/access-policies.md#backup-denyActivation) `backup.denyActivation`, назначенной на каталог, облако или организацию. Подробнее о том, как создать политику авторизации, читайте в разделе [{#T}](../../iam/operations/access-policies/assign.md).

    {% endnote %}

1. [Настройте](../concepts/vm-connection.md#vm-network-access) сетевой доступ для ВМ.

## Создание ВМ {#creating-vm}

{% note info %}

Если для организации дискового пространства защищаемого ресурса вы используете [LVM](https://ru.wikipedia.org/wiki/LVM), ознакомьтесь с [особенностями](../concepts/backup.md#lvm) восстановления ресурсов с LVM в {{ backup-name }}.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать ВМ.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите [операционную систему, поддерживаемую в {{ backup-name }}](../concepts/vm-connection.md#linux).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      1. Выберите подсеть, соответствующую выбранной зоне доступности.
      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
      1. Выберите [группу безопасности](../../vpc/concepts/security-groups.md), настроенную для работы с {{ backup-name }}.
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
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ и описание ВМ. Требования к имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

      {% note info %}
      
      Имя виртуальной машины используется для генерации [внутреннего FQDN](../../compute/concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
      
      {% endnote %}

  1. Укажите другие необходимые параметры ВМ. Подробнее см. [Создать виртуальную машину из публичного образа Linux](../../compute/operations/vm-create/create-linux-vm.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Когда ВМ перейдет в статус `Running`, на нее начнет устанавливаться агент {{ backup-name }}. Установка займет от 5 до 10 минут.

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

  1. [Создайте](../../compute/operations/vm-create/create-linux-vm.md) ВМ:

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
        --ssh-key <путь_к_открытому_SSH-ключу>
      ```

      Где:

      * `--folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
      * `--name` — имя создаваемой ВМ.

        {% note info %}
        
        Имя виртуальной машины используется для генерации [внутреннего FQDN](../../compute/concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
        
        {% endnote %}

      * `--zone` — [зона доступности](../../overview/concepts/geo-scope.md), которая соответствует выбранной подсети.
      * `subnet-name` — имя выбранной [подсети](../../vpc/concepts/network.md#subnet).
      * `security-group-ids` — идентификатор [группы безопасности](../../vpc/concepts/security-groups.md), настроенной для работы с {{ backup-name }}.
      * `image-id` — [идентификатор образа](../../compute/concepts/image.md) операционной системы. См. [список поддерживаемых ОС на базе Linux](../concepts/vm-connection.md#linux).
      * `size` — размер загрузочного диска.
      * `--cores` — [количество vCPU](../../compute/concepts/vm.md) ВМ.
      * `--core-fraction` — гарантированная доля vCPU в %.
      * `--memory` — [объем оперативной памяти](../../compute/concepts/vm.md) ВМ.
      * `--service-account-name` — имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) с ролью `backup.user` или выше.
      * `--ssh-key` — путь к файлу с [открытым SSH-ключом](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Для этого ключа на ВМ будет автоматически создан пользователь `yc-user`.

      В этом примере создается ВМ на базе ОС [Ubuntu 20.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts):

      ```bash
      yc compute instance create \
        --folder-id wasdcjs6be29******** \
        --name my-vm \
        --zone {{ region-id }}-b \
        --network-interface subnet-name=my-vpc-{{ region-id }}-b,nat-ip-version=ipv4,security-group-ids=abcd3570sbqg******** \
        --create-boot-disk image-id=fd8ecgtorub9********,size=25 \
        --cores 2 \
        --core-fraction 100 \
        --memory 4 \
        --service-account-name backup-user \
        --ssh-key my-key.pub
      ```

      Результат:

      ```text
      done (46s)
      id: abcdho6nspdk********
      folder_id: wasdcjs6be29********
      created_at: "2023-10-09T14:57:06Z"
      name: my-vm
      ...
            one_to_one_nat:
              address: 158.***.**.***
      ...
      placement_policy: {}
      ```

  1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по SSH. Для подключения используйте имя пользователя `yc-user` и публичный IP-адрес ВМ, указанный в выводе результата создания ВМ в секции `one_to_one_nat`.
  1. Установите агент {{ backup-name }}:

      **Ubuntu**

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

      **CentOS**

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

Если через 10 минут агент {{ backup-name }} не установился, [обратитесь]({{ link-console-support }}) в техническую поддержку для диагностики проблемы.

{% endnote %}

После установки агента {{ backup-name }} ВМ будет добавлена в сервис **{{ backup-name }}** на вкладку ![machines](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_instances }}**, и ее можно будет привязать к [политике резервного копирования](../concepts/policy.md). Если вы выбрали политику при создании ВМ, то ВМ уже привязана к политике, дополнительные действия не требуются.

#### См. также {#see-also}

* [{#T}](connect-vm-windows.md)
* [{#T}](connect-vm-linux.md)
* [Привязать виртуальную машину к политике резервного копирования](policy-vm/update.md#update-vm-list)
* [{#T}](backup-vm/recover.md)
* [{#T}](backup-vm/delete.md)
* [{#T}](policy-vm/create.md)