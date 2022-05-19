# Удалить HTTP-роутер

Чтобы удалить HTTP-роутер:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан HTTP-роутер.
  1. Выберите сервис **{{ alb-name }}**.
  1. Выберите роутер и нажмите значок ![image](../../_assets/horizontal-ellipsis.svg).
  1. В открывшемся меню выберите пункт **Удалить**.

      Чтобы выполнить это действие с несколькими HTTP-роутерами, выделите нужные в списке и нажмите кнопку **Удалить** в нижней части экрана.

  1. Подтвердите удаление.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления HTTP-роутера:
     ```
     yc alb http-router delete --help
     ```

  1. Выполните команду, указав имя HTTP-роутера:
     ```
     yc alb http-router delete --name <имя HTTP-роутера>
     ```

     Чтобы проверить удаление, получите список HTTP-роутеров, выполнив команду:
     ```
     yc alb http-router list
     ```

- Terraform

  Подробнее о Terraform [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить HTTP-роутер или виртуальный хост, созданные с помощью Terraform:

  1. Откройте файл конфигураций Terraform и удалите фрагмент с описанием HTTP-роутера или виртуального хоста (ресурсы `yandex_alb_http_router` и `yandex_alb_virtual_host` соответственно).
     
     {% cut "Пример описания HTTP-роутера и виртуального хоста в конфигурации Terraform" %}

     ```hcl
     ...
     resource "yandex_alb_http_router" "tf-router" {
       name   = "my-http-router"
       labels = {
         tf-label    = "tf-label-value"
         empty-label = ""
       }
     }
	 
     resource "yandex_alb_virtual_host" "my-virtual-host" {
       name           = "my-virtual-host"
       http_router_id = "${yandex_alb_http_router.tf-router.id}"
       route {
         name = "my-route"
         http_route {
           http_route_action {
             backend_group_id = "${yandex_alb_backend_group.backend-group.id}"
             timeout          = "3s"
           }
         }
       }
     }
     ...
     ```

     {% endcut %}

  1. В командной строке перейдите в папку, где расположен файл конфигурации Terraform.

  1. Проверьте конфигурацию командой:

     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../cli/quickstart.md):

     ```
     yc alb http-router list
     ```

{% endlist %}
