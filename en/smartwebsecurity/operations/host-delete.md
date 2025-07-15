---
title: How to disconnect a security profile in {{ sws-full-name }} from a virtual host, domain, or API gateway
description: Follow this guide to disconnect a security profile in {{ sws-full-name }} from a protected resource.
---

# Disconnecting a security profile from a resource

## Disconnecting from a virtual host {#virtual-host}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [security profile](../concepts/profiles.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Select the security profile to disconnect from the [{{ alb-full-name }}](../../application-load-balancer/) [virtual host](../../application-load-balancer/concepts/http-router.md#virtual-host).
  1. Navigate to the **{{ ui-key.yacloud.smart-web-security.overview.title_connected-to-the-hosts }}** tab.
  1. Next to the host in question, click ![options](../../_assets/console-icons/ellipsis.svg) and select ![disconnect](../../_assets/console-icons/arrow-shape-left-from-line.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_disconnect-host }}**.
  1. Confirm your action.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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
                 backend_group_id: ds7e12p7l6j4********
                 timeout: 60s
                 auto_host_rewrite: false
         route_options:
           security_profile_id: fev3s055oq64********
     created_at: "2024-08-05T08:34:03.973000654Z"
     ```

     Names of virtual hosts are specified in the `virtual_hosts.name` parameter. The example above features only one virtual host: `test-virtual-host`.

  1. To disconnect a security profile from a virtual host, run this command:

     ```bash
     yc application-load-balancer virtual-host update <virtual_host_name> \
        --http-router-name <HTTP_router_name> \
        --security-profile-id ""
     ```

     Where:

     * `<virtual_host_name>`: Virtual host name from the previous step.
     * `--http-router-name`: [HTTP router](../../application-load-balancer/concepts/http-router.md) name. This is a required setting. Instead of the HTTP router name, you can provide its ID in the `http-router-id` parameter.
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
             backend_group_id: ds7e12p7l6j4********
             timeout: 60s
             auto_host_rewrite: false
     route_options: {}
     ```

  For more information about the `yc application-load-balancer virtual-host update` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/update.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  You can disconnect a {{ sws-full-name }} profile from a [{{ alb-full-name }}](../../application-load-balancer/concepts/index.md) in the virtual host settings.

  1. In the {{ TF }} configuration file, for the `yandex_alb_virtual_host` resource, delete `security_profile_id` under `route_options`.

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

  You can check the resource updates using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

  ```bash
  yc alb http-router get <HTTP_router_ID>
  ```

- API {#api}

  {% include [api-host](../../_includes/smartwebsecurity/api-host.md) %}

{% endlist %}

## Disconnecting from a domain {#domain}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the security profile.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Select **Domain protection** → **Domains**.
  1. Select a domain.
  1. In the top-right corner, click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Delete the connected security profile.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Disconnecting from an API gateway {#gateway}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the API gateway is in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Select the API gateway.
  1. In the top-right corner, click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Delete the [x-yc-apigateway:smartWebSecurity](../../api-gateway/concepts/extensions/sws.md) extension from the API gateway specification.

{% endlist %}
