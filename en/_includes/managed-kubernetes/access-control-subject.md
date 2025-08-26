Possible subject types: 
  
  * `userAccount`: [Yandex account](../../iam/concepts/users/accounts.md#passport) added to {{ yandex-cloud }} or an account from a [user pool](../../organization/concepts/user-pools.md).
  * `serviceAccount`: [Service account](../../iam/concepts/users/service-accounts.md) created in {{ yandex-cloud }}.
  * `federatedUser`: Account of an [identity federation](../../organization/concepts/add-federation.md) user.
  * `group`: [{{ org-full-name }}](../../organization/) user group.
  * `system`: [Public group](../../iam/concepts/access-control/public-group.md) of users.
    
    The possible values of a subject ID are as follows:

    * `allAuthenticatedUsers`: [All authenticated users](../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
    * `allUsers`: [Any user](../../iam/concepts/access-control/public-group.md#allUsers). No authentication is required.

To learn more about subject types, see the [Subject a role is assigned to](../../iam/concepts/access-control/index.md#subject) section.