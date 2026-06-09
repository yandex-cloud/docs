# Механизм Attachment для интеграции {{ yandex-cloud }} Gwin с существующей инфраструктурой {{ alb-full-name }}

_Attachment_ — это механизм, при котором инфраструктура [{{ alb-name }}](../../concepts/index.md) создается в {{ TF }}, а [Gwin]({{ gwin-tip-local-link }}) связывает ее с ресурсами {{ k8s }} на основе аннотаций. В этом случае Gwin отвечает только за обновление ресурсов балансировщика, а за их создание и удаление — {{ TF }}.

Такой подход позволяет решать следующие задачи:

* Маршрутизация трафика с одного балансировщика:
  
  * в несколько кластеров [{{ managed-k8s-name }}](../../../managed-kubernetes/concepts/index.md);
  * в кластер {{ managed-k8s-name }} и в другие сервисы.

* Интеграция Gwin с существующей инфраструктурой {{ alb-name }}.
* Переход с маршрутизации через {{ alb-name }} в [{{ ig-name }}](../../../compute/concepts/instance-groups/index.md) на сервисы в {{ k8s }} без изменения балансировщика.
* Конфигурация [Gateway API]({{ configuration-gwin-local-link }}/gateway.md) через {{ TF }}, а не через манифесты {{ k8s }}.


## Процесс настройки групп бэкендов и целевых групп {#backend-and-target-groups-setup}

При использовании Attachment настройка групп бэкендов и целевых групп выполняется одинаково. На примере целевой группы настройка выглядит следующим образом:

