* `{{ lockbox-short-name }}` to store the application's OAuth token in a secret; in the **Secret** section, select the secret, its [version](../../../lockbox/concepts/secret.md#version), and the key used to store the OAuth token.

    If you do not have a {{ lockbox-name }} secret, click **{{ ui-key.yacloud.common.create }}** to create it.

* `Text` to store the application's OAuth token in the specification as text; enter the OAuth token in the **Value** field.

    {% note warning %}

    It is not safe to store the OAuth token in plain text in the specification text.

    {% endnote %}
