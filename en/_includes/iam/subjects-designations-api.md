To indicate a subject, use a combination of its type and unique ID in the `subject.type` and `subject.id` fields of the request. Possible combinations:

#|
|| **subject.type** | **subject.id** ||
|| `userAccount`    | `<user_ID>` ||
|| `serviceAccount` | `<service_account_ID>` ||
|| `federatedUser`  | `<user_ID>` ||
|| `group`          | `<group_ID>` ||
|| `system`         | `allAuthenticatedUsers`

(`All authenticated users` group) ||
|| ^                | `allUsers`

(`All users` group) ||
|| ^                | `group:organization:<organization_ID>:users`

(`All users in organization X` group) ||
|| ^                | `group:federation:<federation_ID>:users`

(`All users in federation N` group) ||
|| ^                | `group:userpool:<pool_ID>:users`

(`All users in userpool P` group) ||
|#
