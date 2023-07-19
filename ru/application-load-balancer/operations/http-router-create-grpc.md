# Создать HTTP-роутер для gRPC-трафика

Чтобы создать HTTP-роутер и добавить в него маршрут:

{% list tabs %}

- Консоль управления

  1. В меню слева выберите **HTTP-роутеры**.
  1. Нажмите кнопку **Создать HTTP-роутер**.
  1. Введите имя роутера: `test-grpc-router`.
  1. В блоке **Виртуальные хосты** нажмите кнопку **Добавить виртуальный хост**.
  1. Введите **Имя**: `test-virtual-host`.
  1. В поле **Authority** введите: `*` или IP-адрес балансировщика.
  1. Нажмите кнопку **Добавить маршрут** и выберите **Тип**: `gRPC`.
     1. Введите **Имя**: `grpc-route`.
     1. В блоке **FQMN** выберите `Начинается с` и в поле ввода укажите `/<первое_слово_названия_сервиса>`, например: `/helloworld`.

         Также чтобы указать FQMN, вы можете использовать опции:
         * `Совпадает с` — для маршрутизации всех запросов, совпадающих с указанным FQMN.
         * `Регулярное выражение` — для маршрутизации всех запросов, удовлетворяющих [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax).
     {% note warning %}

     FQMN должно начинаться с косой черты `/` и содержать часть полного названия сервиса, на который перенаправляется вызов процедуры.

     {% endnote %}

     1. В поле **Действие** оставьте `Маршрутизация`.
     1. В списке **Группа бэкендов** выберите имя группы бэкендов из того же каталога, в котором создаете роутер. 
     1. Остальные настройки оставьте без изменений и нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания HTTP-роутера:

     ```bash
     yc alb http-router create --help
     ```

  1. Выполните команду:

     ```bash
     yc alb http-router create <имя_HTTP-роутера>
     ```

     Результат:

     ```text
     id: a5dcsselagj4o2v4a6e7
     name: <имя_HTTP-роутера>
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2022-06-16T21:04:59.438292069Z"
     ```

  1. Посмотрите описание команды CLI для создания виртуального хоста:

     ```bash
     yc alb virtual-host create --help
     ```

  1. Создайте виртуальный хост, указав имя HTTP-роутера и настройки виртуального хоста:

     ```bash
     yc alb virtual-host create <имя_виртуального_хоста> \
       --http-router-name <имя_HTTP-роутера> \
       --authority *
     ```

     Где `--authority` — домены для заголовков `:authority`, которые будут связаны с этим виртуальным хостом. Поддерживаются символы подстановки, например `*.foo.com` или `*-bar.foo.com`.

     Результат:

     ```text
     done (1s)
     name: <имя_виртуального_хоста>
     authority:
     - *
     ```

  1. Посмотрите описание команды CLI для добавления маршрута:

     ```bash
     yc alb virtual-host append-grpc-route --help
     ```

  1. Добавьте маршрут, указав идентификатор или имя роутера и параметры маршрутизации:

     ```bash
     yc alb virtual-host append-grpc-route <имя_маршрута> \
       --virtual-host-name <имя_виртуального_хоста> \
       --http-router-name <имя_HTTP-роутера> \
       --prefix-fqmn-match / \
       --backend-group-name <имя_группы_бэкендов> \
       --request-max-timeout 60s
     ```

     Где:

     * `--virtual-host-name` — имя виртуального хоста.
     * `--http-router-name` — имя HTTP-роутера.
     * `--prefix-fqmn-match` — параметр для маршрутизации всех запросов с определенным началом. После параметра укажите FQMN `/`.

       Также чтобы задать условие для маршрутизации, вы можете использовать опции:
       * `--exact-fqmn-match` — для маршрутизации всех запросов, совпадающих с указанным FQMN. После параметра укажите `/<FQMN>/`.
       * `--regex-fqmn-match` — для маршрутизации всех запросов, удовлетворяющих [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). После параметра укажите `/<регулярное_выражение>`.
     * `--backend-group-name` — имя группы бэкендов.
     * `--request-max-timeout` — максимальный тайм-аут ожидания запроса, в секундах.

     Результат:

     ```text
     done (1s)
     name: <имя_виртуального_хоста>
     authority:
     - *
     routes:
     - name: <имя_маршрута>
       grpc:
        match:
          fqmn:
           prefix_match: /helloworld
        route:
          backend_group_id: ds7snban2dvnedokp6kc
          max_timeout: 60s
     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры HTTP-роутера и виртуального хоста:

      ```hcl
      resource "yandex_alb_http_router" "tf-router" {
        name          = "<имя_HTTP-роутера>"
        labels        = {
          tf-label    = "tf-label-value"
          empty-label = ""
        }
      }

      resource "yandex_alb_virtual_host" "my-virtual-host" {
        name                    = "<имя_виртуального_хоста>"
        http_router_id          = yandex_alb_http_router.tf-router.id
        route {
          name                  = "<имя_маршрута>"
          grpc_route {
            grpc_route_action {
              backend_group_id  = "<идентификатор_группы_бэкендов>"
              max_timeout       = "60s"
            }
          }
        }
      }
      ```

      Где:

      * `yandex_alb_http_router` — описание HTTP-роутера:
        * `name` — имя HTTP-роутера. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

        * `labels` — [метки](../../resource-manager/concepts/labels.md) для HTTP-роутера. Укажите пару ключ-значение.
      * `yandex_alb_virtual_host` — описание виртуального хоста:
        * `name` — имя виртуального хоста. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

        * `http_router_id` — идентификатор HTTP-роутера.
        * `grpc_route` — описание маршрута для gRPC-трафика:
          * `name` — имя маршрута.
          * `grpc_route_action` — параметр для указания действия c gRPC-трафиком.
             * `backend_group_id` — идентификатор группы бэкэндов.
             * `max_timeout` — максимальный тайм-аут ожидания запроса, в секундах.

      Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

      * Ресурс [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router).
      * Ресурс [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).

  1. Создайте ресурсы

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc alb http-router get <имя_HTTP-роутера>
      ```

- API

  Воспользуйтесь методом REST API [create](../api-ref/HttpRouter/create.md) для ресурса [HttpRouter](../api-ref/HttpRouter/index.md) или вызовом gRPC API [HttpRouterService/Create](../api-ref/grpc/http_router_service.md#Create).

{% endlist %}
