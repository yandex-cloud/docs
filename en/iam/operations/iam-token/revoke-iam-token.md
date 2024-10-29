---
title: How to revoke an IAM token
description: Follow this guide to revoke an IAM token you got earlier.
---

# Revoking an IAM token

You can revoke an [IAM token](../../concepts/authorization/iam-token.md) you got earlier. You may need to do this, for example, if the token is [compromised](../compromised-credentials.md) or if you are getting a new one.

To revoke an IAM token:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Check out the description of the IAM token revocation command:

      ```bash
      yc iam revoke-token --help
      ```

  1. Revoke the IAM token by specifying it in this command:

      ```bash
      yc iam revoke-token \
        --iam-token "<IAM_token>"
      ```

      Result:

      ```text
      subject_id: ajei280a73vc********
      ```

- API {#api}

  Run an http request specifying the IAM token to revoke:

  ```bash
  curl \
    --request POST \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer <IAM_token>" \
    --data '{
        "iamToken": "<IAM_token>"
    }' \
    https://iam.{{ api-host }}/iam/v1/tokens:revoke
  ```

  Result:

  ```json
  {
    "subjectId": "ajei280a73vc********"
  }

{% endlist %}

#### See also {#see-also}

* [{#T}](./create.md)
* [{#T}](./create-for-federation.md)
* [{#T}](./create-for-sa.md)