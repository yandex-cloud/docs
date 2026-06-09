# Yandex Identity and Access Management

Сервис Yandex Identity and Access Management (IAM) — это сервис идентификации и контроля доступа, который помогает централизованно управлять правами доступа пользователей к вашим ресурсам Yandex Cloud. Благодаря IAM все операции над ресурсами выполняются только пользователями с необходимыми правами.

Инфраструктура Yandex Cloud <a href="https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf">защищена</a> в соответствии с Федеральным законом Российской Федерации «О персональных данных» № 152-ФЗ.

# Yandex Identity and Access Management

## Начало работы

 - [Обзор](quickstart-overview.md)

 - [Как управлять доступом к ресурсам](quickstart.md)

 - [Как работать с сервисными аккаунтами](quickstart-sa.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Обработка секретов, попавших в открытый доступ](operations/compromised-credentials.md)

 - [Пользователи](../organization/operations/manage-users.md)

 - [Группы пользователей](../organization/operations/manage-groups.md)

### Сервисные аккаунты

 - [Создание сервисного аккаунта](operations/sa/create.md)

 - [Просмотр сервисных аккаунтов каталога](operations/sa/list-get.md)

 - [Изменение сервисного аккаунта](operations/sa/update.md)

 - [Назначение роли сервисному аккаунту](operations/sa/assign-role-for-sa.md)

 - [Настройка прав доступа к сервисному аккаунту](operations/sa/set-access-bindings.md)

 - [Использование имперсонации](operations/sa/impersonate-sa.md)

 - [Получение информации о сервисном аккаунте](operations/sa/get-id.md)

 - [Получение ID-токена сервисного аккаунта](operations/sa/get-id-token.md)

 - [Удаление сервисного аккаунта](operations/sa/delete.md)

### Политики авторизации

 - [Получение списка шаблонов политик](operations/access-policies/list.md)

 - [Создание политики для ресурса](operations/access-policies/assign.md)

 - [Просмотр политик, созданных для ресурса](operations/access-policies/view-assigned.md)

 - [Удаление политики](operations/access-policies/revoke.md)

### Роли

 - [Назначение роли](operations/roles/grant.md)

 - [Просмотр назначенных ролей](operations/roles/get-assigned-roles.md)

 - [Отзыв роли](operations/roles/revoke.md)

### Аутентификация

#### IAM-токены

 - [Получение IAM-токена для аккаунта на Яндексе](operations/iam-token/create.md)

 - [Получение IAM-токена для сервисного аккаунта](operations/iam-token/create-for-sa.md)

 - [Получение IAM-токена для федеративного аккаунта](operations/iam-token/create-for-federation.md)

 - [Получение IAM-токена для аккаунта локального пользователя](operations/iam-token/create-for-local.md)

 - [Отзыв IAM-токена](operations/iam-token/revoke-iam-token.md)

##### Refresh-токены

 - [Получение списка refresh-токенов](operations/refresh-token/list.md)

 - [Отзыв refresh-токена](operations/refresh-token/revoke.md)

 - [Управление статическими ключами доступа](operations/authentication/manage-access-keys.md)

 - [Управление API-ключами](operations/authentication/manage-api-keys.md)

 - [Управление авторизованными ключами](operations/authentication/manage-authorized-keys.md)

 - [Создание временного ключа доступа с помощью Security Token Service](operations/sa/create-sts-key.md)

 - [Управление эфемерными ключами доступа](operations/authentication/manage-ephemeral-keys.md)

### Доступ сервисов к ресурсам пользователя

 - [Просмотр статусов сервисов](operations/service-control/list-get.md)

 - [Включение и выключение сервисов](operations/service-control/enable-disable.md)

### Федерации сервисных аккаунтов

 - [Настройка федерации сервисных аккаунтов](operations/wlif/setup-wlif.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Разграничение прав доступа для групп пользователей](tutorials/user-group-access-control.md)

### Хранение статического ключа доступа в секрете Yandex Lockbox

 - [Обзор](tutorials/static-key-in-lockbox/index.md)

 - [CLI](tutorials/static-key-in-lockbox/console.md)

 - [Terraform](tutorials/static-key-in-lockbox/terraform.md)

 - [Сервисный аккаунт с профилем OS Login для управления ВМ с помощью Ansible](tutorials/sa-oslogin-ansible.md)

