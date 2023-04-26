# Управление трансфером

Вы можете:

* [получить список трансферов](#list);
* [создать трансфер](#create);
* [изменить трансфер](#update);
* [активировать трансфер](#activate);
* [деактивировать трансфер](#deactivate);
* [перезагрузить трансфер](#reupload);
* [удалить трансфер](#delete).

Подробнее о состояниях трансфера, возможных действиях с ним и имеющихся ограничениях см. в разделе [{#T}](../concepts/transfer-lifecycle.md).

## Получить список трансферов {#list}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.

{% endlist %}

## Создать трансфер {#create}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-transfer }}**.
    1. Выберите эндпоинт для источника или [создайте](./endpoint/index.md#create) новый.
    1. Выберите эндпоинт для приемника или [создайте](./endpoint/index.md#create) новый.
    1. Укажите параметры трансфера:

        * **{{ ui-key.yacloud.common.name }}**.
        * (Опционально) **{{ ui-key.yacloud.common.description }}**.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.type.title }}**:

            * {{ dt-type-copy }} — создает полную копию данных без дальнейшего получения обновлений из источника. B блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}** укажите количество процессов и потоков для организации параллельного копирования.
                Для создания полной копии данных через определенные интервалы времени, включите настройку **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshot.regular_snapshot.title }}** и выберите требуемый интервал копирования в поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.RegularSnapshotIntervalType.interval.title }}**.

                В списке **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshot.incremental_tables.title }}** добавьте таблицы, копирование данных которых осуществляется не полностью, а с места, где копирование завершилось в прошлый раз: укажите значения полей **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.table_namespace.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.table_name.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.key_column.title }}** и **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.key_start_value.title }}** (опционально). Трансфер запомнит максимальное значение колонки курсора и при следующей активации будет считывать только те данные, которые были добавлены или обновлены с момента последнего запуска. Это эффективнее, чем копировать таблицы целиком, но менее эффективно, чем использовать тип трансфера _{{ dt-type-copy-repl }}_. Настройка доступна для источников {{ PG }}, {{ CH }} и Airbyte.

                {% include [postgresql-cursor-serial](../../_includes/data-transfer/serial-increment-cursor.md) %}
        
            * {{ dt-type-repl }} — позволяет получать изменения данных от источника и применять их к приемнику (без создания полной копии данных источника). В блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeIncrement.increment_settings.title }}** укажите количество процессов репликации. Настройка доступна для источников {{ KF }} и {{ DS }}. Если запущено несколько процессов репликации, они поделят между собой партиции реплицируемого топика. 
            * {{ dt-type-copy-repl }} — создает полную копию данных источника и поддерживает ее в актуальном состоянии. В блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshotAndIncrement.snapshot_settings.title }}** укажите количество процессов и потоков для организации параллельного копирования и репликации. В блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshotAndIncrement.increment_settings.title }}** укажите количество процессов репликации. Настройка доступна для источников {{ KF }} и {{ DS }}. Если запущено несколько процессов репликации, они поделят между собой партиции реплицируемого топика. 
            
       * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** — укажите полный путь до каждого объекта для переноса. Будут передаваться только объекты из этого списка. Если в настройках эндпоинта-источника указан список включенных таблиц или коллекций, передаваться будут только те объекты, которые есть в обоих списках. Если указать объекты, которых нет в списке включенных таблиц или коллекций в настройках эндпоинта-источника, активация трансфера завершится с ошибкой `$table not found in source`. Настройка недоступна для источников {{ KF }} и {{ DS }}.

            Укажите полное имя объекта. В зависимости от типа источника используйте соответствующую схему именования:

            * {{ CH }} — `<имя базы>.<путь до таблицы>`;
            * {{ GP }} — `<имя схемы>.<путь до таблицы>`;
            * {{ MG }} — `<имя базы>.<путь до коллекции>`;
            * {{ MY }} — `<имя базы>.<путь до таблицы>`;
            * {{ PG }} — `<имя схемы>.<путь до таблицы>`;
            * Oracle — `<имя схемы>.<путь до таблицы>`;
            * {{ ydb-short-name }} — путь до таблицы.

            Если указанный объект находится в списке исключенных таблиц или коллекций в настройках эндпоинта-источника, или имя объекта введено некорректно, трансфер завершится с ошибкой. Работающий трансфер типа {{ dt-type-repl }} или {{ dt-type-copy-repl }} завершится сразу, незапущенный трансфер — в момент активации.

       * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.transfer_service.transfer_service.CreateTransferRequest.transformation.title }}** — правила преобразований данных. Эта настройка появляется только если источник и приемник имеют разные типы. Выберите **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.rename_tables.title }}** или **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.filter_columns.title }}**. 
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.rename_tables.title }}** — настройки переименования таблиц:
                * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTable.original_name.title }}**:
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name_space.title }}** — схема именования в зависимости от типа источника. Например, схема для {{ PG }} или база данных для {{ MY }}. Если источник не поддерживает абстракции схемы или базы данных, как например в {{ ydb-short-name }}, оставьте поле пустым.
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name.title }}** — имя таблицы в источнике.
                * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTable.new_name.title }}**:
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name_space.title }}** — схема именования в зависимости от типа приемника. Например, схема для {{ PG }} или база данных для {{ MY }}. Если источник не поддерживает абстракции схемы или базы данных, как например в {{ ydb-short-name }}, оставьте поле пустым.
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name.title }}** — новое имя таблицы в приемнике.
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.filter_columns.title }}** — настройки переноса столбцов:
                * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.tables.title }}**:
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.TablesFilter.include_tables.title }}** — имена таблиц, для которых будут действовать настройки переноса столбцов.
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.TablesFilter.exclude_tables.title }}** — имена таблиц, для которых настройки переноса столбцов действовать не будут.
                * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.columns.title }}**:
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ColumnsFilter.include_columns.title }}** — имена столбцов в списке включенных таблиц, которые должны переноситься.
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ColumnsFilter.exclude_columns.title }}** — имена столбцов в списке включенных таблиц, которые переноситься не должны.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- {{ TF }}

    {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

    Чтобы создать трансфер:

    1. В командной строке перейдите в каталог, в котором будут расположены конфигурационные файлы {{ TF }} с планом инфраструктуры. Если такой директории нет — создайте ее.

        1. Если у вас еще нет {{ TF }}, [установите его и создайте конфигурационный файл с настройками провайдера](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. Создайте конфигурационный файл с описанием трансфера.

       Пример структуры конфигурационного файла:

       ```hcl
       resource "yandex_datatransfer_transfer" "<имя трансфера в {{ TF }}>" {
         folder_id   = "<идентификатор каталога>"
         name        = "<имя трансфера>"
         description = "<описание трансфера>"
         source_id   = "<идентификатор эндпоинта-источника>"
         target_id   = "<идентификатор эндпоинта-приемника>"
         type        = "<тип трансфера>"
       }
       ```

       Доступные типы трансферов:

       * `SNAPSHOT_ONLY` — _{{ dt-type-copy }}_;
       * `INCREMENT_ONLY` — _{{ dt-type-repl }}_;
       * `SNAPSHOT_AND_INCREMENT` — _{{ dt-type-copy-repl }}_.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-transfer }}).    

    При создании трансферы типа `INCREMENT_ONLY` и `SNAPSHOT_AND_INCREMENT` активируются и запускаются автоматически.
    Если вы хотите активировать трансфер типа `SNAPSHOT_ONLY` в момент его создания, то добавьте в конфигурационный файл секцию `provisioner "local-exec"` с командой активации трансфера:

    ```hcl
       provisioner "local-exec" {
          command = "yc --profile <профиль> datatransfer transfer activate ${yandex_datatransfer_transfer.<имя Terraform-ресурса трансфера>.id
       }
    ```

    В этом случае копирование выполнится только один раз в момент создания трансфера.

