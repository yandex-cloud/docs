# Подключить целевую группу к сетевому балансировщику

{% list tabs %}

- Консоль управления
  
  Чтобы подключить [целевую группу](../concepts/target-resources.md) к сетевому балансировщику:
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется подключить целевую группу к балансировщику.
  1. В списке сервисов выберите **{{ network-load-balancer-name }}**.
  1. В строке балансировщика, к которому требуется подключить целевую группу, нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Подключить целевую группу**.
  1. Выберите целевую группу или [создайте новую](target-group-create.md).
  1. Задайте настройки проверки состояния.
  1. Нажмите кнопку **Подключить целевую группу**
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для подключения целевой группы к сетевому балансировщику:
  
     ```bash
     yc load-balancer network-load-balancer attach-target-group --help
     ```
  
  1. Подключите целевую группу к балансировщику, указав ее идентификатор и настройки проверки состояния в соответствующих параметрах команды:
  
     ```bash
     yc load-balancer network-load-balancer attach-target-group <идентификатор или имя балансировщика> \
        --target-group target-group-id=<идентификатор целевой группы>,`
                      `healthcheck-name=<имя проверки состояния>,`
                      `healthcheck-interval=<интервал выполнения проверок>s,`
                      `healthcheck-timeout=<время ожидания ответа>s,`
                      `healthcheck-unhealthythreshold=<количество проваленных проверок для статуса Unhealthy>,`
                      `healthcheck-healthythreshold=<количество успешных проверок для статуса Healthy>,`
                      `healthcheck-tcp-port=<TCP-порт>,`
                      `healthcheck-http-port=<HTTP-порт>,`
                      `healthcheck-http-path=<адрес URL, по которому будут выполняться проверки>
     ```

     Где:

     {% include [target-group-cli-description](../../_includes/network-load-balancer/target-group-cli-description.md) %}

     Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list), идентификатор целевой группы — со [списком целевых групп в каталоге](target-group-list.md#list).

     Подробнее о параметрах проверок читайте в разделе [Проверка состояния ресурсов](../concepts/health-check).

- {{ TF }}

  1. Откройте файл конфигурации {{ TF }} и добавьте блок `attached_target_group` в описании сетевого балансировщика:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<имя сетевого балансировщика>"
       ...
       attached_target_group {
         target_group_id = "<идентификатор целевой группы>"
         healthcheck {
           name = "<имя проверки состояния>"
           http_options {
             port = <номер порта>
             path = "<адрес URL, по которому будут выполняться проверки>"
           }
         }
       }
       ...
     }
     ```

     Где:

     * `name` — имя сетевого балансировщика.
     * `attached_target_group` — описание параметров целевой группы для сетевого балансировщика:
        * `target_group_id` — идентификатор целевой группы.
        * `healthcheck` — описание параметров проверки состояния. Укажите имя, порт из диапазона от `1` до `32767` и путь, по которому будут выполняться проверки.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/lb_network_load_balancer).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

  Воспользуйтесь методом API [attachTargetGroup](../api-ref/NetworkLoadBalancer/attachTargetGroup.md) и передайте в запросе:

  * Идентификатор балансировщика в параметре `networkLoadBalancerId`.
  * Идентификатор целевой группы в параметре `attachedTargetGroup.targetGroupId`.
  * Настройки проверки состояния в параметре `attachedTargetGroup.healthChecks`.

  Идентификатор балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list), идентификатор целевой группы — со [списком целевых групп в каталоге](target-group-list.md#list).

{% endlist %}