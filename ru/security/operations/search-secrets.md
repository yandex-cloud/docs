# Поиск секретов {{ yandex-cloud }} в открытых источниках

{{ yandex-cloud }} ищет следующие типы секретов в открытых источниках:

* [API-ключи](../../iam/concepts/authorization/api-key.md).
* [{{ iam-short-name }} Cookies](../../iam/concepts/authorization/cookie.md).
* [{{ iam-short-name }}-токены](../../iam/concepts/authorization/iam-token.md).
* [Статические ключи доступа](../../iam/concepts/authorization/access-key.md).
* [OAuth-токен](../../iam/concepts/authorization/oauth-token.md).

{{ yandex-cloud }} подключен к следующим программам поиска секретов:

* [GitHub Secret scanning partner program](#github-secret-scanning).
* [GitLab Secret Detection](#gitlab-secret-detection).
* [Поисковый индекс Яндекс](#secret-is-leaked).

## GitHub {#github-secret-scanning}

{{ yandex-cloud }} подключен к [secret scanning partner program](https://docs.github.com/en/developers/overview/secret-scanning-partner-program), чтобы уменьшить риски пользователей от утечек секретов в публичные репозитории.

По умолчанию GitHub ищет секреты {{ yandex-cloud }} в публичных репозиториях и отправляет все подозрительные фрагменты в {{ yandex-cloud }}.

В публичных репозиториях поиск выполняется автоматически. [Включить secret scanning](https://docs.github.com/en/code-security/secret-scanning/configuring-secret-scanning-for-your-repositories) для приватного репозитория может администратор репозитория или владелец организации.

## GitLab {#gitlab-secret-detection}

[Стандартный список](https://gitlab.com/gitlab-org/security-products/analyzers/secrets/-/blob/master/gitleaks.toml) шаблонов секретов для [Secret Detection](https://docs.gitlab.com/ee/user/application_security/secret_detection/#enable-secret-detection-using-a-merge-request) включает секреты {{ yandex-cloud }}.

Чтобы включить Secret Detection для вашего проекта, следуйте [инструкции](https://docs.gitlab.com/ee/user/application_security/secret_detection/#enable-secret-detection-using-a-merge-request).

## Поисковый индекс Яндекс {#search-index-detection}

{{ yandex-cloud }} по умолчанию ищет секреты на страницах, которые проиндексированы поиском Яндекс.

## Как узнать, что секрет обнаружен {#secret-is-detected}

Если будет обнаружен валидный секрет, владельцу организации придет письмо c адреса технической поддержки {{ yandex-cloud }}. Письмо будет содержать часть обнаруженного секрета и адрес в интернете, где секрет был обнаружен.

Также {{ iam-name }} запишет в аудитный лог [событие](../../audit-trails/concepts/events.md#iam) `DetectLeakedCredential`.

## Что делать если секрет обнаружен {#secret-is-leaked}

Если ваш секрет попал в публичный репозиторий:

1. Перевыпустите или отзовите секрет по [инструкции](../../iam/operations/compromised-credentials.md). Удалите затронутые ресурсы при необходимости.
1. Удалите секрет из репозитория и истории коммитов по инструкции для [GitHub](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository) или [GitLab](https://docs.gitlab.com/ee/user/project/repository/reducing_the_repo_size_using_git.html#purge-files-from-repository-history).

{% note warning %}

{{ yandex-cloud }} не отзывает найденные секреты и не удаляет их из репозитория. Все действия над секретом выполняет только владелец секрета.

{% endnote %}

## Самостоятельный поиск секретов {#self-implemented-search}

Вы можете использовать следующие регулярные выражения, чтобы самостоятельно проверять свои репозитории:

* {{ iam-short-name }} Cookies

   ```regexp
   c1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}
   ```

* {{ iam-short-name }}-токены

   ```regexp
   t1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}
   ```

* API-ключи

   ```regexp
   AQVN[A-Za-z0-9_\-]{35,38}
   ```

* Статические ключи доступа

   ```regexp
   YC[a-zA-Z0-9_\-]{38}
   ```

* OAuth-токены

   ```regexp
   y[0-3]_[-_A-Za-z0-9]{55}
   ```

{% note info %}

С осторожностью используйте регулярные выражения, так как со временем форматы секретов могут измениться. В документации эти изменения могут отразиться с задержкой.

{% endnote %}
