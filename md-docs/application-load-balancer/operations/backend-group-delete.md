# Удалить группу бэкендов

{% note warning %}

Если группа бэкендов используется хотя бы в одном HTTP-роутере или балансировщике, удалить ее нельзя. Сначала удалите ее из всех HTTP-роутеров и балансировщиков.

{% endnote %}

Чтобы удалить [группу бэкендов](../concepts/backend-group.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создана группа бэкендов.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Напротив имени группы бэкендов нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.

     Чтобы выполнить это действие с несколькими группами, выделите нужные в списке и нажмите кнопку **{{ ui-key.yacloud.common.delete }}** в нижней части экрана.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../cli/index.md) для удаления группы бэкендов:

     ```bash
     yc alb backend-group delete --help
     ```

  1. Выполните команду, указав имя удаляемой группы бэкендов:

     ```bash
     yc alb backend-group delete --name <имя_группы_бэкендов>
     ```

     Чтобы проверить удаление, получите список группы бэкендов, выполнив команду:

     ```bash
     yc alb backend-group list
     ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте конфигурационный файл {{ TF }} и удалите фрагмент с описанием группы бэкендов.

     Пример описания группы бэкендов в конфигурации {{ TF }}:

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name                     = "<имя_группы_бэкендов>"

       http_backend {
         name                   = "<имя_бэкенда>"
         weight                 = 1
         port                   = 80
         target_group_ids       = ["<идентификатор_целевой_группы>"]
         load_balancing_config {
           panic_threshold      = 90
         }    
         healthcheck {
           timeout              = "10s"
           interval             = "2s"
           healthy_threshold    = 10
           unhealthy_threshold  = 15 
           http_healthcheck {
             path               = "/"
           }
         }
       }
     }
     ```

     Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/index.md):

     ```bash
     yc alb backend-group list
     ```

     {% note warning "Ограничения по времени" %}
     
     Провайдер {{ TF }} ограничивает время на выполнение операций с группами бэкендов {{ alb-name }} 10 минутами.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию группы бэкендов блок `timeouts`, например:
     
     ```hcl
     resource "yandex_alb_backend_group" "<имя_группы_бэкендов>" {
       ...
       timeouts {
         create = "60m"
         update = "60m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

- API {#api}

  Воспользуйтесь методом REST API [delete](../api-ref/BackendGroup/delete.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/Delete](../api-ref/grpc/BackendGroup/delete.md).

{% endlist %}