{% endlist %}

## Изменить трансфер {#update}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Выберите трансфер и нажмите кнопку ![pencil](../../_assets/pencil.svg) **{{ ui-key.yacloud.common.edit }}** на панели сверху.
    1. Измените параметры трансфера:
        * **{{ ui-key.yacloud.common.name }}**.
        * (Опционально) **{{ ui-key.yacloud.common.description }}**.
        * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** — укажите полный путь до каждого объекта для переноса. Будут передаваться только объекты из этого списка. Если в настройках эндпоинта-источника указан список включенных таблиц или коллекций, передаваться будут только те объекты, которые есть в обоих списках. Если указать объекты, которых нет в списке включенных таблиц или коллекций в настройках эндпоинта-источника, активация трансфера завершится с ошибкой `$table not found in source`. Настройка недоступна для источников {{ KF }} и {{ DS }}.

            Добавление новых объектов в трансферах типа {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }} приведет к загрузке истории данных по этим объектам (таблицам). Для больших таблиц загрузка истории может занять существенное время. Редактирование списка объектов на трансферах в статусе {{ dt-status-copy }} запрещено.

            Укажите полное имя объекта. В зависимости от типа источника используйте соответствующую схему именования:

            * {{ CH }} — `<имя базы>.<путь до таблицы>`;
            * {{ GP }} — `<имя схемы>.<путь до таблицы>`;
            * {{ MG }} — `<имя базы>.<путь до коллекции>`;
            * {{ MY }} — `<имя базы>.<путь до таблицы>`;
            * {{ PG }} — `<имя схемы>.<путь до таблицы>`;
            * Oracle — `<имя схемы>.<путь до таблицы>`;
            * {{ ydb-short-name }} — путь до таблицы.

            Если указанный объект находится в списке исключенных таблиц или коллекций в настройках эндпоинта-источника, или имя объекта введено некорректно, трансфер завершится с ошибкой. Работающий трансфер типа {{ dt-type-repl }} или {{ dt-type-copy-repl }} завершится сразу, незапущенный трансфер — в момент активации.

        * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.transfer_service.transfer_service.CreateTransferRequest.transformation.title }}** — правила преобразований данных. Эта настройка появляется только если источник и приемник имеют разные типы. Выберите **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.rename_tables.title }}** или **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.filter_columns.title }}**.
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.rename_tables.title }}** — настройки переименования таблиц:
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTable.original_name.title }}**:
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name_space.title }}** — схема именования в зависимости от типа источника. Например, схема для {{ PG }} или база данных для {{ MY }}. Если источник не поддерживает абстракции схемы или базы данных, как например в {{ ydb-short-name }}, оставьте поле пустым.
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name.title }}** — имя таблицы в источнике.
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTable.new_name.title }}**:
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name_space.title }}** — схема именования в зависимости от типа приемника. Например, схема для {{ PG }} или база данных для {{ MY }}. Если источник не поддерживает абстракции схемы или базы данных, как например в {{ ydb-short-name }}, оставьте поле пустым.
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name.title }}** — новое имя таблицы в приемнике.
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.filter_columns.title }}** — настройки переноса столбцов:
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.tables.title }}**:
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.TablesFilter.include_tables.title }}** — имена таблиц, для которых будут действовать настройки переноса столбцов.
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.TablesFilter.exclude_tables.title }}** — имена таблиц, для которых настройки переноса столбцов действовать не будут.
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.columns.title }}**:
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ColumnsFilter.include_columns.title }}** — имена столбцов в списке включенных таблиц, которые должны переноситься.
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ColumnsFilter.exclude_columns.title }}** — имена столбцов в списке включенных таблиц, которые переноситься не должны.    
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием трансфера.

      О том, как создать такой файл, см. в подразделе [Создать трансфер](#create).

  1. Измените значение полей `name` и `description` (имя и описание трансфера).
  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-transfer }}).

