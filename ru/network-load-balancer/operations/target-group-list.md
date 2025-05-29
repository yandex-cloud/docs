# Информация об имеющихся целевых группах

Вы можете запросить детальную информацию о каждой созданной вами целевой группе.

## Получить список целевых групп в каталоге {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. На панели слева выберите ![trgroups.svg](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список целевых групп в каталоге по умолчанию, выполните команду:

    ```bash
    yc load-balancer target-group list
    ```

    Результат:

    ```text
    +----------------------+-------------+---------------------+-------------+--------------+
    |          ID          |    NAME     |       CREATED       |  REGION ID  | TARGET COUNT |
    +----------------------+-------------+---------------------+-------------+--------------+
    | enp1d7t5pdea******** | test-group1 | 2023-02-03 07:17:56 | {{ region-id }} |            1 |
    | ...                  |             |                     |             |              |
    +----------------------+-------------+---------------------+-------------+--------------+
    ```

- API {#api}

    Воспользуйтесь методом API [list](../api-ref/TargetGroup/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

{% endlist %}

## Получить детальную информацию о целевой группе {#get}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [целевая группа](../concepts/target-resources.md).
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. На панели слева выберите ![trgroups.svg](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
    1. Нажмите на имя нужной группы.
    1. На странице **Обзор** отобразится подробная информация о целевой группе.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы узнать имя или уникальный идентификатор [целевой группы](../concepts/target-resources.md), [получите список](#list) целевых групп в каталоге.

    1. Посмотрите описание команды CLI для получения информации о целевой группе:
  
        ```bash
        yc load-balancer target-group --help
        ```

    1. Получите информацию о целевой группе, указав ее имя или идентификатор:

        ```bash
        yc load-balancer target-group get <имя_или_идентификатор_целевой_группы>
        ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [целевой группе](../concepts/target-resources.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_lb_target_group" "my_target_group" {
        target_group_id = "<идентификатор_целевой_группы>"
      }

      output "target_group" {
        value = data.yandex_lb_target_group.my_target_group.created_at
      }
      ```

      Где:

      * `data "yandex_lb_target_group"` — описание целевой группы в качестве источника данных:
         * `target_group_id` — идентификатор целевой группы.
      * `output "target_group"` — выходная переменная, которая содержит информацию дате создания целевой группы:
         * `value` — возвращаемое значение.

      Вместо `created_at` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_lb_target_group` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_lb_target_group).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```bash
      target_group = "2024-03-20T23:43:56Z"
      ```

- API {#api}

    Воспользуйтесь методом API [get](../api-ref/TargetGroup/get.md) и передайте идентификатор целевой группы в параметре `targetGroupId` запроса.

    Идентификатор целевой группы можно получить со [списком целевых групп в каталоге](#list).

{% endlist %}
