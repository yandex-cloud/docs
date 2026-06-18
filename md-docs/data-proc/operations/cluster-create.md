# Создание кластера Yandex Data Processing

## Роли для создания кластера {#roles}

Для создания кластера Yandex Data Processing вашему аккаунту в Yandex Cloud нужны роли:

* [dataproc.editor](../security/index.md#dataproc-editor) — чтобы создать кластер;
* [vpc.user](../../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../../vpc/concepts/network.md#network) кластера;
* [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) — чтобы привязать [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) к кластеру и создавать ресурсы от имени этого сервисного аккаунта.
* [resource-manager.auditor](../../resource-manager/security/index.md#resource-manager-auditor) и выше на каталог, в котором, нужно создать кластер Yandex Data Processing — для подключения к кластеру с помощью [OS Login](../../organization/concepts/os-login.md).

Сервисному аккаунту кластера Yandex Data Processing должны быть назначены роли:

* [dataproc.agent](../security/index.md#dataproc-agent) — чтобы сервисный аккаунт мог получать информацию о состоянии хостов кластера, [заданиях](../concepts/jobs.md) и [лог-группах](../../logging/concepts/log-group.md).
* [dataproc.provisioner](../security/index.md#dataproc-provisioner) — чтобы сервисный аккаунт мог взаимодействовать с автоматически масштабируемой группой ВМ. Тогда будет доступно [автомасштабирование подкластеров](../concepts/autoscaling.md).
* [resource-manager.auditor](../../resource-manager/security/index.md#resource-manager-auditor) и выше на каталог, в котором нужно создать кластер Yandex Data Processing — для подключения к кластеру с помощью [OS Login](../../organization/concepts/os-login.md).

{% note tip %}

Чтобы ограничить права сервисного аккаунта кластера (его IAM-токен доступен при выполнении заданий):

1. Укажите отдельный сервисный аккаунт для автомасштабирования подкластеров при [создании](cluster-create.md) или [изменении кластера](cluster-update.md) через интерфейсы Yandex Cloud CLI, Terraform или API.
1. Назначьте роль `dataproc.provisioner` только этому аккаунту.

{% endnote %}

О назначении ролей читайте в [документации Yandex Identity and Access Management](../../iam/operations/roles/grant.md).


## Настройте сеть {#setup-network}

Настройте доступ в интернет из [подсети](../../vpc/concepts/network.md#subnet), к которой будет подключен [подкластер](../concepts/index.md#resources) Yandex Data Processing с хостом-мастером, например при помощи [NAT-шлюза](../../vpc/operations/create-nat-gateway.md). Это необходимо, чтобы подкластер Yandex Data Processing мог взаимодействовать с сервисами Yandex Cloud или хостами в других сетях.

## Настройте группы безопасности {#change-security-groups}

{% note warning %}

[Группы безопасности](../../vpc/concepts/security-groups.md) необходимо создать и настроить перед созданием кластера Yandex Data Processing. Если в выбранных группах безопасности не будет необходимых правил, Yandex Cloud заблокирует создание кластера Yandex Data Processing.

{% endnote %}

1. [Создайте](../../vpc/operations/security-group-create.md) одну или несколько групп безопасности для служебного трафика кластера Yandex Data Processing.
1. [Добавьте правила](../../vpc/operations/security-group-add-rule.md):
   * По одному правилу для входящего и исходящего служебного трафика:
     * **Диапазон портов** — `0-65535`.
     * **Протокол** — `Любой`.
     * **Источник**/**Назначение** — `Группа безопасности`.
     * **Группа безопасности** — `Текущая`.
   * Отдельное правило для исходящего HTTPS-трафика. Это позволит использовать [бакеты](../../storage/concepts/bucket.md) [Yandex Object Storage](../../storage/index.md), [UI Proxy](../concepts/interfaces.md) и [автоматическое масштабирование](../concepts/autoscaling.md) кластеров Yandex Data Processing.

     Вы можете настроить это правило одним из двух способов:

     {% list tabs %}

     - На все адреса

       * **Диапазон портов** — `443`.
       * **Протокол** — `TCP`.
       * **Назначение** — `CIDR`.
       * **CIDR блоки** — `0.0.0.0/0`.

     - На адреса, используемые Yandex Cloud

       * **Диапазон портов** — `443`.
       * **Протокол** — `TCP`.
       * **Назначение** — `CIDR`.
       * **CIDR блоки**:
         * `84.201.181.26/32` — получение статуса кластера Yandex Data Processing, запуск заданий.
         * `158.160.167.170/32` — UI Proxy.
         * `158.160.59.216/32` — мониторинг состояния кластера Yandex Data Processing, автомасштабирование.
         * `213.180.193.243/32` — доступ к Object Storage.
         * `84.201.181.184/32` — адрес Cloud Logging.

     {% endlist %}

   * Правило, разрешающее доступ к NTP-серверам для синхронизации времени:
     * **Диапазон портов** — `123`.
     * **Протокол** — `UDP`.
     * **Назначение** — `CIDR`.
     * **CIDR блоки** — `0.0.0.0/0`.

Если планируется использовать несколько групп безопасности для кластера Yandex Data Processing, разрешите весь трафик между этими группами.

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера Yandex Data Processing.

{% endnote %}

Вы можете настроить группы безопасности после создания кластера Yandex Data Processing, чтобы [подключиться к Apache Hive™ Metastore](../../metadata-hub/operations/metastore/data-processing-connect.md) или [хостам кластера Yandex Data Processing](connect.md) через интернет или промежуточную [виртуальную машину](../../compute/concepts/vm.md).


## Создайте кластер Yandex Data Processing {#create}

Кластер Yandex Data Processing должен состоять из подкластера с хостом-мастером и как минимум из одного подкластера для хранения или обработки данных.

Если вы хотите создать копию кластера Yandex Data Processing, [импортируйте его конфигурацию](#duplicate) в Terraform.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать кластер Yandex Data Processing.
  1. Нажмите кнопку **Создать ресурс** и выберите ![image](../../_assets/data-processing/data-processing.svg) **Кластер Yandex Data Processing** в выпадающем списке.
  1. Укажите имя и при необходимости описание кластера Yandex Data Processing.

     Требования к имени:

     * должно быть уникальным в рамках каталога;

     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. Выберите [окружение](../concepts/environment.md#environment), в котором нужно создать кластер (после создания кластера окружение изменить невозможно):
     * `PRODUCTION` — для стабильных версий ваших приложений.
     * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.
  1. Добавьте или удалите [метки](../../resource-manager/concepts/labels.md) кластера. Они позволяют разделить и сгруппировать ресурсы на логические группы.
  1. Задайте следующие настройки кластера:

     * [Версия образа](../concepts/environment.md) и сервисы, которые вы хотите использовать в кластере Yandex Data Processing.

        Используя образ версии `2.0.39` или выше, вы можете создать [легковесный кластер](../concepts/index.md#light-weight) без HDFS и подкластеров для хранения данных. При этом обязательно добавьте один или несколько подкластеров для обработки данных и укажите имя бакета.

        {% note tip %}

        Чтобы использовать самую свежую версию образа, укажите значение `2.1`.

        {% endnote %}

     * Способ подключения к кластеру Yandex Data Processing:

        * **SSH-ключ** — с помощью [SSH-ключей](../../glossary/ssh-keygen.md).
        * **Доступ по OS Login** — с помощью [OS Login](../../organization/concepts/os-login.md).

       Если вы выбрали доступ по SSH-ключу, в поле **SSH-ключ** укажите его публичную часть. Как сгенерировать и использовать SSH-ключи, читайте в [документации Yandex Compute Cloud](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * Сервисный аккаунт, которому нужно разрешить доступ к кластеру Yandex Data Processing.
     * Зона доступности для кластера Yandex Data Processing.
     * (Опционально) [Свойства компонентов кластера](../concepts/settings-list.md).
     * (Опционально) Пользовательские [скрипты инициализации](../concepts/init-action.md) хостов кластера. Для каждого скрипта укажите следующую информацию:

        * URI-ссылка на скрипт инициализации в схеме `https://`, `http://`, `hdfs://` или `s3a://`.
        * (Опционально) Таймаут выполнения скрипта (в секундах). Если скрипт инициализации выполняется дольше указанного времени, он будет прерван.
        * (Опционально) Аргументы, заключенные в квадратные скобки и разделенные запятыми. С этими аргументами выполняется скрипт инициализации. Пример аргументов:

          ```text
          ["arg1","arg2",...,"argN"]
          ```

     * Формат, в котором будет указано имя [бакета Yandex Object Storage](../../storage/concepts/bucket.md): **Список** или **ID**.
     * Бакет, который будет использоваться кластером.

        В зависимости от выбранного формата либо выберите из списка бакет с нужным именем, либо укажите имя бакета вручную. Его можно получить со [списком бакетов в каталоге](../../storage/operations/buckets/get-info.md#get-information).

        [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) кластера Yandex Data Processing должен иметь разрешение `READ и WRITE` для этого бакета.

     * Формат, в котором будет указана сеть для кластера Yandex Data Processing.
     * Сеть для кластера.
     * Группы безопасности, в которых имеются необходимые разрешения.

        {% note warning %}

        При создании кластера Yandex Data Processing проверяются настройки групп безопасности. Если функционирование кластера Yandex Data Processing с этими настройками невозможно, будет выведено предупреждение. Пример работающих настроек приведен [выше](#change-security-groups).

        {% endnote %}

     * [UI Proxy](connect-interfaces.md#ui-proxy). Если опция **UI Proxy** включена, будут доступны [веб-интерфейсы компонентов](../concepts/interfaces.md) Yandex Data Processing.
     * [Лог-группа](../../logging/concepts/log-group.md) Yandex Cloud Logging, в которую кластер будет отправлять логи.

        Чтобы сохранять логи в лог-группе, [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту кластера [роль](../../logging/security/index.md#logging-writer) `logging.writer`.

  1. Настройте подкластеры Yandex Data Processing. Доступны следующие виды:

     * Подкластер с хостом-мастером, обозначается как `Мастер`. Может быть только один.
     * Подкластеры для хранения данных, обзначаются как `Data`. На них разворачиваются компоненты для хранения.
     * Подкластеры для обработки данных, обзначаются как `Compute`. На них разворачиваются компоненты для вычислений. [Хранилище](../concepts/storage.md) на таком подкластере предназначено только для временного хранения обрабатываемых файлов.

     Для каждого подкластера Yandex Data Processing укажите:

     * Имя подкластера.
     * Количество хостов (хост-мастер может быть только один).
     * [Класс хостов](../concepts/instance-types.md) — платформа и вычислительные ресурсы, доступные хосту.
     * Размер и тип хранилища.
     * Подсеть.

       В подсети для подкластера Yandex Data Processing с хостом-мастером настройте NAT-шлюз. Подробнее в разделе [Настройте сеть](#setup-network).

     * Доступ к хостам подкластера Yandex Data Processing из интернета. Чтобы включить доступ, выберите опцию **Публичный доступ**. В этом случае подключаться к хостам подкластера Yandex Data Processing можно только с использованием SSL-соединения. Подробнее в разделе [Подключение к кластеру Yandex Data Processing](connect.md).

       {% note warning %}

       После создания кластера Yandex Data Processing невозможно запросить или отключить публичный доступ к подкластеру. Однако подкластер Yandex Data Processing для обработки данных можно удалить и создать заново с нужной настройкой публичного доступа.

       {% endnote %}

  1. (Опционально) Настройте [автоматическое масштабирование](../concepts/autoscaling.md) подкластеров для обработки данных:

     1. В настройках подкластера типа `Compute` включите настройку **Автоматическое масштабирование**.
     1. Задайте параметры автоматического масштабирования.
     1. По умолчанию в качестве метрики для автоматического масштабирования используется `yarn.cluster.containersPending`. Чтобы включить масштабирование на основе загрузки CPU, выключите настройку **Масштабирование по умолчанию** и укажите целевой уровень загрузки CPU.
     1. Нажмите кнопку **Добавить**.

  1. (Опционально) Добавьте и настройте дополнительные подкластеры для хранения или обработки данных.
  1. (Опционально) В дополнительных настройках включите защиту от непреднамеренного удаления кластера.

     Включенная защита не помешает подключиться к кластеру Yandex Data Processing вручную и удалить данные.

  1. Нажмите кнопку **Создать кластер**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать кластер Yandex Data Processing:

  
  1. Проверьте, есть ли в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) подсети для хостов кластера Yandex Data Processing:

     ```bash
     yc vpc subnet list
     ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе [Yandex Virtual Private Cloud](../../vpc/index.md).


  1. Посмотрите описание команды [CLI](../../cli/index.md) для создания кластера Yandex Data Processing:

     ```bash
     yc dataproc cluster create --help
     ```

  1. Укажите параметры кластера Yandex Data Processing в команде создания (в примере приведены не все доступные параметры):

     ```bash
     yc dataproc cluster create <имя_кластера> \
       --environment=<окружение> \
       --bucket=<имя_бакета> \
       --zone=<зона_доступности> \
       --service-account-name=<имя_сервисного_аккаунта> \
       --autoscaling-service-account-name=<имя_сервисного_аккаунта_автомасштабируемых_подкластеров> \
       --version=<версия_образа> \
       --services=<список_компонентов> \
       --ssh-public-keys-file=<путь_к_открытому_SSH-ключу> \
       --subcluster name=<имя_подкластера_с_хостом-мастером>,`
                    `role=masternode,`
                    `resource-preset=<класс_хоста>,`
                    `disk-type=<тип_хранилища>,`
                    `disk-size=<размер_хранилища_ГБ>,`
                    `subnet-name=<имя_подсети>,`
                    `assign-public-ip=<публичный_доступ_к_хосту_подкластера> \
       --subcluster name=<имя_подкластера_для_хранения_данных>,`
                    `role=datanode,`
                    `resource-preset=<класс_хоста>,`
                    `disk-type=<тип_хранилища>,`
                    `disk-size=<размер_хранилища_ГБ>,`
                    `subnet-name=<имя_подсети>,`
                    `hosts-count=<количество_хостов>,`
                    `assign-public-ip=<публичный_доступ_к_хосту_подкластера> \
       --deletion-protection \
       --ui-proxy=<доступ_к_веб-интерфейсам_компонентов> \
       --log-group-id=<идентификатор_лог-группы> \
       --security-group-ids=<список_идентификаторов_групп_безопасности>
     ```

     {% note info %}

     Имя кластера Yandex Data Processing должно быть уникальным в рамках каталога. Может содержать латинские буквы, цифры, дефис и подчеркивание. Максимальная длина имени 63 символа.

     {% endnote %}

     Где:
     * `--environment` — [окружение](../concepts/environment.md#environment) кластера: `prestable` или `production`.
     * `--bucket` — имя бакета в Object Storage, в котором будут храниться зависимости заданий и результаты их выполнения. [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) кластера Yandex Data Processing должен иметь разрешение `READ и WRITE` для этого бакета.
     * `--zone` — [зона доступности](../../overview/concepts/geo-scope.md), в которой должны быть размещены хосты кластера Yandex Data Processing.
     * `--service-account-name` — имя сервисного аккаунта кластера Yandex Data Processing.
     * (Опционально) `--autoscaling-service-account-name` — имя сервисного аккаунта для управления автомасштабируемыми подкластерами.
     * `--version` — [версия образа](../concepts/environment.md).

       Используя образ версии `2.0.39` или выше, вы можете создать [легковесный кластер](../concepts/index.md#light-weight) без HDFS и подкластеров для хранения данных. При этом обязательно добавьте один или несколько подкластеров для обработки данных и укажите имя бакета.

       {% note tip %}

       Чтобы использовать самую свежую версию образа, укажите значение `2.1` в параметре `--version`.

       {% endnote %}

     * `--services` — список [компонентов](../concepts/environment.md), которые вы хотите использовать в кластере Yandex Data Processing. Если не указать этот параметр, будет использоваться набор по умолчанию: `yarn`, `tez`, `spark`.
     * `--ssh-public-keys-file` — полный путь к файлу с публичной частью [SSH-ключа](../../glossary/ssh-keygen.md), который будет использоваться для доступа к хостам кластера Yandex Data Processing. Как создать и использовать SSH-ключи, читайте в [документации Yandex Compute Cloud](../../compute/operations/vm-connect/ssh.md).

        {% note info %}

        Чтобы подключаться к кластеру по [OS Login](../../organization/concepts/os-login.md), вместо `--ssh-public-keys-file` укажите в команде параметр `--oslogin`.

        {% endnote %}

     * `--subcluster` — параметры подкластеров Yandex Data Processing:
       * `name` — имя подкластера Yandex Data Processing.
       * `role` — роль подкластера Yandex Data Processing: `masternode`, `datanode` или `computenode`.
       * `resource-preset` — [класс хостов](../concepts/instance-types.md).
       * `disk-type` — [тип хранилища](../concepts/storage.md): `network-ssd`, `network-hdd` или `network-ssd-nonreplicated`.
       * `disk-size` — размер хранилища в гигабайтах.
       * `subnet-name` — имя подсети.
       * `hosts-count` — количество хостов подкластеров Yandex Data Processing для хранения или обработки данных. Минимальное значение — `1`, максимальное — `32`.
       * `assign-public-ip` — доступ к хостам подкластера Yandex Data Processing из интернета. Может принимать значения `true` или `false`. Если доступ включен, подключаться к кластеру Yandex Data Processing можно только с использованием SSL-соединения. Подробнее в разделе [Подключение к кластеру Yandex Data Processing](connect.md).

         {% note warning %}

         После создания кластера Yandex Data Processing невозможно запросить или отключить публичный доступ к подкластеру. Однако подкластер Yandex Data Processing для обработки данных можно удалить и создать заново с нужной настройкой публичного доступа.

         {% endnote %}

     * `--deletion-protection` — защита от удаления кластера Yandex Data Processing.

       Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.

     * `--ui-proxy` — доступ к [веб-интерфейсам компонентов](../concepts/interfaces.md) Yandex Data Processing. Может принимать значения `true` или `false`.
     * `--log-group-id` — [идентификатор лог-группы](../concepts/logs.md).
     * `--security-group-ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).

     Чтобы создать кластер Yandex Data Processing, состоящих из нескольких подкластеров для хранения или обработки данных, передайте необходимое количество аргументов `--subcluster` в команде создания кластера:

     ```bash
     yc dataproc cluster create <имя_кластера> \
       ...
       --subcluster <параметры_подкластера> \
       --subcluster <параметры_подкластера> \
       ...
     ```

  1. Чтобы включить [автоматическое масштабирование](../concepts/autoscaling.md) в подкластерах Yandex Data Processing для обработки данных, задайте параметры:

     ```bash
     yc dataproc cluster create <имя_кластера> \
       ...
       --subcluster name=<имя_подкластера>,`
                    `role=computenode`
                    `...`
                    `hosts-count=<минимальное_количество_хостов>`
                    `max-hosts-count=<максимальное_количество_хостов>,`
                    `preemptible=<использование_прерываемых_ВМ>,`
                    `warmup-duration=<время_на_разогрев_ВМ>,`
                    `stabilization-duration=<период_стабилизации>,`
                    `measurement-duration=<промежуток_измерения_нагрузки>,`
                    `cpu-utilization-target=<целевой_уровень_загрузки_CPU>,`
                    `autoscaling-decommission-timeout=<таймаут_декомиссии>
     ```

     Где:
     * `hosts-count` — минимальное количество хостов (ВМ) в подкластере Yandex Data Processing. Минимальное значение — `1`, максимальное — `32`.
     * `max-hosts-count` — максимальное количество хостов (ВМ) в подкластере Yandex Data Processing. Минимальное значение — `1`, максимальное — `100`.
     * `preemptible` — использование [прерываемых ВМ](../../compute/concepts/preemptible-vm.md). Может принимать значения `true` или `false`.
     * `warmup-duration` — время в секундах на разогрев ВМ, в формате `<значение>s`. Минимальное значение — `0s`, максимальное — `600s` (10 минут).
     * `stabilization-duration` — период в секундах, в течение которого требуемое количество ВМ не может быть снижено, в формате `<значение>s`. Минимальное значение — `60s` (1 минута), максимальное — `1800s` (30 минут).
     * `measurement-duration` — период в секундах, за который замеры нагрузки усредняются для каждой ВМ, в формате `<значение>s`. Минимальное значение — `60s` (1 минута), максимальное — `600s` (10 минут).
     * `cpu-utilization-target` — целевой уровень загрузки CPU, в процентах. Используйте эту настройку, чтобы включить [масштабирование](../concepts/autoscaling.md) на основе загрузки CPU, иначе в качестве метрики будет использоваться `yarn.cluster.containersPending` (на основе количества ожидающих задания ресурсов). Минимальное значение — `10`, максимальное — `100`.
     * `autoscaling-decommission-timeout` — [таймаут декомиссии](../concepts/decommission.md) в секундах. Минимальное значение — `0`, максимальное — `86400` (сутки).

  1. Чтобы создать кластер Yandex Data Processing, размещенный на [группах выделенных хостов](../../compute/concepts/dedicated-host.md), укажите через запятую их идентификаторы в параметре `--host-group-ids`:

     ```bash
     yc dataproc cluster create <имя_кластера> \
       ...
       --host-group-ids=<идентификаторы_групп_выделенных_хостов>
     ```

     {% note alert %}
     
     Эту настройку нельзя изменить после создания кластера. Использование выделенных хостов существенно влияет на [тарификацию кластера](../../compute/pricing.md#prices-dedicated-host).
     
     {% endnote %}

  1. Чтобы настроить хосты кластера Yandex Data Processing с помощью [скриптов инициализации](../concepts/init-action.md), укажите их в одном или нескольких параметрах `--initialization-action`:

     ```bash
     yc dataproc cluster create <имя_кластера> \
       ...
       --initialization-action uri=<URI_скрипта_инициализации>,`
                               `timeout=<таймаут_выполнения_скрипта>,`
                               `args=["arg1","arg2","arg3",...]
     ```

     Где:
     * `uri` — ссылка на скрипт инициализации в схеме `https://`, `http://`, `hdfs://` или `s3a://`.
     * (Опционально) `timeout` — таймаут выполнения скрипта, в секундах. Скрипт инициализации, выполняющийся дольше указанного времени, будет прерван.
     * (Опционально) `args` — разделенные запятыми аргументы, с которыми должен быть выполнен скрипт инициализации.

- Terraform {#tf}

  
  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).


  Чтобы создать кластер Yandex Data Processing:
  1. В командной строке перейдите в каталог, в котором будут расположены конфигурационные файлы Terraform с планом инфраструктуры. Если такой директории нет — создайте ее.

  
  1. Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     
     
     Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Создайте конфигурационный файл с описанием облачной сети, подсетей, группы безопасности и NAT-шлюза.

     Кластер Yandex Data Processing размещается в облачной сети. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.

     Хосты кластера Yandex Data Processing размещаются в подсетях выбранной облачной сети. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

     Пример структуры конфигурационного файла, в котором описывается облачная сеть с одной подсетью, группа безопасности, NAT-шлюз и таблица маршрутизации:

     ```hcl
     resource "yandex_vpc_network" "test_network" {
       name = "<имя_сети>"
     }

     resource "yandex_vpc_subnet" "test_subnet" {
       name           = "<имя_подсети>"
       zone           = "<зона_доступности>"
       network_id     = yandex_vpc_network.test_network.id
       v4_cidr_blocks = ["<подсеть>"]
       route_table_id = yandex_vpc_route_table.data-processing-rt.id
     }

     resource "yandex_vpc_gateway" "data-processing-gateway" {
       name = "data-processing-gateway"
       shared_egress_gateway {}
     }

     resource "yandex_vpc_route_table" "data-processing-rt" {
       network_id = "${yandex_vpc_network.test-network.id}"

       static_route {
         destination_prefix = "0.0.0.0/0"
         gateway_id         = "${yandex_vpc_gateway.data-processing-gateway.id}"
       }
     }

     resource "yandex_vpc_security_group" "data-processing-sg" {
       description = "Security group for DataProc"
       name        = "data-processing-security-group"
       network_id  = yandex_vpc_network.data-proc-network.id

       egress {
         description    = "Allow outgoing HTTPS traffic"
         protocol       = "TCP"
         port           = 443
         v4_cidr_blocks = ["0.0.0.0/0"]
       }

       ingress {
         description       = "Allow any incomging traffic within the security group"
         protocol          = "ANY"
         from_port         = 0
         to_port           = 65535
         predefined_target = "self_security_group"
       }

       egress {
         description       = "Allow any outgoing traffic within the security group"
         protocol          = "ANY"
         from_port         = 0
         to_port           = 65535
         predefined_target = "self_security_group"
       }

       egress {
         description    = "Allow outgoing traffic to NTP servers for time synchronization"
         protocol       = "UDP"
         port           = 123
         v4_cidr_blocks = ["0.0.0.0/0"]
       }
     }
     ```


  1. Создайте конфигурационный файл с описанием следующих ресурсов:
      * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) кластера Yandex Data Processing, которому нужно разрешить доступ к бакету Object Storage.
      * (Опционально) Сервисный аккаунт для управления автомасштабируемыми подкластерами.
      * Сервисный аккаунт для создания бакета Object Storage.
      * [Статический ключ](../../iam/concepts/authorization/access-key.md).
      * Бакет Object Storage для хранения результатов выполнения [заданий](../concepts/jobs.md).

     ```hcl
     resource "yandex_iam_service_account" "data_proc_sa" {
       name        = "<имя_сервисного_аккаунта>"
       description = "<описание_сервисного_аккаунта>"
     }

     resource "yandex_iam_service_account" "data_proc_sa_autoscaling" {
       name        = "<имя_сервисного_аккаунта>"
       description = "<описание_сервисного_аккаунта>"
     }

     resource "yandex_resourcemanager_folder_iam_member" "dataproc-agent" {
       folder_id = "<идентификатор_каталога>"
       role      = "dataproc.agent"
       member    = "serviceAccount:${yandex_iam_service_account.data_proc_sa.id}"
     }

     resource "yandex_resourcemanager_folder_iam_member" "dataproc-provisioner" {
       folder_id = "<идентификатор_каталога>"
       role      = "dataproc.provisioner"
       member    = "serviceAccount:${yandex_iam_service_account.data_proc_sa_autoscaling.id}"
     }

     resource "yandex_iam_service_account" "bucket_sa" {
       name        = "<имя_сервисного_аккаунта>"
       description = "<описание_сервисного_аккаунта>"
     }

     resource "yandex_resourcemanager_folder_iam_member" "storage-admin" {
       folder_id = "<идентификатор_каталога>"
       role      = "storage.admin"
       member    = "serviceAccount:${yandex_iam_service_account.bucket_sa.id}"
     }

     resource "yandex_iam_service_account_static_access_key" "bucket_sa_static_key" {
       service_account_id = yandex_iam_service_account.bucket_sa.id
     }

     resource "yandex_storage_bucket" "data_bucket" {
       depends_on = [
         yandex_resourcemanager_folder_iam_member.storage-admin
       ]

       grant {
         id          = yandex_iam_service_account.data_proc_sa.id
         type        = "CanonicalUser"
         permissions = ["READ","WRITE"]
       }

       bucket     = "<имя_бакета>"
       access_key = yandex_iam_service_account_static_access_key.bucket_sa_static_key.access_key
       secret_key = yandex_iam_service_account_static_access_key.bucket_sa_static_key.secret_key
     }
     ```

  1. Создайте конфигурационный файл с описанием кластера Yandex Data Processing и его подкластеров.

     При необходимости здесь же можно задать [свойства компонентов кластера Yandex Data Processing, заданий и среды окружения](../concepts/settings-list.md).

     Пример структуры конфигурационного файла, в котором описывается кластер Yandex Data Processing из одного подкластера с хостом-мастером, одного подкластера для хранения данных и одного подкластера для обработки данных:

     ```hcl
     resource "yandex_dataproc_cluster" "data_cluster" {
       bucket                         = "${yandex_storage_bucket.data_bucket.bucket}"
       name                           = "<имя_кластера>"
       description                    = "<описание_кластера>"
       environment                    = "<окружение_кластера>"
       service_account_id             = yandex_iam_service_account.data_proc_sa.id
       autoscaling_service_account_id = yandex_iam_service_account.data_proc_sa_autoscaling.id
       zone_id                        = "<зона_доступности>"
       security_group_ids             = [yandex_vpc_security_group.data-processing-sg.id]
       deletion_protection            = <защита_от_удаления_кластера>

       depends_on = [
         yandex_resourcemanager_folder_iam_member.dataproc-provisioner,
         yandex_resourcemanager_folder_iam_member.dataproc-agent
       ]

       cluster_config {
         version_id = "<версия_образа>"

         hadoop {
           services   = ["<список_компонентов>"]
           # Пример списка: ["HDFS", "YARN", "SPARK", "TEZ", "MAPREDUCE", "HIVE"].
           properties = {
             "<свойство_компонента>" = <значение>
             ...
           }
           ssh_public_keys = [
             file("<путь_к_открытому_SSH-ключу>")
           ]
         }

         subcluster_spec {
           name = "<имя_подкластера_с_хостом-мастером>"
           role = "MASTERNODE"
           resources {
             resource_preset_id = "<класс_хоста>"
             disk_type_id       = "<тип_хранилища>"
             disk_size          = <объем_хранилища_ГБ>
           }
           subnet_id   = yandex_vpc_subnet.test_subnet.id
           hosts_count = 1
         }

         subcluster_spec {
           name = "<имя_подкластера_для_хранения_данных>"
           role = "DATANODE"
           resources {
             resource_preset_id = "<класс_хоста>"
             disk_type_id       = "<тип_хранилища>"
             disk_size          = <объем_хранилища_ГБ>
           }
           subnet_id   = yandex_vpc_subnet.test_subnet.id
           hosts_count = <число_хостов_в_подкластере>
         }

         subcluster_spec {
           name = "<имя_подкластера_для_обработки_данных>"
           role = "COMPUTENODE"
           resources {
             resource_preset_id = "<класс_хоста>"
             disk_type_id       = "<тип_хранилища>"
             disk_size          = <объем_хранилища_ГБ>
           }
           subnet_id   = yandex_vpc_subnet.test_subnet.id
           hosts_count = <число_хостов_в_подкластере>
         }
       }
     }
     ```

     Где `deletion_protection` — защита от удаления кластера Yandex Data Processing. Может принимать значения `true` или `false`.

     Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

     Используя образ версии `2.0.39` или выше, вы можете создать [легковесный кластер](../concepts/index.md#light-weight) без HDFS и подкластеров для хранения данных. При этом обязательно добавьте один или несколько подкластеров для обработки данных и укажите имя бакета.

     {% note tip %}

     Чтобы использовать самую свежую [версию образа](../concepts/environment.md), укажите значение `2.1` в параметре `version_id`.

     {% endnote %}

     Чтобы подключаться к кластеру по [OS Login](../../organization/concepts/os-login.md), вместо `ssh_public_keys` укажите поле `oslogin` со значением `true`.

     Чтобы получить доступ к [веб-интерфейсам компонентов](../concepts/interfaces.md) Yandex Data Processing, добавьте в описание кластера Yandex Data Processing поле `ui_proxy` с значением `true`:

     ```hcl
     resource "yandex_dataproc_cluster" "data_cluster" {
       ...
       ui_proxy = true
       ...
     }
     ```

     Чтобы задать параметры [автоматического масштабирования](../concepts/autoscaling.md) в подкластерах Yandex Data Processing для обработки данных, добавьте в описание соответствующего подкластера `subcluster_spec` блок `autoscaling_config` с нужными вам настройками:

     ```hcl
     subcluster_spec {
       name = "<имя_подкластера>"
       role = "COMPUTENODE"
       ...
       autoscaling_config {
         max_hosts_count        = <максимальное_количество_ВМ_в_группе>
         measurement_duration   = <промежуток_измерения_нагрузки>
         warmup_duration        = <время_на_разогрев>
         stabilization_duration = <период_стабилизации>
         preemptible            = <использование_прерываемых_ВМ>
         cpu_utilization_target = <целевой_уровень_загрузки_vCPU>
         decommission_timeout   = <таймаут_декомиссии>
       }
     }
     ```

     Где:
     * `max_hosts_count` — максимальное количество хостов (ВМ) в подкластере Yandex Data Processing. Минимальное значение — `1`, максимальное — `100`.
     * `measurement_duration` — период в секундах, за который замеры нагрузки усредняются для каждой ВМ, в формате `<значение>s`. Минимальное значение — `60s` (1 минута), максимальное — `600s` (10 минут).
     * `warmup_duration` — время в секундах на разогрев ВМ, в формате `<значение>s`. Минимальное значение — `0s`, максимальное — `600s` (10 минут).
     * `stabilization_duration` — период в секундах, в течение которого требуемое количество ВМ не может быть снижено, в формате `<значение>s`. Минимальное значение — `60s` (1 минута), максимальное — `1800s` (30 минут).
     * `preemptible` — использование [прерываемых ВМ](../../compute/concepts/preemptible-vm.md). Может принимать значения `true` или `false`.
     * `cpu_utilization_target` — целевой уровень загрузки CPU, в процентах. Используйте эту настройку, чтобы включить [масштабирование](../concepts/autoscaling.md) на основе загрузки CPU, иначе в качестве метрики будет использоваться `yarn.cluster.containersPending` (на основе количества ожидающих задания ресурсов). Минимальное значение — `10`, максимальное — `100`.
     * `decommission_timeout` — [таймаут декомиссии](../concepts/decommission.md) в секундах. Минимальное значение — `0`, максимальное — `86400` (сутки).

     Более подробная информация о ресурсах, которые вы можете создать с помощью Terraform, описана в [документации провайдера](../../terraform/resources/dataproc_cluster.md).
     
  1. Проверьте корректность файлов конфигурации Terraform:

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Создайте кластер Yandex Data Processing:

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

     В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Чтобы создать кластер Yandex Data Processing, воспользуйтесь методом API [create](../api-ref/Cluster/create.md) и передайте в запросе:
  * Идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором должен быть размещен кластера Yandex Data Processing, в параметре `folderId`.
  * Имя кластера Yandex Data Processing в параметре `name`.
  * [Окружение](../concepts/environment.md#environment) кластера в параметре `environment` — `PRESTABLE` или `PRODUCTION`.
  * Конфигурацию кластера Yandex Data Processing в параметре `configSpec`, в том числе:
    * [Версию образа](../concepts/environment.md) в параметре `configSpec.versionId`.

      Используя образ версии `2.0.39` или выше, вы можете создать [легковесный кластер](../concepts/index.md#light-weight) без HDFS и подкластеров для хранения данных. При этом обязательно добавьте один или несколько подкластеров для обработки данных и укажите имя бакета.

      {% note tip %}

      Чтобы использовать самую свежую версию образа, укажите значение `2.0`.

      {% endnote %}

    * Список компонентов в параметре `configSpec.hadoop.services`.
    * Публичную часть [SSH-ключа](../../glossary/ssh-keygen.md) в параметре `configSpec.hadoop.sshPublicKeys`.

      {% note info %}

      Чтобы подключаться к кластеру по [OS Login](../../organization/concepts/os-login.md), вместо `configSpec.hadoop.sshPublicKeys` передайте в запросе `configSpec.hadoop.osloginEnabled: true`.

      {% endnote %}

    * Настройки подкластеров Yandex Data Processing в параметре `configSpec.subclustersSpec`.
  * Зону доступности кластера Yandex Data Processing в параметре `zoneId`.
  * Идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) кластера Yandex Data Processing в параметре `serviceAccountId`.
  * (Опционально) Идентификатор сервисного аккаунта для управления автомасштабируемыми подкластерами в параметре `autoscalingServiceAccountId`.
  * Имя бакета в параметре `bucket`.
  * Идентификаторы групп безопасности кластера Yandex Data Processing в параметре `hostGroupIds`.
  * Настройки защиты от удаления кластера Yandex Data Processing в параметре `deletionProtection`.

    Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.

  Чтобы назначить публичный IP-адрес всем хостам подкластера Yandex Data Processing, передайте значение `true` в параметре `configSpec.subclustersSpec.assignPublicIp`.

  Чтобы создать кластер Yandex Data Processing, размещенный на [группах выделенных хостов](../../compute/concepts/dedicated-host.md), передайте список их идентификаторов в параметре `hostGroupIds`.

  {% note alert %}
  
  Эту настройку нельзя изменить после создания кластера. Использование выделенных хостов существенно влияет на [тарификацию кластера](../../compute/pricing.md#prices-dedicated-host).
  
  {% endnote %}

  Чтобы настроить хосты кластера Yandex Data Processing с помощью [скриптов инициализации](../concepts/init-action.md), укажите их в одном или нескольких параметрах `configSpec.hadoop.initializationActions`.

{% endlist %}

После того как кластер Yandex Data Processing перейдет в статус **Running**, вы можете [подключиться](connect.md) к хостам подкластеров Yandex Data Processing.

## Создайте копию кластера Yandex Data Processing {#duplicate}

Вы можете создать кластер Yandex Data Processing, который будет обладать настройками созданного ранее кластера. Для этого конфигурация исходного кластера Yandex Data Processing импортируется в Terraform. В результате вы можете либо создать идентичную копию, либо взять за основу импортированную конфигурацию и внести в нее изменения. Использовать импорт удобно, если исходный кластер Yandex Data Processing обладает множеством настроек (например, это кластер с файловой системой HDFS) и нужно создать похожий на него кластер.

Чтобы создать копию кластера Yandex Data Processing:

{% list tabs group=instructions %}

- Terraform {#tf}

  1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
  1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
  1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.
  1. В той же рабочей директории разместите файл с расширением `.tf` и содержимым:

     ```hcl
     resource "yandex_dataproc_cluster" "old" { }
     ```

  1. Запишите идентификатор первоначального кластера Yandex Data Processing в переменную окружения:

     ```bash
     export DATAPROC_CLUSTER_ID=<идентификатор_кластера>
     ```

     Идентификатор можно запросить вместе со [списком кластеров в каталоге](cluster-list.md#list).

  1. Импортируйте настройки первоначального кластера Yandex Data Processing в конфигурацию Terraform:

     ```bash
     terraform import yandex_dataproc_cluster.old ${DATAPROC_CLUSTER_ID}
     ```

  1. Получите импортированную конфигурацию:

     ```bash
     terraform show
     ```

  1. Скопируйте ее из терминала и вставьте в файл с расширением `.tf`.
  1. Расположите файл в новой директории `imported-cluster`.
  1. Измените скопированную конфигурацию так, чтобы из нее можно было создать новый кластер Yandex Data Processing:
     * Укажите новое имя кластера Yandex Data Processing в строке `resource` и параметре `name`.
     * Удалите параметры `created_at`, `host_group_ids`, `id` и `subcluster_spec.id`.
     * Если вы подключаетесь к кластеру с помощью [SSH-ключа](../../glossary/ssh-keygen.md), измените его формат в параметре `ssh_public_keys`. Исходный формат:

       ```hcl
       ssh_public_keys = [
         <<-EOT
           <ключ>
         EOT,
       ]
       ```

       Требуемый формат:

       ```hcl
       ssh_public_keys = [
         "<ключ>"
       ]
       ```

     * (Опционально) Внесите дополнительные изменения, если вам нужна не идентичная, а кастомизированная копия.
  1. В директории `imported-cluster` [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).
  1. В этой же директории [настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
  1. Поместите конфигурационный файл в директорию `imported-cluster` и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.
  1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  1. Создайте необходимую инфраструктуру:

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

     В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

## Пример {#example}

### Создание легковесного кластера Yandex Data Processing для заданий Spark и PySpark {#creating-a-light-weight-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер Yandex Data Processing для выполнения заданий Spark без HDFS и подкластеров для хранения данных с тестовыми характеристиками:
  * С именем `my-dataproc`.
  * С окружением `production`.
  * С бакетом `dataproc-bucket`.
  * В зоне доступности `ru-central1-d`.
  * С сервисным аккаунтом `dataproc-sa`.
  * Образом версии `2.0`.
  * С компонентами `SPARK` и `YARN`.
  * С путем к публичной части SSH-ключа `/home/username/.ssh/id_rsa.pub`.
  * С подкластером Yandex Data Processing с хостами-мастерами `master` и одним подкластером для обработки данных `compute`:
    * Класса `s2.micro`.
    * С хранилищем на сетевых SSD-дисках (`network-ssd`) объемом 20 ГБ.
    * В подсети `default-ru-central1-d`.
    * С публичным доступом.
  * В группе безопасности `enp6saqnq4ie********`.
  * С защитой от случайного удаления кластера Yandex Data Processing.

  Выполните следующую команду:

  ```bash
  yc dataproc cluster create my-dataproc \
     --environment=production \
     --bucket=dataproc-bucket \
     --zone=ru-central1-d \
     --service-account-name=dataproc-sa \
     --version=2.0 \
     --services=SPARK,YARN \
     --ssh-public-keys-file=/home/username/.ssh/id_rsa.pub \
     --subcluster name="master",`
                  `role=masternode,`
                  `resource-preset=s2.micro,`
                  `disk-type=network-ssd,`
                  `disk-size=20,`
                  `subnet-name=default-ru-central1-d,`
                  `assign-public-ip=true \
     --subcluster name="compute",`
                  `role=computenode,`
                  `resource-preset=s2.micro,`
                  `disk-type=network-ssd,`
                  `disk-size=20,`
                  `subnet-name=default-ru-central1-d,`
                  `assign-public-ip=true \
     --security-group-ids=enp6saqnq4ie******** \
     --deletion-protection
  ```

{% endlist %}