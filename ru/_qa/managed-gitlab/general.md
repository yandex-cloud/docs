#### В чем преимущества {{ mgl-name }} перед пользовательской инсталляцией {{ GL }} Community Edition? {#advantages}

Основное преимущество {{ mgl-name }} заключается в том, что он позволяет сократить затраты на установку и администрирование {{ GL }}. Кроме того, в {{ mgl-name }} добавлена функциональность, которой нет в [Community Edition](https://about.gitlab.com/install/ce-or-ee/) (например, правила ревью кода). Подробнее читайте в разделе [Преимущества сервиса перед пользовательской инсталляцией {{ GL }}](../../managed-gitlab/concepts/managed-gitlab-vs-custom-installation.md).

#### Как перенести данные из {{ GL }} в {{ mgl-name }}? {#migration}

Вы можете перенести данные из пользовательской инсталляции {{ GL }} в сервис {{ mgl-name }}. О том, как это сделать, читайте в [инструкции](../../managed-gitlab/operations/instance/migration.md). Перед началом работы ознакомьтесь с [порядком предоставления услуги](../../managed-gitlab/concepts/migration.md).

Перенести данные из {{ GL }}.com в {{ mgl-name }} нельзя: миграция доступна только для {{ GL }}, установленного на сервер или локальный компьютер (self-managed {{ GL }}).

#### Можно ли интегрировать провайдеров аутентификации для {{ GL }}? {#auth-provider}

Да, для этого [настройте OmniAuth](../../managed-gitlab/operations/omniauth.md).

#### Можно ли использовать Яндекс ID или Яндекс 360 для аутентификации? {#auth-yandex-id}

Да, для этого в OmniAuth [добавьте провайдер](../../managed-gitlab/operations/omniauth.md#add-provider) с типом `Yandex ID` и укажите его [параметры](../../managed-gitlab/operations/omniauth.md#yandex-id).

#### Есть ли интеграция {{ GL }} с {{ tracker-full-name }}? {#tracker-integration}

Да, настройки интеграции описаны в разделе [Интеграция с {{ tracker-full-name }}](../../tracker/user/gitlab.md).

#### Почему не получается отправить изменения в репозиторий {{ mgl-name }}? {#push}

Тексты ошибок:

```text
You are not allowed to push code to this project.
```

```text
You are not allowed to push code to protected branches on this project.
```

Чтобы отправлять изменения в репозиторий {{ mgl-name }}, [назначьте]({{ gl.docs }}/ee/user/project/members/#add-users-to-a-project) пользователю необходимую роль в проекте. Для отправки:

* В защищенные ветки (например `master`) — `Maintainer` или `Owner`.
* В незащищенные — `Developer`, `Maintainer` или `Owner`.

Пользователи с ролями `Guest` и `Reporter` отправлять изменения не могут.

Подробнее о ролях см. в [документации {{ GL }}]({{ gl.docs }}/ee/user/permissions.html).

#### Я получаю ошибку `500 Internal Server Error` при открытии инстанса, в чем может быть проблема? {#500-error}

Дисковое пространство инстанса может быть переполнено. Для очистки дискового пространства и восстановления доступа к инстансу обратитесь в [техническую поддержку]({{ link-console-support }}).

Подробнее о том, как снизить вероятность переполнения дискового пространства инстанса, см. в [инструкции](../../managed-gitlab/operations/instance/clean-up-disk-space.md).
