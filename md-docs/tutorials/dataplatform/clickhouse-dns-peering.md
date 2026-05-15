# Настройка Yandex Cloud DNS для доступа к кластеру Yandex Managed Service for ClickHouse® из других облачных сетей

# Настройка Yandex Cloud DNS для доступа к кластеру управляемых баз данных из других облачных сетей


В этом руководстве в качестве примера используется кластер Managed Service for ClickHouse®. Настройка доступности для других сервисов управляемых баз данных делается аналогично.

Ресурсные записи о кластерах Managed Service for ClickHouse® создаются в [сервисных зонах DNS](../../dns/concepts/dns-zone.md#service-zones), которые работают в пределах одной [облачной сети](../../vpc/concepts/network.md#network). Из-за этого клиенты, например виртуальные машины, которые находятся в другой облачной сети, не могут подключаться к хостам кластера по [FQDN](../../managed-clickhouse/concepts/network.md#hostname), даже если между облачными сетями настроена сетевая связность.

Чтобы клиенты из других облачных сетей могли подключаться к кластеру по FQDN, настройте общую DNS-зону в сервисе Yandex Cloud DNS:

1. [Создайте зону в Yandex Cloud DNS](#create-peering-zone).
1. [Проверьте доступность кластера из другой облачной сети](#check-cluster-availability).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for ClickHouse®: использование вычислительных ресурсов, выделенных хостам (в том числе хостам ZooKeeper), и дискового пространства (см. [тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Плата за ВМ: использование вычислительных ресурсов, хранилища и публичного IP-адреса (опционально) (см. [тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за DNS-зону и DNS-запросы (см. [тарифы Cloud DNS](../../dns/pricing.md)).


## Перед началом работы {#before-you-begin}

1. [Подготовьте пару SSH-ключей](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) для подключения к виртуальным машинам.
1. Подготовьте инфраструктуру:

    {% list tabs %}

    - Вручную

        1. [Создайте две облачные сети](../../vpc/operations/network-create.md) с именами `mch-net` и `another-net`.
        1. В каждой сети [создайте подсеть](../../vpc/operations/subnet-create.md).
        1. В сети `mch-net` [создайте кластер](../../managed-clickhouse/operations/cluster-create.md) Managed Service for ClickHouse® любой подходящей конфигурации с хостами без публичного доступа.
        1. (Опционально) В сети `mch-net` [создайте виртуальную машину на базе Linux](../../compute/operations/vm-create/create-linux-vm.md) с именем `mch-net-vm`. При создании укажите подготовленный ранее публичный SSH-ключ.
        1. В сети `another-net` [создайте виртуальную машину на базе Linux](../../compute/operations/vm-create/create-linux-vm.md) с именем `another-net-vm`. При создании укажите подготовленный ранее публичный SSH-ключ.
        1. Настройте правила групп безопасности кластера и ВМ [по инструкции](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups)

    - С помощью Terraform

        1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации [nets-vm-mch.tf](https://github.com/yandex-cloud-examples/yc-dns-for-managed-clickhouse/blob/main/nets-vm-mch.tf).

            В этом файле описаны:

            * [сети](../../vpc/concepts/network.md#network);
            * [подсети](../../vpc/concepts/network.md#subnet);
            * [группы безопасности](../../vpc/concepts/security-groups.md), необходимые для кластера Managed Service for ClickHouse® и виртуальных машин;
            * виртуальные машины;
            * кластер Managed Service for ClickHouse®;
            * внутренняя зона DNS.

        1. Укажите в файле `nets-vm-mch.tf`:

            * `ch_dbname` — имя базы данных в кластере Managed Service for ClickHouse®.
            * `ch_user` — имя пользователя-администратора в кластере Managed Service for ClickHouse®.
            * `ch_password` — пароль пользователя-администратора в кластере Managed Service for ClickHouse®.
            * `image_id` — идентификатор публичного образа виртуальной машины. О том, как получить список доступных образов, см. в [инструкции](../../compute/operations/images-with-pre-installed-software/get-list.md).
            * `vm_username` — имя пользователя виртуальной машины.
            * `vm_ssh_key_path` — абсолютный путь к публичному ключу для виртуальных машин, который вы подготовили ранее.
            * `create_optional_vm` — параметр, который отвечает за создание виртуальной машины в той же сети, в которой расположен кластер. Установите `1`, чтобы в дальнейшем проверить доступность кластера из той же сети (опционально).

        1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационном файле, и позволяет работать с ресурсами и источниками данных провайдера.
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

1. (Опционально) [Подключитесь по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) к виртуальной машине `mch-net-vm` и [настройте подключение к кластеру](../../managed-clickhouse/operations/connect/clients.md) через `clickhouse-client`, чтобы убедиться, что группы безопасности настроены верно и подключение к кластеру по FQDN из той же облачной сети доступно.
1. Настройте сетевую связность между облачными сетями `mch-net` и `another-net`, например, с помощью [IPSec-шлюза](../routing/ipsec/index.md). Другие способы настроить сетевую связность см. в разделе [Руководства по работе с сетевой инфраструктурой в Yandex Cloud](../routing/index.md).

## Создайте зону в Cloud DNS {#create-peering-zone}

1. Создайте зону DNS:

    {% list tabs %}

    - Вручную

        Создайте внутреннюю зону DNS с адресом `mdb.yandexcloud.net.` [по инструкции](../../dns/operations/zone-create-private.md). В списке сетей укажите сети `mch-net` и `another-net`.

    - С помощью Terraform

        1. Укажите в файле `nets-vm-mch.tf` значение `1` для параметра `create_zone`.

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

    {% endlist %}

1. Проверьте, что в зоне DNS автоматически появилась запись для кластера:

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, где находится зона DNS.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud DNS**.
    1. Выберите зону из списка.
    1. Убедитесь, что в списке записей есть запись вида: `c-<идентификатор_кластера>.rw.mdb.yandexcloud.net.`.

## Проверьте доступность кластера из другой облачной сети {#check-cluster-availability}

1. [Подключитесь по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) к виртуальной машине `another-net-vm`.
1. [Настройте подключение к кластеру](../../managed-clickhouse/operations/connect/clients.md) через `clickhouse-client` и убедитесь, что подключение к кластеру из другой облачной сети по FQDN работает.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs %}

- Вручную

    1. [Зону DNS](../../dns/operations/zone-delete.md).
    1. [Кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-delete.md).
    1. [Облачные сети](../../vpc/operations/network-delete.md).

- С помощью Terraform

    1. В терминале перейдите в директорию с планом инфраструктуры.
    
        {% note warning %}
    
        Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
    
        {% endnote %}
    
    1. Удалите ресурсы:
    
        1. Выполните команду:
    
            ```bash
            terraform destroy
            ```
    
        1. Подтвердите удаление ресурсов и дождитесь завершения операции.
    
        Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

{% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._