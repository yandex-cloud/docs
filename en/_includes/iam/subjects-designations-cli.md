To indicate a subject, use the `--subject` parameter in `<subject_type>:<ID>` format. For some subject types, the [{{ yandex-cloud }} CLI](../../cli/index.yaml) provides separate parameters instead of `--subject`, where you only need to specify the subject name or ID without the type. Possible subject designations and the corresponding CLI parameters:

#|
|| **Subject type** | **Subject designation** | **{{ yandex-cloud }} CLI parameter** ||
|| `userAccount`    | `userAccount:<user_ID>` | `--user-account-id` or `--user-yandex-login` ||
|| `serviceAccount` | `serviceAccount:<service_account_ID>` | `--service-account-id` or `--service-account-name` ||
|| `federatedUser`  | `federatedUser:<user_ID>` | `--user-account-id` ||
|| `group`          | `group:<group_ID>` | `--group-members` ||
|| `system`         | `system:allAuthenticatedUsers`

(`All authenticated users` group) | `--all-authenticated-users` ||
|| ^                | `system:allUsers`

(`All users` group) | — ||
|| ^                | `system:group:organization:<organization_ID>:users`

(`All users in organization X` group) | `--organization-users` ||
|| ^                | `system:group:federation:<federation_ID>:users`

(`All users in federation N` group) | `--federation-users` ||
|| ^                | `system:group:userpool:<pool_ID>:users`

(`All users in userpool P` group) | — ||
|#