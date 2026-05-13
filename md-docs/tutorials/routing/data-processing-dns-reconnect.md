# Переключение сетевого соединения при пересоздании кластера Yandex Data Processing

Пересоздание кластера может понадобиться для обновления программного обеспечения, переноса нагрузки между кластерами, перемещения кластеров между зонами доступности и других операций.

В примере описана настройка DNS для быстрого переключения сетевого трафика на новые [FQDN хостов](../../data-proc/concepts/network.md#hostname) при пересоздании кластера Yandex Data Processing. Для актуального имени хоста-мастера кластера создается сетевой псевдоним (запись CNAME) в сервисе Yandex Cloud DNS. При пересоздании кластера CNAME-запись изменяется на новое имя хоста-мастера.

Чтобы настроить DNS для кластера Yandex Data Processing:

1. [Создайте DNS-зону и запись CNAME](#dns-record).
1. [Удалите кластер и создайте его заново](#recreate-cluster).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Yandex Data Processing (см. [тарифы Yandex Data Processing](../../data-proc/pricing.md)).
* Плата за NAT-шлюз (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Плата за бакет Object Storage: хранение данных и выполнение операций с ними (см. [тарифы Object Storage](../../storage/pricing.md)).
* Плата за использование публичных IP-адресов, если для хостов кластера включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#deploy-infrastructure}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте сеть](../../vpc/operations/network-create.md) с именем `data-proc-network`, при создании выключив опцию **Создать подсети**.
    1. В сети `data-proc-network` [создайте подсеть](../../vpc/operations/subnet-create.md) со следующими параметрами:

        * **Имя** — `data-proc-subnet-a`.
        * **Зона доступности** — `ru-central1-a`.
        * **CIDR** — `192.168.1.0/24`.

    1. [Создайте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) и таблицу маршрутизации с именем `data-proc-route-table` в сети `data-proc-network`. Привяжите таблицу к подсети `data-proc-subnet-a`.

    1. В сети `data-proc-network` [создайте группу безопасности](../../vpc/operations/security-group-create.md) с именем `data-proc-security-group` и следующими правилами:

        * По одному правилу для входящего и исходящего служебного трафика:

            * **Диапазон портов** — `0-65535`.
            * **Протокол** — `Любой`.
            * **Источник**/**Назначение** — `Группа безопасности`.
            * **Группа безопасности** — `Текущая`.

        * Правило для исходящего HTTPS-трафика:

            * **Диапазон портов** — `443`.
            * **Протокол** — `TCP`.
            * **Назначение** — `CIDR`.
            * **CIDR блоки** — `0.0.0.0/0`.

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `data-proc-sa` с ролями:

        * [dataproc.agent](../../data-proc/security/index.md#dataproc-agent);
        * [dataproc.provisioner](../../data-proc/security/index.md#dataproc-provisioner);
        * [storage.uploader](../../storage/security/index.md#storage-uploader);
        * [storage.viewer](../../storage/security/index.md#storage-viewer).

    1. [Создайте бакет Yandex Object Storage](../../storage/operations/buckets/create.md) с ограниченным доступом.

    1. [Создайте кластер Yandex Data Processing](../../data-proc/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

        * **Окружение** — `PRODUCTION`.
        * **Сервисный аккаунт** — `data-proc-sa`.
        * **Формат указания бакета** — `Список`.
        * **Имя бакета** — выберите созданный ранее бакет.
        * **Сеть** — `data-proc-network`.
        * **Группы безопасности** — `data-proc-security-group`.

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите и настройте](../infrastructure-management/terraform-quickstart.md#install-terraform) его.
    1. [Скачайте файл с настройками провайдера](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider).
    1. Скачайте в ту же рабочую директорию файл конфигурации [data-proc-dns-connect.tf](https://github.com/yandex-cloud-examples/yc-data-proc-reconnect-network/blob/main/data-proc-dns-connect.tf).

        В файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * DNS-зона и запись CNAME для хоста-мастера кластера;
        * NAT-шлюз и таблица маршрутизации;
        * [группы безопасности](../../vpc/concepts/security-groups.md);
        * сервисный аккаунт для работы с ресурсами кластера;
        * сервисный аккаунт для управления бакетом;
        * статический ключ доступа, необходимый для выдачи сервисному аккаунту нужных разрешений на бакет;
        * бакет, в котором будут храниться зависимости заданий и результаты их выполнения;
        * кластер Yandex Data Processing.

    1. Укажите в файле `data-proc-dns-connect.tf` переменные:

        * `folder_id` — идентификатор каталога;
        * `path_to_ssh_public_key` — путь к публичному SSH-ключу;
        * `os_sa_name` – имя сервисного аккаунта для управления бакетом;
        * `bucket` — имя бакета.

    1. Выполните команду `terraform init` в рабочей директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
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

## Создайте DNS-зону и запись CNAME {#dns-record}

Создайте ресурсы:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте внутреннюю зону DNS](../../dns/operations/zone-create-private.md) с настройками:

       * **Зона** — `data-proc-test-user.org.`.
       * **Сети** — выберите сеть `data-proc-network`.
       * **Имя** — `dp-private-zone`.

    1. [Создайте DNS-запись](../../dns/operations/resource-record-create.md) с типом CNAME и настройками:
       * **Имя** — `data-proc-test-user.org.`.
       * **Значение** — [FQDN хоста-мастера](../../data-proc/operations/fqdn.md) кластера Yandex Data Processing.

- Terraform {#tf}

    1. [Получите адрес FQDN](../../data-proc/operations/fqdn.md) хоста-мастера кластера Yandex Data Processing.
    1. Укажите в файле `data-proc-dns-connect.tf` переменную:

        * `dataproc_fqdn` — значение FQDN хоста-мастера кластера Yandex Data Processing.

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

Проверьте сетевой доступ к кластеру по записи CNAME:

```text
dig data-proc-test-user.org.
<...>
;; ANSWER SECTION:
data-proc-test-user.org. 600	IN	CNAME	rc1a-dataproc-m-6ijqng07vul2mu8j.mdb.yandexcloud.net.
rc1a-dataproc-m-6ijqng07vul2mu8j.mdb.yandexcloud.net. 600 IN A 192.168.1.8
```

## Удалите кластер и создайте его заново {#recreate-cluster}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите кластер Yandex Data Processing](../../data-proc/operations/cluster-delete.md) и создайте новый с [идентичными характеристиками](#deploy-infrastructure).
    1. [Измените DNS-запись](../../dns/operations/resource-record-update.md), созданную [ранее](#dns-record), и укажите в параметре **Значение** FQDN хоста-мастера вновь созданного кластера.

- Terraform {#tf}

    1. Удалите секцию `yandex_dataproc_cluster` в файле `data-proc-dns-connect.tf`.
    1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Примените изменения:

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

    1. Добавьте секцию `yandex_dataproc_cluster` в файле `data-proc-dns-connect.tf` с тем же содержанием, что и в [исходном файле](#deploy-infrastructure), для создания нового кластера Yandex Data Processing.
    1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Создайте кластер:

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

    1. [Получите адрес FQDN](../../data-proc/operations/fqdn.md) хоста-мастера вновь созданного кластера Yandex Data Processing.
    1. Укажите в файле `data-proc-dns-connect.tf` переменную:

        * `dataproc_fqdn` — значение FQDN хоста-мастера кластера.

    1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Примените изменения:

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

Проверьте, что сетевой доступ к созданному кластеру по записи CNAME сохранился:

```text
dig data-proc-test-user.org.
<...>
;; ANSWER SECTION:
data-proc-test-user.org. 600	IN	CNAME	rc1a-dataproc-m-lsqohjh53rfu659d.mdb.yandexcloud.net.
rc1a-dataproc-m-8kompl81232cdsu8j.mdb.yandexcloud.net. 600 IN A 192.168.1.8
```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите кластер Yandex Data Processing](../../data-proc/operations/cluster-delete.md).
    1. Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).
    1. [Удалите подсеть](../../vpc/operations/subnet-delete.md).
    1. [Удалите таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
    1. [Удалите NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
    1. [Удалите сеть](../../vpc/operations/network-delete.md).
    1. [Удалите DNS-зону](../../dns/operations/zone-delete.md).

- Terraform {#tf}

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