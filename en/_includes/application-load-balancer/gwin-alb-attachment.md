_Attachment_ is a mechanism whereby an [{{ alb-name }}](../../application-load-balancer/concepts/index.md) infrastructure is created in {{ TF }}, while [Gwin]({{ gwin-tip-local-link }}) connects it with {{ k8s }} resources using annotations. In this case, Gwin only arranges updating the load balancer resources, while {{ TF }}, creating and deleting them.

This enables handling the following tasks:

* Routing traffic from a single load balancer:
  
  * To multiple [{{ managed-k8s-name }} clusters](../../managed-kubernetes/concepts/index.md).
  * To a {{ managed-k8s-name }} cluster and other services.

* Integrating Gwin with an existing {{ alb-name }} infrastructure.
* Switching from {{ alb-name }}-based routing in [{{ ig-name }}](../../compute/concepts/instance-groups/index.md) to services in {{ k8s }} while using the same load balancer.
* Configuring [Gateway API]({{ configuration-gwin-local-link }}/gateway.md) using {{ TF }} and not {{ k8s }} manifests.


## Setting up backend groups and target groups {#backend-and-target-groups-setup}

When using attachment, setting up backend groups and target groups is identical. With a target group as an example, the setup looks like this:

1. [Create a target group](../../application-load-balancer/operations/target-group-create.md#tf_1) using {{ TF }}.
    
    In the resource description, add a `lifecycle` section with the `ignore_changes = all` parameter so that {{ TF }} does not overwrite the changes made by Gwin.

1. Add the [gwin.yandex.cloud/attach.targetGroup.id annotation]({{ configuration-gwin-local-link }}/service.md#attach-configuration) to the [Service](../../managed-kubernetes/concepts/service.md) {{ k8s }} resource. The annotation must specify the target group ID in {{ TF }}.
  
When the Service {{ k8s }} resource changes, the Gwin controller updates the load balancer resources as follows:

1. Locates a target group by its annotation.
    
    If no matching target group is found, returns an error message.

1. Updates the target group:

    * Adds the `gwin-attached: true` label.
    * Modifies the target group configuration based on the service in {{ k8s }}.

When updating resources, if Gwin finds a resource that has the `gwin-attached: true` label while there is no corresponding service existing in {{ k8s }}, it returns a warning.

{% note warning %}

If a service is attached (using attachment), you cannot specify it as a backend for other resources (such as Ingress or HTTPRoute ones).

{% endnote %}


## Attachment use cases {#examples}


### Attaching an HTTPRoute resource to a backend group {#httproute-backend-group-attachment}

To attach an [HTTPRoute]({{ configuration-gwin-local-link }}/httproute.md) resource to a backend group:

1. In {{ TF }}, create a backend group and a target group:

    {% list tabs group=instructions %}

    - {{ TF }} {#tf}

      ```hcl
      resource "yandex_alb_backend_group" "demo-attach-httproute-bg-bg" {
        name      = "demo-attach-httproute-bg-bg"
        folder_id = <folder_ID>

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
        folder_id = <folder_ID>
      }

      ```

    {% endlist %}

1. Add the [gwin.yandex.cloud/rule.demo-rule.attach.backendGroup.id annotation]({{ configuration-gwin-local-link }}/httproute.md#attach-configuration) to the HTTPRoute resource:

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


### Attaching an IngressBackendGroup resource to a backend group {#ingress-backend-group-attachment}

To attach an [IngressBackendGroup]({{ configuration-gwin-local-link }}/ingressbackendgroup.md) resource to a backend group:

1. In {{ TF }}, create a backend group and a target group:

    {% list tabs group=instructions %}

    - {{ TF }} {#tf}

      ```hcl
      resource "yandex_alb_backend_group" "demo-attach-ingbg-bg-bg" {
        name      = "demo-attach-ingbg-bg-bg"
        folder_id = <folder_ID>

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
        folder_id = <folder_ID>
      }
      ```

    {% endlist %}

1. In the IngressBackendGroup resource, add the backend group ID to the [attach]({{ configuration-gwin-local-link }}/ingressbackendgroup.md#ingressbackendgroupspec) field:

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


### Attaching a Service resource to a target group {#service-target-group-attachment}

To attach a [Service]({{ configuration-gwin-local-link }}/service.md) resource to a target group:

1. In {{ TF }}, create a backend group and a target group:

    {% list tabs group=instructions %}

    - {{ TF }} {#tf}

      ```hcl
      resource "yandex_alb_backend_group" "demo-attach-service-tg-bg" {
        name      = "demo-attach-service-tg-bg"
        folder_id = <folder_ID>

        http_backend {
          name             = "demo-backend"
          port             = 30081
          target_group_ids = [yandex_alb_target_group.demo-attach-service-tg-tg.id]

          healthcheck {
            healthcheck_port    = 30501 // Port used by Gwin for `nodecheck`
            healthy_threshold   = 3
            unhealthy_threshold = 1
            timeout             = "3s"
            interval            = "3s"
            http_healthcheck {
              path = "/nodecheck?service_namespace=<Service_resource_namespace>&service_name=<Service_resource_name>"
            }
          }
        }
      }

      resource "yandex_alb_target_group" "demo-attach-service-tg-tg" {
        name      = "demo-attach-service-tg-tg"
        folder_id = <folder_ID>
        
        lifecycle {
          ignore_changes = all
        }
      }
      ```
   
   {% endlist %}

1. Add the [gwin.yandex.cloud/attach.targetGroup.id annotation]({{ configuration-gwin-local-link }}/service.md#attach-configuration) to the Service resource:

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