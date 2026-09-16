Интеграция с {{ src-name }} Security позволяет проверять безопасность кода из [инстанса {{ mgl-name }}](../../managed-gitlab/concepts/index.md#instance). Репозитории инстанса автоматически зеркалируются в {{ src-name }}, где выполняются проверки и отображаются их результаты.

Для инстансов {{ mgl-name }} доступна вся функциональность [{{ src-name }} Security]({{ link-src-docs }}/sourcecraft/security/security-overview):

* [Сканирование секретов]({{ link-src-docs }}/sourcecraft/security/security-overview#secret-scanning) — поиск ключей API, токенов, паролей и других чувствительных данных в истории коммитов.
* [Анализ зависимостей (SCA)]({{ link-src-docs }}/sourcecraft/security/security-overview#supply-chain) — выявление известных уязвимостей в сторонних компонентах и проверка их лицензий.
* [Статический анализ кода (SAST)]({{ link-src-docs }}/sourcecraft/security/security-overview#sast) — поиск уязвимостей, ошибок и нарушений стандартов безопасности без запуска кода.
* [Анализ и приоритизация уязвимостей с помощью ИИ]({{ link-src-docs }}/sourcecraft/security/security-overview#ca-triage) — оценка рисков и рекомендации по исправлению найденных проблем.
* [История сканирований]({{ link-src-docs }}/sourcecraft/security/security-overview#history) и [центр контроля уязвимостей]({{ link-src-docs }}/sourcecraft/operations/security-dashboard) — просмотр запусков проверок и результатов для отдельных репозиториев и всей организации.

{% include [sourcecraft-security-notes](sourcecraft-security-notes.md) %}

## Алгоритм интеграции {#scanning}

После включения интеграции сервис создает приватные копии репозиториев инстанса в {{ src-name }} и синхронизирует с ними код. Новые репозитории инстанса также синхронизируются с {{ src-name }}. Проверки выполняются в зеркалируемых репозиториях в {{ src-name }}.

{% note info %}

Сканирования запускаются при поступлении коммитов в [ветку]({{ link-src-docs }}/sourcecraft/concepts/#repos) по умолчанию исходного репозитория {{ GL }}. После синхронизации кода результаты доступны в соответствующем репозитории {{ src-name }} и в центре контроля уязвимостей организации.

{% endnote %}

Чтобы предоставить разработчикам доступ к зеркалируемым репозиториям и результатам проверок, [пригласите их в организацию {{ src-name }}]({{ link-src-docs }}/sourcecraft/security/invite) и [назначьте роли]({{ link-src-docs }}/sourcecraft/security/bind) на нужные репозитории или организацию.

## Названия и адреса зеркалируемых репозиториев в {{ src-name }} {#repository-paths}

Группы и проекты {{ GL }} отличаются от [проектов {{ src-name }}]({{ link-src-docs }}/sourcecraft/concepts/#projects). При зеркалировании путь репозитория {{ GL }} преобразуется в имя репозитория {{ src-name }}: название группы или имя пользователя, название подгруппы и название репозитория соединяются дефисами.

Адрес в {{ GL }}:

```text
https://<домен_инстанса>/<группа_или_пользователь>/<подгруппа>/<репозиторий>
```

Адрес зеркалируемого репозитория в {{ src-name }}:

```text
https://sourcecraft.dev/<слаг_организации>/<группа_или_пользователь>-<подгруппа>-<репозиторий>
```

Подгруппа необязательна: если ее нет, соответствующий фрагмент адреса опускается. _Слаг организации_ — ее идентификатор в адресах {{ src-name }}, который можно посмотреть в [настройках организации]({{ link-src-docs }}/sourcecraft/operations/org-edit).

> Примеры преобразования адресов репозиториев инстанса {{ GL }} на домене `example.gitlab.yandexcloud.net` в организации со слагом `my-org`:
> 
> #|
> || {{ GL }} | `https://example.gitlab.yandexcloud.net/test-group/test-subgroup/example-repo` ||
> || {{ src-name }} | `https://sourcecraft.dev/my-org/test-group-test-subgroup-example-repo` ||
> |#
> 
> #|
> || {{ GL }} | `https://example.gitlab.yandexcloud.net/example-user/my-project` ||
> || {{ src-name }} | `https://sourcecraft.dev/my-org/example-user-my-project` ||
> |#
> 
> #|
> || {{ GL }} | `https://example.gitlab.yandexcloud.net/test-group/test-project` ||
> || {{ src-name }} | `https://sourcecraft.dev/my-org/test-group-test-project` ||
> |#

#### Полезные ссылки {#see-also}

* [Настроить интеграцию {{ mgl-name }} с {{ src-name }} Security](../../managed-gitlab/operations/sourcecraft-security.md).
* [Безопасность в {{ src-name }}]({{ link-src-docs }}/sourcecraft/security/security-overview).
