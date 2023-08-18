# Communities in {{ ml-platform-name }}

_Communities_ is a way to organize team work in {{ ml-platform-name }}. A community determines the scope of projects and resources and helps set up team activities.

Roles determine what the community members can do. A community member may be a _developer_ or an _administrator_. To view a full list of the community members, see the **{{ ui-key.yc-ui-datasphere.common.members }}** tab. A developer can create projects and their resources in the community and run calculations in the IDE. A community administrator can invite new members to the community and manage their roles, change the [payment information](#billing), and share resources with other community members. For more information about roles in {{ ml-platform-name }}, see [{#T}](../security/index.md).

You can [link a channel](../operations/community/link-channel.md) in Slack or Telegram to your community so that users can communicate.

To create resources and run projects in the IDE, link a {{ yandex-cloud }} [billing account](../../billing/concepts/billing-account.md) to the community. To learn how to do it, see [{#T}](../operations/community/link-ba.md).

## Organization community {#organization-team}

For every organization, {{ ml-platform-name }} creates a default community with the `<Organization Name> Team` name. When logging in to {{ ml-platform-name }} for the first time, all users from the organization automatically become members of this community with the `Viewer` (`{{ roles-datasphere-communities-viewer }}`) role. The administrator role in the community is inherited from the `organization-manager.admin` role or higher. Users with the `organization-manager.admin` role can appoint administrators among community members. For more information on access control within an organization, see the [{#T}](../../organization/roles.md) section of the {{ org-full-name }} documentation.

You cannot delete an organization community.

{% note tip %}

You are not required to maintain an organization community. Instead, you can [create](../operations/community/create.md) an independent community for each of your teams.

{% endnote %}

{% include [share-resources](../../_includes/datasphere/sharing-resources.md) %}


#### See also {#see-also}

* [{#T}](../security/index.md)
* [{#T}](../../organization/roles.md)
* [{#T}](../operations/index.md#community)
* [{#T}](../operations/community/link-ba.md)
* [Sharing secrets](../operations/data/secrets.md#share)