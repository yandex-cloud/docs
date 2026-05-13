# Миграция кластера MySQL®

С помощью сервиса Data Transfer вы можете перенести данные из стороннего кластера-источника в кластер-приемник Managed Service for MySQL®.

Этот способ позволяет перенести базу целиком без остановки обслуживания пользователей. Для его использования необходимо разрешить подключение к кластеру-источнику из интернета.


# Перенос данных с использованием сервиса Yandex Data Transfer {#data-transfer}

Чтобы перенести базу данных из MySQL® в Managed Service for MySQL®:

1. [Запустите перенос данных](#start-transfer).
1. [Завершите перенос данных](#finish-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for MySQL®: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы Managed Service for MySQL®](../../managed-mysql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы Data Transfer](../../data-transfer/pricing.md)).


## Запустите перенос данных {#start-transfer}

1. [Подготовьте кластер-источник](../../data-transfer/operations/prepare.md#source-my).
1. Подготовьте инфраструктуру и запустите перенос данных:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте кластер-приемник Managed Service for MySQL®](../../managed-mysql/operations/cluster-create.md) любой подходящей конфигурации. При этом:

            * Версия MySQL® должна быть не ниже, чем в кластере-источнике.

                Перенос данных с повышением мажорной версии MySQL® возможен, но не гарантируется. Подробнее см. в [документации MySQL®](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

                Миграция с понижением версии MySQL® [невозможна](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

            * [Режим SQL](../../managed-mysql/concepts/settings-list.md#setting-sql-mode) должен быть таким же, как и в кластере-источнике.

        1. [Подготовьте кластер-приемник](../../data-transfer/operations/prepare.md#target-my).

        1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

            * **Тип базы данных** — `MySQL`.
            * **Параметры эндпоинта** → **Настройки подключения** — `Пользовательская инсталляция`.

                Укажите параметры подключения к кластеру-источнику.

        1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

            * **Тип базы данных** — `MySQL`.
            * **Параметры эндпоинта** → **Настройки подключения** — `Кластер Managed Service for MySQL`.

                Выберите кластер-приемник из списка и укажите настройки подключения к нему.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа _**Копирование и репликация**_, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

            {% note warning %}

            Избегайте любых изменений в схеме данных в кластере-источнике и кластере-приемнике во время работы трансфера. Подробнее см. в разделе [Работа с базами данных во время трансфера](../../data-transfer/operations/db-actions.md).

            {% endnote %}

    - Terraform {#tf}

        1. [Подготовьте кластер-источник](../../data-transfer/operations/prepare.md#source-my).

        1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mysql-mmy.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-on-premise-mysql-to-cloud/blob/main/data-transfer-mysql-mmy.tf).

            В этом файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру;
            * кластер-приемник Managed Service for MySQL®;
            * эндпоинт для источника;
            * эндпоинт для приемника;
            * трансфер.

        1. Укажите в файле `data-transfer-mysql-mmy.tf`:

            * [параметры эндпоинта-источника](../../data-transfer/operations/endpoint/source/mysql.md#on-premise);
            * параметры кластера-приемника, которые используются и как [параметры эндпоинта-приемника](../../data-transfer/operations/endpoint/target/mysql.md#managed-service):

                * `target_mysql_version` — версия MySQL®, она должна быть не ниже чем в кластере-источнике;
                * `target_sql_mode` — [режим SQL](../../managed-mysql/concepts/settings-list.md#setting-sql-mode), он должен быть таким же, как и в кластере-источнике;
                * `target_db_name` — имя базы данных;
                * `target_user` и `target_password` — имя и пароль пользователя-владельца базы данных.

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

            Трансфер активируется автоматически после создания.

    {% endlist %}

## Завершите перенос данных {#finish-transfer}

1. Дождитесь перехода трансфера в статус **Реплицируется**.
1. Переведите кластер-источник в режим <q>только чтение</q> и переключите нагрузку на кластер-приемник.
1. На странице [мониторинга трансфера](../../data-transfer/operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum data transfer delay**. Это значит, что в кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
1. [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate) трансфер и дождитесь его перехода в статус **Остановлен**.

    Подробнее о статусах трансфера см. в разделе [Жизненный цикл трансфера](../../data-transfer/concepts/transfer-lifecycle.md#statuses).

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите кластер Managed Service for MySQL®](../../managed-mysql/operations/cluster-delete.md).
    1. [Удалите остановленный трансфер](../../data-transfer/operations/transfer.md#delete).
    1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.

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


Реальный пример миграции базы данных MySQL® с помощью сервиса Data Transfer см. в разделе [Синхронизация данных из MySQL с помощью Yandex Data Transfer](sync-mysql.md).

## См. также {#see-also}

Другие способы миграции описаны в [документации Yandex Managed Service for MySQL®](../../managed-mysql/tutorials/data-migration/index.md).