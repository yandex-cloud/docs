---
title: Как подключить профиль безопасности {{ sws-full-name }} к виртуальному хосту, домену или API-шлюзу
description: Следуя данной инструкции, вы сможете подключить профиль безопасности {{ sws-full-name }} к защищаемому ресурсу.
---

# Подключить профиль безопасности к ресурсу

Подключите профиль безопасности к виртуальному хосту, домену или API-шлюзу, чтобы защитить ресурс с помощью {{ sws-name }}.

## Подключить к виртуальному хосту {#host}

Способ подключения зависит от способа управления балансировщиком [{{ alb-full-name }}](../../application-load-balancer/concepts/index.md):

* Если балансировщик управляется вами, используйте интерфейсы {{ yandex-cloud }}.
* Если балансировщик управляется [контроллером](../../application-load-balancer/tools/index.md), используйте аннотацию.

    {% note warning %}

    Для Ingress-контроллера подключайте профиль безопасности только через аннотацию.

    Если подключить профиль через интерфейсы {{ yandex-cloud }}, а затем обновить ресурс Ingress, профиль безопасности отключится из‑за отсутствия аннотации.

    {% endnote %}

{% include [security-profile-sa-roles](../../_includes/smartwebsecurity/security-profile-sa-roles.md) %}

Чтобы подключить профиль безопасности к виртуальному хосту:

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [host-connect](../../_includes/smartwebsecurity/security-profile-host-connect.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Чтобы посмотреть список имеющихся профилей безопасности в каталоге по умолчанию, выполните команду:

     {% include [security-profile-list-command](../../_includes/smartwebsecurity/security-profile-list-command.md) %}

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
                 backend_group_id: ds7a4niks9qv********
                 timeout: 60s
                 auto_host_rewrite: false
         route_options: {}
     created_at: "2024-08-05T08:34:03.973000654Z"
     ```

     Имена виртуальных хостов указаны в параметре `virtual_hosts.name`. В примере выше только один виртуальный хост — `test-virtual-host`.

  1. Чтобы подключить [профиль безопасности](../concepts/profiles.md) к виртуальному хосту, выполните команду:

     ```bash
     yc application-load-balancer virtual-host update <имя_виртуального_хоста> \
        --http-router-name <имя_HTTP-роутера> \
        --security-profile-id <идентификатор_профиля_безопасности>
     ```

     Где:

     * `<имя_виртуального_хоста>` — имя виртуального хоста, полученное на предыдущем шаге.
     * `--http-router-name` — имя HTTP-роутера. Обязательный параметр. Вместо имени HTTP-роутера вы можете передать его идентификатор в параметре `--http-router-id`.
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
             backend_group_id: ds7a4niks9qv********
             timeout: 60s
             auto_host_rewrite: false
     route_options:
       security_profile_id: fev3s055oq64********
      ```

  Подробнее о команде `yc application-load-balancer virtual-host update` читайте в [справочнике CLI](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/update.md).


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Профиль безопасности {{ sws-full-name }} подключается к балансировщику [{{ alb-full-name }}](../../application-load-balancer/concepts/index.md) в настройках виртуального хоста.

  1. В конфигурационном файле {{ TF }} для ресурса `yandex_alb_virtual_host` в блокe `route_options` укажите параметр `security_profile_id` — идентификатор профиля безопасности.

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

- Аннотация {#annotation}

  {% include [Gwin](../../_includes/application-load-balancer/ingress-to-gwin-tip.md) %}

  Используйте аннотации:

  * для [контроллера Gwin](../../application-load-balancer/tools/gwin/index.md) — [HTTPRoute](../../application-load-balancer/gwin-ref/httproute.md#security-configuration) или [RoutePolicy](../../application-load-balancer/gwin-ref/routepolicy.md#cheatsheet);
  * для [Ingress-контроллера](../../application-load-balancer/tools/k8s-ingress-controller/index.md) — [аннотацию ресурса Ingress](../../application-load-balancer/k8s-ref/ingress.md#annot-security-profile-id).

      {% include [sws-editor-role](../../_includes/managed-kubernetes/alb-ref/sws-editor-role.md) %}

{% endlist %}

{% include [auto-scaling-tip](../../_includes/smartwebsecurity/auto-scaling-tip.md) %}

{% include [disable-sp-route](../../_includes/smartwebsecurity/disable-sp-route.md) %}

## Подключить к домену {#domain}

{% list tabs group=instructions %}

- Консоль управления {#console}

   {% include [domain-connect](../../_includes/smartwebsecurity/security-profile-domain-connect.md) %}

{% endlist %}

## Подключить к API-шлюзу {#gateway}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [api-gateway-connect](../../_includes/smartwebsecurity/security-profile-api-gateway-connect.md) %}

{% endlist %}

## См. также {#see-also}

* [{#T}](host-delete.md)
