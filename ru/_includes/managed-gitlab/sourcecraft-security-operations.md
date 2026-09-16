[Интеграция {{ mgl-name }} с {{ src-name }} Security](../../managed-gitlab/concepts/sourcecraft-security.md) позволяет автоматически проверять код из репозиториев [инстанса {{ GL }}](../../managed-gitlab/concepts/index.md#instance) на наличие секретов, уязвимостей в зависимостях и самом коде. Репозитории зеркалируются в {{ src-name }}. Проверки выполняются в зеркалируемых репозиториях, и для них доступна вся функциональность [{{ src-name }} Security]({{ link-src-docs }}/sourcecraft/security/security-overview).

{% include [sourcecraft-security-notes](sourcecraft-security-notes.md) %}

## Включить интеграцию {#enable}

### Подключите дополнение {{ src-name }} Security к организации {#enable-security}

{% list tabs group=instructions %}

- Интерфейс {{ src-name }} {#src}

  1. Откройте [главную страницу]({{ link-src-main }}) {{ src-name }}.
  1. Перейдите к списку **{{ ui-key.sourcecraft.lib.organizations_5CjkW }}** и выберите организацию {{ yandex-cloud }}, в которой находится инстанс {{ GL }}.
  1. На странице организации в разделе ![image](../../_assets/console-icons/shield-exclamation.svg) **{{ ui-key.sourcecraft.mainApp.route_security_4Dbxc }}** откройте секцию ![image](../../_assets/console-icons/circles-4-square.svg) **{{ ui-key.sourcecraft.mainApp.route_security-overview_dQuX9 }}**.
  1. Убедитесь, что дополнение {{ src-name }} Security подключено. Если вместо результатов сканирований отображается предложение включить дополнение **Безопасность**, подключите его для выбранной организации.

      Если доступен пробный период, нажмите **{{ ui-key.sourcecraft.appsec.paywall-action-billing_e7ueS }}** и следуйте указаниям в интерфейсе. Если у вас нет прав для подключения дополнения, обратитесь к администратору организации.

{% endlist %}

### Включите интеграцию в настройках инстанса {{ GL }} {#enable-instance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится инстанс {{ GL }}.
  1. [Перейдите]({{ link-console-main }}/link/managed-gitlab) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Выберите инстанс и в правом верхнем углу страницы нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.gitlab.components.InstanceForm.SourceCraftIntegrationSection.section_title }}** включите опцию **{{ ui-key.yacloud.gitlab.components.InstanceForm.SourceCraftIntegrationSection.field_enable }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.
  1. Дождитесь завершения обновления инстанса: его статус сменится с **Updating** на **Running**, а в разделе **{{ ui-key.yacloud.common.overview }}** поле **{{ ui-key.yacloud.gitlab.field_sourcecraft-integration }}** примет значение **Включена**.

{% endlist %}

{% note tip %}

Интеграцию также можно включить при [создании инстанса {{ GL }}](../../managed-gitlab/operations/instance/instance-create.md#create). Сначала подключите дополнение {{ src-name }} Security к организации, в которой будет создан инстанс.

{% endnote %}

### Дождитесь зеркалирования репозиториев {#check-mirroring}

{% list tabs group=instructions %}

- Интерфейс {{ src-name }} {#src}

  1. Откройте организацию, для которой вы подключили дополнение {{ src-name }} Security.
  1. Перейдите к списку репозиториев организации и дождитесь появления зеркалируемых репозиториев инстанса {{ GL }}.

      Их имена формируются из пути исходного репозитория: например, `test-group/test-subgroup/example-repo` преобразуется в `test-group-test-subgroup-example-repo`. Подробнее о [преобразовании адресов](../../managed-gitlab/concepts/sourcecraft-security.md#repository-paths).

{% endlist %}

{% note info %}

Сканирования запускаются при поступлении коммитов в [ветку]({{ link-src-docs }}/sourcecraft/concepts/#repos) по умолчанию исходного репозитория {{ GL }}. Дождитесь синхронизации кода и завершения проверок, затем [посмотрите результаты](#results) в {{ src-name }}.

{% endnote %}

## Отключить интеграцию {#disable}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится инстанс {{ GL }}.
  1. [Перейдите]({{ link-console-main }}/link/managed-gitlab) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Выберите инстанс и в правом верхнем углу страницы нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.gitlab.components.InstanceForm.SourceCraftIntegrationSection.section_title }}** отключите опцию **{{ ui-key.yacloud.gitlab.components.InstanceForm.SourceCraftIntegrationSection.field_enable }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.
  1. Дождитесь завершения обновления инстанса. В разделе **{{ ui-key.yacloud.common.overview }}** поле **{{ ui-key.yacloud.gitlab.field_sourcecraft-integration }}** примет значение **Выключена**.

{% endlist %}

## Посмотреть результаты сканирования {#results}

Результаты доступны в [центре контроля уязвимостей {{ src-name }}]({{ link-src-docs }}/sourcecraft/operations/security-dashboard). Чтобы предоставить к ним доступ разработчикам, [пригласите пользователей в организацию]({{ link-src-docs }}/sourcecraft/security/invite) и [назначьте роли]({{ link-src-docs }}/sourcecraft/security/bind) на нужные репозитории или организацию.

### Все репозитории {#org}

Выберите организацию, в которой находится инстанс {{ GL }}. В ее центре контроля уязвимостей отображаются результаты для всех доступных вам репозиториев этой организации.

{% list tabs group=instructions %}

- Интерфейс {{ src-name }} {#src}

  {% include [security-dashboard-org](../sourcecraft/security-dashboard-org.md) %}

{% endlist %}

### Конкретный репозиторий {#repo}

Выберите зеркалируемый репозиторий {{ src-name }}, соответствующий исходному репозиторию {{ GL }}.

{% list tabs group=instructions %}

- Интерфейс {{ src-name }} {#src}

  {% include [security-dashboard-repo](../sourcecraft/security-dashboard-repo.md) %}

{% endlist %}

#### Полезные ссылки {#see-also}

* [Интеграция {{ mgl-name }} с {{ src-name }} Security](../../managed-gitlab/concepts/sourcecraft-security.md).
* [Сканирование секретов]({{ link-src-docs }}/sourcecraft/operations/secret-scan).
* [Анализ зависимостей]({{ link-src-docs }}/sourcecraft/operations/supply-chain).
* [Политика лицензий в виде кода]({{ link-src-docs }}/sourcecraft/operations/license-policy).
* [Статический анализ кода]({{ link-src-docs }}/sourcecraft/operations/sast).
* [Анализ и приоритизация уязвимостей с помощью ИИ]({{ link-src-docs }}/sourcecraft/operations/ca-triage).
* [История сканирований]({{ link-src-docs }}/sourcecraft/operations/security-scan-history).
* [Настройка пользовательского анализатора безопасности]({{ link-src-docs }}/sourcecraft/tutorials/custom-security-analyzers).
