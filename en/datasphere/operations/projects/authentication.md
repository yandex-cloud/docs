---
title: "How to authenticate in {{ ds-jobs }}"
description: "This article describes the authentication methods in {{ ds-jobs }}."
---

# Authentication in {{ ds-jobs }}

To use {{ ds-jobs }}, you need to authenticate as a user account.

{% list tabs group=authentication %}

- Yandex account {#yandex-account}

   1. Get an [OAuth token](../../../iam/concepts/authorization/oauth-token.md).
   1. Specify the OAuth token in one of two ways:

      * Using the `YC_TOKEN` or `YC_OAUTH_TOKEN` environment variables in the `~/.bash_profile` configuration file (or `~/.bashrc` for Linux).

         The OAuth token will be saved in the profile configuration and authentication will be automatic.

      * Using [{{ ds-cli }}](../../concepts/jobs/cli.md) and the `-t` option, e.g.:

         ```bash
         datasphere -t <OAuth_token> project job get --id <project_ID>
         ```

         In this case, you will have to specify the OAuth token in each command.


- Federated account {#federated-account}

   To authenticate federated accounts, install and configure the [Yandex CLI](../../../cli/quickstart.md). You cannot run a job as a federated account on a local computer without a graphical shell: the Yandex CLI will redirect your request to the browser for authentication.

{% endlist %}
