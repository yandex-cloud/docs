# Информация об имеющихся сетевых балансировщиках

Вы можете запросить детальную информацию о каждом созданном вами сетевом балансировщике.

## Получить список сетевых балансировщиков в каталоге {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список сетевых балансировщиков в каталоге по умолчанию, выполните команду:

    ```bash
    yc load-balancer network-load-balancer list
    ```

    Результат:

    ```text
    +----------------------+-----------------------+-------------+----------+----------------+------------------------+--------+
    |          ID          |         NAME          |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
    +----------------------+-----------------------+-------------+----------+----------------+------------------------+--------+
    | enp9svq2ajbs******** | network-load-balancer | {{ region-id }} | EXTERNAL |              1 | enp1d7t5pdea********   | ACTIVE |
    | ...                  |                       |             |          |                |                        |        |
    +----------------------+-----------------------+-------------+----------+----------------+------------------------+--------+
    ```

- API {#api}

    Воспользуйтесь методом API [list](../api-ref/NetworkLoadBalancer/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

{% endlist %}

## Получить детальную информацию о сетевом балансировщике {#get}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [сетевой балансировщик](../concepts/index.md).
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. Нажмите на имя нужного сетевого балансировщика.
    1. На странице **Обзор** отобразится подробная информация о балансировщике.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы узнать имя или уникальный идентификатор [сетевого балансировщика](../concepts/index.md), [получите список](#list) балансировщиков в каталоге.

    1. Посмотрите описание команды CLI для получения информации о сетевом балансировщике:
  
        ```bash
        yc load-balancer network-load-balancer --help
        ```

    1. Получите информацию о балансировщике, указав его имя или идентификатор:

        ```bash
        yc load-balancer network-load-balancer get <имя_или_идентификатор_балансировщика>
        ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [сетевом балансировщике](../concepts/index.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_lb_network_load_balancer" "my_balancer" {
        network_load_balancer_id = "<идентификатор_балансировщика>"
      }

      output "network_load_balancer" {
        value = data.yandex_lb_network_load_balancer.my_balancer.created_at
      }
      ```

      Где:

      * `data "yandex_lb_network_load_balancer"` — описание балансировщика в качестве источника данных:
         * `network_load_balancer_id` — идентификатор балансировщика.
      * `output "network_load_balancer"` — выходная переменная, которая содержит информацию о дате создания балансировщика:
         * `value` — возвращаемое значение.

      Вместо `created_at` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_lb_network_load_balancer` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_lb_network_load_balancer).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```bash
      network_load_balancer = "2024-03-20T23:43:56Z"
      ```

- API {#api}

    Воспользуйтесь методом API [get](../api-ref/NetworkLoadBalancer/get.md) и передайте идентификатор сетевого балансировщика в параметре `networkLoadBalancerId` запроса.

    Идентификатор сетевого балансировщика можно получить со [списком сетевых балансировщиков в каталоге](#list).

{% endlist %}