{% endlist %}

При изменении трансфера настройки применяются сразу. Изменение настроек трансфера с типом {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }} приведет к перезапуску трансфера.

## Активировать трансфер {#activate}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Нажмите на значок ![ellipsis](../../_assets/horizontal-ellipsis.svg) рядом с именем нужного трансфера и выберите пункт **{{ ui-key.yacloud.data-transfer.label_connector-operation-ACTIVATE }}**.

{% endlist %}

## Перезагрузить трансфер {#reupload}

Если вы предполагаете, что этап репликации трансфера может завершиться ошибкой (например, из-за [изменения схемы переносимых данных](db-actions.md) на источнике), принудительно перезагрузите трансфер.

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Нажмите на значок ![ellipsis](../../_assets/horizontal-ellipsis.svg) рядом с именем нужного трансфера и выберите пункт **{{ ui-key.yacloud.data-transfer.label_connector-operation-REUPLOAD }}**.

{% endlist %}

Подробнее см. в разделе [{#T}](../concepts/transfer-lifecycle.md).

## Деактивировать трансфер {#deactivate}

В процессе деактивации трансфера:

* отключается слот репликации на источнике;
* удаляются временные логи переноса данных;
* приемник приводится в согласованное состояние:
    * переносятся объекты схемы данных источника для финальной стадии;
    * создаются индексы.

{% list tabs %}

- Консоль управления

    1. Переведите источник в режим <q>только чтение</q> (read-only).
    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Нажмите на значок ![ellipsis](../../_assets/horizontal-ellipsis.svg) рядом с именем нужного трансфера и выберите пункт **{{ ui-key.yacloud.data-transfer.label_connector-operation-DEACTIVATE }}**.
    1. Дождитесь перехода трансфера в статус {{ dt-status-stopped }}.

{% endlist %}

{% note warning %}

Не прерывайте деактивацию трансфера! Если процесс завершится некорректно, работоспособность источника и приемника не гарантируется.

{% endnote %}

Подробнее см. в разделе [{#T}](../concepts/transfer-lifecycle.md).

## Удалить трансфер {#delete}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Если нужный трансфер находится в активном состоянии, [деактивируйте его](#deactivate).
    1. Нажмите на значок ![ellipsis](../../_assets/horizontal-ellipsis.svg) рядом с именем нужного трансфера и выберите пункт **{{ ui-key.yacloud.common.remove }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.remove }}**.

- {{ TF }}

    {% include [terraform-delete](../../_includes/data-transfer/terraform-delete-transfer.md) %}

{% endlist %}
