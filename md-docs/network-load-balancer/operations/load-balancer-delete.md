[Документация Yandex Cloud](../../index.md) > [Yandex Network Load Balancer](../index.md) > [Пошаговые инструкции](index.md) > Сетевые балансировщики > Удалить балансировщик

# Удалить сетевой балансировщик

{% note info %}

Если для сетевого балансировщика включена защита от удаления, то перед удалением балансировщика ее необходимо [отключить](deletion-protection.md#disable).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, где требуется удалить балансировщик.
  1. Перейдите в сервис **Network Load Balancer**.
  1. В строке балансировщика, который требуется удалить, нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления сетевого балансировщика:

     ```bash
     yc load-balancer network-load-balancer delete --help
     ```

  1. Удалите балансировщик:

     ```bash
     yc load-balancer network-load-balancer delete <имя_или_идентификатор_балансировщика>
     ```

     Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить сетевой балансировщик, созданный с помощью Terraform:
  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием сетевого балансировщика.

     ```hcl
     ...
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<имя_балансировщика>"
       listener {
         name = "<имя_обработчика>"
         port = <номер_порта>
         external_address_spec {
           ip_version = "<версия_IP-адреса>"
         }
       }
       attached_target_group {
         target_group_id = "<идентификатор_целевой_группы>"
         healthcheck {
           name = "<имя_проверки_состояния>"
             http_options {
               port = <номер_порта>
               path = "<адрес_URL>"
             }
         }
       }
     }
     ...
     ```

  1. Проверьте корректность настроек.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Удалите сетевой балансировщик.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

- API {#api}

  Чтобы удалить сетевой балансировщик, воспользуйтесь методом REST API [delete](../api-ref/NetworkLoadBalancer/delete.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Delete](../api-ref/grpc/NetworkLoadBalancer/delete.md).

{% endlist %}

## Примеры {#examples}

### Удаление сетевого балансировщика из указанного каталога {from-folder}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы удалить сетевой балансировщик из другого каталога, используйте параметры `--folder-id` или `--folder-name`:

  ```bash
  yc load-balancer network-load-balancer delete test-load-balancer \
     --folder-id=b1gnbfd11bq5********
  ```

  ```bash
  yc load-balancer network-load-balancer delete test-load-balancer \
     --folder-name=test-folder
  ```

{% endlist %}