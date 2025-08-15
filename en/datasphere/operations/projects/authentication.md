---
title: How to get authenticated in {{ ds-jobs }}
description: This article describes {{ ds-jobs }} authentication methods.
---

# Authentication in {{ ds-jobs }}

To use {{ ds-jobs }}, you need to get authenticated as a user account.

{% list tabs group=authentication %}

- Yandex account {#yandex-account}

  1. Get an [OAuth token](../../../iam/concepts/authorization/oauth-token.md).
  1. Provide the OAuth token in one of the following ways:

     * Using the `YC_TOKEN` or `YC_OAUTH_TOKEN` environment variables in the `~/.bash_profile` configuration file (`~/.bashrc` for Linux).

       The OAuth token will be saved in the profile configuration, enabling automatic authentication.

     * Using [{{ ds-cli }}](../../concepts/jobs/cli.md) and the `-t` option. Here is an example:

       ```bash
       datasphere -t <OAuth_token> project job get --id <project_ID>
       ```

       {% include [get-project-id](../../../_includes/datasphere/get-project-id.md) %}

       In this case, you will have to provide the OAuth token in each command.

- Federated account {#federated-account}

  To authenticate federated accounts, install and configure the [Yandex CLI](../../../cli/quickstart.md). You cannot run a job as a federated account on a local computer without a graphical shell: the Yandex CLI will redirect your request to the browser for authentication.

{% endlist %}
