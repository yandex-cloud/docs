---
title: Setting up PyPI
description: Follow this guide to set up PyPI.
---

# Setting up PyPI

1. Depending on the authentication method:

    {% list tabs group=registry_auth %}

    - IAM token {#iam-token}

      Get an [IAM token](../../../iam/concepts/authorization/iam-token.md) for the [Yandex account](../../../iam/operations/iam-token/create.md) or [service account](../../../iam/operations/iam-token/create-for-sa.md) you are going to use for authentication.

      {% note info %}

      The IAM token's [lifetime](../../../iam/concepts/authorization/iam-token.md#lifetime) is limited to {{ iam-token-lifetime }}.

      {% endnote %}

    - OAuth token {#oauth-token}

      [Get]({{ link-cloud-oauth }}) an OAuth token for the Yandex account you are going to use for authentication.

    {% endlist %}

1. In the user’s root directory, create a file named `~/.pypirc` with the following content and specify the token in it:

    {% list tabs group=registry_auth %}

    - IAM token {#iam-token}

      ```text
      [distutils]
      index-servers =
          cloud-registry

      [cloud-registry]
      repository = https://{{ cloud-registry }}/pypi/<registry_ID>/legacy/
      username = iam
      password = <IAM_token>
      ```

    - OAuth token {#oauth-token}

      ```text
      [distutils]
      index-servers =
          cloud-registry

      [cloud-registry]
      repository = https://{{ cloud-registry }}/pypi/<registry_ID>/legacy/
      username = oauth
      password = <OAuth_token>
      ```

    {% endlist %}