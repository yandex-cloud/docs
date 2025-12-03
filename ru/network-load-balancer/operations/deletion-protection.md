# Настроить защиту от удаления

Чтобы предотвратить случайное удаление сетевого балансировщика, [включите для него защиту от удаления](#enable-deletion-protection).

Если защита вам больше не нужна, вы можете [отключить ее](#disable-deletion-protection).

## Включить защиту от удаления {#enable-deletion-protection}

{% note warning %}

Включенная защита балансировщика от удаления не помешает удалить его обработчики и целевые группы.

{% endnote %}

{% list tabs %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. Справа от имени нужного балансировщика нажмите ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
    1. Включите настройку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_deletion-protection }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [include](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Просмотрите описание команды CLI для изменения атрибутов балансировщика:

        ```bash
        yc load-balancer network-load-balancer update --help
        ```

    1. Включите защиту от удаления:

        ```bash
        yc load-balancer network-load-balancer update <имя_или_идентификатор_балансировщика> \
            --deletion-protection
        ```

        Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Откройте актуальный конфигурационный файл с описанием инфраструктуры.

    1. Добавьте к описанию балансировщика параметр `deletion_protection`:


       ```hcl
       resource "yandex_lb_network_load_balancer" "foo" {
         ...
         deletion_protection = true
         ...
       }
       ```

    1. Проверьте корректность настроек.

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Примените изменения.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

    Чтобы включить защиту от удаления, воспользуйтесь методом REST API [update](../api-ref/NetworkLoadBalancer/update.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Update](../api-ref/grpc/NetworkLoadBalancer/update.md) и передайте в запросе:

    * Имя параметра `deletionProtection` в параметре `updateMask`.
    * Значение `true` в параметре `deletionProtection`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Отключить защиту от удаления {#disable-deletion-protection}

{% list tabs %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. Справа от имени нужного балансировщика нажмите ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
    1. Отключите настройку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_deletion-protection }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [include](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Просмотрите описание команды CLI для изменения атрибутов балансировщика:

        ```bash
        yc load-balancer network-load-balancer update --help
        ```

    1. Отключите защиту от удаления:

        ```bash
        yc load-balancer network-load-balancer update <имя_или_идентификатор_балансировщика> \
            --deletion-protection=false
        ```

        Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Откройте актуальный конфигурационный файл с описанием инфраструктуры.

    1. В описании балансировщика измените значение параметра `deletion_protection` на `false`:


       ```hcl
       resource "yandex_lb_network_load_balancer" "foo" {
         ...
         deletion_protection = false
         ...
       }
       ```

    1. Проверьте корректность настроек.

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Примените изменения.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

    Чтобы включить защиту от удаления, воспользуйтесь методом REST API [update](../api-ref/NetworkLoadBalancer/update.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Update](../api-ref/grpc/NetworkLoadBalancer/update.md) и передайте в запросе:

    * Имя параметра `deletionProtection` в параметре `updateMask`.
    * Значение `false` в параметре `deletionProtection`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
