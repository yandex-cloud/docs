---
title: Как управлять трансфером в {{ data-transfer-full-name }}
description: 'Следуя данной инструкции, вы сможете управлять трансфером: получать список трансферов, детальную информацию о трансфере, создавать, изменять, активировать, деактивировать, удалять трансфер.'
---

# Управление трансфером

Вы можете:
* [Получить список трансферов](#list).
* [Получить детальную информацию о трансфере](#get).
* [Создать трансфер](#create).
* [Изменить трансфер](#update).
* [Активировать трансфер](#activate).
* [Деактивировать трансфер](#deactivate).
* [Удалить трансфер](#delete).


Подробнее о состояниях [трансфера](../concepts/index.md#transfer), возможных действиях с ним и имеющихся ограничениях см. в разделе [{#T}](../concepts/transfer-lifecycle.md).

Если вы хотите перенести трансфер и [эндпоинты](../concepts/index.md#endpoint) в другую [зону доступности](../../overview/concepts/geo-scope.md), обратитесь к [инструкции](endpoint/migration-to-an-availability-zone.md).

## Получить список трансферов {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.

  Вы можете отфильтровать список трансферов по доступным параметрам:
  * имя эндпоинта или трансфера;
  * тип базы данных источника и приемника;
  * тип трансфера;
  * стадия, на которой находится трансфер.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Нажмите на имя нужного трансфера.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-transfer }}**.
  1. Выберите эндпоинт для источника или [создайте](./endpoint/index.md#create) новый.
  1. Выберите эндпоинт для приемника или [создайте](./endpoint/index.md#create) новый. Убедитесь, что [подсеть](../concepts/network.md), указанная для эндпоинта приемника, принадлежит той же зоне доступности, что и подсеть эндпоинта источника.
  1. Укажите параметры трансфера:
     * **{{ ui-key.yacloud.common.name }}**.
     * (Опционально) **{{ ui-key.yacloud.common.description }}**.
     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.type.title }}**:
       * {{ dt-type-copy }} — создает полную копию данных без дальнейшего получения обновлений из источника.
         * {% include [field periodic snapshot](../../_includes/data-transfer/fields/periodic-snapshot.md) %}
             * {% include [field incremental tables](../../_includes/data-transfer/fields/incremental-tables.md) %}
             * {% include [field parallel copy](../../_includes/data-transfer/fields/parallel-copy.md) %}
         * {{ dt-type-repl }} — позволяет получать изменения данных от источника и применять их к приемнику (без создания полной копии данных источника).
         * {{ dt-type-copy-repl }} — создает полную копию данных источника и поддерживает ее в актуальном состоянии.
             * {% include [field parallel copy](../../_includes/data-transfer/fields/parallel-copy.md) %}


     
     * Для пар источник-приемник, которые [тарифицируются](../pricing.md) и находятся на стадии [GA](../../overview/concepts/launch-stages.md), вы можете настроить объем вычислительных ресурсов для виртуальной машины в блоке настроек **Среда выполнения**.
     
         Для типа трансфера {{ dt-type-copy-repl }} вычислительные ресурсы среды выполнения для копирования и для репликации выбираются отдельно.
         
         Доступны следующие конфигурации вычислительных ресурсов:

         {% include [vm-computing-resources](../../_includes/data-transfer/vm-computing-resources.md) %}

         Конфигурация ресурсов виртуальной машины определяет производительность [воркеров](../concepts/index.md#worker), переносящих данные. На каждый воркер выделяется отдельная ВМ. Правила тарификации vCPU и RAM, примеры расчета и рекомендации по оптимизации стоимости см. в разделе [Правила тарификации сервиса](../pricing.md).


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

        {% include [list-of-transformers](../../_includes/data-transfer/list-of-transformers.md) %}


    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

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

         1. {% include [cli-install](../../_includes/cli-install.md) %}

             {% include [default-catalogue](../../_includes/default-catalogue.md) %}
       
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

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-transfer }}).


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
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Выберите трансфер и нажмите кнопку ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** на панели сверху.
    1. Измените параметры трансфера:
        * **{{ ui-key.yacloud.common.name }}**.
        * **{{ ui-key.yacloud.common.description }}**.
        * Для трансфера типа {{ dt-type-copy }}:

            * {% include [field periodic snapshot](../../_includes/data-transfer/fields/periodic-snapshot.md) %}

            * {% include [field incremental tables](../../_includes/data-transfer/fields/incremental-tables.md) %}

            * {% include [field parallel copy](../../_includes/data-transfer/fields/parallel-copy.md) %}

        * Для трансфера типа {{ dt-type-copy-repl }}: {#update-copy-repl}

            * {% include [field parallel copy](../../_includes/data-transfer/fields/parallel-copy.md) %}


        
        * Для пар источник-приемник, которые [тарифицируются](../pricing.md) и находятся на стадии [GA](../../overview/concepts/launch-stages.md), вы можете изменить объем вычислительных ресурсов для виртуальной машины в блоке настроек **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.runtime.title }}**.
        
            Для типа трансфера {{ dt-type-copy-repl }} вычислительные ресурсы среды выполнения для копирования и для репликации выбираются отдельно.
        
            Доступны следующие конфигурации вычислительных ресурсов:

            {% include [vm-computing-resources](../../_includes/data-transfer/vm-computing-resources.md) %}

            Конфигурация ресурсов ВМ определяет производительность [воркеров](../concepts/index.md#worker), переносящих данные. На каждый воркер выделяется отдельная ВМ. Правила тарификации vCPU и RAM, примеры расчета и рекомендации по оптимизации стоимости см. в разделе [Правила тарификации сервиса](../pricing.md).


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

           {% include [list-of-transformers](../../_includes/data-transfer/list-of-transformers.md) %}


    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

      О том, как создать такой файл, см. в подразделе [Создать трансфер](#create).

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

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-transfer }}).


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
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Нажмите на значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) рядом с именем нужного трансфера и выберите пункт ![ellipsis](../../_assets/console-icons/play.svg) **{{ ui-key.yacloud.data-transfer.label_connector-operation-ACTIVATE }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы активировать трансфер, выполните команду:

    ```bash
    {{ yc-dt }} transfer activate <идентификатор_трансфера>
    ```

    Идентификатор трансфера можно получить со [списком трансферов в каталоге](#list).


- API {#api}

    Воспользуйтесь методом API [activate](../api-ref/Transfer/activate.md) и передайте значение идентификатора трансфера в параметре `transferId` запроса.

    Чтобы узнать идентификатор трансфера, [получите список трансферов в каталоге](#list).


{% endlist %}

{% include [мобильное приложение](../../_includes/data-transfer/use-mobile-app.md) %}

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
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Нажмите на значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) рядом с именем нужного трансфера и выберите пункт **{{ ui-key.yacloud.data-transfer.label_connector-operation-DEACTIVATE }}**.
    1. Дождитесь перехода трансфера в статус {{ dt-status-stopped }}.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

Подробнее см. в разделе [{#T}](../concepts/transfer-lifecycle.md).


{% include [мобильное приложение](../../_includes/data-transfer/use-mobile-app.md) %}


## Удалить трансфер {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Если нужный трансфер находится в активном состоянии, [деактивируйте его](#deactivate).
    1. Нажмите на значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) рядом с именем нужного трансфера и выберите пункт **{{ ui-key.yacloud.common.remove }}**.
    1. Нажмите кнопку ![ellipsis](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.remove }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить трансфер, выполните команду:

    ```bash
    {{ yc-dt }} transfer delete <идентификатор_трансфера>
    ```

    Идентификатор трансфера можно получить со [списком трансферов в каталоге](#list).

- {{ TF }} {#tf}

    {% include [terraform-delete](../../_includes/data-transfer/terraform-delete-transfer.md) %}


- API {#api}

    Воспользуйтесь методом API [delete](../api-ref/Transfer/delete.md) и передайте значение идентификатора трансфера в параметре `transferId` запроса.

    Чтобы узнать идентификатор трансфера, [получите список трансферов в каталоге](#list).


{% endlist %}



{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
