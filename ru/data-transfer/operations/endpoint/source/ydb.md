# Настройка эндпоинта-источника {{ ydb-name }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:
* Настройки подключения к базе данных {{ ydb-full-name }}. Эти параметры обязательные.
* Список путей для переноса (таблицы, директории).

## Настройки {#settings}

{% list tabs %}

- Консоль управления

  * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/database-name.md) %}

   
  
  * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/service-account.md) %}


  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.title }}** — добавьте пути к таблицам или директориям {{ ydb-name }}, которые необходимо перенести.
  
    Добавление новых путей при редактировании эндпоинта, использующегося в трансферах типа {{ dt-type-copy-repl }} в статусе {{ dt-status-repl }}, не приведет к загрузке истории данных таблиц. Чтобы добавить таблицу с ее историческими данными, используйте поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** в [параметрах трансфера](../../transfer.md#update).

    Для трансферов типа {{ dt-type-copy }} можно не указывать пути, в таком случае будут перенесены все таблицы.

    Для трансферов типа {{ dt-type-repl }} или {{ dt-type-copy-repl }} обязательно указывать пути, в том числе и при репликации всех таблиц.

{% endlist %}
