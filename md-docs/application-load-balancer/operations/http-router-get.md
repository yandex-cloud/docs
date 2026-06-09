# Получить информацию об HTTP-роутере

Вы можете посмотреть идентификатор роутера, его хосты, а также маршруты в хостах.

Чтобы получить информацию об HTTP-роутере:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится роутер.
  1. Перейдите в сервис **Application Load Balancer**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **HTTP-роутеры**.
  1. Выберите HTTP-роутер.
  1. На странице **Обзор** отобразится подробная информация об  HTTP-роутере.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации об HTTP-роутере:

      ```bash
      yc alb http-router get --help
      ```

  1. Получите информацию об HTTP-роутере, указав его идентификатор или имя:

      ```bash
      yc alb http-router get <имя_HTTP-роутера>
      ```

      Результат:

      ```text
      id: ds7u8nv8gl2s********
      name: alb-router
      folder_id: b1geoelk7fld********
      virtual_hosts:
        - name: alb-host
          authority:
            - www.first-site.ru
            - first-site.ru
          route_options:
            security_profile_id: fevcifh6tr**********
          rate_limit:
            all_requests:
              per_second: "100"
          routes:
            - name: route-1
              http:
                route:
                  backend_group_id: ds7maho6c4or********
      created_at: "2024-12-12T12:20:44.091821711Z"
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию об HTTP-роутере с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_alb_http_router" "tf-router" {
        http_router_id = "<идентификатор_http-роутера>"
      }

      output "tf-router-name" {
        value = data.yandex_alb_http_router.tf-router.name
      }
      ```

      Где:

      * `data "yandex_alb_http_router"` — описание HTTP-роутера в качестве источника данных:
         * `http_router_id` — идентификатор HTTP-роутера.
      * `output "tf-router-name"` — выходная переменная, которая содержит имя HTTP-роутера:
         * `value` — возвращаемое значение.

     Вместо `name` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_alb_http_router` см. в [документации провайдера](../../terraform/data-sources/alb_http_router.md).

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform создаст HTTP-роутер и отобразит значения выходной переменной в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      tf-router-name = "myrouter"
      ```

- API {#api}

  Чтобы получить подробную информацию об HTTP-роутере, воспользуйтесь методом REST API [get](../api-ref/HttpRouter/get.md) для ресурса [HttpRouter](../api-ref/HttpRouter/index.md) или вызовом gRPC API [HttpRouterService/Get](../api-ref/grpc/HttpRouter/get.md).

{% endlist %}