1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте и настройте облачную сеть](#create-network).
1. [Создайте ВМ в облаке](#create-vm).
1. [Создайте кластер БД {{ MY }}](#create-mysql).
1. [Настройте сервер для работы с «1C-Битрикс»](#configure-server).
1. [Настройте «1С-Битрикс»](#configure-bitrix).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [bitrix-website-paid-resources](../_tutorials_includes/bitrix-website-paid-resources.md) %}

## Создайте и настройте облачную сеть {#create-network}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Создайте сеть](../../vpc/operations/network-create.md) с именем `network-1`. При создании сети отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. В сети `network-1` [создайте](../../vpc/operations/subnet-create.md) две [подсети](../../vpc/concepts/network.md#subnet) в разных [зонах доступности](../../overview/concepts/geo-scope.md) со следующими параметрами:
     1. Подсеть в зоне доступности `{{ region-id }}-a`:
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `subnet-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `192.168.0.0/24`.
     1. Подсеть в зоне доступности `{{ region-id }}-b`:
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `subnet-b`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-b`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `192.168.1.0/24`.
  1. В сети `network-1` [создайте группы безопасности](../../vpc/operations/security-group-create.md):
     1. С именем `bitrix-sg-vm` для ВМ в облаке. [Задайте правила](../../vpc/operations/security-group-add-rule.md) для этой [группы безопасности](../../vpc/concepts/security-groups.md) в соответствии с таблицей:

        Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
        --- | --- | --- | --- | --- | ---
        Исходящий | `ANY` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`
        Входящий | `HTTP` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`
        Входящий | `EXT-HTTPS` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`
        Входящий | `SSH` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`

     1. С именем `bitrix-sg` для кластера баз данных {{ MY }}. [Задайте правила](../../vpc/operations/security-group-add-rule.md) для этой группы безопасности в соответствии с таблицей:

        Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
        --- | --- | --- | --- | --- | ---
        Исходящий | `ANY` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`
        Входящий | `EXT-HTTPS` | `3306` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}` | `0.0.0.0/0`

{% endlist %}

## Создайте ВМ в облаке {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите пункт **Виртуальная машина**.
  1. В поле **Имя** введите имя ВМ, например, `bitrixwebsite`.
  1. В поле **Зона доступности** выберите `{{ region-id }}-a`.
  1. В блоке **{{ marketplace-name }}** выберите образ операционной системы [Ubuntu 22.04 lts](/marketplace/products/yc/ubuntu-22-04-lts).
  1. В блоке **Диски** выберите жесткий диск `SSD` размером `24 ГБ`.
  1. В блоке **Вычислительные ресурсы**:
     * Выберите [платформу](../../compute/concepts/vm-platforms.md) ВМ.
     * Для корректной работы системы «1С-Битрикс» укажите конфигурацию:
       * **Платформа** — `Intel Ice Lake`.
       * **Гарантированная доля vCPU** — `20%`.
       * **vCPU** — `2`.
       * **RAM** — `4 ГБ`.
  1. В блоке **Сетевые настройки**:
     * В поле **Подсеть** выберите созданную ранее подсеть `subnet-a`.
     * В поле **Публичный адрес** оставьте значение **Автоматически**, чтобы назначить ВМ случайный публичный IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.
     * В поле **Группы безопасности** выберите группу безопасности `bitrix-sg-vm`.
  1. В блоке **Доступ** укажите данные для доступа к ВМ:
     * В поле **Логин** введите предпочтительное имя пользователя, который будет создан на ВМ, например `ubuntu`.
     * В поле **SSH-ключ** скопируйте ваш открытый [SSH-ключ](../../glossary/ssh-keygen.md). Пару ключей для подключения по SSH необходимо создать [самостоятельно](../../compute/operations/vm-connect/ssh.md).
  1. Нажмите кнопку **Создать ВМ**.

  В процессе работы вам может потребоваться сохранять [снимки диска](../../compute/operations/disk-control/create-snapshot.md) ВМ. Они содержат копию файловой системы ВМ на момент создания снимка.

  Вы можете использовать снимки для различных целей, например:
  * Перенос данных с одного диска на другой — например, на диск в другой зоне доступности.
  * Создание [резервной копии](../../compute/concepts/backups.md) диска перед операциями, которые могут повлечь повреждение данных.
  * Версионирование диска путем [регулярного создания снимков диска](../../compute/operations/disk-control/configure-schedule.md).

{% endlist %}

## Создайте кластер БД {{ MY }} {#create-mysql}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице каталога в [консоли управления]({{ link-console-main }}) выберите сервис **{{ mmy-name }}**.
  1. Нажмите кнопку **Создать ресурс** и выберите пункт **Кластер {{ MY }}**.
  1. В поле **Имя** введите имя кластера, например `Bitrix{{ MY }}`.
  1. В блоке **Класс хоста** выберите `s2.micro`. Данных характеристик хватит для работы системы «1С-Битрикс».
  1. В блоке **Размер хранилища** выберите [тип хранилища](../../managed-mysql/concepts/storage.md) — `network-ssd` размером 10 ГБ.
  1. В блоке **База данных** укажите:
     * **Имя БД**. В этом руководстве оставьте значение по умолчанию `db1`.
     * **Имя пользователя**, которое является логином для подключения к БД. В этом руководстве оставьте значение по умолчанию `user1`.
     * **Пароль**, будет использоваться для доступа системой «1С-Битрикс» к БД {{ MY }}, например `p@s$woRd!`.
  1. В блоке **Сетевые настройки**:
     * В поле **Сеть** выберите созданную ранее сеть `network-1`.
     * В поле **Группы безопасности** выберите группу безопасности `bitrix-sg`.
  1. В блоке **Хосты**, при необходимости, поменяйте **Зону доступности**, в которой должна находиться база данных. Для этого нажмите значок ![pencil](../../_assets/pencil.svg) в строке с деталями о хосте. В открывшемся окне выберите нужную зону доступности и нажмите кнопку **Сохранить**.

     Рекомендуется выбрать ту же зону доступности, которую вы выбрали при создании ВМ. Это позволит уменьшить задержку (latency) между ВМ и БД.

     ![Шаг 3](../../_assets/tutorials/bitrix-website/create-mysql-cluster3.png)

  1. Для обеспечения отказоустойчивости вы можете добавить дополнительные хосты для вашей БД. Для этого выберите **Добавить хост** и укажите, в какой зоне доступности он будет размещен.
  1. Остальные поля оставьте без изменений.
  1. Нажмите на кнопку **Создать кластер**.

  Создание кластера БД может занять несколько минут. Проверить доступность созданного кластера вы можете в консоли управления {{ yandex-cloud }}, выбрав сервис **{{ mmy-name }}**. На вкладке **Кластеры** статус кластера должен быть **Running**, состояние **Alive**.

{% endlist %}

## Настройте сервер для работы с «1C-Битрикс» {#configure-server}

{% include [bitrix-website-configure-server](../_tutorials_includes/bitrix-website-configure-server.md) %}

## Настройте «1С-Битрикс» {#configure-bitrix}

{% include [bitrix-website-configure-bitrix](../_tutorials_includes/bitrix-website-configure-bitrix.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ `bitrixwebsite`.
1. [Удалите](../../managed-mysql/operations/cluster-delete.md) кластер БД `Bitrix{{ MY }}`.

Если вы зарезервировали статический публичный IP-адрес специально для этой ВМ:
1. Выберите сервис **{{ vpc-name }}** в вашем каталоге.
1. Перейдите на вкладку **IP-адреса**.
1. Найдите нужный IP-адрес, нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите пункт **Удалить**.
