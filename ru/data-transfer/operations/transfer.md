# Управление трансфером

Вы можете:

* [получить список трансферов](#list);
* [создать трансфер](#create);
* [изменить трансфер](#update);
* [активировать трансфер](#activate);
* [деактивировать трансфер](#deactivate);
* [удалить трансфер](#delete).

Подробнее о состояниях трансфера, возможных действиях с ним и имеющихся ограничениях см. в разделе [{#T}](../concepts/transfer-lifecycle.md).

## Получить список трансферов {#list}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список трансферов в каталоге, выполните команду:

    ```bash
    {{ yc-dt }} transfer list
    ```

- API

    Воспользуйтесь методом API [list](../api-ref/Transfer/list.md).

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

            * {{ dt-type-copy }} — создает полную копию данных без дальнейшего получения обновлений из источника.

                * {% include [field periodic snapshot](../../_includes/data-transfer/fields/periodic-snapshot.md) %}

                * {% include [field incremental tables](../../_includes/data-transfer/fields/incremental-tables.md) %}

                * {% include [field parallel copy](../../_includes/data-transfer/fields/parallel-copy.md) %}

            * {{ dt-type-repl }} — позволяет получать изменения данных от источника и применять их к приемнику (без создания полной копии данных источника).

                * {% include [field parallel repl](../../_includes/data-transfer/fields/parallel-repl.md) %}

            * {{ dt-type-copy-repl }} — создает полную копию данных источника и поддерживает ее в актуальном состоянии.

                * {% include [field parallel copy](../../_includes/data-transfer/fields/parallel-copy.md) %}


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

       * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.transformation.title }}** — правила [преобразований данных](../concepts/data-transformation.md). Эта настройка появляется только если источник и приемник имеют разные типы.
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.rename_tables.title }}** — настройки переименования таблиц:
                * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTable.original_name.title }}**:
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name_space.title }}** — схема именования в зависимости от типа источника. Например, схема для {{ PG }} или база данных для {{ MY }}. Если источник не поддерживает абстракции схемы или базы данных, как например в {{ ydb-short-name }}, оставьте поле пустым.
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name.title }}** — имя таблицы в источнике.
                * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTable.new_name.title }}**:
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name_space.title }}** — схема именования в зависимости от типа приемника. Например, схема для {{ PG }} или база данных для {{ MY }}. Если источник не поддерживает абстракции схемы или базы данных, как например в {{ ydb-short-name }}, оставьте поле пустым.
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name.title }}** — новое имя таблицы в приемнике.
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.filter_columns.title }}** — настройки переноса столбцов. Если для трансфера заданы и переименование таблиц, и фильтр колонок, то в фильтре колонок должны быть указаны исходные имена таблиц в источнике. Имена таблиц и колонок указываются с помощью регулярных выражений. Списки исключенных таблиц и колонок при конфликте с включенными имеют приоритет.
                * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.tables.title }}**:
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.TablesFilter.include_tables.title }}** — имена таблиц, для которых будут действовать настройки переноса столбцов.
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.TablesFilter.exclude_tables.title }}** — имена таблиц, для которых настройки переноса столбцов действовать не будут.
                * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.columns.title }}**:
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ColumnsFilter.include_columns.title }}** — имена столбцов в списке включенных таблиц, которые должны переноситься.
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ColumnsFilter.exclude_columns.title }}** — имена столбцов в списке включенных таблиц, которые переноситься не должны.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать трансфер:

    1. Посмотрите описание команды CLI для создания трансфера:

        ```bash
        {{ yc-dt }} transfer create --help
        ```

    1. Укажите параметры трансфера в команде создания:

        ```bash
        {{ yc-dt }} transfer create <имя трансфера> \
           --source-id=<идентификатор эндпоинта-источника> \
           --target-id=<идентификатор эндпоинта-приемника> \
           --type=<тип трансфера: snapshot-only, increment-only или snapshot-and-increment>
        ```

        {% note info %}

        Имя трансфера должно быть уникальным в каталоге. Оно может содержать латинские буквы, цифры и дефис. Максимальная длина имени 63 символа.

        {% endnote %}

        Где:

        * `--source-id` — идентификатор эндпоинта-источника.
        * `--target-id` — идентификатор эндпоинта-приемника.
        * `--type` — [тип трансфера](../concepts/transfer-lifecycle.md#transfer-types):
            * `snapshot-only` — [копирование](../concepts/transfer-lifecycle.md#copy).
            * `increment-only` — [репликация](../concepts/transfer-lifecycle.md#replication).
            * `snapshot-and-increment` — [копирование и репликация](../concepts/transfer-lifecycle.md#copy-and-replication).

- {{ TF }}

    {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

    
    Если у вас еще нет {{ TF }}, [установите его и настройте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


    Чтобы создать трансфер:

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

- API

    Воспользуйтесь методом API [create](../api-ref/Transfer/create.md) и передайте в запросе:

    * Идентификатор каталога, в котором должен быть размещен трансфер, в параметре `folderId`.
    * Имя трансфера в параметре `name`.
    * Идентификатор эндпоинта-источника в параметре `sourceId`.
    * Идентификатор эндпоинта-приемника в параметре `targetId`.
    * Тип трансфера в параметре `type`.

{% endlist %}

## Изменить трансфер {#update}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Выберите трансфер и нажмите кнопку ![pencil](../../_assets/pencil.svg) **{{ ui-key.yacloud.common.edit }}** на панели сверху.
    1. Измените параметры трансфера:
        * **{{ ui-key.yacloud.common.name }}**.
        * **{{ ui-key.yacloud.common.description }}**.
        * Для трансфера типа {{ dt-type-copy }}:

            * {% include [field periodic snapshot](../../_includes/data-transfer/fields/periodic-snapshot.md) %}

            * {% include [field incremental tables](../../_includes/data-transfer/fields/incremental-tables.md) %}

            * {% include [field parallel copy](../../_includes/data-transfer/fields/parallel-copy.md) %}

        * Для трансфера типа {{ dt-type-repl }}:

            * {% include [field parallel repl](../../_includes/data-transfer/fields/parallel-repl.md) %}

        * Для трансфера типа {{ dt-type-copy-repl }}:

            * {% include [field parallel copy](../../_includes/data-transfer/fields/parallel-copy.md) %}


        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** — укажите полный путь до каждого объекта для переноса. Будут передаваться только объекты из этого списка. Если в настройках эндпоинта-источника указан список включенных таблиц или коллекций, передаваться будут только те объекты, которые есть в обоих списках. Если указать объекты, которых нет в списке включенных таблиц или коллекций в настройках эндпоинта-источника, активация трансфера завершится с ошибкой `$table not found in source`. Настройка недоступна для источников {{ KF }} и {{ DS }}.

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

        * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.transformation.title }}** — правила [преобразований данных](../concepts/data-transformation.md). Эта настройка появляется только если источник и приемник имеют разные типы.
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.rename_tables.title }}** — настройки переименования таблиц:
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTable.original_name.title }}**:
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name_space.title }}** — схема именования в зависимости от типа источника. Например, схема для {{ PG }} или база данных для {{ MY }}. Если источник не поддерживает абстракции схемы или базы данных, как например в {{ ydb-short-name }}, оставьте поле пустым.
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name.title }}** — имя таблицы в источнике.
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTable.new_name.title }}**:
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name_space.title }}** — схема именования в зависимости от типа приемника. Например, схема для {{ PG }} или база данных для {{ MY }}. Если источник не поддерживает абстракции схемы или базы данных, как например в {{ ydb-short-name }}, оставьте поле пустым.
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name.title }}** — новое имя таблицы в приемнике.
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.filter_columns.title }}** — настройки переноса столбцов. Если для трансфера заданы и переименование таблиц, и фильтр колонок, то в фильтре колонок должны быть указаны исходные имена таблиц в источнике. Имена таблиц и колонок указываются с помощью регулярных выражений. Списки исключенных таблиц и колонок при конфликте с включенными имеют приоритет.
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.tables.title }}**:
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.TablesFilter.include_tables.title }}** — имена таблиц, для которых будут действовать настройки переноса столбцов.
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.TablesFilter.exclude_tables.title }}** — имена таблиц, для которых настройки переноса столбцов действовать не будут.
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.columns.title }}**:
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ColumnsFilter.include_columns.title }}** — имена столбцов в списке включенных таблиц, которые должны переноситься.
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ColumnsFilter.exclude_columns.title }}** — имена столбцов в списке включенных таблиц, которые переноситься не должны.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить настройки трансфера:

    1. Посмотрите описание команды CLI для изменения трансфера:

        ```bash
        {{ yc-dt }} transfer update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        {{ yc-dt }} transfer update <идентификатор трансфера> \
           --name=<имя трансфера> \
           --description=<описание трансфера>
        ```

        Идентификатор трансфера можно получить со [списком трансферов в каталоге](#list).

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием трансфера.

      О том, как создать такой файл, см. в подразделе [Создать трансфер](#create).

  1. Измените значение полей `name` и `description` (имя и описание трансфера).
  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-transfer }}).

