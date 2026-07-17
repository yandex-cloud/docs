Для обозначения субъекта используется параметр `--subject` со значением в формате `<тип_субъекта>:<идентификатор>`. Для некоторых типов субъектов в [{{ yandex-cloud }} CLI](../../cli/index.yaml) вместо `--subject` доступны отдельные параметры, в которых достаточно указать имя или идентификатор субъекта без типа. Возможные обозначения субъектов и соответствующие параметры CLI:

#|
|| **Тип субъекта** | **Обозначение субъекта** | **Параметр {{ yandex-cloud }} CLI** ||
|| `userAccount`    | `userAccount:<идентификатор_пользователя>` | `--user-account-id` или `--user-yandex-login` ||
|| `serviceAccount` | `serviceAccount:<идентификатор_сервисного_аккаунта>` | `--service-account-id` или `--service-account-name` ||
|| `federatedUser`  | `federatedUser:<идентификатор_пользователя>` | `--user-account-id` ||
|| `group`          | `group:<идентификатор_группы>` | `--group-members` ||
|| `system`         | `system:allAuthenticatedUsers`

(группа `All authenticated users`) | `--all-authenticated-users` ||
|| ^                | `system:allUsers`

(группа `All users`) | — ||
|| ^                | `system:group:organization:<идентификатор_организации>:users`

(группа `All users in organization X`) | `--organization-users` ||
|| ^                | `system:group:federation:<идентификатор_федерации>:users`

(группа `All users in federation N`) | `--federation-users` ||
|| ^                | `system:group:userpool:<идентификатор_пула>:users`

(группа `All users in userpool P`) | — ||
|#