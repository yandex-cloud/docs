[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for GitLab](../index.md) > [Пошаговые инструкции](index.md) > Интеграция с SourceCraft Security

# Настроить интеграцию Managed Service for GitLab с SourceCraft Security

[Интеграция Managed Service for GitLab с SourceCraft Security](../concepts/sourcecraft-security.md) позволяет автоматически проверять код из репозиториев [инстанса GitLab](../concepts/index.md#instance) на наличие секретов, уязвимостей в зависимостях и самом коде. Репозитории зеркалируются в SourceCraft. Проверки выполняются в зеркалируемых репозиториях, и для них доступна вся функциональность [SourceCraft Security](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/security-overview).

{% note warning %}

Для интеграции требуется платное дополнение _SourceCraft Security_. Стоимость определяется [правилами тарификации SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/pricing#additional).

Репозитории создаются в той же [организации Yandex Cloud](../../organization/concepts/organization.md), в которой находится инстанс GitLab. Эта организация может отличаться от [персональной организации](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#org), автоматически созданной при регистрации в SourceCraft. Убедитесь, что дополнение подключено именно к организации инстанса.

Включая интеграцию, вы подтверждаете передачу исходного кода в SourceCraft. Зеркалируются все репозитории инстанса GitLab, независимо от их настроек видимости. В SourceCraft зеркалируемые репозитории создаются [приватными](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#repo-visibility).

{% endnote %}

## Включить интеграцию {#enable}

### Подключите дополнение SourceCraft Security к организации {#enable-security}

{% list tabs group=instructions %}

- Интерфейс SourceCraft {#src}

  1. Откройте [главную страницу](https://sourcecraft.dev) SourceCraft.
  1. Перейдите к списку **Организации** и выберите организацию Yandex Cloud, в которой находится инстанс GitLab.
  1. На странице организации в разделе ![image](../../_assets/console-icons/shield-exclamation.svg) **Безопасность** откройте секцию ![image](../../_assets/console-icons/circles-4-square.svg) **Обзор**.
  1. Убедитесь, что дополнение SourceCraft Security подключено. Если вместо результатов сканирований отображается предложение включить дополнение **Безопасность**, подключите его для выбранной организации.

      Если доступен пробный период, нажмите **Начать бесплатный пробный период** и следуйте указаниям в интерфейсе. Если у вас нет прав для подключения дополнения, обратитесь к администратору организации.

{% endlist %}

### Включите интеграцию в настройках инстанса GitLab {#enable-instance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится инстанс GitLab.
  1. [Перейдите](https://console.yandex.cloud/link/managed-gitlab) в сервис **Managed Service for&nbsp;GitLab**.
  1. Выберите инстанс и в правом верхнем углу страницы нажмите ![image](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В блоке **Интеграция с SourceCraft** включите опцию **Включить интеграцию с SourceCraft**.
  1. Нажмите **Сохранить**.
  1. Дождитесь завершения обновления инстанса: его статус сменится с **Updating** на **Running**, а в разделе **Обзор** поле **Интеграция с SourceCraft** примет значение **Включена**.

{% endlist %}

{% note tip %}

Интеграцию также можно включить при [создании инстанса GitLab](instance/instance-create.md#create). Сначала подключите дополнение SourceCraft Security к организации, в которой будет создан инстанс.

{% endnote %}

### Дождитесь зеркалирования репозиториев {#check-mirroring}

{% list tabs group=instructions %}

- Интерфейс SourceCraft {#src}

  1. Откройте организацию, для которой вы подключили дополнение SourceCraft Security.
  1. Перейдите к списку репозиториев организации и дождитесь появления зеркалируемых репозиториев инстанса GitLab.

      Их имена формируются из пути исходного репозитория: например, `test-group/test-subgroup/example-repo` преобразуется в `test-group-test-subgroup-example-repo`. Подробнее о [преобразовании адресов](../concepts/sourcecraft-security.md#repository-paths).

{% endlist %}

{% note info %}

Сканирования запускаются при поступлении коммитов в [ветку](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#repos) по умолчанию исходного репозитория GitLab. Дождитесь синхронизации кода и завершения проверок, затем [посмотрите результаты](#results) в SourceCraft.

{% endnote %}

## Отключить интеграцию {#disable}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится инстанс GitLab.
  1. [Перейдите](https://console.yandex.cloud/link/managed-gitlab) в сервис **Managed Service for&nbsp;GitLab**.
  1. Выберите инстанс и в правом верхнем углу страницы нажмите ![image](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В блоке **Интеграция с SourceCraft** отключите опцию **Включить интеграцию с SourceCraft**.
  1. Нажмите **Сохранить**.
  1. Дождитесь завершения обновления инстанса. В разделе **Обзор** поле **Интеграция с SourceCraft** примет значение **Выключена**.

{% endlist %}

## Посмотреть результаты сканирования {#results}

Результаты доступны в [центре контроля уязвимостей SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/security-dashboard). Чтобы предоставить к ним доступ разработчикам, [пригласите пользователей в организацию](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/invite) и [назначьте роли](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/bind) на нужные репозитории или организацию.

### Все репозитории {#org}

Выберите организацию, в которой находится инстанс GitLab. В ее центре контроля уязвимостей отображаются результаты для всех доступных вам репозиториев этой организации.

{% list tabs group=instructions %}

- Интерфейс SourceCraft {#src}

  Чтобы открыть центр контроля уязвимостей [организации](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#org):
  1. Откройте [главную страницу](https://sourcecraft.dev) SourceCraft.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/briefcase.svg) **Организации** и выберите организацию.
  1. В разделе ![image](../../_assets/console-icons/shield-exclamation.svg) **Безопасность** перейдите в секцию ![image](../../_assets/console-icons/circles-4-square.svg) **Обзор**.
  
      На дашбордах **Предупреждения сканирования секретов**, **Зависимости** и **Предупреждения сканирования кода** представлена следующая статистика:
      * **Статус проблем**;
      * **Обработанные проблемы**;
      * **Уровень критичности проблемы** (на дашбордах **Зависимости** и **Предупреждения сканирования кода**).
  
      Чтобы перейти к детальным спискам проблем конкретного типа, рядом с заголовком нужного дашборда нажмите ![image](../../_assets/console-icons/arrow-up-right-from-square.svg).
  
      Также на странице представлен полный список выявленных проблем безопасности со следующей информацией:
      * название репозитория;
      * тип проблемы;
      * сканер, выявивший проблему;
      * время последнего сканирования;
      * данные о предупреждениях.

{% endlist %}

### Конкретный репозиторий {#repo}

Выберите зеркалируемый репозиторий SourceCraft, соответствующий исходному репозиторию GitLab.

{% list tabs group=instructions %}

- Интерфейс SourceCraft {#src}

  Чтобы открыть центр контроля уязвимостей [репозитория](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#repos):
  1. Откройте [главную страницу](https://sourcecraft.dev) SourceCraft.
  1. На вкладке ![image](../../_assets/console-icons/house.svg) **Домой** перейдите в раздел ![image](../../_assets/console-icons/archive.svg) **Репозитории** и выберите репозиторий.
  1. На странице репозитория в разделе ![image](../../_assets/console-icons/shield-exclamation.svg) **Безопасность** перейдите в секцию ![image](../../_assets/console-icons/circles-4-square.svg) **Обзор**.
  
      На дашбордах **Оповещения сканирования секретов**, **Оповещения о зависимостях** и **Оповещения анализа кода** представлена следующая статистика:
      * **Статус проблем**;
      * **Обработанные проблемы**;
      * **Уровень критичности проблемы** (на дашбордах **Оповещения о зависимостях** и **Оповещения анализа кода**).
  
      Чтобы скачать файлы SARIF (Static Analysis Results Interchange Format) или SBOM (Software Bill of Materials) в формате SPDX для аудита или интеграции с внешними системами, нажмите кнопку **Скачать SARIF** или **Скачать SBOM** на нужном дашборде.
  
      Также в центре контроля уязвимостей отображается время последнего сканирования.

{% endlist %}

#### Полезные ссылки {#see-also}

* [Интеграция Managed Service for GitLab с SourceCraft Security](../concepts/sourcecraft-security.md).
* [Сканирование секретов](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/secret-scan).
* [Анализ зависимостей](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/supply-chain).
* [Политика лицензий в виде кода](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/license-policy).
* [Статический анализ кода](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/sast).
* [Анализ и приоритизация уязвимостей с помощью ИИ](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/ca-triage).
* [История сканирований](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/security-scan-history).
* [Настройка пользовательского анализатора безопасности](https://sourcecraft.dev/portal/docs/ru/sourcecraft/tutorials/custom-security-analyzers).