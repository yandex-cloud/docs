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
  1. В списке **Методы HTTP** выберите `GET`.
  1. В поле **Действие** оставьте `Маршрутизация`.
  1. В списке **Группа бэкендов** выберите имя группы бэкендов из того же каталога, в котором создаете роутер.
  1. Остальные настройки оставьте без изменений и нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания HTTP-роутера:
     ```
     yc alb http-router create --help
     ```

  1. Выполните команду:
     ```
     yc alb http-router create <имя HTTP-роутера>
     ```

     Результат:
     ```
     id: a5dcsselagj4o2v4a6e7
     name: test-http-router
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2021-02-11T21:04:59.438292069Z"
     ```

  1. Посмотрите описание команды CLI для создания виртуального хоста:
     ```
     yc alb virtual-host create --help
     ```

  1. Создайте виртуальный хост, указав имя HTTP-роутера и настройки виртуального хоста:
     
     {% if product == "yandex-cloud" %}

     ```
     yc alb virtual-host create <имя виртуального хоста> \
       --http-router-name <имя HTTP-роутера> \
       --authority your-domain.foo.com \
       --modify-request-header name=Accept-Language,append=ru-RU
     ```
     {% endif %}
 
     {% if product == "cloud-il" %}

     ```
     yc alb virtual-host create <имя виртуального хоста> \
       --http-router-name <имя HTTP-роутера> \
       --authority your-domain.foo.com \
       --modify-request-header name=Accept-Language,append=he-IL
     ```

     {% endif %}

     Где:

     * `--authority` — домены для заголовков `Host` и `authority`, которые будут связаны с этим виртуальным хостом. Поддерживаются символы подстановки, например `*.foo.com` или `*-bar.foo.com`.
     * `--modify-request-header` — настройки модификации заголовка запроса:
       * `name` — имя модифицируемого заголовка.
       * `append` — строка, которая будет добавлена к значению заголовка.

     Результат:
     
     {% if product == "yandex-cloud" %}

     ```
     name: test-virtual-host
     authority:
     - your-domain.foo.com
     modify_request_headers:
     - name: Accept-Language
       append: ru-RU
     ```
     
     {% endif %}

     {% if product == "cloud-il" %}

     ```
     name: test-virtual-host
     authority:
     - your-domain.foo.com
     modify_request_headers:
     - name: Accept-Language
       append: he-IL
     ```

     {% endif %}

  1. Посмотрите описание команды CLI для добавления маршрута:
     ```
     yc alb virtual-host append-http-route --help
     ```

  1. Добавьте маршрут, указав идентификатор или имя роутера и параметры маршрутизации:
     ```
     yc alb virtual-host append-http-route <имя маршрута> \
       --virtual-host-name <имя виртуального хоста> \
       --http-router-name <имя HTTP-роутера> \
       --prefix-path-match / \
       --backend-group-name <имя группы бэкендов> \
       --request-timeout <тайм-аут запроса>s \
       --request-idle-timeout <тайм-аут ожидания запроса>s
     ```

     Результат:
     ```
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
       name   = "<имя HTTP-роутера>"
       labels = {
         tf-label    = "tf-label-value"
         empty-label = ""
       }
     }
    
     resource "yandex_alb_virtual_host" "my-virtual-host" {
       name           = "<имя виртуального хоста>"
       http_router_id = yandex_alb_http_router.tf-router.id
       route {
         name = "<имя маршрута>"
         http_route {
           http_route_action {
             backend_group_id = "<идентификатор группы бэкендов>"
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

       * `labels` — [метки](../../overview/concepts/services.md#labels) для HTTP-роутера. Укажите пару ключ-значение.
     * `yandex_alb_virtual_host` — описание виртуального хоста:
       * `name` — имя виртуального хоста. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

       * `http_router_id` — идентификатор HTTP-роутера.
       * `route` — описание маршрута HTTP-роутера. Укажите имя маршрута, идентификатор группы бэкендов и время для обработки запроса (по умолчанию 60 секунд).

     Более подробную информацию о параметрах ресурсов в {{ TF }} см. в документации провайдера ([yandex_alb_http_router](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/alb_http_router) и [yandex_alb_virtual_host](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/alb_virtual_host)).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../cli/quickstart.md):

        ```
        yc alb http-router get <идентификатор http-роутера>
        ```

{% endlist %}
