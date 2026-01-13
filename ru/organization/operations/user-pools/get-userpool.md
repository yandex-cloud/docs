---
title: Как получить информацию о пуле пользователей в {{ org-full-name }}
description: Следуя данной инструкции, вы получите информацию о пуле пользователей в {{ org-name }}.
---

# Получить информацию о пуле пользователей


{% include [note-preview](../../../_includes/note-preview.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. В списке [пулов пользователей](../../concepts/user-pools.md) выберите нужный пул.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [пуле пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool get --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp userpool get <идентификатор_пула>
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы получить список [доменов](../../concepts/domains.md) в [пуле пользователей](../../concepts/user-pools.md):

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_organizationmanager_idp_userpool" "userpool" {
       userpool_id = "<идентификатор_пула>"
     }
     
     output "my_userpool-domains" {
       value = data.yandex_organizationmanager_idp_userpool.userpool.domains
     }
     ```

     Где:

     * `data "yandex_organizationmanager_idp_userpool"` — описание пула пользователей в качестве источника данных:
       * `userpool_id` — идентификатор пула.
     * `output "image"` — выходная переменная, которая содержит информацию о доменах пула:
       * `value` — возвращаемое значение.

     Вместо `domains` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_organizationmanager_idp_userpool` см. в [документации провайдера]({{ tf-provider-datasources-link }}/organizationmanager_idp_userpool).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      my_userpool-domains = tolist([
        "domain.example1.net",
        "domain-example2.ru"
      ])
      ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.Get](../../idp/api-ref/Userpool/get.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/Get](../../idp/api-ref/grpc/Userpool/get.md).

{% endlist %}