---
title: How to connect a {{ sws-full-name }} profile to a virtual host, domain, or API gateway
description: Follow this guide to connect a {{ sws-full-name }} profile to the protected resource.
---

# Connecting a security profile to a resource

To protect your resource using {{ sws-name }}, connect a {{ sws-full-name }} profile to a virtual host, domain, or API gateway.

## Connecting to a virtual host {#host}

The connection method depends on the [{{ alb-full-name }} management method](../../application-load-balancer/concepts/index.md).

* If the load balancer is managed by you, use the {{ yandex-cloud }} interfaces.
* If the load balancer is managed by a [controller](../../application-load-balancer/tools/index.md), use an annotation.

    {% note warning %}

    For an ingress controller, connect the security profile only via an annotation.

    If you connect the profile via the {{ yandex-cloud }} interfaces and then update the Ingress resource, the security profile will be disabled due to the lack of annotation.

    {% endnote %}

{% include [security-profile-sa-roles](../../_includes/smartwebsecurity/security-profile-sa-roles.md) %}

To connect a security profile to a virtual host:

{% list tabs group=instructions %}

- Management console {#console}

  {% include [host-connect](../../_includes/smartwebsecurity/security-profile-host-connect.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. To view a list of current security profiles in the default folder, run this command:

     {% include [security-profile-list-command](../../_includes/smartwebsecurity/security-profile-list-command.md) %}

  1. To view a list of [HTTP routers](../../application-load-balancer/concepts/http-router.md) in the default folder, run this command:

     ```bash
     yc application-load-balancer http-router list
     ```

     Result:

     ```text
     +----------------------+-------------------+-------------+-------------+
     |          ID          |       NAME        | VHOST COUNT | ROUTE COUNT |
     +----------------------+-------------------+-------------+-------------+
     | ds7e9te73uak******** |  my-first-router  |           1 |           1 |
     +----------------------+-------------------+-------------+-------------+
     ```

  1. To view a list of [virtual hosts](../../application-load-balancer/concepts/http-router.md#virtual-host) for the selected HTTP router, run this command:

     ```bash
     yc application-load-balancer http-router get <HTTP_router_name_or_ID>
     ```

     Result:

     ```text
     id: ds7e9te73uak********
     name: my-first-router
     folder_id: b1gt6g8ht345********
     virtual_hosts:
       - name: test-virtual-host
         routes:
           - name: test-route
             http:
               match:
                 path:
                   prefix_match: /
               route:
                 backend_group_id: ds7a4niks9qv********
                 timeout: 60s
                 auto_host_rewrite: false
         route_options: {}
     created_at: "2024-08-05T08:34:03.973000654Z"
     ```

     Names of virtual hosts are specified in the `virtual_hosts.name` parameter. The example above features only one virtual host: `test-virtual-host`.

  1. To connect a [security profile](../concepts/profiles.md) to a virtual host, run this command:

     ```bash
     yc application-load-balancer virtual-host update <virtual_host_name> \
        --http-router-name <HTTP_router_name> \
        --security-profile-id <security_profile_ID>
     ```

     Where:

     * `<virtual_host_name>`: Virtual host name from the previous step.
     * `--http-router-name`: HTTP router name. This is a required setting. Instead of the HTTP router name, you can provide its ID in the `--http-router-id` parameter.
     * `--security-profile-id`: Security profile ID. This is a required setting.

     Result:

     ```text
     done (1s)
     name: test-virtual-host
     routes:
       - name: test-route
         http:
           match:
             path:
               prefix_match: /
           route:
             backend_group_id: ds7a4niks9qv********
             timeout: 60s
             auto_host_rewrite: false
     route_options:
       security_profile_id: fev3s055oq64********
      ```

  For more information about the `yc application-load-balancer virtual-host update` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/update.md).


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  You can connect a {{ sws-full-name }} profile to a [{{ alb-full-name }}](../../application-load-balancer/concepts/index.md) in the virtual host settings.

  1. In the {{ TF }} configuration file, for the `yandex_alb_virtual_host` resource, specify `security_profile_id` under `route_options`.

      ```hcl
      resource "yandex_alb_virtual_host" "my-virtual-host" {
        name                    = "<virtual_host_name>"
        ...

        route_options {
          security_profile_id   = "<security_profile_ID>"
        }
      }
      ```

  1. Apply the changes:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

  ```bash
  yc alb http-router get <HTTP_router_ID>
  ```

- API {#api}

  {% include [api-host](../../_includes/smartwebsecurity/api-host.md) %}

- Annotation {#annotation}

  {% include [Gwin](../../_includes/application-load-balancer/ingress-to-gwin-tip.md) %}

  Use the following annotations:

  * For a [Gwin controller](../../application-load-balancer/tools/gwin/index.md): [HTTPRoute](../../application-load-balancer/gwin-ref/httproute.md#security-configuration) or [RoutePolicy](../../application-load-balancer/gwin-ref/routepolicy.md#cheatsheet).
  * For an [Ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md): [Ingress resource annotation](../../application-load-balancer/k8s-ref/ingress.md#annot-security-profile-id).

      {% include [sws-editor-role](../../_includes/managed-kubernetes/alb-ref/sws-editor-role.md) %}

{% endlist %}

{% include [auto-scaling-tip](../../_includes/smartwebsecurity/auto-scaling-tip.md) %}

{% include [disable-sp-route](../../_includes/smartwebsecurity/disable-sp-route.md) %}

## Connecting to a domain {#domain}

{% list tabs group=instructions %}

- Management console {#console}

   {% include [domain-connect](../../_includes/smartwebsecurity/security-profile-domain-connect.md) %}

{% endlist %}

## Connecting to an API gateway {#gateway}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [api-gateway-connect](../../_includes/smartwebsecurity/security-profile-api-gateway-connect.md) %}

{% endlist %}

## See also {#see-also}

* [{#T}](host-delete.md)