### Интеграции федераций удостоверений сервисных аккаунтов

 - [GitHub](tutorials/wlif-github-integration.md)

 - [GitLab](tutorials/wlif-gitlab-integration.md)

 - [Пользовательская инсталляция Kubernetes](tutorials/wlif-k8s-integration.md)

 - [Managed Service for Kubernetes](tutorials/wlif-managed-k8s-integration.md)

 - [Настройка CI/CD между Cloud Functions и GitHub](tutorials/ci-cd-github-functions.md)

 - [Загрузка объектов в бакет Object Storage с помощью эфемерного ключа доступа](tutorials/ephemeral-key-storage.md)

## Концепции

 - [Обзор](concepts/index.md)

### Аккаунты в Yandex Cloud

 - [Обзор](concepts/users/accounts.md)

 - [Сервисные аккаунты](concepts/users/service-accounts.md)

### Как устроено управление доступом

 - [Обзор](concepts/access-control/index.md)

 - [Роли](concepts/access-control/roles.md)

 - [Политики авторизации](concepts/access-control/access-policies.md)

 - [Системные группы](concepts/access-control/system-group.md)

 - [Публичные группы](concepts/access-control/public-group.md)

 - [Ресурсы, на которые можно назначать роли](concepts/access-control/resources-with-access-control.md)

 - [Имперсонация](concepts/access-control/impersonation.md)

