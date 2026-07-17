Для обозначения субъекта используется комбинация типа и уникального идентификатора в полях запроса `subject.type` и `subject.id`. Возможные комбинации:

#|
|| **subject.type** | **subject.id** ||
|| `userAccount`    | `<идентификатор_пользователя>` ||
|| `serviceAccount` | `<идентификатор_сервисного_аккаунта>` ||
|| `federatedUser`  | `<идентификатор_пользователя>` ||
|| `group`          | `<идентификатор_группы>` ||
|| `system`         | `allAuthenticatedUsers`

(группа `All authenticated users`) ||
|| ^                | `allUsers`

(группа `All users`) ||
|| ^                | `group:organization:<идентификатор_организации>:users`

(группа `All users in organization X`) ||
|| ^                | `group:federation:<идентификатор_федерации>:users`

(группа `All users in federation N`) ||
|| ^                | `group:userpool:<идентификатор_пула>:users`

(группа `All users in userpool P`) ||
|#
