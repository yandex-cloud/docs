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

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. Нажмите на имя нужного сетевого балансировщика.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить информацию о сетевом балансировщике, выполните команду:

    ```bash
    yc load-balancer network-load-balancer get <имя_или_идентификатор_балансировщика>
    ```

    Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](#list).

- API {#api}

    Воспользуйтесь методом API [get](../api-ref/NetworkLoadBalancer/get.md) и передайте идентификатор сетевого балансировщика в параметре `networkLoadBalancerId` запроса.

    Идентификатор сетевого балансировщика можно получить со [списком сетевых балансировщиков в каталоге](#list).

{% endlist %}