### Аутентификация

 - [Как выбрать правильный способ аутентификации](concepts/authorization/index.md)

 - [IAM-токен](concepts/authorization/iam-token.md)

 - [API-ключ](concepts/authorization/api-key.md)

 - [Статический ключ доступа](concepts/authorization/access-key.md)

 - [Security Token Service](concepts/authorization/sts.md)

 - [Эфемерные ключи](concepts/authorization/ephemeral-keys.md)

 - [Авторизованный ключ](concepts/authorization/key.md)

 - [OAuth-токен](concepts/authorization/oauth-token.md)

 - [ID-токен](concepts/authorization/id-token.md)

 - [Cookie](concepts/authorization/cookie.md)

 - [Refresh-токен](concepts/authorization/refresh-token.md)

 - [Доступ сервисов к ресурсам пользователя](concepts/service-control.md)

 - [Федерации удостоверений](concepts/federations.md)

 - [Федерации сервисных аккаунтов](concepts/workload-identity.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Безопасное использование Yandex Cloud](best-practices/using-iam-securely.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

 - [Справочник ролей](roles-reference.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### access-analyzer

 - [Overview](cli-ref/access-analyzer/index.md)

 - [list-subject-access-bindings](cli-ref/access-analyzer/list-subject-access-bindings.md)

### access-key

 - [Overview](cli-ref/access-key/index.md)

 - [create](cli-ref/access-key/create.md)

 - [delete](cli-ref/access-key/delete.md)

 - [get](cli-ref/access-key/get.md)

 - [issue-ephemeral](cli-ref/access-key/issue-ephemeral.md)

 - [list](cli-ref/access-key/list.md)

### access-policy-template

 - [Overview](cli-ref/access-policy-template/index.md)

 - [list](cli-ref/access-policy-template/list.md)

### api-key

 - [Overview](cli-ref/api-key/index.md)

 - [create](cli-ref/api-key/create.md)

 - [delete](cli-ref/api-key/delete.md)

 - [get](cli-ref/api-key/get.md)

 - [list](cli-ref/api-key/list.md)

 - [list-scopes](cli-ref/api-key/list-scopes.md)

 - [update](cli-ref/api-key/update.md)

 - [create-id-token](cli-ref/create-id-token.md)

 - [create-token](cli-ref/create-token.md)

### key

 - [Overview](cli-ref/key/index.md)

 - [create](cli-ref/key/create.md)

 - [delete](cli-ref/key/delete.md)

 - [get](cli-ref/key/get.md)

 - [list](cli-ref/key/list.md)

### oauth-client

 - [Overview](cli-ref/oauth-client/index.md)

 - [create](cli-ref/oauth-client/create.md)

 - [delete](cli-ref/oauth-client/delete.md)

 - [get](cli-ref/oauth-client/get.md)

 - [list](cli-ref/oauth-client/list.md)

 - [update](cli-ref/oauth-client/update.md)

### oauth-client-secret

 - [Overview](cli-ref/oauth-client-secret/index.md)

 - [create](cli-ref/oauth-client-secret/create.md)

 - [delete](cli-ref/oauth-client-secret/delete.md)

 - [get](cli-ref/oauth-client-secret/get.md)

 - [list](cli-ref/oauth-client-secret/list.md)

### refresh-token

 - [Overview](cli-ref/refresh-token/index.md)

 - [list](cli-ref/refresh-token/list.md)

 - [revoke](cli-ref/refresh-token/revoke.md)

 - [revoke-token](cli-ref/revoke-token.md)

### role

 - [Overview](cli-ref/role/index.md)

 - [get](cli-ref/role/get.md)

 - [list](cli-ref/role/list.md)

### service-account

 - [Overview](cli-ref/service-account/index.md)

 - [add-access-binding](cli-ref/service-account/add-access-binding.md)

 - [add-labels](cli-ref/service-account/add-labels.md)

 - [create](cli-ref/service-account/create.md)

 - [delete](cli-ref/service-account/delete.md)

 - [get](cli-ref/service-account/get.md)

 - [list](cli-ref/service-account/list.md)

 - [list-access-bindings](cli-ref/service-account/list-access-bindings.md)

 - [list-operations](cli-ref/service-account/list-operations.md)

 - [remove-access-binding](cli-ref/service-account/remove-access-binding.md)

 - [remove-labels](cli-ref/service-account/remove-labels.md)

 - [set-access-bindings](cli-ref/service-account/set-access-bindings.md)

 - [update](cli-ref/service-account/update.md)

### service-control

 - [Overview](cli-ref/service-control/index.md)

 - [disable](cli-ref/service-control/disable.md)

 - [enable](cli-ref/service-control/enable.md)

 - [get](cli-ref/service-control/get.md)

 - [list](cli-ref/service-control/list.md)

### user-account

 - [Overview](cli-ref/user-account/index.md)

 - [get](cli-ref/user-account/get.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### access-analyzer

 - [Overview](cli-ref/v0/access-analyzer/index.md)

 - [list-subject-access-bindings](cli-ref/v0/access-analyzer/list-subject-access-bindings.md)

#### access-key

 - [Overview](cli-ref/v0/access-key/index.md)

 - [create](cli-ref/v0/access-key/create.md)

 - [delete](cli-ref/v0/access-key/delete.md)

 - [get](cli-ref/v0/access-key/get.md)

 - [issue-ephemeral](cli-ref/v0/access-key/issue-ephemeral.md)

 - [list](cli-ref/v0/access-key/list.md)

#### access-policy-template

 - [Overview](cli-ref/v0/access-policy-template/index.md)

 - [list](cli-ref/v0/access-policy-template/list.md)

#### api-key

 - [Overview](cli-ref/v0/api-key/index.md)

 - [create](cli-ref/v0/api-key/create.md)

 - [delete](cli-ref/v0/api-key/delete.md)

 - [get](cli-ref/v0/api-key/get.md)

 - [list](cli-ref/v0/api-key/list.md)

 - [list-scopes](cli-ref/v0/api-key/list-scopes.md)

 - [update](cli-ref/v0/api-key/update.md)

 - [create-id-token](cli-ref/v0/create-id-token.md)

 - [create-token](cli-ref/v0/create-token.md)

#### key

 - [Overview](cli-ref/v0/key/index.md)

 - [create](cli-ref/v0/key/create.md)

 - [delete](cli-ref/v0/key/delete.md)

 - [get](cli-ref/v0/key/get.md)

 - [list](cli-ref/v0/key/list.md)

#### oauth-client

 - [Overview](cli-ref/v0/oauth-client/index.md)

 - [create](cli-ref/v0/oauth-client/create.md)

 - [delete](cli-ref/v0/oauth-client/delete.md)

 - [get](cli-ref/v0/oauth-client/get.md)

 - [list](cli-ref/v0/oauth-client/list.md)

 - [update](cli-ref/v0/oauth-client/update.md)

#### oauth-client-secret

 - [Overview](cli-ref/v0/oauth-client-secret/index.md)

 - [create](cli-ref/v0/oauth-client-secret/create.md)

 - [delete](cli-ref/v0/oauth-client-secret/delete.md)

 - [get](cli-ref/v0/oauth-client-secret/get.md)

 - [list](cli-ref/v0/oauth-client-secret/list.md)

#### refresh-token

 - [Overview](cli-ref/v0/refresh-token/index.md)

 - [list](cli-ref/v0/refresh-token/list.md)

 - [revoke](cli-ref/v0/refresh-token/revoke.md)

 - [revoke-token](cli-ref/v0/revoke-token.md)

#### role

 - [Overview](cli-ref/v0/role/index.md)

 - [get](cli-ref/v0/role/get.md)

 - [list](cli-ref/v0/role/list.md)

#### service-account

 - [Overview](cli-ref/v0/service-account/index.md)

 - [add-access-binding](cli-ref/v0/service-account/add-access-binding.md)

 - [add-labels](cli-ref/v0/service-account/add-labels.md)

 - [create](cli-ref/v0/service-account/create.md)

 - [delete](cli-ref/v0/service-account/delete.md)

 - [get](cli-ref/v0/service-account/get.md)

 - [list](cli-ref/v0/service-account/list.md)

 - [list-access-bindings](cli-ref/v0/service-account/list-access-bindings.md)

 - [list-operations](cli-ref/v0/service-account/list-operations.md)

 - [remove-access-binding](cli-ref/v0/service-account/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/service-account/remove-labels.md)

 - [set-access-bindings](cli-ref/v0/service-account/set-access-bindings.md)

 - [update](cli-ref/v0/service-account/update.md)

#### service-control

 - [Overview](cli-ref/v0/service-control/index.md)

 - [disable](cli-ref/v0/service-control/disable.md)

 - [enable](cli-ref/v0/service-control/enable.md)

 - [get](cli-ref/v0/service-control/get.md)

 - [list](cli-ref/v0/service-control/list.md)

#### user-account

 - [Overview](cli-ref/v0/user-account/index.md)

 - [get](cli-ref/v0/user-account/get.md)

 - [whoami](cli-ref/v0/whoami.md)

#### workload-identity

 - [Overview](cli-ref/v0/workload-identity/index.md)

##### federated-credential

 - [Overview](cli-ref/v0/workload-identity/federated-credential/index.md)

 - [create](cli-ref/v0/workload-identity/federated-credential/create.md)

 - [delete](cli-ref/v0/workload-identity/federated-credential/delete.md)

 - [get](cli-ref/v0/workload-identity/federated-credential/get.md)

 - [list](cli-ref/v0/workload-identity/federated-credential/list.md)

##### oidc

 - [Overview](cli-ref/v0/workload-identity/oidc/index.md)

###### federation

 - [Overview](cli-ref/v0/workload-identity/oidc/federation/index.md)

 - [add-access-binding](cli-ref/v0/workload-identity/oidc/federation/add-access-binding.md)

 - [add-audiences](cli-ref/v0/workload-identity/oidc/federation/add-audiences.md)

 - [add-labels](cli-ref/v0/workload-identity/oidc/federation/add-labels.md)

 - [create](cli-ref/v0/workload-identity/oidc/federation/create.md)

 - [delete](cli-ref/v0/workload-identity/oidc/federation/delete.md)

 - [get](cli-ref/v0/workload-identity/oidc/federation/get.md)

 - [list](cli-ref/v0/workload-identity/oidc/federation/list.md)

 - [list-access-bindings](cli-ref/v0/workload-identity/oidc/federation/list-access-bindings.md)

 - [remove-access-binding](cli-ref/v0/workload-identity/oidc/federation/remove-access-binding.md)

 - [remove-audiences](cli-ref/v0/workload-identity/oidc/federation/remove-audiences.md)

 - [remove-labels](cli-ref/v0/workload-identity/oidc/federation/remove-labels.md)

 - [set-access-bindings](cli-ref/v0/workload-identity/oidc/federation/set-access-bindings.md)

 - [update](cli-ref/v0/workload-identity/oidc/federation/update.md)

 - [whoami](cli-ref/whoami.md)

### workload-identity

 - [Overview](cli-ref/workload-identity/index.md)

#### federated-credential

 - [Overview](cli-ref/workload-identity/federated-credential/index.md)

 - [create](cli-ref/workload-identity/federated-credential/create.md)

 - [delete](cli-ref/workload-identity/federated-credential/delete.md)

 - [get](cli-ref/workload-identity/federated-credential/get.md)

 - [list](cli-ref/workload-identity/federated-credential/list.md)

#### oidc

 - [Overview](cli-ref/workload-identity/oidc/index.md)

##### federation

 - [Overview](cli-ref/workload-identity/oidc/federation/index.md)

 - [add-access-binding](cli-ref/workload-identity/oidc/federation/add-access-binding.md)

 - [add-audiences](cli-ref/workload-identity/oidc/federation/add-audiences.md)

 - [add-labels](cli-ref/workload-identity/oidc/federation/add-labels.md)

 - [create](cli-ref/workload-identity/oidc/federation/create.md)

 - [delete](cli-ref/workload-identity/oidc/federation/delete.md)

 - [get](cli-ref/workload-identity/oidc/federation/get.md)

 - [list](cli-ref/workload-identity/oidc/federation/list.md)

 - [list-access-bindings](cli-ref/workload-identity/oidc/federation/list-access-bindings.md)

 - [remove-access-binding](cli-ref/workload-identity/oidc/federation/remove-access-binding.md)

 - [remove-audiences](cli-ref/workload-identity/oidc/federation/remove-audiences.md)

 - [remove-labels](cli-ref/workload-identity/oidc/federation/remove-labels.md)

 - [set-access-bindings](cli-ref/workload-identity/oidc/federation/set-access-bindings.md)

 - [update](cli-ref/workload-identity/oidc/federation/update.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### AccessAnalyzer

 - [Overview](api-ref/grpc/AccessAnalyzer/index.md)

 - [ListSubjectAccessBindings](api-ref/grpc/AccessAnalyzer/listSubjectAccessBindings.md)

#### AccessPolicyTemplate

 - [Overview](api-ref/grpc/AccessPolicyTemplate/index.md)

 - [List](api-ref/grpc/AccessPolicyTemplate/list.md)

#### ApiKey

 - [Overview](api-ref/grpc/ApiKey/index.md)

 - [List](api-ref/grpc/ApiKey/list.md)

 - [Get](api-ref/grpc/ApiKey/get.md)

 - [Create](api-ref/grpc/ApiKey/create.md)

 - [Update](api-ref/grpc/ApiKey/update.md)

 - [Delete](api-ref/grpc/ApiKey/delete.md)

 - [ListOperations](api-ref/grpc/ApiKey/listOperations.md)

 - [ListScopes](api-ref/grpc/ApiKey/listScopes.md)

#### IamToken

 - [Overview](api-ref/grpc/IamToken/index.md)

 - [Create](api-ref/grpc/IamToken/create.md)

 - [CreateForServiceAccount](api-ref/grpc/IamToken/createForServiceAccount.md)

 - [Revoke](api-ref/grpc/IamToken/revoke.md)

#### Key

 - [Overview](api-ref/grpc/Key/index.md)

 - [Get](api-ref/grpc/Key/get.md)

 - [List](api-ref/grpc/Key/list.md)

 - [Create](api-ref/grpc/Key/create.md)

 - [Update](api-ref/grpc/Key/update.md)

 - [Delete](api-ref/grpc/Key/delete.md)

 - [ListOperations](api-ref/grpc/Key/listOperations.md)

#### OAuthClientSecret

 - [Overview](api-ref/grpc/OAuthClientSecret/index.md)

 - [Get](api-ref/grpc/OAuthClientSecret/get.md)

 - [List](api-ref/grpc/OAuthClientSecret/list.md)

 - [Create](api-ref/grpc/OAuthClientSecret/create.md)

 - [Delete](api-ref/grpc/OAuthClientSecret/delete.md)

#### OAuthClient

 - [Overview](api-ref/grpc/OAuthClient/index.md)

 - [Get](api-ref/grpc/OAuthClient/get.md)

 - [List](api-ref/grpc/OAuthClient/list.md)

 - [Create](api-ref/grpc/OAuthClient/create.md)

 - [Update](api-ref/grpc/OAuthClient/update.md)

 - [Delete](api-ref/grpc/OAuthClient/delete.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### RefreshToken

 - [Overview](api-ref/grpc/RefreshToken/index.md)

 - [List](api-ref/grpc/RefreshToken/list.md)

 - [Revoke](api-ref/grpc/RefreshToken/revoke.md)

#### Role

 - [Overview](api-ref/grpc/Role/index.md)

 - [Get](api-ref/grpc/Role/get.md)

 - [List](api-ref/grpc/Role/list.md)

#### ServiceAccount

 - [Overview](api-ref/grpc/ServiceAccount/index.md)

 - [Get](api-ref/grpc/ServiceAccount/get.md)

 - [List](api-ref/grpc/ServiceAccount/list.md)

 - [Create](api-ref/grpc/ServiceAccount/create.md)

 - [Update](api-ref/grpc/ServiceAccount/update.md)

 - [Delete](api-ref/grpc/ServiceAccount/delete.md)

 - [ListAccessBindings](api-ref/grpc/ServiceAccount/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/ServiceAccount/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/ServiceAccount/updateAccessBindings.md)

 - [ListOperations](api-ref/grpc/ServiceAccount/listOperations.md)

#### ServiceControl

 - [Overview](api-ref/grpc/ServiceControl/index.md)

 - [Get](api-ref/grpc/ServiceControl/get.md)

 - [List](api-ref/grpc/ServiceControl/list.md)

 - [Enable](api-ref/grpc/ServiceControl/enable.md)

 - [Disable](api-ref/grpc/ServiceControl/disable.md)

 - [ResolveAgent](api-ref/grpc/ServiceControl/resolveAgent.md)

#### UserAccount

 - [Overview](api-ref/grpc/UserAccount/index.md)

 - [Get](api-ref/grpc/UserAccount/get.md)

#### YandexPassportUserAccount

 - [Overview](api-ref/grpc/YandexPassportUserAccount/index.md)

 - [GetByLogin](api-ref/grpc/YandexPassportUserAccount/getByLogin.md)

#### Access Key

 - [Overview](awscompatibility/api-ref/grpc/index.md)

##### AccessKey

 - [Overview](awscompatibility/api-ref/grpc/AccessKey/index.md)

 - [List](awscompatibility/api-ref/grpc/AccessKey/list.md)

 - [Get](awscompatibility/api-ref/grpc/AccessKey/get.md)

 - [Create](awscompatibility/api-ref/grpc/AccessKey/create.md)

 - [Update](awscompatibility/api-ref/grpc/AccessKey/update.md)

 - [Delete](awscompatibility/api-ref/grpc/AccessKey/delete.md)

 - [ListOperations](awscompatibility/api-ref/grpc/AccessKey/listOperations.md)

##### Operation

 - [Overview](awscompatibility/api-ref/grpc/Operation/index.md)

 - [Get](awscompatibility/api-ref/grpc/Operation/get.md)

 - [Cancel](awscompatibility/api-ref/grpc/Operation/cancel.md)

##### TemporaryAccessKey

 - [Overview](awscompatibility/api-ref/grpc/TemporaryAccessKey/index.md)

 - [CreateEphemeral](awscompatibility/api-ref/grpc/TemporaryAccessKey/createEphemeral.md)

#### Workload Identity

 - [Overview](workload/workload-identity/api-ref/grpc/index.md)

##### FederatedCredential

 - [Overview](workload/workload-identity/api-ref/grpc/FederatedCredential/index.md)

 - [Get](workload/workload-identity/api-ref/grpc/FederatedCredential/get.md)

 - [List](workload/workload-identity/api-ref/grpc/FederatedCredential/list.md)

 - [Create](workload/workload-identity/api-ref/grpc/FederatedCredential/create.md)

 - [Delete](workload/workload-identity/api-ref/grpc/FederatedCredential/delete.md)

##### Operation

 - [Overview](workload/workload-identity/api-ref/grpc/Operation/index.md)

 - [Get](workload/workload-identity/api-ref/grpc/Operation/get.md)

 - [Cancel](workload/workload-identity/api-ref/grpc/Operation/cancel.md)

##### Federation

 - [Overview](workload/oidc/workload-identity/api-ref/grpc/index.md)

###### Federation

 - [Overview](workload/oidc/workload-identity/api-ref/grpc/Federation/index.md)

 - [Get](workload/oidc/workload-identity/api-ref/grpc/Federation/get.md)

 - [Create](workload/oidc/workload-identity/api-ref/grpc/Federation/create.md)

 - [Update](workload/oidc/workload-identity/api-ref/grpc/Federation/update.md)

 - [Delete](workload/oidc/workload-identity/api-ref/grpc/Federation/delete.md)

 - [List](workload/oidc/workload-identity/api-ref/grpc/Federation/list.md)

 - [ListAccessBindings](workload/oidc/workload-identity/api-ref/grpc/Federation/listAccessBindings.md)

 - [SetAccessBindings](workload/oidc/workload-identity/api-ref/grpc/Federation/setAccessBindings.md)

 - [UpdateAccessBindings](workload/oidc/workload-identity/api-ref/grpc/Federation/updateAccessBindings.md)

###### Operation

 - [Overview](workload/oidc/workload-identity/api-ref/grpc/Operation/index.md)

 - [Get](workload/oidc/workload-identity/api-ref/grpc/Operation/get.md)

 - [Cancel](workload/oidc/workload-identity/api-ref/grpc/Operation/cancel.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### AccessAnalyzer

 - [Overview](api-ref/AccessAnalyzer/index.md)

 - [ListSubjectAccessBindings](api-ref/AccessAnalyzer/listSubjectAccessBindings.md)

#### AccessPolicyTemplate

 - [Overview](api-ref/AccessPolicyTemplate/index.md)

 - [List](api-ref/AccessPolicyTemplate/list.md)

#### ApiKey

 - [Overview](api-ref/ApiKey/index.md)

 - [List](api-ref/ApiKey/list.md)

 - [Get](api-ref/ApiKey/get.md)

 - [Create](api-ref/ApiKey/create.md)

 - [Update](api-ref/ApiKey/update.md)

 - [Delete](api-ref/ApiKey/delete.md)

 - [ListOperations](api-ref/ApiKey/listOperations.md)

 - [ListScopes](api-ref/ApiKey/listScopes.md)

#### IamToken

 - [Overview](api-ref/IamToken/index.md)

 - [Create](api-ref/IamToken/create.md)

 - [CreateForServiceAccount](api-ref/IamToken/createForServiceAccount.md)

 - [Revoke](api-ref/IamToken/revoke.md)

#### Key

 - [Overview](api-ref/Key/index.md)

 - [Get](api-ref/Key/get.md)

 - [List](api-ref/Key/list.md)

 - [Create](api-ref/Key/create.md)

 - [Update](api-ref/Key/update.md)

 - [Delete](api-ref/Key/delete.md)

 - [ListOperations](api-ref/Key/listOperations.md)

#### OAuthClientSecret

 - [Overview](api-ref/OAuthClientSecret/index.md)

 - [Get](api-ref/OAuthClientSecret/get.md)

 - [List](api-ref/OAuthClientSecret/list.md)

 - [Create](api-ref/OAuthClientSecret/create.md)

 - [Delete](api-ref/OAuthClientSecret/delete.md)

#### OAuthClient

 - [Overview](api-ref/OAuthClient/index.md)

 - [Get](api-ref/OAuthClient/get.md)

 - [List](api-ref/OAuthClient/list.md)

 - [Create](api-ref/OAuthClient/create.md)

 - [Update](api-ref/OAuthClient/update.md)

 - [Delete](api-ref/OAuthClient/delete.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### RefreshToken

 - [Overview](api-ref/RefreshToken/index.md)

 - [List](api-ref/RefreshToken/list.md)

 - [Revoke](api-ref/RefreshToken/revoke.md)

#### Role

 - [Overview](api-ref/Role/index.md)

 - [Get](api-ref/Role/get.md)

 - [List](api-ref/Role/list.md)

#### ServiceAccount

 - [Overview](api-ref/ServiceAccount/index.md)

 - [Get](api-ref/ServiceAccount/get.md)

 - [List](api-ref/ServiceAccount/list.md)

 - [Create](api-ref/ServiceAccount/create.md)

 - [Update](api-ref/ServiceAccount/update.md)

 - [Delete](api-ref/ServiceAccount/delete.md)

 - [ListAccessBindings](api-ref/ServiceAccount/listAccessBindings.md)

 - [SetAccessBindings](api-ref/ServiceAccount/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/ServiceAccount/updateAccessBindings.md)

 - [ListOperations](api-ref/ServiceAccount/listOperations.md)

#### ServiceControl

 - [Overview](api-ref/ServiceControl/index.md)

 - [Get](api-ref/ServiceControl/get.md)

 - [List](api-ref/ServiceControl/list.md)

 - [Enable](api-ref/ServiceControl/enable.md)

 - [Disable](api-ref/ServiceControl/disable.md)

 - [ResolveAgent](api-ref/ServiceControl/resolveAgent.md)

#### UserAccount

 - [Overview](api-ref/UserAccount/index.md)

 - [Get](api-ref/UserAccount/get.md)

#### YandexPassportUserAccount

 - [Overview](api-ref/YandexPassportUserAccount/index.md)

 - [GetByLogin](api-ref/YandexPassportUserAccount/getByLogin.md)

#### Access Key

 - [Overview](awscompatibility/api-ref/index.md)

##### AccessKey

 - [Overview](awscompatibility/api-ref/AccessKey/index.md)

 - [List](awscompatibility/api-ref/AccessKey/list.md)

 - [Get](awscompatibility/api-ref/AccessKey/get.md)

 - [Create](awscompatibility/api-ref/AccessKey/create.md)

 - [Update](awscompatibility/api-ref/AccessKey/update.md)

 - [Delete](awscompatibility/api-ref/AccessKey/delete.md)

 - [ListOperations](awscompatibility/api-ref/AccessKey/listOperations.md)

##### Operation

 - [Overview](awscompatibility/api-ref/Operation/index.md)

 - [Get](awscompatibility/api-ref/Operation/get.md)

 - [Cancel](awscompatibility/api-ref/Operation/cancel.md)

##### TemporaryAccessKey

 - [Overview](awscompatibility/api-ref/TemporaryAccessKey/index.md)

 - [CreateEphemeral](awscompatibility/api-ref/TemporaryAccessKey/createEphemeral.md)

#### Workload Identity

 - [Overview](workload/workload-identity/api-ref/index.md)

##### FederatedCredential

 - [Overview](workload/workload-identity/api-ref/FederatedCredential/index.md)

 - [Get](workload/workload-identity/api-ref/FederatedCredential/get.md)

 - [List](workload/workload-identity/api-ref/FederatedCredential/list.md)

 - [Create](workload/workload-identity/api-ref/FederatedCredential/create.md)

 - [Delete](workload/workload-identity/api-ref/FederatedCredential/delete.md)

##### Operation

 - [Overview](workload/workload-identity/api-ref/Operation/index.md)

 - [Get](workload/workload-identity/api-ref/Operation/get.md)

 - [Cancel](workload/workload-identity/api-ref/Operation/cancel.md)

##### Federation

 - [Overview](workload/oidc/workload-identity/api-ref/index.md)

###### Federation

 - [Overview](workload/oidc/workload-identity/api-ref/Federation/index.md)

 - [Get](workload/oidc/workload-identity/api-ref/Federation/get.md)

 - [Create](workload/oidc/workload-identity/api-ref/Federation/create.md)

 - [Update](workload/oidc/workload-identity/api-ref/Federation/update.md)

 - [Delete](workload/oidc/workload-identity/api-ref/Federation/delete.md)

 - [List](workload/oidc/workload-identity/api-ref/Federation/list.md)

 - [ListAccessBindings](workload/oidc/workload-identity/api-ref/Federation/listAccessBindings.md)

 - [SetAccessBindings](workload/oidc/workload-identity/api-ref/Federation/setAccessBindings.md)

 - [UpdateAccessBindings](workload/oidc/workload-identity/api-ref/Federation/updateAccessBindings.md)

###### Operation

 - [Overview](workload/oidc/workload-identity/api-ref/Operation/index.md)

 - [Get](workload/oidc/workload-identity/api-ref/Operation/get.md)

 - [Cancel](workload/oidc/workload-identity/api-ref/Operation/cancel.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [История изменений](release-notes.md)

## Вопросы и ответы

 - [Общие вопросы](qa/general.md)

 - [Вход в систему и доступ к ресурсам](qa/access.md)

 - [Все вопросы на одной странице](qa/index.md)

 - [Обучающие курсы](training.md)