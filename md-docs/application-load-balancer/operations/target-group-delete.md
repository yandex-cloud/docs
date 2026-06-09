# Удалить целевую группу {{ alb-name }}

{% note warning %}

Если целевая группа используется хотя бы в одной группе бэкендов, удалить ее нельзя. Сначала [удалите](backend-group-update.md#update-group) ее из всех групп бэкендов.

{% endnote %}

Чтобы удалить [целевую группу](../concepts/target-group.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создана целевая группа.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.alb.label_target-groups }}**.
  1. Выберите целевую группу и нажмите значок ![image](../../_assets/console-icons/ellipsis.svg).
  1. В открывшемся меню выберите пункт **{{ ui-key.yacloud.common.delete }}**.

     Чтобы выполнить это действие с несколькими целевыми группами, выделите нужные в списке и нажмите кнопку **{{ ui-key.yacloud.common.delete }}** в нижней части экрана.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../cli/index.md) для удаления целевой группы:

     ```bash
     yc alb target-group delete --help
     ```

  1. Выполните команду:

     ```bash
     yc alb target-group delete <имя_или_идентификатор_целевой_группы>
     ```

     Чтобы проверить удаление, получите список целевых групп, выполнив команду:

     ```bash
     yc alb target-group list
     ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте конфигурационный файл {{ TF }} и удалите фрагмент с описанием целевой группы.

     Пример описания целевой группы в конфигурации {{ TF }}:

     ```hcl
     resource "yandex_alb_target_group" "foo" {
       name           = "<имя_целевой_группы>"

       target {
         subnet_id    = "<идентификатор_подсети>"
         ip_address   = "<внутренний_IP-адрес_ВМ_1>"
       }

       target {
         subnet_id    = "<идентификатор_подсети>"
         ip_address   = "<внутренний_IP-адрес_ВМ_2>"
       }

       target {
         subnet_id    = "<идентификатор_подсети>"
         ip_address   = "<внутренний_IP-адрес_ВМ_3>"
       }
     }
     ```

     Подробную информацию о параметрах ресурса `yandex_alb_target_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-targetgroup }}).
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

     Проверить изменения целевой группы можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/index.md):

     ```bash
     yc alb target-group list
     ```

     {% note warning "Ограничения по времени" %}
     
     Провайдер {{ TF }} ограничивает время на выполнение операций с целевыми группами {{ alb-name }} 10 минутами.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию целевой группы блок `timeouts`, например:
     
     ```hcl
     resource "yandex_alb_target_group" "<имя_целевой_группы>" {
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

  Воспользуйтесь методом REST API [delete](../api-ref/TargetGroup/delete.md) для ресурса [TargetGroup](../api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/Delete](../api-ref/grpc/TargetGroup/delete.md).

{% endlist %}