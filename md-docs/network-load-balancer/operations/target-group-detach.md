# Отключить целевую группу от сетевого балансировщика

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы отключить [целевую группу](../concepts/target-resources.md) от сетевого балансировщика:
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется отключить целевую группу от балансировщика.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Выберите балансировщик, от которого требуется отключить целевую группу.
  1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.section_attached-target-groups }}** в строке с нужной целевой группой нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg).
  1. В открывшемся меню нажмите **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_detach-action }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_detach-action }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для отключения целевой группы от сетевого балансировщика:

     ```bash
     yc load-balancer network-load-balancer detach-target-group --help
     ```

  1. Отключите [целевую группу](../concepts/target-resources.md) от сетевого балансировщика:

     ```bash
     yc load-balancer network-load-balancer detach-target-group <имя_или_идентификатор_балансировщика> \
        --target-group-id=<идентификатор_целевой_группы>
     ```

     Идентификатор, имя балансировщика и идентификаторы подключенных целевых групп можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы отключить [целевую группу](../concepts/target-resources.md) от сетевого балансировщика, созданного с помощью {{ TF }}:
  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием целевой группы.

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<имя_сетевого_балансировщика>"
       ...
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
       ...
     }
     ```

  1. Проверьте корректность настроек.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

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

  Чтобы отключить целевую группу от сетевого балансировщика, воспользуйтесь методом REST API [detachTargetGroup](../api-ref/NetworkLoadBalancer/detachTargetGroup.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/DetachTargetGroup](../api-ref/grpc/NetworkLoadBalancer/detachTargetGroup.md) и передайте в запросе:

  * Идентификатор балансировщика в параметре `networkLoadBalancerId`.
  * Идентификатор целевой группы в параметре `targetGroupId`.

  Идентификатор балансировщика и идентификаторы подключенных целевых групп можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

{% endlist %}