---
title: Управлять исключениями политики MFA в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете управлять исключениями политики MFA в {{ org-full-name }}.
---

# Управлять исключениями политики MFA

Исключения позволяют не применять [политику MFA](../../concepts/mfa.md#mfa-policies) к отдельным пользователям или [группам пользователей](../../concepts/groups.md), добавленным в целевую группу этой политики. Этим пользователям или группам пользователей не придется заново настраивать аутентификацию, если вы уберете их из списка исключений.

## Изменить список исключений {#update}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите список пользователей или групп, к которым применяется политика MFA:

     ```bash
     yc organization-manager mfa-enforcement list-audience \
       --id <идентификатор_политики>
     ```

  1. Посмотрите описание команды CLI для изменения списка исключений политики MFA:

     ```bash
     yc organization-manager mfa-enforcement update-excluded-audience --help
     ```

  1. Чтобы добавить пользователей или группы пользователей в список исключений политики MFA, выполните команду:

     ```bash
     yc organization-manager mfa-enforcement update-excluded-audience \
       --id <идентификатор_политики> \
       --audience-delta subject-id=<идентификатор_субъекта>,action=<действие>
     ```

     Где:

     * `--audience-delta` — параметр для изменения списка пользователей/групп в политике:
       * `subject-id` — идентификатор пользователя или группы.
       * `action` — действие: `action-add` — добавить, `action-remove` — удалить.

     Можно указать несколько параметров `--audience-delta` для одновременного добавления или удаления нескольких объектов.

     Результат:

      ```text
      mfa_enforcement_id: bpfjv8qeq4ii********
      effective_deltas:
        - action: ACTION_ADD
          subject_id: aje0j5mts02t********
      ```

{% endlist %}

## Посмотреть список исключений {#list}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите список пользователей или групп, к которым применяется политика MFA:

     ```bash
     yc organization-manager mfa-enforcement list-excluded-audience \
       --id <идентификатор_политики>
     ```

     Результат:

      ```text
      +----------------------+---------------+
      |          ID          |     TYPE      |
      +----------------------+---------------+
      | aje0j5mts02t******** | federatedUser |
      +----------------------+---------------+
      ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](./add-users.md)
* [{#T}](./create-policy.md)
* [{#T}](./update-policy.md)
* [{#T}](./deactivate-reactivate-policy.md)
* [{#T}](./delete-policy.md)
* [{#T}](./manage-verification.md)
* [{#T}](../../concepts/mfa.md)