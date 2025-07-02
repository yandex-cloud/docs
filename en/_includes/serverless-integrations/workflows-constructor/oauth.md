* `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_oauth_token_description_lockbox }}` to store the application's OAuth token in a secret; in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_oauth_token_properties_lockbox_properties_name_view_spec_layout_title }}** section, select the secret, its [version](../../../lockbox/concepts/secret.md#version), and the key used to store the OAuth token.

    If you do not have a {{ lockbox-name }} secret, click **{{ ui-key.yacloud.common.create }}** to create it.

* `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_oauth_token_description_plain }}` to store the application's OAuth token in the specification as text; enter the OAuth token in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_oauth_token_properties_plain_properties_token_view_spec_layout_title }}** field.

    {% note warning %}

    It is not safe to store the OAuth token in plain text in the specification text.

    {% endnote %}
