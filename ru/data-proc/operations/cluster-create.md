# Создание кластера {{ dataproc-name }}

Для создания кластера {{ dataproc-name }} пользователю должны быть назначены роли `editor` и `dataproc.agent`. Подробнее см. в [описании ролей](../security/index.md#roles).

## Настройте сеть {#setup-network}

В подсети, к которой будет подключен подкластер с управляющим хостом, [настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md). Это необходимо, чтобы подкластер мог взаимодействовать c сервисами {{ yandex-cloud }} или хостами в других сетях.

## Настройте группы безопасности {#change-security-groups}

{% note warning %}

Группы безопасности необходимо создать и настроить перед созданием кластера. Если в выбранных группах безопасности не будет необходимых правил, {{ yandex-cloud }} заблокирует создание кластера.

{% endnote %}

1. [Создайте](../../vpc/operations/security-group-create.md) одну или несколько групп безопасности для служебного трафика кластера.
1. [Добавьте правила](../../vpc/operations/security-group-add-rule.md):

    * По одному правилу для входящего и исходящего служебного трафика:

        * Диапазон портов — `{{ port-any }}`.
        * Протокол — `Любой` (`Any`).
        * Источник — `Группа безопасности`.
        * Группа безопасности — `Текущая` (`Self`).

    * Отдельное правило для исходящего HTTPS-трафика:

        * Диапазон портов — `{{ port-https }}`.
        * Протокол — `TCP`.
        * Назначение — `CIDR`.
        * CIDR блоки — `0.0.0.0/0`.

        Это позволит использовать [бакеты {{ objstorage-full-name }}](../../storage/concepts/bucket.md), [UI Proxy](../concepts/interfaces.md) и [автоматическое масштабирование](../concepts/autoscaling.md) кластеров.

Если планируется использовать несколько групп безопасности для кластера, разрешите весь трафик между этими группами.

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера.

{% endnote %}

Настройку групп безопасности для [подключения к хостам кластера](connect.md) через промежуточную ВМ можно выполнить после создания кластера.

## Создайте кластер {#create}

Кластер должен состоять из подкластера с управляющим хостом и как минимум из одного подкластера для хранения или обработки данных.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер.

  1. Нажмите кнопку **Создать ресурс** и выберите ![image](../../_assets/data-proc/data-proc.svg) **Кластер {{ dataproc-name }}** в выпадающем списке.

  1. Введите имя кластера в поле **Имя кластера**. Требования к имени:

     * Должно быть уникальным в рамках каталога

     {% include [name-format.md](../../_includes/name-format.md) %}

  1. Выберите подходящую [версию образа](../concepts/environment.md) и сервисы, которые вы хотите использовать в кластере.

     {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

     {% note tip %}

     Чтобы использовать самую свежую версию образа, укажите значение `2.0`.

     {% endnote %}

  1. Вставьте в поле **SSH-ключ** публичную часть вашего SSH-ключа. Как сгенерировать и использовать SSH-ключи, читайте в [документации {{ compute-full-name }}](../../compute/operations/vm-connect/ssh.md).
  1. Выберите или создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которому нужно разрешить доступ к кластеру.
  1. Выберите зону доступности для кластера.
  1. При необходимости задайте [свойства компонентов кластера, заданий и среды окружения](../concepts/settings-list.md).
  1. При необходимости укажите пользовательские [скрипты инициализации](../concepts/init-action.md) хостов кластера. Для каждого скрипта укажите:

      * **URI** — ссылка на скрипт инициализации в схеме `https://`, `http://`, `hdfs://` или `s3a://`.
      * (Опционально) **Таймаут** —  таймаут (в секундах) выполнения скрипта. Скрипт инициализации, выполняющийся дольше указанного времени, будет прерван.
      * (Опционально) **Аргументы** — заключенные в квадратные скобки `[]` и разделенные запятыми аргументы, с которыми должен быть выполнен скрипт инициализации, например:

          ```text
          ["arg1","arg2",...,"argN"]
          ```

  1. Выберите имя бакета в {{ objstorage-full-name }}, в котором будут храниться зависимости заданий и результаты их выполнения.
  1. Выберите сеть для кластера.
  1. Выберите группы безопасности, в которых имеются необходимые разрешения.

      {% note warning %}

      При создании кластера проверяются настройки групп безопасности. Если функционирование кластера с этими настройками невозможно, то будет выведено предупреждение. Пример работающих настроек приведен [выше](#change-security-groups).

      {% endnote %}

  1. Включите опцию **UI Proxy**, чтобы получить доступ к [веб-интерфейсам компонентов](../concepts/interfaces.md) {{ dataproc-name }}.
  
  1. Логи кластера сохраняются в сервисе [{{ cloud-logging-full-name }}](../../logging/). Выберите нужную лог-группу из списка или [создайте новую](../../logging/operations/create-group.md).

      Для работы этой функции [назначьте сервисному аккаунту кластера](../../iam/operations/roles/grant.md#access-to-sa) роль `logging.writer`. Подробнее см. в [документации {{ cloud-logging-full-name }}](../../logging/security/index.md).

  1. Настройте подкластеры: не больше одного подкластера с управляющим хостом (обозначается как **Мастер**), и подкластеры для хранения или обработки данных.

     Роли подкластеров для хранения и обработки данных различаются тем, что на подкластерах для хранения данных можно разворачивать компоненты для хранения, а для обработки — компоненты для вычислений. Хранилище на подкластере для обработки данных предназначено только для временного хранения обрабатываемых файлов.

  1. Для каждого подкластера можно настроить:

     * Количество хостов.
     * [Класс хостов](../concepts/instance-types.md) — платформа и вычислительные ресурсы, доступные хосту.
     * Размер и тип [хранилища](../concepts/storage.md).
     * Подсеть сети, в которой расположен кластер.

      В подсети для подкластера с управляющим хостом нужно [настроить NAT-шлюз](../../vpc/operations/create-nat-gateway.md).

      1. Для доступа к хостам подкластера из интернета выберите опцию **Публичный доступ**. В этом случае подключаться к хостам подкластера можно только с использованием SSL-соединения. Подробнее см. в разделе [{#T}](connect.md).

        {% note warning %}

        После создания кластера невозможно запросить или отключить публичный доступ к подкластеру. Однако подкластер для обработки данных можно удалить и создать заново с нужной настройкой публичного доступа.

        {% endnote %}

  1. В подкластерах для обработки данных можно задать параметры [автоматического масштабирования](../concepts/autoscaling.md).

     {% include [note-info-service-account-roles](../../_includes/data-proc/service-account-roles.md) %}

     1. В блоке **Добавить подкластер** нажмите кнопку **Добавить**.
     1. В поле **Роли** выберите `COMPUTENODE`.
     1. В блоке **Масштабирование** включите настройку **Автоматическое масштабирование**.
     1. Задайте параметры автоматического масштабирования.
     1. По умолчанию в качестве метрики для автоматического масштабирования используется `yarn.cluster.containersPending`. Чтобы включить масштабирование на основе загрузки CPU, выключите настройку **Масштабирование по умолчанию** и укажите целевой уровень загрузки CPU.
     1. Нажмите кнопку **Добавить**.

  1. При необходимости задайте дополнительные настройки кластера:

      **Защита от удаления** — управляет защитой кластера от непреднамеренного удаления пользователем.

      Включенная защита не помешает подключиться к кластеру вручную и удалить данные.

  1. Нажмите кнопку **Создать кластер**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать кластер:

    
    1. Проверьте, есть ли в каталоге подсети для хостов кластера:

        ```bash
        yc vpc subnet list
        ```

        Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе {{ vpc-full-name }}.


    1. Посмотрите описание команды CLI для создания кластера:

        ```bash
        {{ yc-dp }} cluster create --help
        ```

    1. Укажите параметры кластера в команде создания (в примере приведены не все доступные параметры):

        
        ```bash
        {{ yc-dp }} cluster create <имя кластера> \
           --bucket=<имя бакета> \
           --zone=<зона доступности> \
           --service-account-name=<имя сервисного аккаунта кластера> \
           --version=<версия образа> \
           --services=<список компонентов> \
           --ssh-public-keys-file=<полный путь к файлу с публичной частью SSH-ключа> \
           --subcluster name=<имя подкластера с управляющим хостом>,`
                       `role=masternode,`
                       `resource-preset=<класс хоста>,`
                       `disk-type=<тип хранилища: network-ssd, network-hdd или network-ssd-nonreplicated>,`
                       `disk-size=<размер хранилища в гигабайтах>,`
                       `subnet-name=<имя подсети>,`
                       `assign-public-ip=<публичный доступ к хосту подкластера: true или false> \
           --subcluster name=<имя подкластера для хранения данных>,`
                       `role=datanode,`
                       `resource-preset=<класс хоста>,`
                       `disk-type=<тип хранилища: network-ssd, network-hdd или network-ssd-nonreplicated>,`
                       `disk-size=<размер хранилища в гигабайтах>,`
                       `subnet-name=<имя подсети>,`
                       `hosts-count=<количество хостов>,`
                       `assign-public-ip=<публичный доступ к хостам подкластера: true или false> \
           --deletion-protection=<защита от удаления кластера: true или false> \
           --ui-proxy=<доступ к веб-интерфейсам компонентов: true или false> \
           --security-group-ids=<список идентификаторов групп безопасности> \
           --log-group-id=<идентификатор лог-группы>
        ```



        {% note info %}

        Имя кластера должно быть уникальным в рамках каталога. Может содержать латинские буквы, цифры, дефис и нижнее подчеркивание. Максимальная длина имени 63 символа.

        {% endnote %}

        Где:

        * `--bucket` — имя бакета в {{ objstorage-full-name }}, в котором будут храниться зависимости заданий и результаты их выполнения. Сервисный аккаунт кластера должен иметь разрешение `READ и WRITE` для этого бакета.
        * `--zone` — [зона доступности](../../overview/concepts/geo-scope.md), в которой должны быть размещены хосты кластера.
        * `--service-account-name` — имя [сервисного аккаунта кластера](../../iam/concepts/users/service-accounts.md). Сервисному аккаунту кластера должна быть назначена роль `mdb.dataproc.agent`.
        * `--version` — [версия образа](../concepts/environment.md).

            {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

            {% note tip %}

            Чтобы использовать самую свежую версию образа, укажите значение `2.0` в параметре `--version`.

            {% endnote %}

        * `--services` — список [компонентов](../concepts/environment.md), которые вы хотите использовать в кластере. Если не указать этот параметр, будет использоваться набор по умолчанию: `hdfs`, `yarn`, `mapreduce`, `tez`, `spark`.
        * `--ssh-public-keys-file` — полный путь к файлу с публичной частью SSH-ключа, который будет использоваться для доступа к хостам кластера. Как создать и использовать SSH-ключи, читайте в [документации {{ compute-full-name }}](../../compute/operations/vm-connect/ssh.md).
        * `--subcluster` — параметры подкластеров:
            * `name` — имя подкластера.
            * `role` — роль подкластера: `masternode`, `datanode` или `computenode`.
            * `resource-preset` — [класс хостов](../concepts/instance-types.md).
            * `disk-type` — [тип хранилища](../concepts/storage.md).
            * `disk-size` — размер хранилища в гигабайтах.
            * `subnet-name` — [имя подсети](../../vpc/concepts/network.md#subnet).
            * `hosts-count` — количество хостов подкластеров для хранения или обработки данных. Минимальное значение — `1`, максимальное — `32`.
            * `assign-public-ip` — доступ к хостам подкластера из интернета. В этом случае подключаться к кластеру можно только с использованием SSL-соединения. Подробнее см. в разделе [{#T}](connect.md).

                {% note warning %}

                После создания кластера невозможно запросить или отключить публичный доступ к подкластеру. Однако подкластер для обработки данных можно удалить и создать заново с нужной настройкой публичного доступа.

                {% endnote %}

        * `--deletion-protection` — защита от удаления кластера.

            {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

        * `--ui-proxy` — доступ к [веб-интерфейсам компонентов](../concepts/interfaces.md) {{ dataproc-name }}.
        * `--security-group-ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).
                * `--log-group-id` — [идентификатор лог-группы](../concepts/logs.md).

        Чтобы создать кластер, состоящих из нескольких подкластеров для хранения или обработки данных, передайте необходимое количество аргументов `--subcluster` в команде создания кластера:

        ```bash
        {{ yc-dp }} cluster create <имя кластера> \
           ...
           --subcluster <параметры подкластера> \
           --subcluster <параметры подкластера> \
           ...
        ```

        1. Чтобы включить [автоматическое масштабирование](../concepts/autoscaling.md) в подкластерах для обработки данных, задайте параметры:

            ```bash
            {{ yc-dp }} cluster create <имя кластера> \
               ...
               --subcluster name=<имя подкластера>,`
                           `role=computenode`
                           `...`
                           `hosts-count=<минимальное количество хостов>`
                           `max-hosts-count=<максимальное количество хостов>,`
                           `preemptible=<использование прерываемых ВМ: true или false>,`
                           `warmup-duration=<время на разогрев ВМ>,`
                           `stabilization-duration=<период стабилизации>,`
                           `measurement-duration=<промежуток измерения нагрузки>,`
                           `cpu-utilization-target=<целевой уровень загрузки CPU, %>,`
                           `autoscaling-decommission-timeout=<таймаут декомиссии, сек.>
            ```

            Где:

            * `hosts-count` — минимальное количество хостов (виртуальных машин) в подкластере. Минимальное значение — `1`, максимальное — `32`.
            * `max-hosts-count` — максимальное количество хостов (виртуальных машин) в подкластере. Минимальное значение — `1`, максимальное — `100`.
            * `preemptible` — использование [прерываемых ВМ](../../compute/concepts/preemptible-vm.md).
            * `warmup-duration` — время в секундах на разогрев ВМ, в формате `<значение>s`. Минимальное значение — `0s`, максимальное — `600s` (10 минут).
            * `stabilization-duration` — период в секундах, в течение которого требуемое количество ВМ не может быть снижено, в формате `<значение>s`. Минимальное значение — `60s` (1 минута), максимальное — `1800s` (30 минут).
            * `measurement-duration` — период в секундах, за который замеры нагрузки усредняются для каждой ВМ, в формате `<значение>s`. Минимальное значение — `60s` (1 минута), максимальное — `600s` (10 минут).
            * `cpu-utilization-target` — целевой уровень загрузки CPU, в процентах. Используйте эту настройку, чтобы включить [масштабирование](../concepts/autoscaling.md) на основе загрузки CPU, иначе в качестве метрики будет использоваться `yarn.cluster.containersPending` (на основе количества ожидающих задания ресурсов). Минимальное значение — `10`, максимальное — `100`.
            * `autoscaling-decommission-timeout` — [таймаут декомиссии](../concepts/decommission.md) в секундах. Минимальное значение — `0`, максимальное — `86400` (сутки).

            {% include [note-info-service-account-roles](../../_includes/data-proc/service-account-roles.md) %}

    
    1. Чтобы создать кластер, размещенный на [группах выделенных хостов](../../compute/concepts/dedicated-host.md), укажите через запятую их идентификаторы в параметре `--host-group-ids`:

        ```bash
        {{ yc-dp }} cluster create <имя кластера> \
           ...
           --host-group-ids=<идентификаторы групп выделенных хостов>
        ```

        {% include [Dedicated hosts note](../../_includes/data-proc/note-dedicated-hosts.md) %}


    1. Чтобы настроить хосты кластера с помощью [скриптов инициализации](../concepts/init-action.md), укажите их в одном или нескольких параметрах `--initialization-action`:

        ```bash
        {{ yc-dp }} cluster create <имя кластера> \
           ...
           --initialization-action uri=<URI скрипта инициализации>,`
                                  `timeout=<таймаут выполнения скрипта>,`
                                  `args=["arg1","arg2","arg3",...]
        ```

        Где:

        * `uri` — ссылка на скрипт инициализации в схеме `https://` или `s3a://`.
        * (Опционально) `timeout` —  таймаут (в секундах) выполнения скрипта. Скрипт инициализации, выполняющийся дольше указанного времени, будет прерван.
        * (Опционально) `args` — разделенные запятыми аргументы, с которыми должен быть выполнен скрипт инициализации.

- {{ TF }}

    {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Чтобы создать кластер:

    1. В командной строке перейдите в каталог, в котором будут расположены конфигурационные файлы {{ TF }} с планом инфраструктуры. Если такой директории нет — создайте ее.

    
    1. Если у вас еще нет {{ TF }}, [установите его и создайте конфигурационный файл с настройками провайдера](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    1. Создайте конфигурационный файл с описанием [облачной сети](../../vpc/concepts/network.md#network) и [подсетей](../../vpc/concepts/network.md#subnet).

       Кластер размещается в облачной сети. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.

       Хосты кластера размещаются в подсетях выбранной облачной сети. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

       Пример структуры конфигурационного файла, в котором описывается облачная сеть с одной подсетью:

       ```hcl
       resource "yandex_vpc_network" "<имя сети в {{ TF }}>" { name = "<имя сети>" }

       resource "yandex_vpc_subnet" "<имя подсети в {{ TF }}>" {
         name           = "<имя подсети>"
         zone           = "<зона доступности>"
         network_id     = yandex_vpc_network.<имя сети в {{ TF }}>.id
         v4_cidr_blocks = ["<подсеть>"]
       }
       ```


    1. Создайте конфигурационный файл с описанием [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), которому нужно разрешить доступ к кластеру, а также [статического ключа](../../iam/concepts/authorization/access-key.md) и [бакета {{ objstorage-full-name }}](../../storage/concepts/bucket.md) для хранения заданий и результатов.

       ```hcl
       resource "yandex_iam_service_account" "<имя сервисного аккаунта в {{ TF }}>" {
         name        = "<имя сервисного аккаунта>"
         description = "<описание сервисного аккаунта>"
       }

       resource "yandex_resourcemanager_folder_iam_binding" "dataproc" {
         folder_id = "<идентификатор каталога>"
         role      = "mdb.dataproc.agent"
         members   = [
           "serviceAccount:${yandex_iam_service_account.<имя сервисного аккаунта в {{ TF }}>.id}"
         ]
       }

       resource "yandex_resourcemanager_folder_iam_binding" "bucket-creator" {
         folder_id = "<идентификатор каталога>"
         role      = "editor"
         members   = [
           "serviceAccount:${yandex_iam_service_account.<имя сервисного аккаунта в {{ TF }}>.id}"
         ]
       }

       resource "yandex_iam_service_account_static_access_key" "<имя статического ключа в {{ TF }}>" {
         service_account_id = yandex_iam_service_account.<имя сервисного аккаунта в {{ TF }}>.id
       }

       resource "yandex_storage_bucket" "<имя бакета в {{ TF }}>" {
         depends_on = [
           yandex_resourcemanager_folder_iam_binding.bucket-creator
         ]

         bucket     = "<имя бакета>"
         access_key = yandex_iam_service_account_static_access_key.<имя статического ключа в {{ TF }}>.access_key
         secret_key = yandex_iam_service_account_static_access_key.<имя статического ключа в {{ TF }}>.secret_key
       }
       ```

    1. Создайте конфигурационный файл с описанием кластера и его подкластеров.

       При необходимости здесь же можно задать [свойства компонентов кластера, заданий и среды окружения](../concepts/settings-list.md).

       Пример структуры конфигурационного файла, в котором описывается кластер из одного подкластера с управляющим хостом, одного подкластера для хранения данных и одного подкластера для обработки данных:

       ```hcl
       resource "yandex_dataproc_cluster" "<имя кластера в {{ TF }}>" {
         bucket              = "<имя бакета в {{ TF }}>"
         name                = "<имя кластера>"
         description         = "<описание кластера>"
         service_account_id  = "<идентификатор сервисного аккаунта в {{ TF }}>"
         zone_id             = "<зона доступности>"
         security_group_ids  = ["<список идентификаторов групп безопасности>"]
         deletion_protection = <защита от удаления кластера: true или false>

         cluster_config {
           version_id = "<версия образа>"

           hadoop {
             services   = ["<список компонентов>"]
             # пример списка: ["HDFS", "YARN", "SPARK", "TEZ", "MAPREDUCE", "HIVE"]
             properties = {
               "<свойство компонента>" = <значение>
               ...
             }
             ssh_public_keys = [
               file("${file("<путь к файлу публичной части SSH-ключа>")}")
             ]
           }

           subcluster_spec {
             name = "<имя подкластера с управляющим хостом>"
             role = "MASTERNODE"
             resources {
               resource_preset_id = "<класс хоста>"
               disk_type_id       = "<тип хранилища>"
               disk_size          = <объем хранилища, ГБ>
             }
             subnet_id   = "<идентификатор подсети в {{ TF }}>"
             hosts_count = 1
           }

           subcluster_spec {
             name = "<имя подкластера для хранения данных>"
             role = "DATANODE"
             resources {
               resource_preset_id = "<класс хоста>"
               disk_type_id       = "<тип хранилища>"
               disk_size          = <объем хранилища, ГБ>
             }
             subnet_id   = "<идентификатор подсети в {{ TF }}>"
             hosts_count = <число хостов в подкластере>
           }

           subcluster_spec {
             name = "<имя подкластера для обработки данных>"
             role = "COMPUTENODE"
             resources {
               resource_preset_id = "<класс хоста>"
               disk_type_id       = "<тип хранилища>"
               disk_size          = <объем хранилища, ГБ>
             }
             subnet_id   = "<идентификатор подсети в {{ TF }}>"
             hosts_count = <число хостов в подкластере>
           }
         }
       }
       ```

       {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

       {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

       {% note tip %}

       Чтобы использовать самую свежую версию образа, укажите значение `2.0` в параметре `version_id`.

       {% endnote %}

       Чтобы получить доступ к [веб-интерфейсам компонентов](../concepts/interfaces.md) {{ dataproc-name }}, добавьте в описание кластера поле `ui_proxy`:

       ```hcl
       resource "yandex_dataproc_cluster" "<имя кластера в {{ TF }}>" {
         ...
         ui_proxy = <включить опцию UI Proxy: true или false>
         ...
       }
       ```

       Чтобы задать параметры [автоматического масштабирования](../concepts/autoscaling.md) в подкластерах для обработки данных, добавьте в описание соответствующего подкластера `subcluster_spec` блок `autoscaling_config` с нужными вам настройками:

       ```hcl
       subcluster_spec {
         name = "<имя подкластера>"
         role = "COMPUTENODE"
         ...
         autoscaling_config {
           max_hosts_count        = <максимальное количество ВМ в группе>
           measurement_duration   = <промежуток измерения нагрузки (в секундах)>
           warmup_duration        = <время на разогрев ВМ (в секундах)>
           stabilization_duration = <период стабилизации (в секундах)>
           preemptible            = <использование прерываемых ВМ: true или false>
           cpu_utilization_target = <целевой уровень загрузки vCPU, %>
           decommission_timeout   = <таймаут декомиссии ВМ (в секундах)>
         }
       }
       ```

       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/dataproc_cluster).

    1. Проверьте корректность файлов конфигурации {{ TF }}:

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

- API

    Чтобы создать кластер, воспользуйтесь методом API [create](../api-ref/Cluster/create) и передайте в запросе:

    * Идентификатор каталога, в котором должен быть размещен кластера, в параметре `folderId`.
    * Имя кластера в параметре `name`.
    * Конфигурацию кластера в параметре `configSpec`, в том числе:
        * [Версию образа](../concepts/environment.md) в параметре `configSpec.versionId`.

            {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

            {% note tip %}

            Чтобы использовать самую свежую версию образа, укажите значение `2.0`.

            {% endnote %}

        * Список компонентов в параметре `configSpec.hadoop.services`.
        * Публичную часть SSH-ключа в параметре `configSpec.hadoop.sshPublicKeys`.
        * Настройки подкластеров в параметре `configSpec.subclustersSpec`.
    * Зону доступности кластера в параметре `zoneId`.
    * Идентификатор сервисного аккаунта кластера в параметре `serviceAccountId`.
    * Имя бакета в параметре `bucket`.
    * Идентификаторы групп безопасности кластера в параметре `hostGroupIds`.
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

    Чтобы назначить публичный IP-адрес всем хостам подкластера, передайте значение `true` в параметре `configSpec.subclustersSpec.assignPublicIp`.

    
    Чтобы создать кластер, размещенный на [группах выделенных хостов](../../compute/concepts/dedicated-host.md), передайте список их идентификаторов в параметре `hostGroupIds`.

    {% include [Dedicated hosts note](../../_includes/data-proc/note-dedicated-hosts.md) %}


    Чтобы использовать для первоначальной настройки хостов кластера [скрипты инициализации](../concepts/init-action.md), укажите их в параметре `config_spec.hadoop.initialization_actions[]`.

{% endlist %}

После того, как кластер перейдет в статус **Running**, вы можете [подключиться](connect.md) к хостам подкластеров с помощью указанного SSH-ключа.

## Примеры {#examples}

### Создание легковесного кластера для заданий Spark и PySpark {#creating-a-light-weight-cluster}

{% list tabs %}

- CLI

    Создайте кластер {{ dataproc-name }} для выполнения заданий Spark без HDFS и подкластеров для хранения данных с тестовыми характеристиками:

    * С именем `my-dataproc`.
    * С бакетом `dataproc-bucket`.
    * В зоне доступности `{{ zone-id }}`.
    * С сервисным аккаунтом `dataproc-sa`.
    * Образом версии `2.0`.
    * С компонентами `SPARK` и `YARN`.
    * С путем к публичной части SSH-ключа `/home/username/.ssh/id_rsa.pub`.
    * С подкластером с управляющими хостами `master` и одним подкластером для обработки данных `compute`:

        * Класса `{{ host-class }}`.
        * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 20 ГБ.
        * В подсети `{{ subnet-name }}`.
        * С публичным доступом.

    * В группе безопасности `{{ security-group }}`.
    * С защитой от случайного удаления кластера.

    Выполните следующую команду:

    ```bash
    {{ yc-dp }} cluster create my-dataproc \
       --bucket=dataproc-bucket \
       --zone={{ zone-id }} \
       --service-account-name=dataproc-sa \
       --version=2.0 \
       --services=SPARK,YARN \
       --ssh-public-keys-file=/home/username/.ssh/id_rsa.pub \
       --subcluster name="master",`
                   `role=masternode,`
                   `resource-preset={{ host-class }},`
                   `disk-type={{ disk-type-example }},`
                   `disk-size=20,`
                   `subnet-name={{ subnet-name }},`
                   `assign-public-ip=true \
       --subcluster name="compute",`
                   `role=computenode,`
                   `resource-preset={{ host-class }},`
                   `disk-type={{ disk-type-example }},`
                   `disk-size=20,`
                   `subnet-name={{ subnet-name }},`
                   `assign-public-ip=true \
       --security-group-ids={{ security-group }} \
       --deletion-protection=true
    ```

{% endlist %}
