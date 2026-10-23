Воспользуйтесь вызовом [ManagedRepackService.LaunchRepack](../../../managed-postgresql/api-ref/grpc/ManagedRepack/launchRepack.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

```bash
grpcurl \
  -format json \
  -import-path ~/cloudapi/ \
  -import-path ~/cloudapi/third_party/googleapis/ \
  -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/managed_repack_service.proto \
  -rpc-header "Authorization: Bearer $IAM_TOKEN" \
  -d '{
        "cluster_id": "<идентификатор_кластера>",
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
      }' \
  {{ api-host-mdb }}:{{ port-https }} \
  yandex.cloud.mdb.postgresql.v1.ManagedRepackService.LaunchRepack
```

Где:

* `cluster_id` — идентификатор кластера {{ mpg-full-name }}.

    Идентификатор кластера вы можете получить со [списком кластеров в каталоге](../../../managed-postgresql/operations/cluster-list.md#list-clusters).
* `type` — тип объектов, которые вы собираетесь перепаковывать. В одном запросе можно передать только объекты одного типа. Возможные значения:

    * `REPACK_TYPE_TABLE` — таблица.
    * `REPACK_TYPE_INDEX` — индекс.
* `dbname` — имя базы данных, в которой находятся целевые объекты.
* `targets` — список целевых объектов:
    * `schema` — схема, к которой относится целевой объект.
    * `name` — имя объекта.

        Чтобы указать все объекты в схеме, вместо имени передайте в запросе строку `"all_in_schema": true`.

{% cut "Пример вызова" %}

```bash
grpcurl \
  -format json \
  -import-path ~/cloudapi/ \
  -import-path ~/cloudapi/third_party/googleapis/ \
  -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/managed_repack_service.proto \
  -rpc-header "Authorization: Bearer $IAM_TOKEN" \
  -d '{
        "cluster_id": "c9qbr99vea28********",
        "spec": {
          "type": "REPACK_TYPE_TABLE",
          "dbname": "db1",
          "targets": [
            {
              "schema": "public",
              "name": "customers"
            },
            {
              "schema": "public",
              "name": "employees"
            },
            {
              "schema": "public",
              "name": "products"
            }
          ]
        }
      }' \
  {{ api-host-mdb }}:{{ port-https }} \
  yandex.cloud.mdb.postgresql.v1.ManagedRepackService.LaunchRepack \
  | jq
```

Результат:

```json
{
  "running": {
    "clusterId": "c9qbr99vea28********",
    "startTime": "2026-10-22T05:08:24Z",
    "spec": {
      "type": "REPACK_TYPE_TABLE",
      "dbname": "db1",
      "targets": [
        {
          "schema": "public",
          "name": "customers"
        },
        {
          "schema": "public",
          "name": "employees"
        },
        {
          "schema": "public",
          "name": "products"
        }
      ]
    },
    "launchId": "983d1818-63c5-4313-a427-18cb********"
  }
}
```

{% endcut %}