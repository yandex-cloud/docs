---
title: "Вопросы и ответы про {{ mgl-full-name }}"
description: "На странице представлены вопросы и ответы про {{ mgl-name }}."
---

# Общие вопросы про {{ mgl-name }}

#### Можно ли интегрировать провайдеров аутентификации для {{ GL }}? {#auth-provider}

Да, для этого [настройте OmniAuth](../operations/omniauth.md).

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

#### Как импортировать проект из gitlab.com в {{ mgl-name }}?

Воспользуйтесь инструкцией по импорту и экспорту проектов в [документации {{ GL }}]({{ gl.docs }}/ee/user/project/settings/import_export.html).

Если по какой-то причине этот способ вам не подходит, выполните настройку интеграции сервера согласно [инструкции]({{ gl.docs }}/ee/integration/gitlab.html) и обратитесь в [техническую поддержку]({{ link-console-support }}) {{ yandex-cloud }}, указав полученные значения `Application ID` и `Secret`, а также другие желаемые параметры.
