1. Go to [{{ org-full-name }}]({{ link-org-cloud-center }}).
1. In the left-hand panel, select ![icon-users](../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**. The page will display a list of organization users with the following fields:

    * **{{ ui-key.yacloud.common.resource-acl.label_subject }}**: User full name.
    * **{{ ui-key.yacloud_org.entity.user.caption.username }}**: User login.
    * **{{ ui-key.yacloud_org.entity.user.caption.status }}**: Current user status:

        * `Active`: Active user.
        * `Inactive`: Inactive user.
    * **{{ ui-key.yacloud_org.entity.user.caption.provider }}**: Information about the user's identity provider:

        * For federated users: [Identity federation](../organization/concepts/add-federation.md) name.
        * For local users: [User pool](../organization/concepts/user-pools.md) name.
        * For users with a Yandex account: `Yandex ID`.
    * **{{ ui-key.yacloud_org.entity.user.column_last-auth }}**: Date and time of the user's last [authentication](../iam/concepts/authorization/index.md) in {{ yandex-cloud }}. There may be no date if no authentication has yet taken place or if it happened before this feature was introduced.

        * For federated and local users, the date is displayed in the list and in the user card.
        * For users with a Yandex account, the date is displayed only in the card and only when viewed under the same user's name.

    * **{{ ui-key.yacloud.common.id }}**: User ID.
    * **{{ ui-key.yacloud_org.entity.user.caption.email }}**: User email address.

    {% note info %}

    Some fields may not be displayed. To set up field display, click ![gear](../_assets/console-icons/gear.svg) in the top-right corner of the user list, select the fields, and click **{{ ui-key.yacloud.common.apply }}**.

    You can also re-order the fields by dragging them with your mouse.

    {% endnote %}
 
1. Locate the user in the list. Use the filter or search bar at the top of the screen as needed.
1. Click the row with the name for details about the user and the user's [groups](../organization/concepts/groups.md), [MFA factors](../organization/concepts/mfa.md#mfa-factors) (for federated and local users), [{{ oslogin }} profiles](../organization/concepts/os-login.md#os-login-profiles), and [SSH keys](../organization/concepts/os-login.md#ssh-keys).