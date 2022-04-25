# Создание кластера {{ dataproc-name }}

## Настройте сеть {#setup-network}

В подсети, к которой будет подключен подкластер {{ dataproc-name }} с ролью `Мастер`, [включите NAT в интернет](../../vpc/operations/enable-nat.md). Это необходимо, чтобы подкластер мог взаимодействовать c сервисами {{ yandex-cloud }} или хостами в других сетях.

## Настройте группы безопасности {#change-security-groups}

{% note warning %}

Группы безопасности необходимо создать и настроить перед созданием кластера. Если в выбранных группах безопасности не будет необходимых правил, {{ yandex-cloud }} заблокирует создание кластера.

{% endnote %}

1. [Создайте](../../vpc/operations/security-group-create.md) одну или несколько групп безопасности для служебного трафика кластера.
1. [Добавьте правила](../../vpc/operations/security-group-update.md#add-rule):

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

        Это позволит использовать [бакеты {{ objstorage-name }}](../../storage/concepts/bucket.md), [UI Proxy](../concepts/interfaces.md) и [автоматическое масштабирование](../concepts/autoscaling.md) кластеров.

Если планируется использовать несколько групп безопасности для кластера, разрешите весь трафик между этими группами.

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера.

{% endnote %}

Настройку групп безопасности для [подключения к хостам кластера](connect.md) через промежуточную ВМ можно выполнить после создания кластера.

## Создайте кластер {#create}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер.

  1. Нажмите кнопку **Создать ресурс** и выберите **Кластер {{ dataproc-name }}** в выпадающем списке.

  1. Введите имя кластера в поле **Имя кластера**. Имя кластера должно быть уникальным в рамках каталога. Требования к имени:

     {% include [name-format.md](../../_includes/name-format.md) %}

  1. Выберите подходящую [версию образа](../concepts/environment.md) и сервисы, которые вы хотите использовать в кластере.

     {% note info %}

     Обратите внимание на то, что некоторые компоненты обязательны для использования других компонентов. Например, чтобы использовать Spark необходим YARN.

     {% endnote %}

  1. Вставьте в поле **SSH-ключ** публичную часть вашего SSH-ключа. Как сгенерировать и использовать SSH-ключи, читайте в [документации {{ compute-full-name }}](../../compute/operations/vm-connect/ssh.md).
  1. Выберите или создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которому нужно разрешить доступ к кластеру.
  1. Выберите зону доступности для кластера.
  1. При необходимости задайте [свойства компонентов кластера, заданий и среды окружения](../concepts/settings-list.md).
  1. Выберите имя бакета в {{ objstorage-name }}, на котором будут храниться зависимости заданий и результаты их выполнения.
  1. Выберите сеть для кластера.
  1. Выберите группы безопасности, в которых имеются необходимые разрешения.

      {% note warning %}

      При создании кластера проверяются настройки групп безопасности. Если функционирование кластера с этими настройками невозможно, то будет выведено предупреждение. Пример работающих настроек приведен [выше](#change-security-groups).

      {% endnote %}

  1. Включите опцию **UI Proxy**, чтобы получить доступ к [веб-интерфейсам компонентов](../concepts/interfaces.md) {{ dataproc-name }}.
  1. Логи кластера сохраняются в сервисе [{{ cloud-logging-full-name }}](../../logging/). Выберите нужную лог-группу из списка или [создайте новую](../../logging/operations/create-group.md).

      Для работы этой функции [назначьте сервисному аккаунту кластера](../../iam/operations/roles/grant.md#access-to-sa) роль `logging.writer`. Подробнее см. в [документации {{ cloud-logging-full-name }}](../../logging/security/index.md).

  1. Настройте подкластеры: не больше одного главного подкластера с управляющим хостом (обозначается как **Мастер**), и подкластеры для хранения данных или вычислений.

     Роли подкластеров (`Compute` и `Data`) различаются тем, что на `Data`-подкластерах можно разворачивать компоненты для хранения данных, а на `Compute` — компоненты обработки данных. Хранилище на подкластере `Compute` предназначено только для временного хранения обрабатываемых файлов.

  1. Для каждого подкластера можно настроить:

     * Количество хостов.
     * [Класс хостов](../concepts/instance-types.md) — платформа и вычислительные ресурсы, доступные хосту.
     * Размер и тип [хранилища](../../compute/concepts/filesystem.md).
     * Подсеть сети, в которой расположен кластер.

       В подсети для подкластера с ролью `Мастер` должен быть включен NAT в интернет. Подробнее см. в разделе [{#T}](#setup-network).

  1. Для доступа к кластеру из интернета выберите опцию **Публичный доступ** в настройках главного подкластера. В этом случае подключаться к кластеру можно только с использованием SSL-соединения. Подробнее см. в разделе [{#T}](connect.md).

     {% note warning %}

     Запросить публичный доступ после создания кластера невозможно.

     {% endnote %}

  1. Для `Compute` подкластеров можно задать параметры [автоматического масштабирования](../concepts/autoscaling.md).

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

    1. Посмотрите описание команды CLI для создания кластера:

        ```bash
        yc dataproc cluster create --help
        ```

    1. Укажите параметры кластера в команде создания (в примере приведены не все доступные параметры):

        ```bash
        yc dataproc cluster create <имя кластера> \
          --zone <зона доступности кластера> \
          --service-account-name <имя сервисного аккаунта кластера> \
          --version <версия образа> \
          --services <список компонентов> \
          --subcluster name=<имя подкластера с ролью MASTERNODE>,`
                      `role=masternode,`
                      `resource-preset=<класс хоста>,`
                      `disk-type=<тип хранилища>,`
                      `disk-size=<размер хранилища, ГБ>,`
                      `subnet-name=<имя подсети>,`
                      `hosts-count=1`
                      `assign-public-ip=<назначение публичного IP-адреса всем хостам подкластера: true или false> \
          --subcluster name=<имя подкластера с ролью DATANODE>,`
                      `role=datanode,`
                      `resource-preset=<класс хоста>,`
                      `disk-type=<тип хранилища>,`
                      `disk-size=<размер хранилища, ГБ>,`
                      `subnet-name=<имя подсети>,`
                      `hosts-count=<количество хостов>,`
                      `assign-public-ip=<назначение публичного IP-адреса всем хостам подкластера: true или false> \
          --bucket <имя бакета> \
          --ssh-public-keys-file <путь к публичной части SSH-ключа> \
          --security-group-ids <список идентификаторов групп безопасности> \
          --deletion-protection=<защита от удаления кластера: true или false> \
          --log-group-id <идентификатор лог-группы>
        ```

        {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. Чтобы создать кластер, размещенный на [группах выделенных хостов](../../compute/concepts/dedicated-host.md), укажите через запятую их идентификаторы в параметре `--host-group-ids`:

        ```bash
        yc dataproc cluster create <имя кластера> \
          ...
          --host-group-ids <идентификаторы групп выделенных хостов>
        ```

        {% include [Dedicated hosts note](../../_includes/data-proc/note-dedicated-hosts.md) %}

- Terraform

  {% if audience != "internal" %}
  {% include [terraform-definition](../../_includes/tutorials/terraform-definition.md) %}
  {% endif %}

  Чтобы создать кластер:

    1. В командной строке перейдите в каталог, в котором будут расположены конфигурационные файлы {{ TF }} с планом инфраструктуры. Если такой директории нет — создайте ее.

    {% if audience != "internal" %}

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

    {% endif %}

    1. Создайте конфигурационный файл с описанием [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), которому нужно разрешить доступ к кластеру, а также [статического ключа](../../iam/concepts/authorization/access-key.md) и [бакета {{ objstorage-full-name }}](../../storage/concepts/bucket.md) для хранения заданий и результатов.

       ```hcl
       resource "yandex_iam_service_account" "<имя сервисного аккаунта в {{ TF }}>" {
         name        = "<имя сервисного аккаунта>"
         description = "<описание сервисного аккаунта>"
       }

       resource "yandex_resourcemanager_folder_iam_binding" "dataproc" {
         role    = "mdb.dataproc.agent"
         members = [
           "serviceAccount:${yandex_iam_service_account.<имя сервисного аккаунта в {{ TF }}>.id}"
         ]
       }

       resource "yandex_resourcemanager_folder_iam_binding" "bucket-creator" {
         role    = "editor"
         members = [
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

       Пример структуры конфигурационного файла, в котором описывается кластер из одного главного подкластера и одного подкластера для хранения данных:

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
               file("<путь к файлу публичной части SSH-ключа>")
             ]
           }

           subcluster_spec {
             name = "<имя подкластера>"
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
             name = "<имя подкластера>"
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
             name = "<имя подкластера>"
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

       Чтобы получить доступ к [веб-интерфейсам компонентов](../concepts/interfaces.md) {{ dataproc-name }}, добавьте в описание кластера поле `ui_proxy`:

       ```hcl
       resource "yandex_dataproc_cluster" "<имя кластера в {{ TF }}>" {
         ...
         ui_proxy            = <включить опцию UI Proxy: true или false>
         ...
       }
       ```

       Чтобы задать параметры [автоматического масштабирования](../concepts/autoscaling.md) для `Compute` подкластеров, добавьте в описание соответствующего подкластера `subcluster_spec` блок `autoscaling_config` с нужными вам настройками:

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

       Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера]({{tf-provider-dp}}).

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
        * Версию [образа](../concepts/environment.md) в параметре `configSpec.versionId`.
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

{% endlist %}

После того, как кластер перейдет в статус **Running**, вы можете [подключиться](connect.md) к хосту главного подкластера с помощью указанного SSH-ключа.
