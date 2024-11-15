# Создание кластера {{ dataproc-name }}

Для создания кластера {{ dataproc-name }} у пользователя должны быть следующие роли:

* [dataproc.editor](../security/index.md#dataproc-editor) — чтобы создать кластер;
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../../vpc/concepts/network.md#network) кластера;
* [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) — чтобы создавать ресурсы от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) кластера.


## Настройте сеть {#setup-network}

Настройте доступ в интернет из [подсети](../../vpc/concepts/network.md#subnet), к которой будет подключен [подкластер](../concepts/index.md#resources) {{ dataproc-name }} с хостом-мастером, например при помощи [NAT-шлюза](../../vpc/operations/create-nat-gateway.md). Это необходимо, чтобы подкластер {{ dataproc-name }} мог взаимодействовать с сервисами {{ yandex-cloud }} или хостами в других сетях.

## Настройте группы безопасности {#change-security-groups}

{% note warning %}

[Группы безопасности](../../vpc/concepts/security-groups.md) необходимо создать и настроить перед созданием кластера {{ dataproc-name }}. Если в выбранных группах безопасности не будет необходимых правил, {{ yandex-cloud }} заблокирует создание кластера {{ dataproc-name }}.

{% endnote %}

1. [Создайте](../../vpc/operations/security-group-create.md) одну или несколько групп безопасности для служебного трафика кластера {{ dataproc-name }}.
1. [Добавьте правила](../../vpc/operations/security-group-add-rule.md):
   * По одному правилу для входящего и исходящего служебного трафика:
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`.
   * Отдельное правило для исходящего HTTPS-трафика. Это позволит использовать [бакеты](../../storage/concepts/bucket.md) [{{ objstorage-full-name }}](../../storage/), [UI Proxy](../concepts/interfaces.md) и [автоматическое масштабирование](../concepts/autoscaling.md) кластеров {{ dataproc-name }}.

     Вы можете настроить это правило одним из двух способов:

     {% list tabs %}

     - На все адреса

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

     - На адреса, используемые {{ yandex-cloud }}

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**:
         * `84.201.181.26/32` — получение статуса кластера {{ dataproc-name }}, запуск заданий, UI Proxy.
         * `158.160.59.216/32` — мониторинг состояния кластера {{ dataproc-name }}, автомасштабирование.
         * `213.180.193.243/32` — доступ к {{ objstorage-name }}.
         * `84.201.181.184/32` — адрес {{ cloud-logging-name }}.

     {% endlist %}

   * Правило, разрешающее доступ к NTP-серверам для синхронизации времени:
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `123`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_udp }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

Если планируется использовать несколько групп безопасности для кластера {{ dataproc-name }}, разрешите весь трафик между этими группами.

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера {{ dataproc-name }}.

{% endnote %}

Вы можете настроить группы безопасности после создания кластера {{ dataproc-name }}, чтобы [подключиться к {{ metastore-name }}](../../metadata-hub/operations/metastore/dataproc-connect.md) или [хостам кластера {{ dataproc-name }}](connect.md) через интернет или промежуточную [виртуальную машину](../../compute/concepts/vm.md).


## Создайте кластер {{ dataproc-name }} {#create}

Кластер {{ dataproc-name }} должен состоять из подкластера с хостом-мастером и как минимум из одного подкластера для хранения или обработки данных.

Если вы хотите создать копию кластера {{ dataproc-name }}, [импортируйте его конфигурацию](#duplicate) в {{ TF }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать кластер {{ dataproc-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите ![image](../../_assets/data-proc/data-proc.svg) **{{ ui-key.yacloud.iam.folder.dashboard.value_data-proc }}** в выпадающем списке.
  1. Укажите имя и при необходимости описание кластера {{ dataproc-name }}.

     Требования к имени:

     * должно быть уникальным в рамках каталога;

     {% include [name-format.md](../../_includes/name-format.md) %}

  1. Добавьте или удалите [метки](../../resource-manager/concepts/labels.md) кластера. Они позволяют разделить и сгруппировать ресурсы на логические группы.
  1. Задайте следующие настройки кластера:

     * [Версия образа](../concepts/environment.md) и сервисы, которые вы хотите использовать в кластере {{ dataproc-name }}.

        {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

        {% note tip %}

        Чтобы использовать самую свежую версию образа, укажите значение `2.0`.

        {% endnote %}

     * Публичная часть [SSH-ключа](../../glossary/ssh-keygen.md) в поле **{{ ui-key.yacloud.mdb.forms.config_field_public-keys }}**. Как сгенерировать и использовать SSH-ключи, читайте в [документации {{ compute-full-name }}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

     * Сервисный аккаунт, которому нужно разрешить доступ к кластеру {{ dataproc-name }}. Сервисному аккаунту кластера {{ dataproc-name }} должны быть [назначены роли](../../iam/operations/sa/assign-role-for-sa.md):

        {% include [sa-roles](../../_includes/data-proc/sa-roles.md) %}

     * Зона доступности для кластера {{ dataproc-name }}.
     * (Опционально) [Свойства компонентов кластера](../concepts/settings-list.md).
     * (Опционально) Пользовательские [скрипты инициализации](../concepts/init-action.md) хостов кластера. Для каждого скрипта укажите следующую информацию:

        * URI-ссылка на скрипт инициализации в схеме `https://`, `http://`, `hdfs://` или `s3a://`.
        * (Опционально) Таймаут выполнения скрипта (в секундах). Если скрипт инициализации выполняется дольше указанного времени, он будет прерван.
        * (Опционально) Аргументы, заключенные в квадратные скобки и разделенные запятыми. С этими аргументами выполняется скрипт инициализации. Пример аргументов:

          ```text
          ["arg1","arg2",...,"argN"]
          ```

     * Формат, в котором будет указано имя [бакета {{ objstorage-full-name }}](../../storage/concepts/bucket.md): **{{ ui-key.yacloud.forms.label_form-list }}** или **{{ ui-key.yacloud.forms.label_form-id }}**.
     * Бакет, который будет использоваться кластером.

        В зависимости от выбранного формата либо выберите из списка бакет с нужным именем, либо укажите имя бакета вручную. Его можно получить со [списком бакетов в каталоге](../../storage/operations/buckets/get-info.md#get-information).

     * Формат, в котором будет указана сеть для кластера {{ dataproc-name }}.
     * Сеть для кластера.
     * Группы безопасности, в которых имеются необходимые разрешения.

        {% note warning %}

        При создании кластера {{ dataproc-name }} проверяются настройки групп безопасности. Если функционирование кластера {{ dataproc-name }} с этими настройками невозможно, будет выведено предупреждение. Пример работающих настроек приведен [выше](#change-security-groups).

        {% endnote %}

     * [UI Proxy](./connect-interfaces.md#ui-proxy). Если опция **{{ ui-key.yacloud.mdb.forms.config_field_ui_proxy }}** включена, будут доступны [веб-интерфейсы компонентов](../concepts/interfaces.md) {{ dataproc-name }}.
     * [Лог-группа](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}, в которую кластер будет отправлять логи.

        Чтобы сохранять логи в лог-группе, [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту кластера [роль](../../logging/security/index.md#logging-writer) `logging.writer`.

  1. Настройте подкластеры {{ dataproc-name }}. Доступны следующие виды:

     * Подкластер с хостом-мастером, обозначается как `{{ ui-key.yacloud.mdb.forms.label_master-subcluster }}`. Может быть только один.
     * Подкластеры для хранения данных, обзначаются как `{{ ui-key.yacloud.mdb.forms.label_data-subcluster }}`. На них разворачиваются компоненты для хранения.
     * Подкластеры для обработки данных, обзначаются как `{{ ui-key.yacloud.mdb.forms.label_compute-subcluster }}`. На них разворачиваются компоненты для вычислений. [Хранилище](../concepts/storage.md) на таком подкластере предназначено только для временного хранения обрабатываемых файлов.

     Для каждого подкластера {{ dataproc-name }} укажите:

     * Имя подкластера.
     * Количество хостов (хост-мастер может быть только один).
     * [Класс хостов](../concepts/instance-types.md) — платформа и вычислительные ресурсы, доступные хосту.
     * Размер и тип хранилища.
     * Подсеть.

        В подсети для подкластера {{ dataproc-name }} с хостом-мастером настройте NAT-шлюз. Подробнее см. в разделе [Настройте сеть](#setup-network).

     * Доступ к хостам подкластера {{ dataproc-name }} из интернета. Чтобы включить доступ, выберите опцию **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}**. В этом случае подключаться к хостам подкластера {{ dataproc-name }} можно только с использованием SSL-соединения. Подробнее см. в разделе [{#T}](connect.md).

       {% note warning %}

       После создания кластера {{ dataproc-name }} невозможно запросить или отключить публичный доступ к подкластеру. Однако подкластер {{ dataproc-name }} для обработки данных можно удалить и создать заново с нужной настройкой публичного доступа.

       {% endnote %}

  1. (Опционально) Настройте [автоматическое масштабирование](../concepts/autoscaling.md) подкластеров для обработки данных:

     1. В настройках подкластера типа `{{ ui-key.yacloud.mdb.forms.label_compute-subcluster }}` включите настройку **{{ ui-key.yacloud.mdb.forms.label_autoscaling-activated }}**.
     1. Задайте параметры автоматического масштабирования.
     1. По умолчанию в качестве метрики для автоматического масштабирования используется `yarn.cluster.containersPending`. Чтобы включить масштабирование на основе загрузки CPU, выключите настройку **{{ ui-key.yacloud.compute.groups.create.field_default-utilization-target }}** и укажите целевой уровень загрузки CPU.
     1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_add-subcluster }}**.

  1. (Опционально) Добавьте и настройте дополнительные подкластеры для хранения или обработки данных.
  1. (Опционально) В дополнительных настройках включите защиту от непреднамеренного удаления кластера.

     Включенная защита не помешает подключиться к кластеру {{ dataproc-name }} вручную и удалить данные.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер {{ dataproc-name }}:


  1. Проверьте, есть ли в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) подсети для хостов кластера {{ dataproc-name }}:

     ```bash
     yc vpc subnet list
     ```

     Если ни одной подсети в каталоге нет, [создайте нужные подсети](../../vpc/operations/subnet-create.md) в сервисе [{{ vpc-full-name }}](../../vpc/).


  1. Посмотрите описание команды [CLI](../../cli/) для создания кластера {{ dataproc-name }}:

     ```bash
     {{ yc-dp }} cluster create --help
     ```

  1. Укажите параметры кластера {{ dataproc-name }} в команде создания (в примере приведены не все доступные параметры):

     ```bash
     {{ yc-dp }} cluster create <имя_кластера> \
       --bucket=<имя_бакета> \
       --zone=<зона_доступности> \
       --service-account-name=<имя_сервисного_аккаунта> \
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

     Имя кластера {{ dataproc-name }} должно быть уникальным в рамках каталога. Может содержать латинские буквы, цифры, дефис и подчеркивание. Максимальная длина имени 63 символа.

     {% endnote %}

     Где:
     * `--bucket` — имя бакета в {{ objstorage-name }}, в котором будут храниться зависимости заданий и результаты их выполнения. [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) кластера {{ dataproc-name }} должен иметь разрешение `READ и WRITE` для этого бакета.
     * `--zone` — [зона доступности](../../overview/concepts/geo-scope.md), в которой должны быть размещены хосты кластера {{ dataproc-name }}.
     * `--service-account-name` — имя сервисного аккаунта кластера {{ dataproc-name }}. Сервисному аккаунту кластера {{ dataproc-name }} должны быть [назначены роли](../../iam/operations/sa/assign-role-for-sa.md):

       {% include [sa-roles](../../_includes/data-proc/sa-roles.md) %}

     * `--version` — [версия образа](../concepts/environment.md).

       {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

       {% note tip %}

       Чтобы использовать самую свежую версию образа, укажите значение `2.0` в параметре `--version`.

       {% endnote %}

     * `--services` — список [компонентов](../concepts/environment.md), которые вы хотите использовать в кластере {{ dataproc-name }}. Если не указать этот параметр, будет использоваться набор по умолчанию: `yarn`, `tez`, `spark`.
     * `--ssh-public-keys-file` — полный путь к файлу с публичной частью [SSH-ключа](../../glossary/ssh-keygen.md), который будет использоваться для доступа к хостам кластера {{ dataproc-name }}. Как создать и использовать SSH-ключи, читайте в [документации {{ compute-full-name }}](../../compute/operations/vm-connect/ssh.md).
     * `--subcluster` — параметры подкластеров {{ dataproc-name }}:
       * `name` — имя подкластера {{ dataproc-name }}.
       * `role` — роль подкластера {{ dataproc-name }}: `masternode`, `datanode` или `computenode`.
       * `resource-preset` — [класс хостов](../concepts/instance-types.md).
       * `disk-type` — [тип хранилища](../concepts/storage.md): `network-ssd`, `network-hdd` или `network-ssd-nonreplicated`.
       * `disk-size` — размер хранилища в гигабайтах.
       * `subnet-name` — имя подсети.
       * `hosts-count` — количество хостов подкластеров {{ dataproc-name }} для хранения или обработки данных. Минимальное значение — `1`, максимальное — `32`.
       * `assign-public-ip` — доступ к хостам подкластера {{ dataproc-name }} из интернета. Может принимать значения `true` или `false`. Если доступ включен, подключаться к кластеру {{ dataproc-name }} можно только с использованием SSL-соединения. Подробнее см. в разделе [{#T}](connect.md).

         {% note warning %}

         После создания кластера {{ dataproc-name }} невозможно запросить или отключить публичный доступ к подкластеру. Однако подкластер {{ dataproc-name }} для обработки данных можно удалить и создать заново с нужной настройкой публичного доступа.

         {% endnote %}

     * `--deletion-protection` — защита от удаления кластера {{ dataproc-name }}.

       {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

     * `--ui-proxy` — доступ к [веб-интерфейсам компонентов](../concepts/interfaces.md) {{ dataproc-name }}. Может принимать значения `true` или `false`.
     * `--log-group-id` — [идентификатор лог-группы](../concepts/logs.md).
     * `--security-group-ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).

     Чтобы создать кластер {{ dataproc-name }}, состоящих из нескольких подкластеров для хранения или обработки данных, передайте необходимое количество аргументов `--subcluster` в команде создания кластера:

     ```bash
     {{ yc-dp }} cluster create <имя_кластера> \
       ...
       --subcluster <параметры_подкластера> \
       --subcluster <параметры_подкластера> \
       ...
     ```

  1. Чтобы включить [автоматическое масштабирование](../concepts/autoscaling.md) в подкластерах {{ dataproc-name }} для обработки данных, задайте параметры:

     ```bash
     {{ yc-dp }} cluster create <имя_кластера> \
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
     * `hosts-count` — минимальное количество хостов (ВМ) в подкластере {{ dataproc-name }}. Минимальное значение — `1`, максимальное — `32`.
     * `max-hosts-count` — максимальное количество хостов (ВМ) в подкластере {{ dataproc-name }}. Минимальное значение — `1`, максимальное — `100`.
     * `preemptible` — использование [прерываемых ВМ](../../compute/concepts/preemptible-vm.md). Может принимать значения `true` или `false`.
     * `warmup-duration` — время в секундах на разогрев ВМ, в формате `<значение>s`. Минимальное значение — `0s`, максимальное — `600s` (10 минут).
     * `stabilization-duration` — период в секундах, в течение которого требуемое количество ВМ не может быть снижено, в формате `<значение>s`. Минимальное значение — `60s` (1 минута), максимальное — `1800s` (30 минут).
     * `measurement-duration` — период в секундах, за который замеры нагрузки усредняются для каждой ВМ, в формате `<значение>s`. Минимальное значение — `60s` (1 минута), максимальное — `600s` (10 минут).
     * `cpu-utilization-target` — целевой уровень загрузки CPU, в процентах. Используйте эту настройку, чтобы включить [масштабирование](../concepts/autoscaling.md) на основе загрузки CPU, иначе в качестве метрики будет использоваться `yarn.cluster.containersPending` (на основе количества ожидающих задания ресурсов). Минимальное значение — `10`, максимальное — `100`.
     * `autoscaling-decommission-timeout` — [таймаут декомиссии](../concepts/decommission.md) в секундах. Минимальное значение — `0`, максимальное — `86400` (сутки).

  1. Чтобы создать кластер {{ dataproc-name }}, размещенный на [группах выделенных хостов](../../compute/concepts/dedicated-host.md), укажите через запятую их идентификаторы в параметре `--host-group-ids`:

     ```bash
     {{ yc-dp }} cluster create <имя_кластера> \
       ...
       --host-group-ids=<идентификаторы_групп_выделенных_хостов>
     ```

     {% include [Dedicated hosts note](../../_includes/data-proc/note-dedicated-hosts.md) %}

  1. Чтобы настроить хосты кластера {{ dataproc-name }} с помощью [скриптов инициализации](../concepts/init-action.md), укажите их в одном или нескольких параметрах `--initialization-action`:

     ```bash
     {{ yc-dp }} cluster create <имя_кластера> \
       ...
       --initialization-action uri=<URI_скрипта_инициализации>,`
                               `timeout=<таймаут_выполнения_скрипта>,`
                               `args=["arg1","arg2","arg3",...]
     ```

     Где:
     * `uri` — ссылка на скрипт инициализации в схеме `https://`, `http://`, `hdfs://` или `s3a://`.
     * (Опционально) `timeout` — таймаут выполнения скрипта, в секундах. Скрипт инициализации, выполняющийся дольше указанного времени, будет прерван.
     * (Опционально) `args` — разделенные запятыми аргументы, с которыми должен быть выполнен скрипт инициализации.

- {{ TF }} {#tf}


  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}


  Чтобы создать кластер {{ dataproc-name }}:
  1. В командной строке перейдите в каталог, в котором будут расположены конфигурационные файлы {{ TF }} с планом инфраструктуры. Если такой директории нет — создайте ее.


  1. {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Создайте конфигурационный файл с описанием облачной сети и подсетей.

     Кластер {{ dataproc-name }} размещается в облачной сети. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.

     Хосты кластера {{ dataproc-name }} размещаются в подсетях выбранной облачной сети. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

     Пример структуры конфигурационного файла, в котором описывается облачная сеть с одной подсетью:

     ```hcl
     resource "yandex_vpc_network" "test_network" {
       name = "<имя_сети>"
     }

     resource "yandex_vpc_subnet" "test_subnet" {
       name           = "<имя_подсети>"
       zone           = "<зона_доступности>"
       network_id     = yandex_vpc_network.test_network.id
       v4_cidr_blocks = ["<подсеть>"]
     }
     ```


  1. Создайте конфигурационный файл с описанием [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), которому нужно разрешить доступ к кластеру {{ dataproc-name }}, а также [статического ключа](../../iam/concepts/authorization/access-key.md) и бакета {{ objstorage-name }} для хранения заданий и результатов.

     ```hcl
     resource "yandex_iam_service_account" "data_proc_sa" {
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
       member    = "serviceAccount:${yandex_iam_service_account.data_proc_sa.id}"
     }

     resource "yandex_iam_service_account_static_access_key" "sa_static_key" {
       service_account_id = yandex_iam_service_account.data_proc_sa.id
     }

     resource "yandex_storage_bucket" "data_bucket" {
       depends_on = [
         yandex_resourcemanager_folder_iam_member.dataproc-provisioner
       ]

       bucket     = "<имя_бакета>"
       access_key = yandex_iam_service_account_static_access_key.sa_static_key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
     }
     ```

  1. Создайте конфигурационный файл с описанием кластера {{ dataproc-name }} и его подкластеров.

     При необходимости здесь же можно задать [свойства компонентов кластера {{ dataproc-name }}, заданий и среды окружения](../concepts/settings-list.md).

     Пример структуры конфигурационного файла, в котором описывается кластер {{ dataproc-name }} из одного подкластера с хостом-мастером, одного подкластера для хранения данных и одного подкластера для обработки данных:

     ```hcl
     resource "yandex_dataproc_cluster" "data_cluster" {
       bucket              = "<имя_бакета>"
       name                = "<имя_кластера>"
       description         = "<описание_кластера>"
       service_account_id  = yandex_iam_service_account.data_proc_sa.id
       zone_id             = "<зона_доступности>"
       security_group_ids  = ["<список_идентификаторов_групп_безопасности>"]
       deletion_protection = <защита_от_удаления_кластера>

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
             file("${file("<путь_к_открытому_SSH-ключу>")}")
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

     Где `deletion_protection` — защита от удаления кластера {{ dataproc-name }}. Может принимать значения `true` или `false`.

     {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

     {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

     {% note tip %}

     Чтобы использовать самую свежую [версию образа](../concepts/environment.md), укажите значение `2.0` в параметре `version_id`.

     {% endnote %}

     Чтобы получить доступ к [веб-интерфейсам компонентов](../concepts/interfaces.md) {{ dataproc-name }}, добавьте в описание кластера {{ dataproc-name }} поле `ui_proxy` с значением `true`:

     ```hcl
     resource "yandex_dataproc_cluster" "data_cluster" {
       ...
       ui_proxy = true
       ...
     }
     ```

     Чтобы задать параметры [автоматического масштабирования](../concepts/autoscaling.md) в подкластерах {{ dataproc-name }} для обработки данных, добавьте в описание соответствующего подкластера `subcluster_spec` блок `autoscaling_config` с нужными вам настройками:

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
     * `max_hosts_count` — максимальное количество хостов (ВМ) в подкластере {{ dataproc-name }}. Минимальное значение — `1`, максимальное — `100`.
     * `measurement_duration` — период в секундах, за который замеры нагрузки усредняются для каждой ВМ, в формате `<значение>s`. Минимальное значение — `60s` (1 минута), максимальное — `600s` (10 минут).
     * `warmup_duration` — время в секундах на разогрев ВМ, в формате `<значение>s`. Минимальное значение — `0s`, максимальное — `600s` (10 минут).
     * `stabilization_duration` — период в секундах, в течение которого требуемое количество ВМ не может быть снижено, в формате `<значение>s`. Минимальное значение — `60s` (1 минута), максимальное — `1800s` (30 минут).
     * `preemptible` — использование [прерываемых ВМ](../../compute/concepts/preemptible-vm.md). Может принимать значения `true` или `false`.
     * `cpu_utilization_target` — целевой уровень загрузки CPU, в процентах. Используйте эту настройку, чтобы включить [масштабирование](../concepts/autoscaling.md) на основе загрузки CPU, иначе в качестве метрики будет использоваться `yarn.cluster.containersPending` (на основе количества ожидающих задания ресурсов). Минимальное значение — `10`, максимальное — `100`.
     * `decommission_timeout` — [таймаут декомиссии](../concepts/decommission.md) в секундах. Минимальное значение — `0`, максимальное — `86400` (сутки).

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/dataproc_cluster).
  1. Проверьте корректность файлов конфигурации {{ TF }}:

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте кластер {{ dataproc-name }}:

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

- API {#api}

  Чтобы создать кластер {{ dataproc-name }}, воспользуйтесь методом API [create](../api-ref/Cluster/create) и передайте в запросе:
  * Идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором должен быть размещен кластера {{ dataproc-name }}, в параметре `folderId`.
  * Имя кластера {{ dataproc-name }} в параметре `name`.
  * Конфигурацию кластера {{ dataproc-name }} в параметре `configSpec`, в том числе:
    * [Версию образа](../concepts/environment.md) в параметре `configSpec.versionId`.

      {% include [note-light-weight-cluster](../../_includes/data-proc/note-light-weight-cluster.md) %}

      {% note tip %}

      Чтобы использовать самую свежую версию образа, укажите значение `2.0`.

      {% endnote %}

    * Список компонентов в параметре `configSpec.hadoop.services`.
    * Публичную часть [SSH-ключа](../../glossary/ssh-keygen.md) в параметре `configSpec.hadoop.sshPublicKeys`.
    * Настройки подкластеров {{ dataproc-name }} в параметре `configSpec.subclustersSpec`.
  * Зону доступности кластера {{ dataproc-name }} в параметре `zoneId`.
  * Идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) кластера {{ dataproc-name }} в параметре `serviceAccountId`. Сервисному аккаунту должны быть [назначены роли](../../iam/operations/sa/assign-role-for-sa.md):

       {% include [sa-roles](../../_includes/data-proc/sa-roles.md) %}

  * Имя бакета в параметре `bucket`.
  * Идентификаторы групп безопасности кластера {{ dataproc-name }} в параметре `hostGroupIds`.
  * Настройки защиты от удаления кластера {{ dataproc-name }} в параметре `deletionProtection`.

    {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-data.md) %}

  Чтобы назначить публичный IP-адрес всем хостам подкластера {{ dataproc-name }}, передайте значение `true` в параметре `configSpec.subclustersSpec.assignPublicIp`.

  Чтобы создать кластер {{ dataproc-name }}, размещенный на [группах выделенных хостов](../../compute/concepts/dedicated-host.md), передайте список их идентификаторов в параметре `hostGroupIds`.

  {% include [Dedicated hosts note](../../_includes/data-proc/note-dedicated-hosts.md) %}

  Чтобы настроить хосты кластера {{ dataproc-name }} с помощью [скриптов инициализации](../concepts/init-action.md), укажите их в одном или нескольких параметрах `configSpec.hadoop.initializationActions`.

{% endlist %}

После того как кластер {{ dataproc-name }} перейдет в статус **Running**, вы можете [подключиться](connect.md) к хостам подкластеров {{ dataproc-name }} с помощью указанного SSH-ключа.

## Создайте копию кластера {{ dataproc-name }} {#duplicate}

Вы можете создать кластер {{ dataproc-name }}, который будет обладать настройками созданного ранее кластера. Для этого конфигурация исходного кластера {{ dataproc-name }} импортируется в {{ TF }}. В результате вы можете либо создать идентичную копию, либо взять за основу импортированную конфигурацию и внести в нее изменения. Использовать импорт удобно, если исходный кластер {{ dataproc-name }} обладает множеством настроек (например, это кластер с файловой системой HDFS) и нужно создать похожий на него кластер.

Чтобы создать копию кластера {{ dataproc-name }}:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
  1. В той же рабочей директории разместите файл с расширением `.tf` и содержимым:

     ```hcl
     resource "yandex_dataproc_cluster" "old" { }
     ```

  1. Запишите идентификатор первоначального кластера {{ dataproc-name }} в переменную окружения:

     ```bash
     export DATAPROC_CLUSTER_ID=<идентификатор_кластера>
     ```

     Идентификатор можно запросить вместе со [списком кластеров в каталоге](../../data-proc/operations/cluster-list.md#list).

  1. Импортируйте настройки первоначального кластера {{ dataproc-name }} в конфигурацию {{ TF }}:

     ```bash
     terraform import yandex_dataproc_cluster.old ${DATAPROC_CLUSTER_ID}
     ```

  1. Получите импортированную конфигурацию:

     ```bash
     terraform show
     ```

  1. Скопируйте ее из терминала и вставьте в файл с расширением `.tf`.
  1. Расположите файл в новой директории `imported-cluster`.
  1. Измените скопированную конфигурацию так, чтобы из нее можно было создать новый кластер {{ dataproc-name }}:
     * Укажите новое имя кластера {{ dataproc-name }} в строке `resource` и параметре `name`.
     * Удалите параметры `created_at`, `host_group_ids`, `id` и `subcluster_spec.id`.
     * Измените формат [SSH-ключа](../../glossary/ssh-keygen.md) в параметре `ssh_public_keys`. Исходный формат:

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
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Создайте необходимую инфраструктуру:

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Пример {#example}

### Создание легковесного кластера {{ dataproc-name }} для заданий Spark и PySpark {#creating-a-light-weight-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер {{ dataproc-name }} для выполнения заданий Spark без HDFS и подкластеров для хранения данных с тестовыми характеристиками:
  * С именем `my-dataproc`.
  * С бакетом `dataproc-bucket`.
  * В зоне доступности `{{ zone-id }}`.
  * С сервисным аккаунтом `dataproc-sa`.
  * Образом версии `2.0`.
  * С компонентами `SPARK` и `YARN`.
  * С путем к публичной части SSH-ключа `/home/username/.ssh/id_rsa.pub`.
  * С подкластером {{ dataproc-name }} с хостами-мастерами `master` и одним подкластером для обработки данных `compute`:
    * Класса `{{ host-class }}`.
    * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 20 ГБ.
    * В подсети `{{ subnet-name }}`.
    * С публичным доступом.
  * В группе безопасности `{{ security-group }}`.
  * С защитой от случайного удаления кластера {{ dataproc-name }}.

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
     --deletion-protection
  ```

{% endlist %}
