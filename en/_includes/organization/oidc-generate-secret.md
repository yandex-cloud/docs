Under **{{ ui-key.yacloud_org.application.overview.secret_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.secret_section_add_new_secret_action }}**, and in the window that opens:

1. Optionally, add a description for the new secret.
1. Click **{{ ui-key.yacloud.common.create }}**.

The window will display the generated [application secret](../../organization/concepts/applications.md#oidc-secret). Save this value.

{% note warning %}

If you refresh or close the application information page, you will not be able to view the secret again.

{% endnote %}

If you closed or refreshed the page before saving the secret, click **{{ ui-key.yacloud_org.application.overview.secret_section_add_new_secret_action }}** to create a new one.

To delete a secret, in the list of secrets on the OIDC app page, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) in the secret row and select ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.