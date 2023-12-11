---
title: "Как работает связь между {{ tracker-full-name }} и {{ GL }}"
description: "Из статьи вы узнаете, как работает связь между {{ tracker-name }} и {{ GL }}."
---

# {{ GL }}

## Настроить связь {#relation}


В [задачах {{ tracker-name }}](../about-tracker.md#zadacha) можно автоматически добавлять ссылки на [Merge Requests]({{ gl.docs }}/ee/user/project/merge_requests/) из {{ GL }}, указывая [ключ](../glossary.md#key) нужной задачи в названии или описании нового Merge Request. Ссылки будут размещаться в разделе [{{ ui-key.startrek.ui_components_issue-links_ExternalLinksCollapse.external-relations}}](../external-links.md).

Дополнительно можно включить автоматическое создание комментариев в задаче с информацией о Merge Requests. Автоматическое комментирование доступно только для [{{ mgl-name }}](../../managed-gitlab/).

{% include [create hook](../../_includes/managed-gitlab/create-hook.md) %}

{% include [test hook](../../_includes/managed-gitlab/test-hook.md) %}

### См. также {#see-also}

* [Практическое руководство по интеграции {{ GL }} с {{ tracker-full-name }}](../../managed-gitlab/tutorials/tracker-integration.md).

## Подключить репозиторий {#repo}

Чтобы подключить репозиторий на [GitLab](https://gitlab.com) к {{ tracker-name }}:

{% note info %}

Закрытый репозиторий доступен только авторизованным пользователям GitLab (**Internal project**) или команде проекта (**Private project**).

{% endnote %}

1. {% include [make sure you are admin](../../_includes/tracker/make-sure-admin.md) %}

1. {% include [path to the repository](../../_includes/tracker/repository-path.md) %}

1. В поле **Платформа** выберите GitLab.

1. Получите на GitLab OAuth-токен для своего репозитория. Подробную инструкцию о том, как получить токен, читайте в [документации GitLab](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html#create-a-personal-access-token). Для корректной работы {{ tracker-name }} при настройке разрешения включите опции **read_repository** и **read_api**.

1. Укажите адрес репозитория в формате `https://gitlab.com/<логин владельца репозитория>/<имя репозитория>` и токен для подключения.

1. Нажмите кнопку **Подключить**.

1. Убедитесь, что статус репозитория отображается в {{ tracker-name }} как **Подключен**.

{% include [commits](../../_includes/tracker/add_commits.md) %}

## Собственный сервер {#on-premise}

{% include [on-premise server](../../_includes/tracker/on-premise-server.md) %}

