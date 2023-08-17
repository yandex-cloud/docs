# Общие вопросы про {{ mgl-name }}

#### Можно ли интегрировать провайдеров аутентификации для {{ GL }}? {#auth-provider}

Да, для этого [настройте OmniAuth](../operations/omniauth.md).

#### Почему не получается отправить изменения в репозиторий {{ mgl-name }}? {#push}

Тексты ошибок:

```text
You are not allowed to push code to this project.
```

```text
You are not allowed to push code to protected branches on this project.
```

Чтобы отправлять изменения в репозиторий {{ mgl-name }}, [назначьте](https://docs.gitlab.com/ee/user/project/members/#add-users-to-a-project) пользователю необходимую роль в проекте. Для отправки:

* В защищенные ветки (например `main`) — `Maintainer` или `Owner`.
* В незащищенные — `Developer`, `Maintainer` или `Owner`.

Пользователи с ролями `Guest` и `Reporter` отправлять изменения не могут.

{% note info %}

В сервисе {{ mgl-name }} имя ветки по-умолчанию — `main`. Обращение к ветке `master` приведет к ошибке доступа, если эта ветка еще не создана вами вручную.

{% endnote %}

Подробнее о ролях см. в [документации GitLab](https://docs.gitlab.com/ee/user/permissions.html).
