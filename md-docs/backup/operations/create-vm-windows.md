# Создать виртуальную машину Windows Server с подключением к {{ backup-name }}

Вы можете создавать резервные копии [виртуальных машин](../../compute/concepts/vm.md) {{ compute-name }} c [поддерживаемыми операционными системами на базе Windows](../concepts/vm-connection.md#windows).

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

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать ВМ.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите [операционную систему, поддерживаемую в {{ backup-name }}](../concepts/vm-connection.md#windows).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      1. Выберите подсеть, соответствующую выбранной зоне доступности.
      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
      1. Выберите [группу безопасности](../../vpc/concepts/security-groups.md), настроенную для работы с {{ backup-name }}.
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

        {% note info %}
        
        Имя виртуальной машины используется для генерации [внутреннего FQDN](../../compute/concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
        
        {% endnote %}

      * `--zone` — [зона доступности](../../overview/concepts/geo-scope.md), которая соответствует выбранной подсети.
      * `subnet-name` — имя выбранной [подсети](../../vpc/concepts/network.md#subnet).
      * `security-group-ids` — идентификатор [группы безопасности](../../vpc/concepts/security-groups.md), настроенной для работы с {{ backup-name }}.
      * `image-id` — [идентификатор образа](../../compute/concepts/image.md) операционной системы. См. [список поддерживаемых ОС на базе Windows](../concepts/vm-connection.md#windows).
      * `size` — размер загрузочного диска.
      * `--cores` — [количество vCPU](../../compute/concepts/vm.md) ВМ.
      * `--core-fraction` — гарантированная доля vCPU в %.
      * `--memory` — [объем оперативной памяти](../../compute/concepts/vm.md) ВМ.
      * `--service-account-name` — имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) с ролью `backup.user` или выше.
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
        --service-account-name backup-user \
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

      {% note info %}
      
      Команды [`yc compute instance create`](../../cli/cli-ref/compute/cli-ref/instance/create.md) | [`create-with-container`](../../cli/cli-ref/compute/cli-ref/instance/create-with-container.md) | [`update`](../../cli/cli-ref/compute/cli-ref/instance/update.md) | [`add-metadata`](../../cli/cli-ref/compute/cli-ref/instance/add-metadata.md) поддерживают подстановку в метаданные ВМ значений переменных окружения. Эти значения, заданные в ключе `user-data` в формате `$<имя_переменной>`, в момент выполнения команды {{ yandex-cloud }} CLI будут подставлены в метаданные ВМ из переменных окружения среды, в которой выполняется команда. 
      
      Чтобы изменить такое поведение, не подставлять значение переменной из среды выполнения команды CLI и передать в метаданные ВМ имя переменной в формате `$<имя_переменной>`, используйте синтаксис с двумя символами доллара. Например: `$$<имя_переменной>`.
      
      Подробнее см. в разделе [{#T}](../../compute/concepts/metadata/sending-metadata.md#environment-variables).
      
      {% endnote %}

{% endlist %}

Когда ВМ перейдет в статус `Running`, на нее начнет устанавливаться агент {{ backup-name }}. Установка займет от 10 до 30 минут.

{% note info %}

Если через 30 минут агент {{ backup-name }} не установился, [обратитесь]({{ link-console-support }}) в техническую поддержку для диагностики проблемы.

{% endnote %}

После установки агента {{ backup-name }} ВМ будет добавлена в сервис **{{ backup-name }}** на вкладку ![machines](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_instances }}**, и ее можно будет привязать к [политике резервного копирования](../concepts/policy.md). Если вы выбрали политику при создании ВМ, то ВМ уже привязана к политике, дополнительные действия не требуются.

#### См. также {#see-also}

* [{#T}](connect-vm-windows.md)
* [{#T}](connect-vm-linux.md)
* [Привязать виртуальную машину к политике резервного копирования](policy-vm/update.md#update-vm-list)
* [{#T}](backup-vm/recover.md)
* [{#T}](backup-vm/delete.md)
* [{#T}](policy-vm/create.md)