# Как начать работать с Yandex Cloud Backup на существующей ВМ


Прежде чем начать работу с Cloud Backup, убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md) и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`.

Убедитесь также, что у вас есть [виртуальная машина](../../compute/concepts/vm.md) Yandex Compute Cloud. В этой инструкции вы подключите к Cloud Backup виртуальную машину под управлением ОС [Linux](https://ru.wikipedia.org/wiki/Linux). Если у вас нет виртуальной машины, воспользуйтесь инструкцией [Как начать работать с Yandex Cloud Backup на новой ВМ](new-vm.md).

{% cut "В стоимость ресурсов для резервного копирования ВМ входят:" %}

* плата за [вычислительные ресурсы](../../compute/concepts/vm-platforms.md) и [диски](../../compute/concepts/disk.md) ВМ ([тарифы Yandex Compute Cloud](../../compute/pricing.md));
* плата за защищенные ВМ и хранение резервных копий ([тарифы Yandex Cloud Backup](../../backup/pricing.md)).

{% endcut %}

Чтобы начать работать с Cloud Backup:

1. [Подготовьте инфраструктуру](#deploy-infrastructure).
1. [Активируйте Cloud Backup](#activate-provider).
1. [Установите агент Cloud Backup](#connect-vm).
1. [Привяжите ВМ к политике резервного копирования](#add-policy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте инфраструктуру {#deploy-infrastructure}

1. В [облачной сети](../../vpc/concepts/network.md#network) с подключаемой к Cloud Backup виртуальной машиной [создайте](../../vpc/operations/security-group-create.md) группу безопасности со следующими [правилами](../../vpc/concepts/security-groups.md#security-groups-rules) для исходящего трафика:

    Диапазон портов | Протокол | Назначение | CIDR блоки
    --- | --- | --- | ---
    `80` | `TCP` | `CIDR` | `213.180.193.0/24`
    `80` | `TCP` | `CIDR` | `213.180.204.0/24`
    `443` | `TCP` | `CIDR` | `84.47.172.0/24`
    `443` | `TCP` | `CIDR` | `84.201.181.0/24`
    `443` | `TCP` | `CIDR` | `178.176.128.0/24`
    `443` | `TCP` | `CIDR` | `213.180.193.0/24`
    `443` | `TCP` | `CIDR` | `213.180.204.0/24`
    `7770-7800` | `TCP` | `CIDR` | `84.47.172.0/24`
    `8443` | `TCP` | `CIDR` | `84.47.172.0/24`
    `44445` | `TCP` | `CIDR` | `51.250.1.0/24`
    
    
    
    {% note tip %}
    
    При установке [агента Cloud Backup](../concepts/agent.md) на ВМ или сервер BareMetal может понадобиться доустановить отсутствующие компоненты ПО из интернета. Для этого добавьте в [группу безопасности](../../vpc/concepts/security-groups.md) следующее правило для исходящего трафика:
    * **Диапазон портов** — `0-65535`.
    * **Протокол** — `Любой` (`Any`).
    * **Назначение** — `CIDR`.
    * **CIDR блоки** — `0.0.0.0/0`.
    После установки агента Cloud Backup вы можете удалить это правило.
    
    Для доступа к ВМ по протоколу [SSH](../../compute/operations/vm-connect/ssh.md) добавьте следующее правило для входящего трафика:
    * **Диапазон портов** — `22`.
    * **Протокол** — `Любой` (`Any`).
    * **Назначение** — `CIDR`.
    * **CIDR блоки** — `0.0.0.0/0`.
    
    {% endnote %}

1. Назначьте подключаемой к Cloud Backup ВМ созданную [группу безопасности](../../vpc/concepts/security-groups.md):

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно подключить ВМ к Cloud Backup.
      1. Перейдите в сервис **Compute Cloud** и выберите нужную ВМ.
      1. В блоке **Сетевой интерфейс** добавьте группу безопасности в [сетевой интерфейс](../../compute/concepts/network.md) ВМ:
      
          * В правом верхнем углу блока нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Изменить**.
          * В открывшемся окне в поле **Группы безопасности** выберите созданную ранее группу безопасности.
          * Нажмите **Сохранить**.
      
      1. Если у ВМ нет [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses), то в секции **Сеть** в правом верхнем углу блока нужного сетевого интерфейса нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Добавить публичный IP-адрес**. В открывшемся окне:
      
          * В поле **Публичный адрес** выберите `Автоматически`, чтобы автоматически получить IP-адрес, или `Список`, чтобы выбрать зарезервированный адрес из списка.
          * (Опционально) Если в поле **Публичный адрес** вы выбрали `Автоматически`, включите опцию **Защита от DDoS-атак**. Подробнее в разделе [Yandex DDoS Protection в Virtual Private Cloud](../../vpc/ddos-protection/index.md).
          * Если в поле **Публичный адрес** вы выбрали `Список`, выберите IP-адрес, который хотите привязать к ВМ. IP-адрес и ВМ должны находиться в одной [зоне доступности](../../overview/concepts/geo-scope.md).
          * Нажмите **Добавить**.
      
          Вместо назначения ВМ публичного IP-адреса вы можете привязать к подсети с ВМ [таблицу маршрутизации](../../vpc/concepts/routing.md#rt-vm), разрешающую доступ в интернет через [NAT-шлюз](../../vpc/concepts/gateways.md) или пользовательский маршрутизатор.

    {% endlist %}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../security/index.md#backup-user) `backup.user` или выше. 
1. Привяжите к подключаемой к Cloud Backup ВМ созданный [сервисный аккаунт](../../iam/concepts/users/service-accounts.md):

    {% note info %}
    
    К виртуальной машине можно привязать только один сервисный аккаунт.
    
    {% endnote %}
    
    Чтобы привязать сервисный аккаунт к ВМ, необходимо иметь разрешение на использование этого сервисного аккаунта. Это разрешение входит в роли [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user), [editor](../../iam/roles-reference.md#editor) и выше.

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно подключить ВМ к Cloud Backup.
      1. Перейдите в сервис **Compute Cloud** и в открывшемся списке выберите нужную ВМ.
      1. В правом верхнем углу страницы нажмите ![image](../../_assets/console-icons/pencil.svg) **Изменить ВМ**.
      1. В блоке **Дополнительно** выберите сервисный аккаунт с ролью `backup.user` или выше.
      1. Нажмите **Сохранить изменения**.

    {% endlist %}

## Активируйте Cloud Backup {#activate-provider}

Чтобы активировать сервис, у вас должна быть _минимальная_ [роль](../security/index.md#backup-user) `backup.user` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создавать резервные копии ВМ или серверов BareMetal.

Активация сервиса запускает работу провайдера резервного копирования. Подробнее о провайдере резервного копирования и передаваемых ему данных в разделе [Активация сервиса и провайдер резервного копирования](../concepts/index.md#providers).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно подключить ВМ к Cloud Backup.
  1. Перейдите в сервис **Cloud Backup**.
  1. Если сервис Cloud Backup еще не активирован, нажмите **Активировать**.

      Если кнопки **Активировать** нет и вам доступно создание ВМ с подключением к Cloud Backup, значит, сервис уже активирован. Переходите к следующему шагу.

{% endlist %}

## Установите агент Cloud Backup {#connect-vm}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по SSH.
1. Установите агент Cloud Backup на ВМ. Для этого в терминале Linux выполните команду:

    {% list tabs group=operating_system %}

    - Ubuntu {#ubuntu}

      ```bash
      sudo apt update && \
      sudo apt install -y jq && \
      curl https://storage.yandexcloud.net/backup-distributions/agent_installer.sh | sudo bash
      ```

      Результат:

      ```text
      ...
      Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
      ```

    - CentOS {#centos}

      ```bash
      sudo yum install epel-release -y && \
      sudo yum update -y && \
      sudo yum install jq -y && \
      curl https://storage.yandexcloud.net/backup-distributions/agent_installer.sh | sudo bash
      ```

      Результат:

      ```text
      ...
      Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
      ```

    {% endlist %}

    {% note info %}

    В случае появления ошибки `Failed to parse cloudbackup from instance attributes IAM token and instance registration id are empty, unable to provide authorization` убедитесь, что к ВМ [привязан](../operations/connect-vm-linux.md#connect-sa-to-vm) сервисный аккаунт с [ролью](../security/index.md#backup-user) `backup.user` или выше.

    {% endnote %}

## Привяжите ВМ к политике резервного копирования {#add-policy}

После установки агента ВМ будет добавлена в сервис **Cloud Backup** на вкладку ![machines](../../_assets/console-icons/server.svg) **Виртуальные машины**, и ее можно будет [привязать](../operations/policy-vm/attach-and-detach-vm.md) к [политике резервного копирования](../concepts/policy.md) Cloud Backup.

1. Убедитесь, что агент Cloud Backup установлен:
   
   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором активирован сервис.
     1. Перейдите в сервис **Compute Cloud**.
     1. Выберите нужную ВМ.
     1. Убедитесь, что в блоке **Резервное копирование** в поле **Cloud Backup** отображается значение `Нет политики`.
   
   {% endlist %}
1. Привяжите ВМ к политике резервного копирования:
   
   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором активирован сервис и где находится нужная виртуальная машина.
     1. Перейдите в сервис **Cloud Backup**.
     1. На панели слева выберите ![policies](../../_assets/console-icons/calendar.svg) **Политики копирования**.
     1. Выберите одну из политик, созданных по умолчанию. При необходимости нажмите кнопку **Создать политику**, чтобы создать новую политику.
     1. В блоке **Привязанные ресурсы** на вкладке **Виртуальные машины** нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **Привязать ресурс**.
     1. В открывшемся окне выберите нужную ВМ из списка и нажмите **Привязать**.
   
   {% endlist %}
   
   В результате виртуальная машина будет привязана к политике резервного копирования, а ее резервные копии начнут создаваться по расписанию, заданному в политике.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. Если для ВМ были созданы резервные копии, [удалите](../operations/backup-vm/delete.md) их.
1. [Удалите](../operations/delete-vm.md) ВМ из Cloud Backup.

## Что дальше {#what-is-next}

* [Узнайте об особенностях сервиса](../concepts/index.md)
* [Посмотрите другие инструкции по работе с сервисом](../operations/index.md)

#### Полезные ссылки {#see-also}

* [Чем отличается резервная копия от снапшота](../../glossary/snapshot.md#backup-vs-snapshot)
* [Создать снимок диска](../../compute/operations/disk-control/create-snapshot.md)

* [Как начать работать с Yandex Cloud Backup](index.md)