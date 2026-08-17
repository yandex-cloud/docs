To indicate a subject, use a combination of its type and unique ID, i.e., `<subject_type>:<ID>`. How you can designate a subject:

#|
|| **Subject type** | **Subject designation** ||
|| `userAccount`    | `userAccount:<user_ID>` ||
|| `serviceAccount` | `serviceAccount:<service_account_ID>` ||
|| `federatedUser`  | `federatedUser:<user_ID>` ||
|| `group`          | `group:<group_ID>` ||
|| `system`         | `system:allAuthenticatedUsers`

(`All authenticated users` group) ||
|| ^                | `system:allUsers`

(`All users` group) ||
|| ^                | `system:group:organization:<organization_ID>:users`

(`All users in organization X` group) ||
|| ^                | `system:group:federation:<federation_ID>:users`

(`All users in federation N` group) ||
|| ^                | `system:group:userpool:<pool_ID>:users`

(`All users in userpool P` group) ||
|#