---
title: "Подключить целевую группу к сетевому балансировщику"
description: "Следуя данной инструкции, вы сможете подключить целевую группу к сетевому балансировщику."
---

# Подключить целевую группу к сетевому балансировщику

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  Чтобы подключить [целевую группу](../concepts/target-resources.md) к сетевому балансировщику:
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется подключить целевую группу к балансировщику.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. В строке балансировщика, к которому требуется подключить целевую группу, нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_attach-tg }}**.
  1. Выберите целевую группу или [создайте новую](target-group-create.md).
  1. Задайте настройки проверки состояния.
  1. Нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_attach-tg }}**
  
- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для подключения целевой группы к сетевому балансировщику:
  
     ```bash
     yc load-balancer network-load-balancer attach-target-group --help
     ```

  1. Узнайте имя или идентификатор балансировщика, получив [список сетевых балансировщиков в каталоге](load-balancer-list.md#list).

  1. Подключите целевую группу к балансировщику, указав ее идентификатор и настройки проверки состояния в соответствующих параметрах команды:
  
     ```bash
     yc load-balancer network-load-balancer attach-target-group <имя_или_идентификатор_балансировщика> \
        --target-group target-group-id=<идентификатор_целевой_группы>,`
                      `healthcheck-name=<имя_проверки_состояния>,`
                      `healthcheck-interval=<интервал_выполнения_проверок>s,`
                      `healthcheck-timeout=<время_ожидания_ответа>s,`
                      `healthcheck-unhealthythreshold=<количество_проваленных_проверок_для_статуса_Unhealthy>,`
                      `healthcheck-healthythreshold=<количество_успешных_проверок_для_статуса_Healthy>,`
                      `healthcheck-tcp-port=<TCP-порт>,`
                      `healthcheck-http-port=<HTTP-порт>,`
                      `healthcheck-http-path=<адрес_URL>
     ```

     Где:

     {% include [target-group-cli-description](../../_includes/network-load-balancer/target-group-cli-description.md) %}

     Подробнее о параметрах проверок читайте в разделе [Проверка состояния ресурсов](../concepts/health-check).

- {{ TF }} {#tf}

  1. Откройте файл конфигурации {{ TF }} и добавьте блок `attached_target_group` в описании сетевого балансировщика:

     ```hcl
     resource "yandex_lb_network_load_balancer" "foo" {
       name = "<имя_балансировщика>"
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

     Где:

     * `name` — имя сетевого балансировщика.
     * `attached_target_group` — описание параметров целевой группы для сетевого балансировщика:
        * `target_group_id` — идентификатор целевой группы.

          {% include [get-target-group-id](../../_includes/network-load-balancer/get-target-group-id.md) %}

        * `healthcheck` — описание параметров проверки состояния. Укажите имя, порт из диапазона от `1` до `32767` и путь, по которому будут выполняться проверки.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/lb_network_load_balancer).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте сетевой балансировщик.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Чтобы подключить целевую группу к сетевому балансировщику, воспользуйтесь методом REST API [attachTargetGroup](../api-ref/NetworkLoadBalancer/attachTargetGroup.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/AttachTargetGroup](../api-ref/grpc/network_load_balancer_service.md#AttachTargetGroup) и передайте в запросе:

  * Идентификатор балансировщика в параметре `networkLoadBalancerId`.
  * Идентификатор целевой группы в параметре `attachedTargetGroup.targetGroupId`.
  * Настройки проверки состояния в параметре `attachedTargetGroup.healthChecks`.

  Идентификатор балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list), идентификатор целевой группы — со [списком целевых групп в каталоге](target-group-list.md#list).

{% endlist %}