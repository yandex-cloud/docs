Воспользуйтесь методом [ManagedRepack.LaunchRepack](../../../managed-postgresql/api-ref/ManagedRepack/launchRepack.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

```bash
curl \
  --request POST \
  --header "Authorization: Bearer $IAM_TOKEN" \
  --header "Content-Type: application/json" \
  --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>:managedRepack_launch' \
  --data '{
            "spec": {
              "type": "<тип_объектов>",
              "dbname": "<имя_базы_данных>",
              "targets": [
                {
                  "schema": "<схема>",
                  "name": "<имя_объекта_1>"
                },
                {
                  "schema": "<схема>",
                  "name": "<имя_объекта_2>"
                },
                ...
                {
                  "schema": "<схема>",
                  "name": "<имя_объекта_n>"
                }
              ]
            }
          }'
```

Где:

* `<идентификатор_кластера>` — идентификатор кластера {{ mpg-full-name }}.

    Идентификатор кластера вы можете получить со [списком кластеров в каталоге](../../../managed-postgresql/operations/cluster-list.md#list-clusters).
* `type` — тип объектов, которые вы собираетесь перепаковывать. В одном запросе можно передать только объекты одного типа. Возможные значения:

    * `REPACK_TYPE_TABLE` — таблица.
    * `REPACK_TYPE_INDEX` — индекс.
* `dbname` — имя базы данных, в которой находятся целевые объекты.
* `targets` — список целевых объектов:
    * `schema` — схема, к которой относится целевой объект.
    * `name` — имя объекта.

        Чтобы указать все объекты в схеме, вместо имени передайте в запросе строку `"allInSchema": true`.

{% cut "Пример запроса" %}

```bash
curl \
  --request POST \
  --header "Authorization: Bearer $IAM_TOKEN" \
  --header "Content-Type: application/json" \
  --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/c9qbr99vea28********:managedRepack_launch' \
  --data '{
            "spec": {
              "type": "REPACK_TYPE_TABLE",
              "dbname": "db1",
              "targets": [
                {
                  "schema": "public",
                  "allInSchema": true
                }
              ]
            }
          }' \
  | jq
```

Результат:

```json
{
  "running": {
    "clusterId": "c9qbr99vea28********",
    "startTime": "2026-10-21T19:30:33Z",
    "spec": {
      "type": "REPACK_TYPE_TABLE",
      "dbname": "db1",
      "targets": [
        {
          "schema": "public",
          "allInSchema": true
        }
      ]
    },
    "launchId": "14f218d0-63e6-4eb8-9fbc-1fdd********"
  }
}
```

{% endcut %}