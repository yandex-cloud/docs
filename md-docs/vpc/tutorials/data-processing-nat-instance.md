# Настройка сети для Yandex Data Processing


В этом руководстве описано создание кластера Yandex Data Processing с настройкой подсетей и NAT-шлюза.


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластер Yandex Data Processing: использование вычислительных ресурсов с наценкой за сервис Yandex Data Processing, использование сетевых дисков, получение и хранение логов, объем исходящего трафика ([тарифы Yandex Data Processing](../../data-proc/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Yandex Virtual Private Cloud](../pricing.md)).
* NAT-шлюз: почасовое использование шлюза и исходящий через него трафик ([тарифы Virtual Private Cloud](../pricing.md)).
* Бакет Yandex Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../storage/pricing.md)).


## Создайте ресурсы {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте сеть](../operations/network-create.md) с именем `data-proc-network`, при создании выключив опцию **Создать подсети**.
    1. В сети `data-proc-network` [создайте подсеть](../operations/subnet-create.md) со следующими параметрами:

        * **Имя** — `data-proc-subnet-a`.
        * **Зона доступности** — `ru-central1-a`.
        * **CIDR** — `192.168.1.0/24`.

    1. [Создайте NAT-шлюз](../operations/create-nat-gateway.md) и таблицу маршрутизации с именем `data-proc-route-table` в сети `data-proc-network`. Привяжите таблицу к подсети `data-proc-subnet-a`.

    1. В сети `data-proc-network` [создайте группу безопасности](../operations/security-group-create.md) с именем `data-proc-security-group` и следующими правилами:

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

        * Правило, разрешающее доступ к NTP-серверам для синхронизации времени:

            * **Диапазон портов**  — `123`.
            * **Протокол** — `UDP`.
            * **Назначение** — `CIDR`.
            * **CIDR блоки** — `0.0.0.0/0`.

        {% note info %}
        
        Вы можете добавить [дополнительные правила в группу безопасности](../../data-proc/operations/security-groups.md), чтобы подключиться к хостам кластера.
        
        {% endnote %}

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `data-proc-sa` с ролями:

        * [dataproc.agent](../../data-proc/security/index.md#dataproc-agent);
        * [dataproc.provisioner](../../data-proc/security/index.md#dataproc-provisioner);
        * [storage.uploader](../../storage/security/index.md#storage-uploader);
        * [storage.viewer](../../storage/security/index.md#storage-viewer).

    1. [Создайте бакет Yandex Object Storage](../../storage/operations/buckets/create.md) с ограниченным доступом.

    1. [Создайте кластер Yandex Data Processing](../../data-proc/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

        * **Сервисный аккаунт** — `data-proc-sa`.
        * **Формат указания бакета** — `Список`.
        * **Имя бакета** — выберите созданный ранее бакет.
        * **Сеть** — `data-proc-network`.
        * **Группы безопасности** — `data-proc-security-group`.

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
       
       
       Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
    1. [Скачайте файл конфигурации кластера](https://github.com/yandex-cloud-examples/yc-data-proc-configure-network/blob/main/data-proc-nat-gateway.tf) в ту же рабочую директорию.

        В файле описаны:

        * сеть;
        * подсеть;
        * NAT-шлюз и таблица маршрутизации;
        * группа безопасности;
        * сервисный аккаунт для работы с ресурсами кластера;
        * сервисный аккаунт для управления бакетом;
        * статический ключ доступа, необходимый для выдачи сервисному аккаунту нужных разрешений на бакет;
        * бакет, в котором будут храниться зависимости заданий и результаты их выполнения;
        * кластер Yandex Data Processing.

        {% note info %}
        
        Вы можете добавить [дополнительные правила в группу безопасности](../../data-proc/operations/security-groups.md), чтобы подключиться к хостам кластера.
        
        {% endnote %}

    1. Укажите в файле конфигурации все необходимые параметры.

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

    В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud/cloud).

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите кластер Yandex Data Processing](../../data-proc/operations/cluster-delete.md).
    1. Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../operations/address-delete.md).
    1. [Удалите бакет Object Storage](../../storage/operations/buckets/delete.md). Перед удалением бакета [удалите из него все объекты](../../storage/operations/objects/delete.md).
    1. [Удалите подсеть](../operations/subnet-delete.md).
    1. [Удалите таблицу маршрутизации](../operations/delete-route-table.md).
    1. [Удалите NAT-шлюз](../operations/delete-nat-gateway.md).
    1. [Удалите сеть](../operations/network-delete.md).

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