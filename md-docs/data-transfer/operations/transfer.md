# Управление трансфером

Вы можете:
* [Получить список трансферов](#list).
* [Получить детальную информацию о трансфере](#get).
* [Создать трансфер](#create).
* [Изменить трансфер](#update).
* [Активировать трансфер](#activate).
* [Деактивировать трансфер](#deactivate).
* [Удалить трансфер](#delete).


Подробнее о состояниях [трансфера](../concepts/index.md#transfer), возможных действиях с ним и имеющихся ограничениях читайте в разделе [{#T}](../concepts/transfer-lifecycle.md).

Если вы хотите перенести трансфер и [эндпоинты](../concepts/index.md#endpoint) в другую [зону доступности](../../overview/concepts/geo-scope.md), обратитесь к [инструкции](endpoint/migration-to-an-availability-zone.md).

## Получить список трансферов {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.

  Вы можете отфильтровать список трансферов по доступным параметрам:
  * имя эндпоинта или трансфера;
  * тип базы данных источника и приемника;
  * тип трансфера;
  * стадия, на которой находится трансфер.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список трансферов в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder), выполните команду:

  ```bash
  {{ yc-dt }} transfer list
  ```


- API {#api}

  Воспользуйтесь методом API [list](../api-ref/Transfer/list.md).


{% endlist %}

## Получить детальную информацию о трансфере {#get}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}).
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Нажмите на имя нужного трансфера.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы получить информацию о трансфере, выполните команду:

    ```bash
    {{ yc-dt }} transfer get <идентификатор_трансфера>
    ```

    Идентификатор трансфера можно получить со [списком трансферов в каталоге](#list).


- API {#api}

    Воспользуйтесь методом API [get](../api-ref/Transfer/get.md) и передайте значение идентификатора трансфера в параметре `transferId` запроса.

    Чтобы узнать идентификатор трансфера, [получите список трансферов в каталоге](#list).


{% endlist %}

## Создать трансфер {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-transfer }}**.
  1. Выберите эндпоинт для источника или [создайте](endpoint/index.md#create) новый.
  1. Выберите эндпоинт для приемника или [создайте](endpoint/index.md#create) новый. Убедитесь, что [подсеть](../concepts/network.md), указанная для эндпоинта приемника, принадлежит той же зоне доступности, что и подсеть эндпоинта источника.
  1. Укажите параметры трансфера:
     * **{{ ui-key.yacloud.common.name }}**.
     * (Опционально) **{{ ui-key.yacloud.common.description }}**.
     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.type.title }}**:
       * {{ dt-type-copy }} — создает полную копию данных без дальнейшего получения обновлений из источника.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshot.regular_snapshot.title }}** — включите для создания полной копии данных через определенные интервалы времени.
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.RegularSnapshotIntervalType.interval.title }}** — выберите интервал копирования из списка. Трансфер будет регулярно запускаться с указанным интервалом. Первый запуск произойдет сразу после сохранения настроек. Если вы запустите трансфер вручную, то следующий запуск произойдет после указанного интервала.
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.RegularSnapshotIntervalType.cron_expression.title }}** — укажите расписание запусков копирования в [формате cron](../../compute/concepts/snapshot-schedule.md#cron). Время указывается в часовом поясе [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00).
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.RegularSnapshotSettings.increment_delay_seconds.title }}** — укажите [временную задержку](../concepts/regular-incremental-copy.md#increment-delay) для завершения текущих транзакций.
             * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshot.incremental_tables.title }}** — укажите таблицы, копирование данных которых осуществляется не полностью, а с места, где копирование завершилось в прошлый раз: укажите значения полей **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.table_namespace.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.table_name.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.key_column.title }}** и (опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.key_start_value.title }}**. Подробнее читайте в разделе [Периодическое инкрементальное копирование](../concepts/regular-incremental-copy.md).
               
               {% note info %}
               
               Это эффективнее, чем копировать таблицы целиком, но менее эффективно, чем использовать тип трансфера _{{ dt-type-copy-repl }}_. Настройка доступна для источников {{ PG }}, {{ CH }} и {{ AB }}.
               
               {% endnote %}
             * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.SnapshotSettings.parallel_settings.title }}** — укажите количество [воркеров](../concepts/index.md#worker) и потоков в каждом воркере для организации параллельного копирования.
               
               Подробнее о настройке воркеров и потоков — в [рекомендациях по параллельному копированию](../concepts/sharded.md#recommendations).
         * {{ dt-type-repl }} — позволяет получать изменения данных от источника и применять их к приемнику (без создания полной копии данных источника).
         * {{ dt-type-copy-repl }} — создает полную копию данных источника и поддерживает ее в актуальном состоянии.
             * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.SnapshotSettings.parallel_settings.title }}** — укажите количество [воркеров](../concepts/index.md#worker) и потоков в каждом воркере для организации параллельного копирования.
               
               Подробнее о настройке воркеров и потоков — в [рекомендациях по параллельному копированию](../concepts/sharded.md#recommendations).


     
     * Для пар источник-приемник, которые [тарифицируются](../pricing.md) и находятся на стадии [GA](../../overview/concepts/launch-stages.md), вы можете настроить объем вычислительных ресурсов для виртуальной машины в блоке настроек **Среда выполнения**.
     
         Для типа трансфера {{ dt-type-copy-repl }} вычислительные ресурсы среды выполнения для копирования и для репликации выбираются отдельно.
         
         Доступны следующие конфигурации вычислительных ресурсов:

         * 2 виртуальных процессора (vCPU) и 4 гигабайта оперативной памяти (RAM). Эта конфигурация используется по умолчанию.
         * 4 vCPU и 8 ГБ RAM.
         * 8 vCPU и 16 ГБ RAM.

         Конфигурация ресурсов виртуальной машины определяет производительность [воркеров](../concepts/index.md#worker), переносящих данные. На каждый воркер выделяется отдельная ВМ. Правила тарификации vCPU и RAM, примеры расчета и рекомендации по оптимизации стоимости читайте в разделе [Правила тарификации сервиса](../pricing.md).


     * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** — укажите полный путь до каждого объекта для переноса. Будут передаваться только объекты из этого списка. Если в настройках эндпоинта-источника указан список включенных таблиц или коллекций, передаваться будут только те объекты, которые есть в обоих списках. Если указать объекты, которых нет в списке включенных таблиц или коллекций в настройках эндпоинта-источника, активация трансфера завершится с ошибкой `$table not found in source`. Настройка недоступна для источников {{ KF }} и {{ DS }}.

         Укажите полное имя объекта. В зависимости от типа источника используйте соответствующую схему именования:

         * {{ CH }} — `<имя_базы>.<путь_до_таблицы>`;
         * {{ GP }} — `<имя_схемы>.<путь_до_таблицы>`;
         * {{ MG }} — `<имя_базы>.<путь_до_коллекции>`;
         * {{ MY }} — `<имя_базы>.<путь_до_таблицы>`;
         * {{ PG }} — `<имя_схемы>.<путь_до_таблицы>`;
         * {{ ydb-short-name }} — путь до таблицы;
         * Oracle — `<имя_схемы>.<путь_до_таблицы>`.

         Если указанный объект находится в списке исключенных таблиц или коллекций в настройках эндпоинта-источника, или имя объекта введено некорректно, трансфер завершится с ошибкой. Работающий трансфер типа {{ dt-type-repl }} или {{ dt-type-copy-repl }} завершится сразу, незапущенный трансфер — в момент активации.

     * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.transformation.title }}** — правила [преобразований данных](../concepts/data-transformation.md). Эта настройка появляется только если источник и приемник имеют разные типы.

        * [{#T}](../concepts/data-transformation.md#rename-tables)
        * [{#T}](../concepts/data-transformation.md#columns-filter)
        * [{#T}](../concepts/data-transformation.md#data-mask)
        * [{#T}](../concepts/data-transformation.md#subtable-splitting)
        * [{#T}](../concepts/data-transformation.md#replace-primary-key)
        * [{#T}](../concepts/data-transformation.md#convert-to-string)
        * [{#T}](../concepts/data-transformation.md#shard)
        * [{#T}](../concepts/data-transformation.md#append-only-sources)


    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать трансфер:

    1. Посмотрите описание команды CLI для создания трансфера:

        ```bash
        {{ yc-dt }} transfer create --help
        ```

    1. Укажите параметры трансфера в команде создания:

        ```bash
        {{ yc-dt }} transfer create <имя_трансфера> \
           --source-id=<идентификатор_эндпоинта-источника> \
           --target-id=<идентификатор_эндпоинта-приемника> \
           --type=<тип_трансфера>
        ```

        Где:

        * `--source-id` — идентификатор эндпоинта-источника.
        * `--target-id` — идентификатор эндпоинта-приемника.
        * `--type` — [тип трансфера](../concepts/transfer-lifecycle.md#transfer-types):
            * `snapshot-only` — [копирование](../concepts/transfer-lifecycle.md#copy).
            * `increment-only` — [репликация](../concepts/transfer-lifecycle.md#replication).
            * `snapshot-and-increment` — [копирование и репликация](../concepts/transfer-lifecycle.md#copy-and-replication).

        {% note info %}

        Имя трансфера должно быть уникальным в каталоге. Оно может содержать латинские буквы, цифры и дефис. Максимальная длина имени 63 символа.

        {% endnote %}

- {{ TF }} {#tf}

    [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

    Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

    Чтобы создать трансфер:

    1. Создайте конфигурационный файл с описанием трансфера.

       Пример структуры конфигурационного файла:

       ```hcl
       resource "yandex_datatransfer_transfer" "<имя_трансфера_в_{{ TF }}>" {
         folder_id   = "<идентификатор_каталога>"
         name        = "<имя_трансфера>"
         description = "<описание_трансфера>"
         source_id   = "<идентификатор_эндпоинта-источника>"
         target_id   = "<идентификатор_эндпоинта-приемника>"
         type        = "<тип_трансфера>"
       }
       ```

       Где:
       
       * `type` — тип трансфера. Возможные значения:
         
         * `SNAPSHOT_ONLY` — копирование;
         * `INCREMENT_ONLY` — репликация;
         * `SNAPSHOT_AND_INCREMENT` — копирование и репликация.

         Трансферы `INCREMENT_ONLY` и `SNAPSHOT_AND_INCREMENT` активируются и запускаются при создании автоматически.
       
       * Чтобы активировать трансфер `SNAPSHOT_ONLY` в момент его создания:

         1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

             По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
       
         1. Добавьте в конфигурационный файл секцию `provisioner "local-exec"` с командой активации трансфера:

             ```hcl
             provisioner "local-exec" {
               command = "yc --profile <профиль> datatransfer transfer activate ${yandex_datatransfer_transfer.<имя_Terraform-ресурса_трансфера>.id}"
             }
             ```
         
             В этом случае копирование выполнится только один раз в момент создания трансфера.

       * Чтобы задать параметры среды выполнения трансфера `SNAPSHOT_ONLY`, добавьте в описание ресурса блок `runtime`:

         ```hcl
         resource "yandex_datatransfer_transfer" "<имя_трансфера_в_{{ TF }}>" {
           ...
           runtime {
             yc_runtime {
               job_count = <количество_воркеров>
               upload_shard_params {
                 job_count     = <количество_воркеров>
                 process_count = <количество_потоков>
               }
             }
           }
           ...
         }
         ```

         Где:

         * `job_count` — количество воркеров, запущенных параллельно.
         * `upload_shard_params` — параметры параллельного копирования:
           
           * `job_count` — количество воркеров;
           * `process_count` — количество потоков внутри каждого воркера.

       * Чтобы задать параметры среды выполнения трансфера `INCREMENT_ONLY`, добавьте в описание ресурса блок `replication_runtime`:

         ```hcl
         resource "yandex_datatransfer_transfer" "<имя_трансфера_в_{{ TF }}>" {
           ...
           replication_runtime {
             yc_runtime {
               job_count = <количество_воркеров>
               upload_shard_params {
                 job_count     = <количество_воркеров>
                 process_count = <количество_потоков>
               }
             }
           }
           ...
         }
         ```

       * Чтобы задать параметры среды выполнения трансфера `SNAPSHOT_AND_INCREMENT`, добавьте в описание ресурса блоки `runtime` и `replication_runtime`:
         
         ```hcl
         resource "yandex_datatransfer_transfer" "<имя_трансфера_в_{{ TF }}>" {
           ...
           runtime {
             yc_runtime {
               job_count = <количество_воркеров>
               upload_shard_params {
                 job_count     = <количество_воркеров>
                 process_count = <количество_потоков>
               }
             }
           }

           replication_runtime {
             yc_runtime {
               job_count = <количество_воркеров>
               upload_shard_params {
                 job_count     = <количество_воркеров>
                 process_count = <количество_потоков>
               }
             }
           }
           ...
         }
         ```

         Где:

         * `runtime` — параметры среды выполнения трансфера для копирования;
         * `replication_runtime` — параметры среды выполнения трансфера для репликации.

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

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

    Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-dt-transfer }}).


- REST API {#api}

    Воспользуйтесь методом REST API [Transfer.Create](../api-ref/Transfer/create.md) и передайте в запросе:

    * Идентификатор каталога, в котором должен быть размещен трансфер, в параметре `folderId`.
    * Имя трансфера в параметре `name`.
    * Идентификатор эндпоинта-источника в параметре `sourceId`.
    * Идентификатор эндпоинта-приемника в параметре `targetId`.
    * Тип трансфера в параметре `type`. Возможные значения:
      
      * `SNAPSHOT_ONLY` — копирование;
      * `INCREMENT_ONLY` — репликация;
      * `SNAPSHOT_AND_INCREMENT` — копирование и репликация.

    * Параметры среды выполнения:
    
      * Для типа трансфера `SNAPSHOT_ONLY` — в объекте `runtime`.
      * Для типа трансфера `INCREMENT_ONLY` — в объекте `replicationRuntime`.
      * Для типа трансфера `SNAPSHOT_AND_INCREMENT`:
      
        * в объекте `runtime` — для копирования;
        * в объекте `replicationRuntime` — для репликации.

- gRPC API {#grpc-api}

    Воспользуйтесь методом gRPC API [TransferService.Create](../api-ref/grpc/Transfer/create.md) и передайте в запросе:

    * Идентификатор каталога, в котором должен быть размещен трансфер, в параметре `folder_id`.
    * Имя трансфера в параметре `name`.
    * Идентификатор эндпоинта-источника в параметре `source_id`.
    * Идентификатор эндпоинта-приемника в параметре `target_id`.
    * Тип трансфера в параметре `type`. Возможные значения:
      
      * `SNAPSHOT_ONLY` — копирование;
      * `INCREMENT_ONLY` — репликация;
      * `SNAPSHOT_AND_INCREMENT` — копирование и репликация.
    
    * Параметры среды выполнения:
    
      * Для типа трансфера `SNAPSHOT_ONLY` — в объекте `runtime`.
      * Для типа трансфера `INCREMENT_ONLY` — в объекте `replication_runtime`.
      * Для типа трансфера `SNAPSHOT_AND_INCREMENT`:
      
        * в объекте `runtime` — для копирования;
        * в объекте `replication_runtime` — для репликации.


{% endlist %}

## Изменить трансфер {#update}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}).
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Выберите трансфер и нажмите кнопку ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** на панели сверху.
    1. Измените параметры трансфера:
        * **{{ ui-key.yacloud.common.name }}**.
        * **{{ ui-key.yacloud.common.description }}**.
        * Для трансфера типа {{ dt-type-copy }}:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshot.regular_snapshot.title }}** — включите для создания полной копии данных через определенные интервалы времени.
              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.RegularSnapshotIntervalType.interval.title }}** — выберите интервал копирования из списка. Трансфер будет регулярно запускаться с указанным интервалом. Первый запуск произойдет сразу после сохранения настроек. Если вы запустите трансфер вручную, то следующий запуск произойдет после указанного интервала.
              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.RegularSnapshotIntervalType.cron_expression.title }}** — укажите расписание запусков копирования в [формате cron](../../compute/concepts/snapshot-schedule.md#cron). Время указывается в часовом поясе [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00).
              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.RegularSnapshotSettings.increment_delay_seconds.title }}** — укажите [временную задержку](../concepts/regular-incremental-copy.md#increment-delay) для завершения текущих транзакций.

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshot.incremental_tables.title }}** — укажите таблицы, копирование данных которых осуществляется не полностью, а с места, где копирование завершилось в прошлый раз: укажите значения полей **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.table_namespace.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.table_name.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.key_column.title }}** и (опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.key_start_value.title }}**. Подробнее читайте в разделе [Периодическое инкрементальное копирование](../concepts/regular-incremental-copy.md).
              
              {% note info %}
              
              Это эффективнее, чем копировать таблицы целиком, но менее эффективно, чем использовать тип трансфера _{{ dt-type-copy-repl }}_. Настройка доступна для источников {{ PG }}, {{ CH }} и {{ AB }}.
              
              {% endnote %}

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.SnapshotSettings.parallel_settings.title }}** — укажите количество [воркеров](../concepts/index.md#worker) и потоков в каждом воркере для организации параллельного копирования.
              
              Подробнее о настройке воркеров и потоков — в [рекомендациях по параллельному копированию](../concepts/sharded.md#recommendations).

        * Для трансфера типа {{ dt-type-copy-repl }}: {#update-copy-repl}

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.SnapshotSettings.parallel_settings.title }}** — укажите количество [воркеров](../concepts/index.md#worker) и потоков в каждом воркере для организации параллельного копирования.
              
              Подробнее о настройке воркеров и потоков — в [рекомендациях по параллельному копированию](../concepts/sharded.md#recommendations).


        
        * Для пар источник-приемник, которые [тарифицируются](../pricing.md) и находятся на стадии [GA](../../overview/concepts/launch-stages.md), вы можете изменить объем вычислительных ресурсов для виртуальной машины в блоке настроек **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.runtime.title }}**.
        
            Для типа трансфера {{ dt-type-copy-repl }} вычислительные ресурсы среды выполнения для копирования и для репликации выбираются отдельно.
        
            Доступны следующие конфигурации вычислительных ресурсов:

            * 2 виртуальных процессора (vCPU) и 4 гигабайта оперативной памяти (RAM). Эта конфигурация используется по умолчанию.
            * 4 vCPU и 8 ГБ RAM.
            * 8 vCPU и 16 ГБ RAM.

            Конфигурация ресурсов ВМ определяет производительность [воркеров](../concepts/index.md#worker), переносящих данные. На каждый воркер выделяется отдельная ВМ. Правила тарификации vCPU и RAM, примеры расчета и рекомендации по оптимизации стоимости читайте в разделе [Правила тарификации сервиса](../pricing.md).


        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** — укажите полный путь до каждого объекта для переноса. Будут передаваться только объекты из этого списка. Если в настройках эндпоинта-источника указан список включенных таблиц или коллекций, передаваться будут только те объекты, которые есть в обоих списках. Если указать объекты, которых нет в списке включенных таблиц или коллекций в настройках эндпоинта-источника, активация трансфера завершится с ошибкой `$table not found in source`. Настройка недоступна для источников {{ KF }} и {{ DS }}.

            Добавление новых объектов в трансферах типа {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }} приведет к загрузке истории данных по этим объектам (таблицам). Для больших таблиц загрузка истории может занять существенное время. Редактирование списка объектов на трансферах в статусе {{ dt-status-copy }} запрещено.

            Укажите полное имя объекта. В зависимости от типа источника используйте соответствующую схему именования:

            * {{ CH }} — `<имя_базы>.<путь_до_таблицы>`;
            * {{ GP }} — `<имя_схемы>.<путь_до_таблицы>`;
            * {{ MG }} — `<имя_базы>.<путь_до_коллекции>`;
            * {{ MY }} — `<имя_базы>.<путь_до_таблицы>`;
            * {{ PG }} — `<имя_схемы>.<путь_до_таблицы>`;
            * {{ ydb-short-name }} — путь до таблицы;
            * Oracle — `<имя_схемы>.<путь_до_таблицы>`.

            Если указанный объект находится в списке исключенных таблиц или коллекций в настройках эндпоинта-источника, или имя объекта введено некорректно, трансфер завершится с ошибкой. Работающий трансфер типа {{ dt-type-repl }} или {{ dt-type-copy-repl }} завершится сразу, незапущенный трансфер — в момент активации.

        * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.transformation.title }}** — правила [преобразований данных](../concepts/data-transformation.md). Эта настройка появляется только если источник и приемник имеют разные типы.

           * [{#T}](../concepts/data-transformation.md#rename-tables)
           * [{#T}](../concepts/data-transformation.md#columns-filter)
           * [{#T}](../concepts/data-transformation.md#data-mask)
           * [{#T}](../concepts/data-transformation.md#subtable-splitting)
           * [{#T}](../concepts/data-transformation.md#replace-primary-key)
           * [{#T}](../concepts/data-transformation.md#convert-to-string)
           * [{#T}](../concepts/data-transformation.md#shard)
           * [{#T}](../concepts/data-transformation.md#append-only-sources)


    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить настройки трансфера:

    1. Посмотрите описание команды CLI для изменения трансфера:

        ```bash
        {{ yc-dt }} transfer update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        {{ yc-dt }} transfer update <идентификатор_трансфера> \
           --name=<имя_трансфера> \
           --description=<описание_трансфера>
        ```

        Идентификатор трансфера можно получить со [списком трансферов в каталоге](#list).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием трансфера.

      О том, как создать такой файл, читайте в подразделе [Создать трансфер](#create).

  1. Измените значение полей `name` и `description` (имя и описание трансфера).
  1. Измените параметры среды выполнения:
      
      * Для типа трансфера `SNAPSHOT_ONLY` — в блоке `runtime`.
      * Для типа трансфера `INCREMENT_ONLY` — в блоке `replication_runtime`.
        
        Если параметры среды выполнения уже заданы в блоке `runtime`, то добавлять блок `replication_runtime` не требуется.

      * Для типа трансфера `SNAPSHOT_AND_INCREMENT`:
        
        * в блоке `runtime` — для копирования;
        * в блоке `replication_runtime` — для репликации.

        Если задан только блок `runtime`, то параметры среды выполнения для копирования и для репликации будут одинаковыми.

  1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Подтвердите изменение ресурсов.

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

  Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-dt-transfer }}).


- REST API {#api}

    Воспользуйтесь методом REST API [Transfer.Update](../api-ref/Transfer/update.md) и передайте в запросе:

    * Идентификатор трансфера в параметре `transferId`. Чтобы узнать идентификатор, [получите список трансферов в каталоге](#list).
    * Имя трансфера в параметре `name`.
    * Описание трансфера в параметре `description`.
    * Параметры среды выполнения:

      * Для типа трансфера `SNAPSHOT_ONLY` — в объекте `runtime`.
      * Для типа трансфера `INCREMENT_ONLY` — в объекте `replicationRuntime`.

        Если параметры среды выполнения уже заданы в объекте `runtime`, то передавать `replicationRuntime` не требуется.

      * Для типа трансфера `SNAPSHOT_AND_INCREMENT`:
      
        * в объекте `runtime` — для копирования;
        * в объекте `replicationRuntime` — для репликации.

        Если задан только объект `runtime`, то параметры среды выполнения для копирования и для репликации будут одинаковыми.

    * Список изменяемых полей конфигурации трансфера в параметре `updateMask`.

      {% note warning %}

      При изменении трансфера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

      {% endnote %}

- gRPC API {#grpc-api}
    
    Воспользуйтесь методом gRPC API [TransferService.Update](../api-ref/grpc/Transfer/update.md) и передайте в запросе:

    * Идентификатор трансфера в параметре `transfer_id`. Чтобы узнать идентификатор, [получите список трансферов в каталоге](#list).
    * Имя трансфера в параметре `name`.
    * Описание трансфера в параметре `description`.
    * Параметры среды выполнения:

      * Для типа трансфера `SNAPSHOT_ONLY` — в объекте `runtime`.
      * Для типа трансфера `INCREMENT_ONLY` — в объекте `replication_runtime`.

        Если параметры среды выполнения уже заданы в объекте `runtime`, то передавать `replication_runtime` не требуется.

      * Для типа трансфера `SNAPSHOT_AND_INCREMENT`:
      
        * в объекте `runtime` — для копирования;
        * в объекте `replication_runtime` — для репликации.

        Если задан только объект `runtime`, то параметры среды выполнения для копирования и для репликации будут одинаковыми.

    * Список изменяемых полей конфигурации трансфера в параметре `update_mask`.

      {% note warning %}

      При изменении трансфера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

      {% endnote %}


{% endlist %}

При изменении трансфера настройки применяются сразу. Изменение настроек трансфера с типом {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }} приведет к перезапуску трансфера.

## Активировать трансфер {#activate}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}).
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Нажмите на значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) рядом с именем нужного трансфера и выберите пункт ![ellipsis](../../_assets/console-icons/play.svg) **{{ ui-key.yacloud.data-transfer.label_connector-operation-ACTIVATE }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы активировать трансфер, выполните команду:

    ```bash
    {{ yc-dt }} transfer activate <идентификатор_трансфера>
    ```

    Идентификатор трансфера можно получить со [списком трансферов в каталоге](#list).


- API {#api}

    Воспользуйтесь методом API [activate](../api-ref/Transfer/activate.md) и передайте значение идентификатора трансфера в параметре `transferId` запроса.

    Чтобы узнать идентификатор трансфера, [получите список трансферов в каталоге](#list).


{% endlist %}

{% note info %}

Операция доступна в [мобильном приложении](https://yandex.cloud/ru/mobile-app) {{ yandex-cloud }}. 

{% endnote %}

## Деактивировать трансфер {#deactivate}

В процессе деактивации трансфера:

* отключается слот репликации на источнике;
* удаляются временные логи переноса данных;
* приемник приводится в согласованное состояние:
    * переносятся объекты схемы данных источника для финальной стадии;
    * создаются индексы.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Переведите источник в режим <q>только чтение</q> (read-only).
    1. Перейдите на [страницу каталога]({{ link-console-main }}).
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Нажмите на значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) рядом с именем нужного трансфера и выберите пункт **{{ ui-key.yacloud.data-transfer.label_connector-operation-DEACTIVATE }}**.
    1. Дождитесь перехода трансфера в статус {{ dt-status-stopped }}.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы деактивировать трансфер, выполните команду:

    ```bash
    {{ yc-dt }} transfer deactivate <идентификатор_трансфера>
    ```

    Идентификатор трансфера можно получить со [списком трансферов в каталоге](#list).


- API {#api}

    Воспользуйтесь методом API [deactivate](../api-ref/Transfer/deactivate.md) и передайте значение идентификатора трансфера в параметре `transferId` запроса.

    Чтобы узнать идентификатор трансфера, [получите список трансферов в каталоге](#list).


{% endlist %}

{% note warning %}

Не прерывайте деактивацию трансфера! Если процесс завершится некорректно, работоспособность источника и приемника не гарантируется.

{% endnote %}

Подробнее читайте в разделе [{#T}](../concepts/transfer-lifecycle.md).


{% note info %}

Операция доступна в [мобильном приложении](https://yandex.cloud/ru/mobile-app) {{ yandex-cloud }}. 

{% endnote %}


## Удалить трансфер {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}).
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Если нужный трансфер находится в активном состоянии, [деактивируйте его](#deactivate).
    1. Нажмите на значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) рядом с именем нужного трансфера и выберите пункт **{{ ui-key.yacloud.common.remove }}**.
    1. Нажмите кнопку ![ellipsis](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.remove }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы удалить трансфер, выполните команду:

    ```bash
    {{ yc-dt }} transfer delete <идентификатор_трансфера>
    ```

    Идентификатор трансфера можно получить со [списком трансферов в каталоге](#list).

- {{ TF }} {#tf}

    Чтобы удалить трансфер, созданный с помощью {{ TF }}:
    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
    
       О том, как создать такой файл, читайте в разделе [{#T}](transfer.md#create).
    1. Удалите описание трансфера.
    1. Проверьте корректность настроек.
    
       1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
       1. Выполните команду:
       
          ```bash
          terraform validate
          ```
       
          Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
    
    1. Введите слово `yes` и нажмите **Enter**.
    
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
    
    Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-dt-transfer }}).


- API {#api}

    Воспользуйтесь методом API [delete](../api-ref/Transfer/delete.md) и передайте значение идентификатора трансфера в параметре `transferId` запроса.

    Чтобы узнать идентификатор трансфера, [получите список трансферов в каталоге](#list).


{% endlist %}



_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._