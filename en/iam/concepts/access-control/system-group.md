# allAuthenticatedUsers system group

_A system group_ is an identifier of a group of users (subjects).

At the moment, there is just one system group, `allAuthenticatedUsers`, that applies to all [authenticated](../authorization/) users. These are all registered Yandex.Cloud users or service accounts.

By assigning a subject the `allAuthenticatedUsers` role for a resource, you grant public access to the resource to anyone authenticated in Yandex.Cloud, but only for such operations that are allowed by the given role.

This is useful if you want to share your resources with other Yandex.Cloud users. For example, you have an OS disk image that you want to share. To do this, assign the `allAuthenticatedUsers` subject the `compute.images.user` role for the folder that contains the image.

