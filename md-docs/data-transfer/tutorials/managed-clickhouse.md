# Миграция кластера ClickHouse®

# Миграция данных с использованием сервиса Yandex Data Transfer

С помощью сервиса Data Transfer вы можете перенести вашу базу данных из стороннего кластера-источника ClickHouse® в кластер-приемник Managed Service for ClickHouse®.

Этот способ позволяет:

* скопировать базу без остановки обслуживания пользователей;
* обойтись без создания промежуточной [виртуальной машины](../../glossary/vm.md) или разрешения доступа к вашему кластеру-приемнику Managed Service for ClickHouse® из интернета.

Вы также можете использовать этот способ для переноса данных между двумя кластерами Managed Service for ClickHouse®. Для успешного переноса в эндпоинте-источнике укажите порты `8443` и `9440`, а также добавьте [SSL-сертификат](../../managed-clickhouse/operations/connect/index.md#get-ssl-cert).

Подробнее в разделе [Какие задачи решает сервис Yandex Data Transfer](../concepts/use-cases.md).


## Перед началом работы {#before-you-begin}

[Разрешите подключение к кластеру-источнику из интернета](../concepts/network.md#source-external).

### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for ClickHouse®: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Managed Service for ClickHouse®](../../managed-clickhouse/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных ([тарифы Data Transfer](../pricing.md)).


## Перенос данных {#data-transfer}

1. [Подготовьте кластер-источник](../operations/prepare.md#source-ch).
1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте группу безопасности](../../vpc/operations/security-group-create.md) и [настройте ее](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

        1. [Создайте кластер-приемник Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-create.md), вычислительная мощность и размер хранилища которого соответствуют среде, в которой развернута копируемая база данных.

            При создании кластера укажите группу безопасности, подготовленную ранее.

            Имя базы в кластере-приемнике должно совпадать с именем базы-источника.

            Если вы планируете подключаться к кластеру через сервис [Yandex WebSQL](../../websql/concepts/index.md), включите в настройках кластера настройку **Доступ из WebSQL**.

        1. [Создайте эндпоинт для источника](../operations/endpoint/index.md#create):

            * **Тип базы данных** — `ClickHouse`.
            * **Параметры эндпоинта** → **Настройки подключения** — `Пользовательская инсталляция`.

                Укажите параметры подключения к кластеру-источнику.

        1. [Создайте эндпоинт для приемника](../operations/endpoint/index.md#create):

            * **Тип базы данных** — `ClickHouse`.
            * **Параметры эндпоинта** → **Настройки подключения** — `Managed кластер`.

                Выберите кластер-приемник из списка и укажите настройки подключения к нему.

        1. [Создайте трансфер](../operations/transfer.md#create) типа _**Копирование**_, использующий созданные эндпоинты, и [активируйте](../operations/transfer.md#activate) его.

    - С помощью Terraform {#tf}

        1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-ch-mch.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-on-premise-clickhouse-to-cloud/blob/main/data-transfer-ch-mch.tf).

            В этом файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру;
            * кластер-приемник Managed Service for ClickHouse®;
            * эндпоинт для источника;
            * эндпоинт для приемника;
            * трансфер.

        1. Укажите в файле `data-transfer-ch-mch.tf`:

            * [параметры эндпоинта-источника](../operations/endpoint/source/clickhouse.md#on-premise):
                * `source_user` и `source_pwd` — имя и пароль пользователя для доступа к источнику;
                * `source_db_name` — имя базы данных;
                * `source_host` — FQDN или IP-адрес сервера ClickHouse®;
                * `source_shard` — имя шарда;
                * `source_http_port` и `source_native_port` — порты для подключения по HTTP-интерфейсу и нативному интерфейсу ClickHouse®.

            * параметры кластера-приемника, которые используются и как [параметры эндпоинта-приемника](../operations/endpoint/target/clickhouse.md#managed-service):

                * `target_clickhouse_version` — версия ClickHouse®;
                * `target_user` и `target_password` — имя и пароль пользователя-владельца базы данных.

            * параметры [CLI Yandex Cloud](../../cli/index.md), чтобы активировать кластер автоматически:

                * `profile_name` — имя вашего профиля в CLI Yandex Cloud.

                    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

        1. (Опционально) Если вы планируете подключаться к кластеру через сервис [Yandex WebSQL](../../websql/concepts/index.md), добавьте к ресурсу кластера блок `access`:

            ```hcl
            access {
                web_sql = true
            }
            ```

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

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **Завершен**.
1. Убедитесь, что в базу данных Managed Service for ClickHouse® перенеслись данные из кластера-источника ClickHouse®:

    {% list tabs group=instructions %}
    
    
    - Yandex WebSQL {#websql}

        1. [Создайте подключение](../../websql/operations/create-connection.md#connect-cluster) к БД в кластере Managed Service for ClickHouse®.
        1. Проверьте, что БД содержит таблицы из кластера-источника. Для этого через созданное подключение [выполните запрос](../../websql/operations/query-executor.md#execute-query) к БД:

            ```sql
            SHOW TABLES FROM <имя_базы_данных>;
            ```

        1. Проверьте, что таблицы содержат данные из таблиц кластера-источника. Для этого через созданное подключение [выполните запрос](../../websql/operations/query-executor.md#execute-query) к нужной таблице:

            ```sql
            SELECT * FROM <имя_базы_данных>.<имя_таблицы>;
            ```


    - CLI {#cli}

        1. [Получите SSL-сертификат](../../managed-clickhouse/operations/connect/index.md#get-ssl-cert) для подключения к кластеру Managed Service for ClickHouse®.      
        1. [Подключитесь к БД](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) в кластере Managed Service for ClickHouse® с помощью `clickhouse-client`.
        1. Проверьте, что БД содержит таблицы из кластера-источника:

            ```sql
            SHOW TABLES FROM <имя_базы_данных>;
            ```
 
        1. Проверьте, что таблицы содержат данные из таблиц кластера-источника:

            ```sql
            SELECT * FROM <имя_базы_данных>.<имя_таблицы>;
            ```

    {% endlist %}

## Удалите созданные ресурсы {#clear-out}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Удалите кластер Managed Service for ClickHouse®](../../managed-clickhouse/operations/cluster-delete.md).
  1. [Удалите завершившийся трансфер](../operations/transfer.md#delete).
  1. [Удалите эндпоинты](../operations/endpoint/index.md#delete) для источника и приемника.

- С помощью Terraform {#tf}

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