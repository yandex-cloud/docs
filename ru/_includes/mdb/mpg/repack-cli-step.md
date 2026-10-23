Выполните команду:

```bash
yc managed-postgresql repack launch \
  --cluster-name <имя_кластера> \
  --database <имя_базы_данных> \
  --type <тип_объектов> \
  --target '<схема_1>.<имя_объекта_1>','<имя_объекта_2>',...,'<имя_объекта_n>' \
  --target '<схема_2>.<имя_объекта_1>','<имя_объекта_2>',...,'<имя_объекта_m>'
```

Где:

* `--cluster-name` — имя кластера {{ mpg-full-name }}.

    Вместо имени кластера вы можете передать его идентификатор в параметре `--cluster-id`.

    Имя и идентификатор кластера вы можете получить со [списком кластеров в каталоге](../../../managed-postgresql/operations/cluster-list.md#list-clusters).
* `--database` — имя базы данных, в которой находятся целевые объекты.
* `--type` — тип объектов, которые вы собираетесь перепаковывать. В одной команде можно передать только объекты одного типа. Возможные значения:

    * `table` — таблица.
    * `index` — индекс.
* `--target` — список объектов в формате `<схема>.<имя_объекта>`. Несколько объектов можно передать через запятую.

    Чтобы передать все объекты в схеме, используйте символ подстановки `*`. Например: `public.*`.

    В одной команде YC CLI вы можете задать одновременно несколько целей.

{% cut "Пример команды" %}

```bash
yc managed-postgresql repack launch \
  --cluster-id c9qbr99vea28******** \
  --database db1 \
  --type table \
  --target 'public.products','customers','employees'
```

Результат:

```text
running:
  cluster_id: c9qbr99vea28********
  start_time: "2026-10-21T19:08:45Z"
  spec:
    type: REPACK_TYPE_TABLE
    dbname: db1
    targets:
      - schema: public
        name: products,customers,employees
  launch_id: 68d917ca-ebc1-4725-84c7-9a29********
```

{% endcut %}