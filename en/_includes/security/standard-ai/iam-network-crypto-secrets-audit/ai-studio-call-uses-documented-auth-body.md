{#ai-iam4-id}

Requirement ID: `AI-IAM4`

{#ai-iam4-requirement}

**Requirement**

The {{ ai-studio-name }} client must use an IAM token or API key of the service account and a role matching the selected API. Use the `ai.languageModels.user` role for text generation, `ai.assistants.editor` together with `ai.languageModels.user` for the Responses API, and `ai.models.user` for the Realtime API. These roles are API-specific; always consult the respective API guides before using them with a different API. For information about headers and minimum roles, see [this {{ ai-studio-name }} authentication reference]({{ link-docs-ai }}ai-studio/api-ref/authentication.html).

An API key must have explicitly defined scopes and a limited lifetime or an approved review period. To select a scope, refer to the target API guides and the current list of available scopes. Do not use one single scope for all models. To learn more about key management and scope behavior, see [this {{ iam-short-name }} guide](../../../../iam/operations/authentication/manage-api-keys.md).

If your API supports IAM tokens, opt for a short-lived one.

To run a Vector Store search, you need the `yc.ai.foundationModels.execute` scope. You cannot replace it with `yc.ai.languageModels.execute` or any other similar scope.

{#ai-iam4-implementation}

**Implementation**

You can check the scopes of any API key in the management console or through the API with the key metadata output. To find out how to view scopes, refer to the current version of the [{{ iam-short-name }} CLI reference](../../../../iam/operations/authentication/manage-api-keys.md) or the management interface.

{#ai-iam4-check}

**Check**

```bash
yc iam api-key list --service-account-name <service_account_name>
```

1. Map each key’s metadata to the key’s owner, API you are calling, assigned scopes, and lifetime.
1. View the current scopes via the management console or API, or by running the `yc iam api-key get` command.

Do not output the secret value in the check report. Allowed calls should succeed, while API calls outside the selected scopes, or those using expired or revoked keys, must be rejected.

{#ai-iam4-artifacts}

**Artifact**

* Key metadata without the value.
* Owner and API mapping.
* Service account bindings.
* Key lifecycle in {{ at-name }}.
* Results of the allowed and denied calls.
