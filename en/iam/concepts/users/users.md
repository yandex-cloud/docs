# Yandex Cloud users

_Users_ are the subjects of Yandex Cloud who perform operations on resources. Subjects can be assigned [roles](../access-control/roles.md) that define their [access rights](../access-control/access-bindings.md) for a resource, folder, or cloud.

_Subjects_ are not just regular Yandex Cloud users. There are three types of subjects in Yandex Cloud: normal users, service accounts, and system groups. You can assign roles to any of these subjects.

## Normal user {#passport}

_A normal user_ is a user who has registered with Yandex Cloud.

The user registers with Yandex Cloud using a Yandex account.

The user can register independently with a promo code or an [invite](../../operations/users/create.md).

When a user registers with a promo code, they get their own cloud where they are assigned as the [owner](../../../resource-manager/concepts/resources-hierarchy.md#owner). When registering by an invite, the user becomes a [member](../../../resource-manager/concepts/resources-hierarchy.md#member) in the cloud they were invited to.

## Service account {#sa}

[!INCLUDE-NOTITLE [service-accounts](service-accounts.md)]

## System groups {#system}

_A system group_ is an identifier of a group of subjects.

At the moment, there is just one system group, `[!KEYREF subjects-allAuthenticatedUsers]`, that applies to any authenticated user. This may be any registered Yandex Cloud user or service account.

By assigning a subject the `[!KEYREF subjects-allAuthenticatedUsers]` role for the resource, you grant public access to the resource to anyone authenticated in Yandex Cloud, but only on such operations that are allowed by the given role.

This is useful if you want to share your resources with other Yandex Cloud users. For example, if you assign the role of `[!KEYREF roles-image-user]`  to the  `allAuthenticatedUsers` subject for a folder containing disk images, then anyone authenticated in Yandex Cloud can use these images to create new disks or virtual machines. To do this via the API, you just need to specify the folder ID and IAM token in the request.

