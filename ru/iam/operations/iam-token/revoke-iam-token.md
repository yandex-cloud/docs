---
title: Как отозвать IAM-токен
description: Следуя данной инструкции, вы сможете отозвать полученный ранее IAM-токен.
---

# Отзыв IAM-токена

Полученный ранее [IAM-токен](../../concepts/authorization/iam-token.md) можно отозвать. Например, это может потребоваться при его [компрометации](../compromised-credentials.md) или при получении нового IAM-токена.

Чтобы отозвать IAM-токен:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды отзыва IAM-токена:

      ```bash
      yc iam revoke-token --help
      ```

  1. Отзовите IAM-токен, указав его в команде:

      ```bash
      yc iam revoke-token \
        --iam-token "<IAM-токен>"
      ```

      Результат:

      ```text
      subject_id: ajei280a73vc********
      ```

- API {#api}

  Выполните http-запрос, указав отзываемый IAM-токен:

  ```bash
  curl \
    --request POST \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer <IAM-токен>" \
    --data '{
        "iamToken": "<IAM-токен>"
    }' \
    https://iam.{{ api-host }}/iam/v1/tokens:revoke
  ```

  Результат:

  ```json
  {
    "subjectId": "ajei280a73vc********"
  }

{% endlist %}

#### См. также {#see-also}

* [{#T}](./create.md)
* [{#T}](./create-for-federation.md)
* [{#T}](./create-for-sa.md)