1. [Создайте целевую группу](../../operations/target-group-create.md#tf_1) с помощью {{ TF }}.
    
    В описании ресурса добавьте блок `lifecycle` с параметром `ignore_changes = all`, чтобы {{ TF }} не перезаписывал изменения, внесенные Gwin.

1. Добавьте в ресурс [Service](../../../managed-kubernetes/concepts/service.md) {{ k8s }} [аннотацию gwin.yandex.cloud/attach.targetGroup.id]({{ configuration-gwin-local-link }}/service.md#attach-configuration) с идентификатором целевой группы в {{ TF }}.
  
При изменении ресурса Service {{ k8s }} контроллер Gwin обновляет ресурсы балансировщика следующим образом:

1. Находит целевую группу по аннотации.
    
    Если целевая группа не найдена, возвращается сообщение об ошибке.

1. Обновляет целевую группу:

    * добавляет метку `gwin-attached: true`;
    * изменяет конфигурацию целевой группы на основе сервиса в {{ k8s }}.

Если при обновлении ресурсов Gwin находит ресурс, у которого есть метка `gwin-attached: true`, но соответствующий сервис в {{ k8s }} не существует, возвращается предупреждение.

{% note warning %}

Если сервис привязан через Attachment, он не может быть указан в качестве бэкенда для других ресурсов (например, Ingress или HTTPRoute).

{% endnote %}


## Примеры использования Attachment {#examples}


### Привязка ресурса HTTPRoute к группе бэкендов {#httproute-backend-group-attachment}

Чтобы привязать ресурс [HTTPRoute]({{ configuration-gwin-local-link }}/httproute.md) к группе бэкендов:

1. В {{ TF }} создайте группу бэкендов и целевую группу:

    {% list tabs group=instructions %}

    - {{ TF }} {#tf}

      ```hcl
      resource "yandex_alb_backend_group" "demo-attach-httproute-bg-bg" {
        name      = "demo-attach-httproute-bg-bg"
        folder_id = <идентификатор_каталога>

        http_backend {
          name             = "placeholder-backend"
          target_group_ids = [yandex_alb_target_group.demo-attach-httproute-bg-placeholder-tg.id]
        }

        lifecycle {
          ignore_changes = all
        }
      }

      resource "yandex_alb_target_group" "demo-attach-httproute-bg-placeholder-tg" {
        name      = "demo-attach-httproute-bg-placeholder-tg"
        folder_id = <идентификатор_каталога>
      }

      ```

    {% endlist %}

1. В ресурс HTTPRoute добавьте [аннотацию gwin.yandex.cloud/rule.demo-rule.attach.backendGroup.id]({{ configuration-gwin-local-link }}/httproute.md#attach-configuration):

    ```yaml
    apiVersion: gateway.networking.k8s.io/v1
    kind: HTTPRoute
    metadata:
      name: demo-http-route
      namespace: demo-ns
      annotations:
        gwin.yandex.cloud/rule.demo-rule.attach.backendGroup.id: ${yandex_alb_backend_group.demo-attach-httproute-bg-bg.id}
      labels:
        app: demo-attachment
    spec:
      parentRefs:
        - group: gwin.yandex.cloud
          kind: Attach
          name: attach
      rules:
        - name: demo-rule
          backendRefs:
            - name: hello-world
              port: 80
              weight: 100
    ```


### Привязка ресурса IngressBackendGroup к группе бэкендов {#ingress-backend-group-attachment}

Чтобы привязать ресурс [IngressBackendGroup]({{ configuration-gwin-local-link }}/ingressbackendgroup.md) к группе бэкендов:

1. В {{ TF }} создайте группу бэкендов и целевую группу:

    {% list tabs group=instructions %}

    - {{ TF }} {#tf}

      ```hcl
      resource "yandex_alb_backend_group" "demo-attach-ingbg-bg-bg" {
        name      = "demo-attach-ingbg-bg-bg"
        folder_id = <идентификатор_каталога>

        http_backend {
          name             = "placeholder-backend"
          target_group_ids = [yandex_alb_target_group.demo-attach-ingbg-bg-placeholder-tg.id]
        }

        lifecycle {
          ignore_changes = all
        }
      }

      resource "yandex_alb_target_group" "demo-attach-ingbg-bg-placeholder-tg" {
        name      = "demo-attach-ingbg-bg-placeholder-tg"
        folder_id = <идентификатор_каталога>
      }
      ```

    {% endlist %}

1. В ресурсе IngressBackendGroup в поле [attach]({{ configuration-gwin-local-link }}/ingressbackendgroup.md#ingressbackendgroupspec) добавьте идентификатор группы бэкендов:

    ```yaml
    apiVersion: gwin.yandex.cloud/v1
    kind: IngressBackendGroup
    metadata:
      name: demo-ingressbackendgroup
      namespace: demo-ns
    spec:
      type: HTTP
      attach:
        backendGroup:
          id: ${yandex_alb_backend_group.demo-attach-ingbg-bg-bg.id}
      backends:
        - name: demo-backend
          weight: 60
          backendRef:
            group: ""
            kind: Service
            name: hello-world
            port: 80
            weight: 100
    ```


### Привязка ресурса Service к целевой группе {#service-target-group-attachment}

Чтобы привязать ресурс [Service]({{ configuration-gwin-local-link }}/service.md) к целевой группе:

1. В {{ TF }} создайте группу бэкендов и целевую группу:

    {% list tabs group=instructions %}

    - {{ TF }} {#tf}

      ```hcl
      resource "yandex_alb_backend_group" "demo-attach-service-tg-bg" {
        name      = "demo-attach-service-tg-bg"
        folder_id = <идентификатор_каталога>

        http_backend {
          name             = "demo-backend"
          port             = 30081
          target_group_ids = [yandex_alb_target_group.demo-attach-service-tg-tg.id]

          healthcheck {
            healthcheck_port    = 30501 // Порт, который использует Gwin для nodecheck
            healthy_threshold   = 3
            unhealthy_threshold = 1
            timeout             = "3s"
            interval            = "3s"
            http_healthcheck {
              path = "/nodecheck?service_namespace=<пространство_имен_ресурса_Service>&service_name=<имя_ресурса_Service>"
            }
          }
        }
      }

      resource "yandex_alb_target_group" "demo-attach-service-tg-tg" {
        name      = "demo-attach-service-tg-tg"
        folder_id = <идентификатор_каталога>
        
        lifecycle {
          ignore_changes = all
        }
      }

    {% endlist %}

1. В ресурс Service добавьте [аннотацию gwin.yandex.cloud/attach.targetGroup.id]({{ configuration-gwin-local-link }}/service.md#attach-configuration):

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: demo-attach-service-tg-service
      namespace: demo-ns
      annotations:
        gwin.yandex.cloud/attach.targetGroup.id: ${yandex_alb_target_group.demo-attach-service-tg-tg.id}
    spec:
      selector:
        app: hello-world
      ports:
        - port: 80
          targetPort: 80
          nodePort: 30081
      type: NodePort
    ```
```