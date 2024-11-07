1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) with an administrator or organization owner account.

1. In the left-hand panel, select ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.

1. If the user already has at least one role, click ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.entity.user.action.acl }}** in the row with this user.

    If the user is not on the list, click **{{ ui-key.yacloud_org.entity.user.action.acl }}** in the top-right corner. In the window that opens, select a user from the list or use the search bar.

1. Click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.form.acl.edit.action.role.add }}** and select the [role](../../iam/concepts/access-control/roles.md) you want to assign to the user. You can assign multiple roles.

    You can find the description of the available roles in the {{ iam-full-name }} documentation in the [{{ yandex-cloud }}](../../iam/roles-reference.md) role reference.

1. Click **{{ ui-key.yacloud.common.save }}**.