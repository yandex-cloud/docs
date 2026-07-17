Для обозначения субъекта используется комбинация типа и уникального идентификатора — `<тип_субъекта>:<идентификатор>`. Возможные обозначения субъектов:

#|
|| **Тип субъекта** | **Обозначение субъекта** ||
|| `userAccount`    | `userAccount:<идентификатор_пользователя>` ||
|| `serviceAccount` | `serviceAccount:<идентификатор_сервисного_аккаунта>` ||
|| `federatedUser`  | `federatedUser:<идентификатор_пользователя>` ||
|| `group`          | `group:<идентификатор_группы>` ||
|| `system`         | `system:allAuthenticatedUsers`

(группа `All authenticated users`) ||
|| ^                | `system:allUsers`

(группа `All users`) ||
|| ^                | `system:group:organization:<идентификатор_организации>:users`

(группа `All users in organization X`) ||
|| ^                | `system:group:federation:<идентификатор_федерации>:users`

(группа `All users in federation N`) ||
|| ^                | `system:group:userpool:<идентификатор_пула>:users`

(группа `All users in userpool P`) ||
|#