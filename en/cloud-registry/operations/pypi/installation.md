---
title: Setting up PyPI
description: Follow this guide to set up PyPI.
---

# Setting up PyPI

1. {% include [auth-env-vars](../../../_includes/cloud-registry/auth-env-vars.md) %}
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

    - API key {#api-key}

      ```text
      [distutils]
      index-servers =
          cloud-registry

      [cloud-registry]
      repository = https://{{ cloud-registry }}/pypi/<registry_ID>/legacy/
      username = api_key
      password = <API_key>
      ```

    {% endlist %}