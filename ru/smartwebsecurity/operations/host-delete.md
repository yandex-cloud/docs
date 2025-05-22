---
title: Как отключить профиль безопасности {{ sws-full-name }} от виртуального хоста, домена, API-шлюза
description: Следуя данной инструкции, вы сможете отключить профиль безопасности {{ sws-full-name }} от защищаемого ресурса.
---

# Отключить профиль безопасности от ресурса

## Отключить от виртуального хоста {#virtual-host}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный [профиль безопасности](../concepts/profiles.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Выберите профиль безопасности, который вы хотите отключить от [виртуального хоста](../../application-load-balancer/concepts/http-router.md#virtual-host) сервиса [{{ alb-full-name }}](../../application-load-balancer/).
  1. Перейдите на вкладку **{{ ui-key.yacloud.smart-web-security.overview.title_connected-to-the-hosts }}**.
  1. В строке с нужным хостом нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите ![disconnect](../../_assets/console-icons/arrow-shape-left-from-line.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_disconnect-host }}**.
  1. Подтвердите отключение.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Чтобы посмотреть список [HTTP-роутеров](../../application-load-balancer/concepts/http-router.md) в каталоге по умолчанию, выполните команду:

     ```bash
     yc application-load-balancer http-router list
     ```

     Результат:

     ```text
     +----------------------+-------------------+-------------+-------------+
     |          ID          |       NAME        | VHOST COUNT | ROUTE COUNT |
     +----------------------+-------------------+-------------+-------------+
     | ds7e9te73uak******** |  my-first-router  |           1 |           1 |
     +----------------------+-------------------+-------------+-------------+
     ```

  1. Чтобы посмотреть список [виртуальных хостов](../../application-load-balancer/concepts/http-router.md#virtual-host) выбранного HHTP-роутера, выполните команду:

     ```bash
     yc application-load-balancer http-router get <имя_или_идентификатор_HTTP-роутера>
     ```

     Результат:

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

     Имена виртуальных хостов указаны в параметре `virtual_hosts.name`. В примере выше только один виртуальный хост — `test-virtual-host`.

  1. Чтобы отключить профиль безопасности от виртуального хоста, выполните команду:

     ```bash
     yc application-load-balancer virtual-host update <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера> \
        --security-profile-id ""
     ```

     Где:

     * `<имя_виртуального_хоста>` — имя виртуального хоста, полученное на предыдущем шаге.
     * `--http-router-name` — имя [HTTP-роутера](../../application-load-balancer/concepts/http-router.md). Обязательный параметр. Вместо имени HTTP-роутера вы можете передать его идентификатор в параметре `http-router-id`.
     * `--security-profile-id` — идентификатор профиля безопасности. Обязательный параметр.

     Результат:

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

  Подробнее о команде `yc application-load-balancer virtual-host update` читайте в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/update.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Профиль безопасности {{ sws-full-name }} отключается от балансировщика [{{ alb-full-name }}](../../application-load-balancer/concepts/index.md) в настройках виртуального хоста.

  1. В конфигурационном файле {{ TF }} для ресурса `yandex_alb_virtual_host`  в блокe `route_options` удалите параметр `security_profile_id` — идентификатор профиля безопасности.

      ```hcl
      resource "yandex_alb_virtual_host" "my-virtual-host" {
        name                    = "<имя_виртуального_хоста>"
        ...

        route_options {
          security_profile_id   = "<идентификатор_профиля_безопасности>"
        }
      }
      ```

  1. Примените изменения:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

  ```bash
  yc alb http-router get <идентификатор_HTTP-роутера>
  ```

- API {#api}

  {% include [api-host](../../_includes/smartwebsecurity/api-host.md) %}

{% endlist %}

## Отключить от домена {#domain}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится профиль безопасности.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Выберите раздел **Защита доменов** → **Домены**.
  1. Выберите домен. 
  1. В правом верхнем углу нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Удалите подключенный профиль безопасности.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Отключить от API-шлюза {#gateway}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный API-шлюз.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Выберите API-шлюз.
  1. В правом верхнем углу нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В спецификации API-шлюза удалите расширение [x-yc-apigateway:smartWebSecurity](../../api-gateway/concepts/extensions/sws.md).

{% endlist %}
