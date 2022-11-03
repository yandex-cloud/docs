# Communities in {{ ml-platform-name }}

_Communities_ is a way to organize team work in {{ ml-platform-name }}. A community determines the scope of projects and resources and helps set up team activities.

Roles determine what the community members can do. Community members can be _developers_ or _administrators_ in the community. To see a full list of the community members, see the **Member** tab. A developer can create projects and their resources in the community and run calculations in the IDE. A community administrator can invite new members to the community and manage their roles, change the [payment information](#billing), and share resources with other community members. For more information about roles in {{ ml-platform-name }}, see [{#T}](../security/index.md).

For every organization, {{ ml-platform-name }} creates a default community with the name `<Organization Name> Team`. When logging in to {{ ml-platform-name }} for the first time, all the users from the organization automatically become members of this community with the Developer role. The administrator role in the community is inherited from the role `organization-manager.admin` or higher. Users with the role `organization-manager.admin` can appoint administrators among community members. For more information about access control within an organization, see the {{ org-full-name }} documentation, [{#T}](../../organization/roles.md).

You can't delete the organization's community.

{% note tip %}

However, it's not necessary to maintain the organization's community. You can [create](../operations/community/create.md) an independent community for each of your teams.

{% endnote %}

You can [link a channel](../operations/community/link-channel.md) in Slack or Telegram to your community so that users can communicate.

To create resources and run projects in the IDE, link a {{ yandex-cloud }} [billing account](../../billing/concepts/billing-account.md) to the community. To learn how to do it, see [{#T}](../operations/community/link-ba.md).

{% include [share-resources](../../_includes/datasphere/sharing-resources.md) %}


#### See also {#see-also}

* [{#T}](../security/index.md)
* [{#T}](../../organization/roles.md)
* [{#T}](../operations/index.md#community)
* [{#T}](../operations/community/link-ba.md)
* [Sharing secrets](../operations/data/secrets.md#share)