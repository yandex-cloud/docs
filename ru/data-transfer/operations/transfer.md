---
title: "Как управлять трансфером в {{ data-transfer-full-name }}"
description: "Следуя данной инструкции, вы сможете управлять трансфером."
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

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.

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

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
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

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
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
             * {% include [field parallel repl](../../_includes/data-transfer/fields/parallel-repl.md) %}
         * {{ dt-type-copy-repl }} — создает полную копию данных источника и поддерживает ее в актуальном состоянии.
             * {% include [field parallel copy](../../_includes/data-transfer/fields/parallel-copy.md) %}


     * Для пар источник-приемник, которые [тарифицируются](../pricing.md) и находятся на стадии [GA](../../overview/concepts/launch-stages.md), вы можете настроить объем вычислительных ресурсов для виртуальной машины в блоке настроек **Среда выполнения**. Выберите одну из трех предложенных конфигураций. Конфигурация ресурсов виртуальной машины определяет производительность [воркеров](../concepts/index.md#worker), переносящих данные. На каждый воркер выделяется отдельная ВМ. Правила тарификации vCPU и RAM, примеры расчета и рекомендации по оптимизации стоимости см. в разделе [Правила тарификации сервиса](../pricing.md).

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
          command = "yc --profile <профиль> datatransfer transfer activate ${yandex_datatransfer_transfer.<имя_Terraform-ресурса_трансфера>.id
       }
    ```

    В этом случае копирование выполнится только один раз в момент создания трансфера.

- API {#api}

    Воспользуйтесь методом API [create](../api-ref/Transfer/create.md) и передайте в запросе:

    * Идентификатор каталога, в котором должен быть размещен трансфер, в параметре `folderId`.
    * Имя трансфера в параметре `name`.
    * Идентификатор эндпоинта-источника в параметре `sourceId`.
    * Идентификатор эндпоинта-приемника в параметре `targetId`.
    * Тип трансфера в параметре `type`.

{% endlist %}

## Изменить трансфер {#update}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Выберите трансфер и нажмите кнопку ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** на панели сверху.
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


       * Для пар источник-приемник, которые [тарифицируются](../pricing.md) и находятся на стадии [GA](../../overview/concepts/launch-stages.md), вы можете изменить объем вычислительных ресурсов для виртуальной машины в блоке настроек **Среда выполнения**. Выберите одну из трех предложенных конфигураций. Конфигурация ресурсов ВМ определяет производительность [воркеров](../concepts/index.md#worker), переносящих данные. На каждый воркер выделяется отдельная ВМ. Правила тарификации vCPU и RAM, примеры расчета и рекомендации по оптимизации стоимости см. в разделе [Правила тарификации сервиса](../pricing.md).

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
  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-transfer }}).

- API {#api}

    Воспользуйтесь методом API [update](../api-ref/Transfer/update.md) и передайте в запросе:

    * Идентификатор трансфера в параметре `transferId`. Чтобы узнать идентификатор, [получите список трансферов в каталоге](#list).
    * Имя трансфера в параметре `name`.
    * Описание трансфера в параметре `description`.
    * Список изменяемых полей конфигурации трансфера в параметре `updateMask`.

    {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

При изменении трансфера настройки применяются сразу. Изменение настроек трансфера с типом {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }} приведет к перезапуску трансфера.

## Активировать трансфер {#activate}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Нажмите на значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) рядом с именем нужного трансфера и выберите пункт **{{ ui-key.yacloud.data-transfer.label_connector-operation-ACTIVATE }}**.

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
    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
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

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Если нужный трансфер находится в активном состоянии, [деактивируйте его](#deactivate).
    1. Нажмите на значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) рядом с именем нужного трансфера и выберите пункт **{{ ui-key.yacloud.common.remove }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.remove }}**.

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
