# Создать HTTP-роутер для HTTP-трафика

Чтобы создать HTTP-роутер и добавить в него маршрут:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создаваться HTTP-роутер.
  1. В списке сервисов выберите **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/router.svg) **HTTP-роутеры**.
  1. Нажмите кнопку **Создать HTTP-роутер**.
  1. Введите имя роутера: `test-router`.
  1. В блоке **Виртуальные хосты** нажмите кнопку **Добавить виртуальный хост**.
  1. Введите имя хоста: `test-host-1`.
  1. Нажмите кнопку **Добавить маршрут**.
  1. Введите **Имя**: `test-route`.
  1. В поле **Путь** выберите `Совпадает с` и укажите путь `/`. 

      Также чтобы указать путь, вы можете использовать опции:
      * `Начинается с` —  для маршрутизации всех запросов с определенным началом.
      * `Регулярное выражение` — для маршрутизации всех запросов, удовлетворяющих [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax).

  1. В списке **Методы HTTP** выберите `GET`.
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
      name: test-http-router
      folder_id: aoerb349v3h4bupphtaf
      created_at: "2021-02-11T21:04:59.438292069Z"
      ```

  1. Посмотрите описание команды CLI для создания виртуального хоста:
    
      ```bash
      yc alb virtual-host create --help
      ```

  1. Создайте виртуальный хост, указав имя HTTP-роутера и настройки виртуального хоста:
     
      
      ```bash
      yc alb virtual-host create <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера> \
        --authority your-domain.foo.com \
        --modify-request-header name=Accept-Language,append=ru-RU
      ```

 

      Где:

      * `--authority` — домены для заголовков `Host` и `authority`, которые будут связаны с этим виртуальным хостом. Поддерживаются символы подстановки, например `*.foo.com` или `*-bar.foo.com`.
      * `--modify-request-header` — настройки модификации заголовка запроса:
        * `name` — имя модифицируемого заголовка.
        * `append` — строка, которая будет добавлена к значению заголовка.

      Результат:
     
      
      ```text
      name: test-virtual-host
      authority:
      - your-domain.foo.com
      modify_request_headers:
      - name: Accept-Language
        append: ru-RU
      ```
     


  1. Посмотрите описание команды CLI для добавления маршрута:

      ```bash
      yc alb virtual-host append-http-route --help
      ```

  1. Добавьте маршрут, указав идентификатор или имя роутера и параметры маршрутизации:
    
      ```bash
      yc alb virtual-host append-http-route <имя_маршрута> \
        --virtual-host-name <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера> \
        --prefix-path-match / \
        --backend-group-name <имя_группы_бэкендов> \
        --request-timeout <тайм-аут_запроса>s \
        --request-idle-timeout <тайм-аут_ожидания_запроса>s
      ```

      Где:

      * `--virtual-host-name` — имя виртуального хоста.
      * `--http-router-name` — имя HTTP-роутера.
      * `--prefix-path-match` — параметр для маршрутизации всех запросов с определенным началом. После параметра укажите путь `/`.

        Также чтобы задать условие для маршрутизации, вы можете использовать параметры:
        * `--exact-path-match` — для маршрутизации всех запросов, совпадающих с указанным путем. После параметра укажите `/<путь>/`. 
        * `--regex-path-match` — для маршрутизации всех запросов, удовлетворяющих [регулярному выражению](https://ru.wikipedia.org/wiki/Регулярные_выражения) стандарта [RE2](https://github.com/google/re2/wiki/Syntax). После параметра укажите `/<регулярное_выражение>`.
      * `--backend-group-name` — имя группы бэкендов.
      * `--request-timeout` — тайм-аут запроса, в секундах.
      * `--request-max-timeout` — максимальный тайм-аут ожидания запроса, в секундах.

      Результат:

      ```text
      done (1s)
      name: test-virtual-host
      authority:
      - your-domain.foo.com
      routes:
      - name: test-route
        http:
          match:
            path:
              prefix_match: /
          route:
            backend_group_id: a5d4db973944t2fh8gor
            timeout: 2s
            idle_timeout: 3s
      modify_request_headers:
      - name: Accept-Language
        append: ru-RU
      ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры HTTP-роутера и виртуального хоста:

     ```hcl
     resource "yandex_alb_http_router" "tf-router" {
       name   = "<имя_HTTP-роутера>"
       labels = {
         tf-label    = "tf-label-value"
         empty-label = ""
       }
     }
    
     resource "yandex_alb_virtual_host" "my-virtual-host" {
       name           = "<имя_виртуального_хоста>"
       http_router_id = yandex_alb_http_router.tf-router.id
       route {
         name = "<имя_маршрута>"
         http_route {
           http_route_action {
             backend_group_id = "<идентификатор_группы_бэкендов>"
             timeout          = "3s"
           }
         }
       }
     }    
     ```

     Где:

     * `yandex_alb_virtual_host` — описание HTTP-роутера:
       * `name` — имя HTTP-роутера. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

       * `labels` — [метки](../../resource-manager/concepts/labels.md) для HTTP-роутера. Укажите пару ключ-значение.
     * `yandex_alb_virtual_host` — описание виртуального хоста:
       * `name` — имя виртуального хоста. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

       * `http_router_id` — идентификатор HTTP-роутера.
       * `route` — описание маршрута HTTP-роутера. Укажите имя маршрута, идентификатор группы бэкендов и время для обработки запроса (по умолчанию 60 секунд).

     Более подробную информацию о параметрах ресурсов в {{ TF }} см. в документации провайдера ([yandex_alb_http_router](https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs/resources/alb_http_router) и [yandex_alb_virtual_host](https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs/resources/alb_virtual_host)).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../cli/quickstart.md):

        ```bash
        yc alb http-router get <имя_HTTP-роутера>
        ```

- API

  Воспользуйтесь методом REST API [create](../api-ref/HttpRouter/create.md) для ресурса [HttpRouter](../api-ref/HttpRouter/index.md) или вызовом gRPC API [HttpRouterService/Create](../api-ref/grpc/http_router_service.md#Create).

{% endlist %}
