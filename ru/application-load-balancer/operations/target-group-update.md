# Изменить целевую группу

Вы можете добавлять или удалять виртуальные машины из целевой группы.

## Добавить ВМ в целевую группу {#add-targets}

Чтобы добавить ВМ в целевую группу:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создана целевая группа.
  1. Выберите сервис **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/trgroups.svg) **Целевые группы**.
  1. Нажмите на имя нужной группы.
  1. Нажмите **Добавить целевые ресурсы**.
  1. Отметьте нужные ВМ и нажмите кнопку **Добавить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для добавления ресурсов в целевые группы:

     ```bash
     yc alb target-group add-targets --help
     ```

  1. Выполните команду, указав имя целевой группы, имя подсети и внутренний IP-адрес ВМ:

     ```bash
     yc alb target-group --name <имя целевой группы> add-targets \
       --target subnet-name=<имя подсети>,ip-address=<внутренний IP-адрес ВМ>
     ```

     Результат:

     ```text
     done (1s)
     id: a5daisped2unjsnbjhhl
     name: test-tg
     ...
     - ip_address: 10.128.0.32
       subnet_id: blt6pca13je62sqvjq5b
     created_at: "2021-02-11T11:16:27.770674538Z"
     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Откройте конфигурационный файл {{ TF }} и добавьте блок `target` с параметрами целевого ресурса во фрагмент с описанием целевой группы:

     ```hcl
     resource "yandex_alb_target_group" "foo" {
       name           = "<имя целевой группы>"

       target {
         subnet_id    = "<идентификатор подсети>"
         ip_address   = "<внутренний IP-адрес ВМ 1>"
       }

       target {
         subnet_id    = "<идентификатор подсети>"
         ip_address   = "<внутренний IP-адрес ВМ 2>"
       }

       target {
         subnet_id    = "<идентификатор подсети>"
         ip_address   = "<внутренний IP-адрес ВМ 3>"
       }
        
       target {
         subnet_id    = "<идентификатор подсети>"
         ip_address   = "<внутренний IP-адрес ВМ 4>"
       }
     }
     ```

     Где `yandex_alb_target_group` — параметры целевой группы:
     * `name` — имя целевой группы.
     * `target` — параметры целевого ресурса:
       * `subnet_id` — идентификатор подсети, в которой размещена ВМ. Получить список доступных подсетей можно с помощью команды [CLI](../../cli/quickstart.md): `yc vpc subnet list`.
       * `ip_address` — внутренний IP-адрес ВМ. Получить список внутренних IP-адресов можно с помощью команды [CLI](../../cli/quickstart.md): `yc vpc subnet list-used-addresses --id <идентификатор подсети>`.

     Подробную информацию о параметрах ресурса `yandex_alb_target_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-targetgroup }}).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

     Проверить изменения целевой группы можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb target-group get --name <имя целевой группы>
     ```

- API

  Воспользуйтесь методом REST API [addTargets](../api-ref/TargetGroup/addTargets.md) для ресурса [TargetGroup](../api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/AddTargets](../api-ref/grpc/target_group_service.md#AddTargets).

{% endlist %}

## Удалить ВМ из целевой группы {#remove-targets}

Чтобы удалить ВМ из целевой группы:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создана целевая группа.
  1. Выберите сервис **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/trgroups.svg) **Целевые группы**.
  1. Нажмите на имя нужной группы.
  1. Выберите виртуальную машину и в нижней части экрана нажмите кнопку **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления ресурсов из целевой группы:

     ```bash
     yc alb target-group remove-targets --help
     ```

  1. Выполните следующую команду, указав имя целевой группы, имя подсети и внутренний IP-адрес ВМ:

     ```bash
     yc alb target-group --name <имя целевой группы> \
     remove-targets --target subnet-name=<имя подсети>,ip-address=<внутренний IP-адрес ВМ>
     ```

     Результат:

     ```text
     done (1s)
     id: a5daisped2unjsnbjhhl
     name: test-tg
     ...
     - ip_address: 10.129.0.30
       subnet_id: blt6pcatjje62sqvjq5b
     created_at: "2021-02-11T11:16:27.770674538Z"
     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Откройте конфигурационный файл {{ TF }} и удалите блок `target` с IP-адресом ВМ, которую нужно удалить, во фрагменте с описанием целевой группы:

     Пример описания целевой группы в конфигурации {{ TF }}:

     ```hcl
     resource "yandex_alb_target_group" "foo" {
       name           = "<имя целевой группы>"

       target {
         subnet_id    = "<идентификатор подсети>"
         ip_address   = "<внутренний IP-адрес ВМ 1>"
       }

       target {
         subnet_id    = "<идентификатор подсети>"
         ip_address   = "<внутренний IP-адрес ВМ 2>"
       }

       target {
         subnet_id    = "<идентификатор подсети>"
         ip_address   = "<внутренний IP-адрес ВМ 3>"
       }
     }
     ```

     Подробную информацию о параметрах ресурса `yandex_alb_target_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-targetgroup }}).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

     Проверить изменения целевой группы можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb target-group get --name <имя целевой группы>
     ```

- API

  Воспользуйтесь методом REST API [removeTargets](../api-ref/TargetGroup/removeTargets.md) для ресурса [TargetGroup](../api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/RemoveTargets](../api-ref/grpc/target_group_service.md#RemoveTargets).

{% endlist %}