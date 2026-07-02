[Документация Yandex Cloud](../../index.md) > [Yandex Application Load Balancer](../index.md) > [Пошаговые инструкции](index.md) > L7-балансировщики > Получить информацию об L7-балансировщике

# Получить информацию об L7-балансировщике

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится [L7-балансировщик](../concepts/application-load-balancer.md).
  1. Перейдите в сервис **Application Load Balancer**.
  1. Выберите L7-балансировщик.
  1. На странице **Обзор** отобразится подробная информация о балансировщике.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации об [L7-балансировщике](../concepts/application-load-balancer.md):

      ```bash
      yc alb load-balancer get --help
      ```

  1. Получите информацию о балансировщике, указав его имя или идентификатор:

      ```bash
      yc alb load-balancer get <имя_балансировщика>
      ```

      Результат:

      ```text
      id: a5d88ep483cm********
      name: test-balancer2
      folder_id: aoe197919j8e********
      status: ACTIVE
      region_id: ru-central1
      network_id: c64l1c06d151********
      allocation_policy:
        locations:
        - zone_id: ru-central1-a
          subnet_id: buc4gsmpj8hv********
      log_group_id: eolul9ap0bv0********
      created_at: "2021-04-26T12:12:13.624832586Z"
      log_options:
        log_group_id: e23ujjda632o********
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию об [L7-балансировщике](../concepts/application-load-balancer.md) с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_alb_load_balancer" "tf-alb" {
        load_balancer_id = "<идентификатор_балансировщика>"
      }

      output "tf-alb-listener" {
        value = data.yandex_alb_load_balancer.tf-alb.allocation_policy
      }
      ```

      Где:

      * `data "yandex_alb_load_balancer"` — описание L7-балансировщика в качестве источника данных:
         * `load_balancer_id` — идентификатор L7-балансировщика.
      * `output "allocation_policy"` — выходная переменная, которая содержит информацию о политике размещения L7-балансировщика:
         * `value` — возвращаемое значение.

     Вместо `allocation_policy` вы можете выбрать любой другой параметр для получения информации. Подробнее о параметрах источника данных `yandex_alb_load_balancer` в [документации провайдера](../../terraform/data-sources/alb_load_balancer.md).

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

      Terraform создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      tf-alb-listener = tolist([
        {
          "location" = toset([
            {
              "disable_traffic" = false
              "subnet_id" = "buc4gsmpj8hv********"
              "zone_id" = "ru-central1-a"
            },
            ...
      ```

- API {#api}

  Чтобы получить подробную информацию об [L7-балансировщике](../concepts/application-load-balancer.md), воспользуйтесь методом REST API [get](../api-ref/LoadBalancer/get.md) для ресурса [LoadBalancer](../api-ref/LoadBalancer/index.md) или вызовом gRPC API [LoadBalancerService/Get](../api-ref/grpc/LoadBalancer/get.md).

{% endlist %}