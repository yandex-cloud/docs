---
title: Источники DAG-файлов в {{ maf-full-name }}
description: Узнайте, как {{ maf-name }} загружает DAG-файлы из бакета {{ objstorage-name }} или Git-репозитория и какие способы аутентификации поддерживаются.
---

# Источники DAG-файлов

Кластер {{ maf-name }} автоматически загружает [DAG-файлы](index.md#about-the-service) из внешнего источника: бакета {{ objstorage-full-name }} или Git-репозитория. Для кластера выбирается один источник. Его тип и параметры подключения задаются при [создании](../operations/cluster-create.md) или [изменении кластера](../operations/cluster-update.md).

## Бакет {{ objstorage-name }} {#object-storage}

В бакете хранятся DAG-файлы, а также дополнительные скрипты и модули, которые используются в DAG. Файлы могут находиться в корне бакета или в папке. Кластер автоматически загружает их из выбранного бакета.

## Git-репозиторий {#git}

Для подключения к Git-репозиторию задаются его адрес, имя ветки и путь к каталогу с DAG-файлами. Кластер загружает файлы из указанного каталога выбранной ветки.

{% include [git-sync-network](../../_includes/mdb/maf/note-git-sync-network.md) %}

### Способы аутентификации {#git-auth}

Способ аутентификации определяет формат адреса репозитория и необходимые учетные данные:

{% list tabs %}

- SSH-ключ

    Для подключения по SSH используется адрес в формате `git@<хост>:<путь_к_репозиторию>.git`, например `git@github.com:<имя_пользователя>/<имя_репозитория>.git`, и закрытый SSH-ключ доступа к репозиторию.

    {% include [git-sync-ssh](../../_includes/mdb/maf/note-git-sync-ssh.md) %}

- Логин и пароль

    Для подключения по HTTP(S) используется адрес в формате `https://<хост>/<путь_к_репозиторию>.git` или `http://<хост>/<путь_к_репозиторию>.git`, например `https://github.com/<имя_пользователя>/<имя_репозитория>.git`, а также имя пользователя и пароль.

    Вместо пароля можно передать [токен доступа](#git-token), если его поддерживает сервис, в котором размещен репозиторий. Имя пользователя и пароль или токен должны быть непустыми. Учетные данные задаются в отдельных параметрах подключения, а не в адресе репозитория.

{% endlist %}

### Аутентификация с помощью токена {#git-token}

Токен доступа передается в параметре пароля при подключении по HTTPS. Токен создается в сервисе, в котором размещен репозиторий, и должен предоставлять права на чтение репозитория с DAG-файлами. Токен позволяет ограничить права доступа по сравнению с паролем учетной записи.

Имя пользователя зависит от сервиса и типа токена. Ниже приведены примеры и ссылки на документацию сервисов:

#|
|| **Сервис** | **Тип токена** | **Имя пользователя** ||
|| GitHub | [Personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#using-a-personal-access-token-on-the-command-line) | Логин пользователя GitHub. Имя должно быть непустым, хотя для аутентификации используется сам токен. ||
|| GitLab | [Personal access token](https://docs.gitlab.com/user/profile/personal_access_tokens/#clone-repository-using-personal-access-token) | Любая непустая строка, например логин пользователя GitLab или `oauth2`. ||
|| GitLab | [Deploy token](https://docs.gitlab.com/user/project/deploy_tokens/) | Имя, заданное при создании токена. По умолчанию имеет вид `gitlab+deploy-token-<номер>`. ||
|| GitLab | [OAuth access token](https://docs.gitlab.com/api/oauth2/) | `oauth2`. ||
|| Bitbucket Cloud | [API token](https://support.atlassian.com/bitbucket-cloud/docs/using-api-tokens/) | Логин пользователя Bitbucket с учетом регистра или `x-bitbucket-api-token-auth`. ||
|| Bitbucket Cloud | Access token [репозитория](https://support.atlassian.com/bitbucket-cloud/docs/using-access-tokens/) или [проекта](https://support.atlassian.com/bitbucket-cloud/docs/using-project-access-tokens/) | `x-token-auth`. ||
|| Azure DevOps | [Personal access token](https://learn.microsoft.com/en-us/azure/devops/repos/git/auth-overview?view=azure-devops#personal-access-tokens-alternative-option) | Любая непустая строка, например `git`. ||
|#

Если токен истек или был отозван, создайте новый и обновите параметры подключения в [настройках кластера](../operations/cluster-update.md).

## Примеры использования {#examples}

* [{#T}](../tutorials/data-processing-automation.md)
* [{#T}](../tutorials/airflow-auto-tasks.md)

#### Полезные ссылки {#see-also}

[Загрузка DAG-файлов в кластер](../operations/upload-dags.md)
