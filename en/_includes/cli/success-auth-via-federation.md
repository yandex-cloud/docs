{% if audience != "internal" %}

On successful authentication, the [IAM token](../../iam/concepts/authorization/iam-token.md) is saved in the profile. This token is used to authenticate each operation until the [token expires](../../iam/concepts/authorization/iam-token.md). After that, the CLI again displays a prompt to authenticate in the browser.

{% endif %}
