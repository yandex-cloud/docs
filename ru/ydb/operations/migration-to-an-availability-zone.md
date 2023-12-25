# Миграция базы данных {{ ydb-short-name }} в другую зону доступности

Имеет смысл выполнять миграцию в другую зону доступности только для [Dedicated базы данных](../concepts/serverless-and-dedicated.md) {{ ydb-short-name }}. К Serverless БД миграция не применяется.

Dedicated БД располагается в нескольких [зонах доступности](../../overview/concepts/geo-scope.md) региона центральной России `{{ region-id }}`. Вы можете заменить одну зону на другую. Для этого:

1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в зоне доступности, в которую вы переносите БД.
1. Переместите базу данных {{ ydb-short-name }} в новый набор подсетей:

   {% list tabs %}

   - {{ yandex-cloud }} CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Выполните команду:

      ```bash
      {{ yc-ydb }} database update <имя_БД> \
         --subnet-id <идентификатор_подсети_в_зоне_{{ region-id }}-a> \
         --subnet-id <идентификатор_подсети_в_зоне_{{ region-id }}-b> \
         --subnet-id <идентификатор_подсети_в_зоне_{{ region-id }}-d>
      ```

   - {{ TF }}

      {% include [terraform-install](../../_includes/terraform-install.md) %}

      1. Откройте конфигурационный файл {{ TF }} с планом инфраструктуры и измените фрагмент с описанием БД:

         ```hcl
         resource "yandex_ydb_database_dedicated" "<название_БД>" {
            ...
            subnet_ids = [<идентификаторы_подсетей>]
            ...
         }
         ```

         В параметре `subnet_ids` перечислите через запятую идентификаторы подсетей в зонах доступности `{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-d`.

      1. Примените изменения:

         {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   {% endlist %}

## Миграция в {{ data-transfer-full-name }} {#data-transfer}

Если вы используете [трансфер типа](../../data-transfer/concepts/transfer-lifecycle.md#transfer-types) {{ dt-type-repl }} или {{ dt-type-copy-repl }} и ваша БД выступает в роли [эндпоинта](../../data-transfer/concepts/index.md#endpoint), после смены подсетей в БД перезапустите трансфер одним из двух способов:

{% include [reactivate-a-transfer](../../_includes/data-transfer/reactivate-a-transfer.md) %}

Подробнее см. в разделе [{#T}](../../data-transfer/operations/endpoint/migration-to-an-availability-zone.md).
