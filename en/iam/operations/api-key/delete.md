---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Deleting API keys

{% list tabs %}

- CLI

  1. View the list of API keys for the service account by entering the account name (for example, `my-robot`):

      ```
      $ yc iam api-key list --service-account-name my-robot
      ```

      The folder specified in the CLI profile is used by default to search for the service account. You can specify a different folder using the `--folder-name` or `--folder-id` flag.

  1. Delete the API key by specifying its ID:

      ```
      $ yc iam api-key delete <API-KEY-ID>
      ```

- API

  1. Delete the API key using the [delete](../../api-ref/ApiKey/delete.md) method for the [ApiKey](../../api-ref/ApiKey/index.md) resource:

      ```bash
      $ export APIKEY_ID=ajeke74kbp5bfq7m6ka2
      $ export IAM_TOKEN=CggaATEVAgA...
      $ curl -X DELETE -H "Authorization: Bearer $IAM_TOKEN" \
          https://iam.api.cloud.yandex.net/iam/v1/apiKeys/$APIKEY_ID
      ```

{% endlist %}

