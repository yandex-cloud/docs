[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for GitLab](../index.md) > [Концепции](index.md) > Интеграция с SourceCraft Security

# Интеграция Managed Service for GitLab с SourceCraft Security

Интеграция с SourceCraft Security позволяет проверять безопасность кода из [инстанса Managed Service for GitLab](index.md#instance). Репозитории инстанса автоматически зеркалируются в SourceCraft, где выполняются проверки и отображаются их результаты.

Для инстансов Managed Service for GitLab доступна вся функциональность [SourceCraft Security](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/security-overview):

* [Сканирование секретов](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/security-overview#secret-scanning) — поиск ключей API, токенов, паролей и других чувствительных данных в истории коммитов.
* [Анализ зависимостей (SCA)](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/security-overview#supply-chain) — выявление известных уязвимостей в сторонних компонентах и проверка их лицензий.
* [Статический анализ кода (SAST)](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/security-overview#sast) — поиск уязвимостей, ошибок и нарушений стандартов безопасности без запуска кода.
* [Анализ и приоритизация уязвимостей с помощью ИИ](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/security-overview#ca-triage) — оценка рисков и рекомендации по исправлению найденных проблем.
* [История сканирований](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/security-overview#history) и [центр контроля уязвимостей](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/security-dashboard) — просмотр запусков проверок и результатов для отдельных репозиториев и всей организации.

{% note warning %}

Для интеграции требуется платное дополнение _SourceCraft Security_. Стоимость определяется [правилами тарификации SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/pricing#additional).

Репозитории создаются в той же [организации Yandex Cloud](../../organization/concepts/organization.md), в которой находится инстанс GitLab. Эта организация может отличаться от [персональной организации](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#org), автоматически созданной при регистрации в SourceCraft. Убедитесь, что дополнение подключено именно к организации инстанса.

Включая интеграцию, вы подтверждаете передачу исходного кода в SourceCraft. Зеркалируются все репозитории инстанса GitLab, независимо от их настроек видимости. В SourceCraft зеркалируемые репозитории создаются [приватными](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#repo-visibility).

{% endnote %}

## Алгоритм интеграции {#scanning}

После включения интеграции сервис создает приватные копии репозиториев инстанса в SourceCraft и синхронизирует с ними код. Новые репозитории инстанса также синхронизируются с SourceCraft. Проверки выполняются в зеркалируемых репозиториях в SourceCraft.

{% note info %}

Сканирования запускаются при поступлении коммитов в [ветку](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#repos) по умолчанию исходного репозитория GitLab. После синхронизации кода результаты доступны в соответствующем репозитории SourceCraft и в центре контроля уязвимостей организации.

{% endnote %}

Чтобы предоставить разработчикам доступ к зеркалируемым репозиториям и результатам проверок, [пригласите их в организацию SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/invite) и [назначьте роли](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/bind) на нужные репозитории или организацию.

## Названия и адреса зеркалируемых репозиториев в SourceCraft {#repository-paths}

Группы и проекты GitLab отличаются от [проектов SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#projects). При зеркалировании путь репозитория GitLab преобразуется в имя репозитория SourceCraft: название группы или имя пользователя, название подгруппы и название репозитория соединяются дефисами.

Адрес в GitLab:

```text
https://<домен_инстанса>/<группа_или_пользователь>/<подгруппа>/<репозиторий>
```

Адрес зеркалируемого репозитория в SourceCraft:

```text
https://sourcecraft.dev/<слаг_организации>/<группа_или_пользователь>-<подгруппа>-<репозиторий>
```

Подгруппа необязательна: если ее нет, соответствующий фрагмент адреса опускается. _Слаг организации_ — ее идентификатор в адресах SourceCraft, который можно посмотреть в [настройках организации](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/org-edit).

> Примеры преобразования адресов репозиториев инстанса GitLab на домене `example.gitlab.yandexcloud.net` в организации со слагом `my-org`:
> 
> #|
> || GitLab | `https://example.gitlab.yandexcloud.net/test-group/test-subgroup/example-repo` ||
> || SourceCraft | `https://sourcecraft.dev/my-org/test-group-test-subgroup-example-repo` ||
> |#
> 
> #|
> || GitLab | `https://example.gitlab.yandexcloud.net/example-user/my-project` ||
> || SourceCraft | `https://sourcecraft.dev/my-org/example-user-my-project` ||
> |#
> 
> #|
> || GitLab | `https://example.gitlab.yandexcloud.net/test-group/test-project` ||
> || SourceCraft | `https://sourcecraft.dev/my-org/test-group-test-project` ||
> |#

#### Полезные ссылки {#see-also}

* [Настроить интеграцию Managed Service for GitLab с SourceCraft Security](../operations/sourcecraft-security.md).
* [Безопасность в SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/security-overview).