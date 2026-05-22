---
title: Как настроить права доступа к сертификату {{ certificate-manager-full-name }}
description: Следуя данной инструкции, вы сможете настроить права доступа к сертификату.
---

# Настроить права доступа к сертификату

Чтобы предоставить пользователю, группе или [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) доступ к [сертификату](../concepts/index.md#types), назначьте на него [роль](../../iam/concepts/access-control/roles.md).

## Назначить роль {#access-to-user}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для назначения роли на сертификат:

      ```bash
      yc certificate-manager certificate add-access-binding --help
      ```

  1. Получите список сертификатов в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      ```bash
      yc certificate-manager certificate list
      ```

      Результат:

      ```text
      +----------------------+--------+-------------+---------------------+----------+---------+
      |          ID          |  NAME  |   DOMAINS   |      NOT AFTER      |   TYPE   | STATUS  |
      +----------------------+--------+-------------+---------------------+----------+---------+
      | fpqgbg3fajpg******** | cert-1 | example.com | 2026-01-04 13:58:14 | IMPORTED | ISSUED  |
      | fpqlhev2j4ad******** | cert-2 | example.com | 2026-01-04 14:07:02 | IMPORTED | ISSUED  |
      +----------------------+--------+-------------+---------------------+----------+---------+
      ```

  1. Посмотрите список ролей, которые уже назначены на ресурс:

      ```bash
      yc certificate-manager certificate list-access-bindings <идентификатор_сертификата>
      ```

  1. Назначьте роль с помощью команды:

      * Пользователю:

          ```bash
          yc certificate-manager certificate add-access-binding <идентификатор_сертификата> \
            --user-account-id <идентификатор_пользователя> \
            --role <роль>
          ```

          Где:

          * `--user-account-id` — [идентификатор пользователя](../../organization/operations/users-get.md).
          * `--role` — назначаемая [роль](../security/index.md#roles-list).

      * Сервисному аккаунту:

          ```bash
          yc certificate-manager certificate add-access-binding <идентификатор_сертификата> \
            --service-account-id <идентификатор_сервисного_аккаунта> \
            --role <роль>
          ```

          Где:

          * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md).
          * `--role` — назначаемая роль.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы назначить роль на сертификат с помощью {{ TF }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_cm_certificate_iam_member" "mycert-roles" {
        certificate_id = "<идентификатор_сертификата>"
        role           = "<роль>"
        member         = "<тип_субъекта>:<идентификатор_субъекта>"
      }
      ```

      Где:

      * `certificate_id` — идентификатор сертификата.
      * `role` — назначаемая [роль](../security/index.md#roles-list).
      * `member` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль. Указывается в формате `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

       Подробнее о параметрах ресурса `yandex_cm_certificate_iam_member` см. в [документации провайдера]({{ tf-provider-resources-link }}/cm_certificate_iam_member).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно с помощью команды [CLI](../../cli/):

      ```bash
      yc certificate-manager certificate list-access-bindings <идентификатор_сертификата>
      ```

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../api-ref/Certificate/updateAccessBindings.md) для ресурса [Certificate](../api-ref/Certificate/) или вызовом gRPC API [CertificateService/UpdateAccessBindings](../api-ref/grpc/Certificate/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}

## Назначить несколько ролей {#multiple-roles}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Вы можете назначить несколько ролей с помощью команды `set-access-bindings`.

  {% include [set-access-bindings](../../_includes/compute/set-access-bindings-note.md) %}

  1. Посмотрите список ролей, назначенных на сертификат:

      ```bash
      yc certificate-manager certificate list-access-bindings <идентификатор_сертификата>
      ```

      Если роли надо сохранить, укажите их в команде назначения ролей.

  1. Посмотрите описание команды CLI для назначения ролей на сертификат:

      ```bash
      yc certificate-manager certificate set-access-bindings --help
      ```

  1. Назначьте роли:

      ```bash
      yc certificate-manager certificate set-access-bindings <идентификатор_сертификата> \
        --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--access-binding` — назначаемая роль:
          * `role` — идентификатор назначаемой роли.
          * `subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

      Например, назначьте роли нескольким пользователям и сервисному аккаунту:

      ```bash
      yc certificate-manager certificate set-access-bindings my-certificate \
        --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
        --access-binding role=viewer,subject=userAccount:helj89sfj80a********
        --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы назначить несколько ролей на сертификат с помощью {{ TF }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_cm_certificate_iam_member" "mycert-roles1" {
        certificate_id = "<идентификатор_сертификата>"
        role           = "<роль_1>"
        member         = "<тип_субъекта>:<идентификатор_субъекта>"
      }

      resource "yandex_cm_certificate_iam_member" "mycert-roles2" {
        certificate_id = "<идентификатор_сертификата>"
        role           = "<роль_2>"
        member         = "<тип_субъекта>:<идентификатор_субъекта>"
      }
      ```

      Где:

      * `certificate_id` — идентификатор сертификата.
      * `role` — назначаемая [роль](../security/index.md#roles-list).
      * `member` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль. Указывается в формате `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

       Подробнее о параметрах ресурса `yandex_cm_certificate_iam_member` см. в [документации провайдера]({{ tf-provider-resources-link }}/cm_certificate_iam_member).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно с помощью команды [CLI](../../cli/):

      ```bash
      yc certificate-manager certificate list-access-bindings <идентификатор_сертификата>
      ```

- API {#api}

  Воспользуйтесь методом REST API [setAccessBindings](../api-ref/Certificate/setAccessBindings.md) для ресурса [Certificate](../api-ref/Certificate/) или вызовом gRPC API [CertificateService/SetAccessBindings](../api-ref/grpc/Certificate/setAccessBindings.md).

{% endlist %}

## Отозвать роль {#revoke-role}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для отзыва роли на сертификат:

      ```bash
      yc certificate-manager certificate remove-access-binding --help
      ```

  1. Посмотрите, кому и какие роли назначены на ресурс:

      ```bash
      yc certificate-manager certificate list-access-bindings <идентификатор_сертификата>
      ```

  1. Чтобы отозвать права доступа, выполните команду:

      ```bash
      yc certificate-manager certificate remove-access-binding <идентификатор_сертификата> \
        --role <идентификатор_роли> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--role` — идентификатор роли, которую надо отозвать.
      * `--subject` — [субъект](../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

      Например, чтобы отозвать роль `{{ roles-viewer }}` у пользователя с идентификатором `ajel6l0jcb9s********`:

      ```bash
      yc certificate-manager certificate remove-access-binding my-certificate \
        --role viewer \
        --subject userAccount:ajel6l0jcb9s********
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы отозвать роль, назначенную на сертификат:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием роли:

      ```hcl
      resource "yandex_cm_certificate_iam_member" "mycert-roles" {
        certificate_id = "<идентификатор_сертификата>"
        role           = "<роль>"
        member         = "<тип_субъекта>:<идентификатор_субъекта>"
      }
      ```

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Проверить изменения можно с помощью команды [CLI](../../cli/quickstart.md):
      ```bash
      yc certificate-manager certificate list-access-bindings <идентификатор_сертификата>
      ``

- API {#api}

  Чтобы отозвать роли на сертификат, воспользуйтесь методом REST API [updateAccessBindings](../api-ref/Certificate/updateAccessBindings.md) для ресурса [Certificate](../api-ref/Certificate/) или вызовом gRPC API [CertificateService/UpdateAccessBindings](../api-ref/grpc/Certificate/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}
