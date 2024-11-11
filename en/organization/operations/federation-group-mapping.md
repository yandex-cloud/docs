# Configuring user group mapping for your federation

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

To configure user access to {{ yandex-cloud }} resources using [group mapping](../concepts/add-federation.md#group-mapping):

1. [Create user groups](#create-group) in {{ org-name }}.
1. [Configure access rights](#access) to {{ yandex-cloud }} resources.
1. Create user groups in your [identity provider](../concepts/add-federation.md#federation-usage) and add users to them.

    {% note info %}

    You can use existing user groups.

    {% endnote %}

1. Set up user group mapping in the identity provider's SAML attribute settings. To learn how to do this, consult the provider's documentation or contact their support.

    Identity providers offer guides on how to set up group mapping:

   * [{{ keycloak }}](../tutorials/federations/group-mapping/keycloak.md).
   * [{{ microsoft-idp.adfs-full }}](../tutorials/federations/group-mapping/adfs.md).
   * [{{ microsoft-idp.entra-id-full }}](../tutorials/federations/group-mapping/entra-id.md).
   * [Google](https://support.google.com/a/answer/11143403?sjid=815248229840499495-EU).

1. Set up user group mapping in the federation settings:

    {% list tabs group=instructions %}

    - {{ cloud-center }} interface {#cloud-center}

      1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) with an administrator or organization owner account.

      1. In the left-hand panel, select ![VectorSquare](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

      1. Click the line with the required federation and go to the **{{ ui-key.yacloud_org.form.group-mapping.note.tab-idp }}** tab.

      1. Enable **{{ ui-key.yacloud_org.form.group-mapping.field.idp }}**.

      1. Click **{{ ui-key.yacloud_org.form.group-mapping.create.add }}** and configure mapping:

          * **{{ ui-key.yacloud_org.form.group-mapping.note.group-name }}**: Enter the name of an identity provider group.
          * **{{ ui-key.yacloud_org.form.group-mapping.note.iam-group }}**: Select a {{ org-name }} group from the list.

      1. Repeat the previous step for each group you want to map.

      1. Click **{{ ui-key.yacloud_org.actions.save-changes }}**.

    {% endlist %}