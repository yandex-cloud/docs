# Миграция на сторонний кластер {{ MY }}

Чтобы перенести базу данных, развернутую в кластере {{ mmy-full-name }}, на сторонний кластер {{ MY }}:

1. Перенесите данные.
1. Закройте старую базу данных на запись.
1. Переведите нагрузку на сторонний кластер.

Поддерживается миграция между разными версиями: например, можно перенести базы из {{ MY }} версии 5.7 в версию 8. При этом мажорная версия {{ MY }} на стороннем кластере должна быть не ниже версии на кластере {{ mmy-full-name }}.


## Необходимые платные ресурсы {#paid-resources}

В стоимость инфраструктуры для миграции входит плата за каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы {{ data-transfer-name }}](../../data-transfer/pricing.md)).


## Перед началом работы {#before-you-begin}

Создайте кластер {{ MY }} любой подходящей конфигурации. При этом:

* Версия {{ MY }} должна быть не ниже чем на кластере-источнике.

    Перенос данных с повышением мажорной версии {{ MY }} возможен, но не гарантируется. Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

    Миграция с понижением версии {{ MY }} [невозможна](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

* [Режим SQL](../../managed-mysql/concepts/settings-list.md#setting-sql-mode) должен быть таким же, как и на кластере-источнике.

## Перенос данных {#data-transfer}

# Перенос данных с использованием сервиса {{ data-transfer-full-name }} {#data-transfer}

1. [Подготовьте базу данных кластера-источника](../../data-transfer/operations/prepare.md#source-my).
1. [Подготовьте базу данных кластера-приемника](../../data-transfer/operations/prepare.md#target-my).
1. Создайте эндпоинты и трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `MySQL`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.

                Укажите идентификатор кластера-источника.

        1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `MySQL`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.on_premise.title }}`.
                
                Укажите параметры подключения к кластеру-приемнику.

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-copy-repl }}_, использующий созданные эндпоинты.

        1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate).

    - {{ TF }} {#tf}

        1. Если у вас еще нет {{ TF }}, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации трансфера и эндпоинтов [data-transfer-mmy-mysql.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-cloud-mysql-to-on-premise/blob/main/data-transfer-mmy-mysql.tf).

        1. Укажите в файле конфигурации:

            * [параметры эндпоинта-источника](../../data-transfer/operations/endpoint/source/mysql.md#managed-service);
            * [параметры эндпоинта-приемника](../../data-transfer/operations/endpoint/target/mysql.md#on-premise).

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

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

            В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

            Трансфер активируется автоматически после создания.

    {% endlist %}

    {% note warning %}

    Избегайте любых изменений в схеме данных на кластере-источнике и кластере-приемнике во время работы трансфера. Подробнее см. в разделе [{#T}](../../data-transfer/operations/db-actions.md).

    {% endnote %}

1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.
1. Переведите кластер-источник в режим <q>только чтение</q> и переключите нагрузку на кластер-приемник.
1. На странице [мониторинга трансфера](../../data-transfer/operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum data transfer delay**. Это значит, что в кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
1. [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate-transfer) трансфер и дождитесь его перехода в статус {{ dt-status-stopped }}.

    Подробнее о статусах трансфера см. в разделе [Жизненный цикл трансфера](../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

    {% list tabs group=instructions %}

    - Вручную {#manual}

      1. [Удалите остановленный трансфер](../../data-transfer/operations/transfer.md#delete).
      1. [Удалите эндпоинты для источника и приемника](../../data-transfer/operations/endpoint/index.md#delete).

    - {{ TF }} {#tf}

      1. В терминале перейдите в директорию с планом инфраструктуры.
      
          {% note warning %}
      
          Убедитесь, что в директории нет {{ TF }}-манифестов с ресурсами, которые вы хотите сохранить. {{ TF }} удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
      
          {% endnote %}
      
      1. Удалите ресурсы:
      
          1. Выполните команду:
      
              ```bash
              terraform destroy
              ```
      
          1. Подтвердите удаление ресурсов и дождитесь завершения операции.
      
          Все ресурсы, которые были описаны в {{ TF }}-манифестах, будут удалены.

    {% endlist %}

## См. также {#see-also}

Другие способы миграции описаны в [документации {{ mmy-full-name }}](../../managed-mysql/tutorials/index.md).