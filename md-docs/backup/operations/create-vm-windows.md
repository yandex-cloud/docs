# Создать виртуальную машину Windows Server с подключением к Cloud Backup

Вы можете создавать резервные копии [виртуальных машин](../../compute/concepts/vm.md) Compute Cloud c [поддерживаемыми операционными системами на базе Windows](../concepts/vm-connection.md#windows).

Для корректной работы [агента Cloud Backup](../concepts/agent.md) ВМ должна соответствовать [минимальным требованиям](../concepts/vm-connection.md#requirements).

## Перед началом работы {#before-you-begin}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с [ролью](../security/index.md#backup-user) `backup.user` или выше.

    При создании ВМ с помощью [консоли управления](https://console.yandex.cloud) использовать сервисный аккаунт не обязательно. При этом пользователю, создающему ВМ, должна быть назначена [роль](../security/index.md#backup-user) `backup.user` или выше на каталог, в котором создается ВМ.

    {% note warning %}

    С 1 августа 2026 года роли [compute.editor](../../compute/security/index.md#compute-editor) и [compute.admin](../../compute/security/index.md#compute-admin) получают новый набор разрешений от роли [backup.user](../security/index.md#backup-user), позволяющий подключать виртуальные машины к сервису Yandex Cloud Backup, а также привязывать и отвязывать их от [политик резервного копирования](../concepts/policy.md).

    Если вы не планируете подключать ваши ресурсы к Cloud Backup и не хотите предоставлять вашим пользователям такие разрешения, вы можете заблаговременно отключить эти возможности с помощью [политики авторизации](../../iam/concepts/access-control/access-policies.md#backup-denyActivation) `backup.denyActivation`, назначенной на каталог, облако или организацию. Подробнее о том, как создать политику авторизации, читайте в разделе [Создание политики авторизации для ресурса](../../iam/operations/access-policies/assign.md).

    {% endnote %}

1. [Настройте](../concepts/vm-connection.md#vm-network-access) сетевой доступ для ВМ.

## Создание ВМ {#creating-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **Виртуальные машины** и нажмите кнопку **Создать виртуальную машину**.
  1. В блоке **Образ загрузочного диска** выберите [операционную систему, поддерживаемую в Cloud Backup](../concepts/vm-connection.md#windows).
  1. В блоке **Расположение** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **Сетевые настройки**:

      1. Выберите подсеть, соответствующую выбранной зоне доступности.
      1. В поле **Публичный IP-адрес** выберите `Автоматически`.
      1. Выберите [группу безопасности](../../vpc/concepts/security-groups.md), настроенную для работы с Cloud Backup.
  1. Включите опцию **Резервное копирование** и в поле **Политики резервного копирования** выберите [политику](../concepts/policy.md) резервного копирования, которая будет использоваться Cloud Backup для работы с ВМ.
     
     Если у вас нет политики резервного копирования, нажмите кнопку **Создать**, чтобы создать ее.
     
     Чтобы создать новую ВМ с подключением к Cloud Backup, вашему аккаунту должна быть назначена [роль](../security/index.md#backup-user) `backup.user` или выше на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы создаете ВМ.
     
     {% note info %}
     
     Если у вашего аккаунта нет назначенной роли `backup.user` или выше, вы можете подключить ВМ к Cloud Backup с помощью [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), которому назначена такая роль. 
     
     Для этого разверните блок **Дополнительно** и в поле **Сервисный аккаунт** выберите подходящий сервисный аккаунт. При необходимости [создайте](../../iam/operations/sa/create.md) новый сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../security/index.md#backup-user) `backup.user`.
     
     {% endnote %}
     
     {% note tip %}
     
     Установка агента Cloud Backup является ресурсоемкой операцией. Если вы хотите использовать ВМ в минимально возможной конфигурации или, например, ВМ с [уровнем производительности vCPU](../../compute/concepts/performance-levels.md) ниже 100%, рекомендуем на время установки агента Cloud Backup увеличить ресурсы ВМ.
     
     {% endnote %}
     
     Подробнее читайте в разделе [Подключение виртуальных машин Compute Cloud и серверов Yandex BareMetal к Cloud Backup](../concepts/vm-connection.md).
  1. В блоке **Общая информация** задайте имя ВМ и описание ВМ. Требования к имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

      {% note info %}
      
      Имя виртуальной машины используется для генерации [внутреннего FQDN](../../compute/concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
      
      {% endnote %}

  1. Укажите другие необходимые параметры ВМ.
  1. Нажмите кнопку **Создать ВМ**.

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
      | b0c6n43f9lgh******** | default-ru-central1-d     | enpe3m3fa00u******** |                | ru-central1-d     | [10.***.0.0/24] |
      | e2l2da8a20b3******** | default-ru-central1-b     | enpe3m3fa00u******** |                | ru-central1-b     | [10.***.0.0/24] |
      | e9bnlm18l70a******** | default-ru-central1-a     | enpe3m3fa00u******** |                | ru-central1-a     | [10.***.0.0/24] |
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      ```

  1. Создайте файл `init.ps1` со сценарием для установки на ВМ агента Cloud Backup:

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

      * `--name` — имя ВМ.

        {% note info %}
        
        Имя виртуальной машины используется для генерации [внутреннего FQDN](../../compute/concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
        
        {% endnote %}

      * `--zone` — [зона доступности](../../overview/concepts/geo-scope.md), которая соответствует выбранной подсети.
      * `subnet-name` — имя выбранной [подсети](../../vpc/concepts/network.md#subnet).
      * `security-group-ids` — идентификатор [группы безопасности](../../vpc/concepts/security-groups.md), настроенной для работы с Cloud Backup.
      * `image-id` — [идентификатор образа](../../compute/concepts/image.md) операционной системы. [Список поддерживаемых ОС на базе Windows](../concepts/vm-connection.md#windows).
      * `size` — размер загрузочного диска.
      * `--cores` — [количество vCPU](../../compute/concepts/vm.md) ВМ.
      * `--core-fraction` — гарантированная доля vCPU в %.
      * `--memory` — [объем оперативной памяти](../../compute/concepts/vm.md) ВМ.
      * `--service-account-name` — имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) с ролью `backup.user` или выше.
      * `--user-data` — путь к созданному ранее файлу со сценарием для установки на ВМ агента Cloud Backup.

      В этом примере создается ВМ на базе Windows Server 2022:

      ```bash
      yc compute instance create \
        --name my-vm \
        --zone ru-central1-b \
        --network-interface subnet-name=my-vpc-ru-central1-b,nat-ip-version=ipv4,security-group-ids=abcd3570sbqg******** \
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
      
      Команды [`yc compute instance create`](../../cli/cli-ref/compute/cli-ref/instance/create.md) | [`create-with-container`](../../cli/cli-ref/compute/cli-ref/instance/create-with-container.md) | [`update`](../../cli/cli-ref/compute/cli-ref/instance/update.md) | [`add-metadata`](../../cli/cli-ref/compute/cli-ref/instance/add-metadata.md) поддерживают подстановку в метаданные ВМ значений переменных окружения. Эти значения, заданные в ключе `user-data` в формате `$<имя_переменной>`, в момент выполнения команды Yandex Cloud CLI будут подставлены в метаданные ВМ из переменных окружения среды, в которой выполняется команда. 
      
      Чтобы изменить такое поведение, не подставлять значение переменной из среды выполнения команды CLI и передать в метаданные ВМ имя переменной в формате `$<имя_переменной>`, используйте синтаксис с двумя символами доллара. Например: `$$<имя_переменной>`.
      
      Подробнее в разделе [Особенности передачи переменных окружения в метаданных через CLI](../../compute/concepts/metadata/sending-metadata.md#environment-variables).
      
      {% endnote %}

{% endlist %}

Когда ВМ перейдет в статус `Running`, на нее начнет устанавливаться агент Cloud Backup. Установка займет от 10 до 30 минут.

{% note info %}

Если через 30 минут агент Cloud Backup не установился, [обратитесь](https://center.yandex.cloud/support) в техническую поддержку для диагностики проблемы.

{% endnote %}

После установки агента Cloud Backup ВМ будет добавлена в сервис **Cloud Backup** на вкладку ![machines](../../_assets/console-icons/server.svg) **Виртуальные машины**, и ее можно будет привязать к [политике резервного копирования](../concepts/policy.md). Если вы выбрали политику при создании ВМ, то ВМ уже привязана к политике, дополнительные действия не требуются.

#### Полезные ссылки {#see-also}

* [Подключить существующую виртуальную машину на Windows Server к Cloud Backup](connect-vm-windows.md)
* [Подключить существующую виртуальную машину на Linux к Cloud Backup](connect-vm-linux.md)
* [Привязать виртуальную машину к политике резервного копирования](policy-vm/update.md#update-vm-list)
* [Восстановить виртуальную машину или сервер Yandex BareMetal из резервной копии](backup-vm/recover.md)
* [Удалить резервную копию](backup-vm/delete.md)
* [Создать политику резервного копирования](policy-vm/create.md)