- API

    Воспользуйтесь методом API [update](../api-ref/Transfer/update.md) и передайте в запросе:

    * Идентификатор трансфера в параметре `transferId`. Чтобы узнать идентификатор, [получите список трансферов в каталоге](#list).
    * Имя трансфера в параметре `name`.
    * Описание трансфера в параметре `description`.
    * Список изменяемых полей конфигурации трансфера в параметре `updateMask`.

    {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

При изменении трансфера настройки применяются сразу. Изменение настроек трансфера с типом {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }} приведет к перезапуску трансфера.

## Активировать трансфер {#activate}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Нажмите на значок ![ellipsis](../../_assets/horizontal-ellipsis.svg) рядом с именем нужного трансфера и выберите пункт **{{ ui-key.yacloud.data-transfer.label_connector-operation-ACTIVATE }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы активировать трансфер, выполните команду:

    ```bash
    {{ yc-dt }} transfer activate <идентификатор трансфера>
    ```

    Идентификатор трансфера можно получить со [списком трансферов в каталоге](#list).

- API

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

{% list tabs %}

- Консоль управления

    1. Переведите источник в режим <q>только чтение</q> (read-only).
    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Нажмите на значок ![ellipsis](../../_assets/horizontal-ellipsis.svg) рядом с именем нужного трансфера и выберите пункт **{{ ui-key.yacloud.data-transfer.label_connector-operation-DEACTIVATE }}**.
    1. Дождитесь перехода трансфера в статус {{ dt-status-stopped }}.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы деактивировать трансфер, выполните команду:

    ```bash
    {{ yc-dt }} transfer deactivate <идентификатор трансфера>
    ```

    Идентификатор трансфера можно получить со [списком трансферов в каталоге](#list).

- API

    Воспользуйтесь методом API [deactivate](../api-ref/Transfer/deactivate.md) и передайте значение идентификатора трансфера в параметре `transferId` запроса.

    Чтобы узнать идентификатор трансфера, [получите список трансферов в каталоге](#list).

{% endlist %}

{% note warning %}

Не прерывайте деактивацию трансфера! Если процесс завершится некорректно, работоспособность источника и приемника не гарантируется.

{% endnote %}

Подробнее см. в разделе [{#T}](../concepts/transfer-lifecycle.md). 


{% include [мобильное приложение](../../_includes/data-transfer/use-mobile-app.md) %}


## Удалить трансфер {#delete}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Если нужный трансфер находится в активном состоянии, [деактивируйте его](#deactivate).
    1. Нажмите на значок ![ellipsis](../../_assets/horizontal-ellipsis.svg) рядом с именем нужного трансфера и выберите пункт **{{ ui-key.yacloud.common.remove }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.remove }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить трансфер, выполните команду:

    ```bash
    {{ yc-dt }} transfer delete <идентификатор трансфера>
    ```

    Идентификатор трансфера можно получить со [списком трансферов в каталоге](#list).

- {{ TF }}

    {% include [terraform-delete](../../_includes/data-transfer/terraform-delete-transfer.md) %}

- API

    Воспользуйтесь методом API [delete](../api-ref/Transfer/delete.md) и передайте значение идентификатора трансфера в параметре `transferId` запроса.

    Чтобы узнать идентификатор трансфера, [получите список трансферов в каталоге](#list).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
