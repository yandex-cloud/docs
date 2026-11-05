---
title: Подключение к {{ ycdr-full-name }}
description: 'Следуя этой инструкции, вы подключитесь к {{ ycdr-full-name }}: создадите приемник алертов, передадите необходимые данные и настроите роли.'
---

# Подключение к {{ ycdr-full-name }}

## Создайте заявку на подключение {#create-ticket}

Заявку создает [владелец организации](../../organization/security/index.md#organization-manager-organizations-owner) или [пользователь с правами администратора](../../organization/security/index.md#organization-manager-admin) на уровне организации.

1. Откройте [главную страницу поддержки]({{ link-console-support }}) в {{ support-center-name }}.
1. Нажмите **{{ ui-key.support-center.tickets.common.action_create-ticket }}**.
1. Выберите формат обращения **{{ ui-key.support-center.tickets.common.label_ticket-type-question }}**.
1. В поле **{{ ui-key.support-center.ticket.create.field_service }}** укажите сервис `{{ ycdr-full-name }}`.
1. В поле **{{ ui-key.support-center.ticket.create.field_subject }}** введите тему, например: `Запрос на подключение к {{ ycdr-name }}`.
1. Нажмите **{{ ui-key.yacloud.common.continue }}** и в текстовом поле опишите запрос. Укажите, что хотите подключить организацию к {{ ycdr-name }}. Организация подключается целиком — со всеми облаками и каталогами.
1. Отправьте обращение.
1. Сохраните идентификатор созданного обращения — он понадобится далее.

После обработки заявки {{ yandex-cloud }} выдаст необходимые разрешения для доступа к сервису.

## Создайте приемник алертов {#create-alert-sink}

[Приемник алертов](../../security-deck/concepts/workspace.md#alert-sinks) — это ресурс, в который {{ ycdr-name }} будет направлять сгенерированные [алерты](../../security-deck/concepts/alerts.md). Разместите его в отдельном каталоге.

{% note info %}

Для создания приемника алертов у вас должна быть роль [security-deck.admin](../../security-deck/security/index.md#security-deck-admin) или одна из ролей [resource-manager.admin](../../iam/roles-reference.md#resource-manager-admin), [resource-manager.editor](../../iam/roles-reference.md#resource-manager-editor) на каталог или облако.

{% endnote %}

1. [Создайте](../../resource-manager/operations/folder/create.md) отдельный каталог в выбранном облаке.
1. [Назначьте](../../iam/operations/roles/grant.md) роль `editor` на этот каталог только аналитикам центра мониторинга и реагирования на инциденты информационной безопасности ([SOC](../../security/standarts.md#incident-resp), Security Operations Center) и сотрудникам службы безопасности.
1. [Перейдите]({{ link-sd-main }}) в сервис {{ sd-name }}.
1. На панели слева выберите **{{ ui-key.yacloud_org.security-center.label_settings }}**.
1. Откройте вкладку **{{ ui-key.yacloud_org.security.settings.SettingsPageLayout.alertSinkLabel_gvxBa }}**.
1. Чтобы создать приемник алертов, нажмите **{{ ui-key.yacloud_org.security-center.alerts.sink.action_create }}**.
1. В открывшемся окне:
   * Введите имя приемника и при необходимости описание.
   * В поле **{{ ui-key.yacloud.common.folder }}** выберите созданный ранее каталог.
   * Нажмите **{{ ui-key.yacloud_org.security-center.alerts.sink.action_create }}**.
1. Сохраните идентификатор созданного приемника — он понадобится на следующем шаге.

## Передайте данные в {{ yandex-cloud }} {#provide-data}

1. Откройте [главную страницу поддержки]({{ link-console-support }}) в {{ support-center-name }}.
1. В списке обращений выберите [созданную ранее](#create-ticket) заявку. Чтобы найти ее, укажите идентификатор в поле **{{ ui-key.support-center.navigation.title_search }}**.
1. Добавьте в заявку данные:
   * [Идентификатор]({{ link-sd-main }}/settings/alert-sink) приемника алертов, созданного ранее.
   * [Идентификатор федерации](#get-federation-id), если используется федеративная аутентификация.
   * Почтовые домены — если используются учетные записи Яндекс 360 или другие корпоративные аккаунты.
   * Адреса электронной почты для получения алертов. Можно указать до пяти адресов.
1. Нажмите **{{ ui-key.support-center.ticket.details.action_send-comment }}**.

При необходимости продублируйте данные в рабочем чате или по электронной почте.

Дождитесь ответа в тикете о том, что организация подключена к {{ ycdr-name }}.

### Как получить идентификатор федерации {#get-federation-id}

1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.
1. В строке с нужной федерацией скопируйте и сохраните значение поля **{{ ui-key.yacloud_org.common.columns.column_id }}**.

## Подключение журналов {{ at-name }} {#audit-trails}

{{ yandex-cloud }} подключит журналы {{ at-name }} самостоятельно — никаких действий с вашей стороны не требуется.

В сервисе [{{ org-full-name }}]({{ link-org-cloud-center }}), в разделе ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**, появятся сервисные учетные записи:
 
* `yc-security-shadow-trail` с идентификатором `yc.security.shadow-trail` и ролью [audit-trails.viewer](../../audit-trails/security/index.md#at-viewer) — для чтения аудитных логов;
* `yc-security-secops-soar-main` с идентификатором `yc.security.secops-soar-main` и ролью [security-deck.editor](../../security-deck/security/index.md#security-deck-editor) — для чтения комментариев из приемника алертов и интеграции с ним.

## Настройка сканирования мисконфигураций {#config-scan}

{{ ycdr-name }} сканирует метаданные конфигурации облачных ресурсов и выявляет мисконфигурации — небезопасные настройки инфраструктуры. Пользовательские данные не используются.

Сканирование выполняется от имени учетной записи `yaem-xxxxxx-sa` с идентификатором `yc.yaem-xxxxxx.yaem-sa` и ролью [{{ roles-auditor }}](../../iam/roles-reference.md#auditor). Это наименее привилегированная роль: она позволяет только читать конфигурацию и метаданные ресурсов.

{% note warning %}

Метаданные конфигурации не содержат конфиденциальной информации. Дополнительное соглашение не требуется — достаточно NDA (Non-Disclosure Agreement), подписанного при заключении договора с {{ yandex-cloud }}.

{% endnote %}

## Настройте роли {#configure-roles}

[Назначьте](../../iam/operations/roles/grant.md) пользователям роли в зависимости от их задач:

* Для просмотра дашбордов с мисконфигурациями назначьте на организацию роль [ycdr.admin](../security/index.md#ycdr-admin).
* Для работы только с алертами назначьте на облако или каталог, где находится приемник алертов, роль [security-deck.editor](../../security-deck/security/index.md#security-deck-editor).

## Устраните мисконфигурации {#fix-misconfigs}

После завершения сканирования результаты будут доступны на специальном дашборде в разделе **{{ ycdr-name }}** сервиса [{{ sd-full-name }}]({{ link-sd-main }}).

Не все найденные мисконфигурации требуют исправления. Часть настроек соответствует вашим требованиям или особенностям инфраструктуры (например, открытый порт нужен для работы конкретного сервиса). Проанализируйте отчет и запланируйте устранение только реальных мисконфигураций. Это повысит безопасность облака и снизит количество ложноположительных срабатываний алертов.

## Протестируйте сбор событий и алертов {#test}

После настройки сбора событий проверьте, что {{ ycdr-name }} корректно реагирует на подозрительные действия:

1. Сгенерируйте подозрительные события одним из способов:
   * вручную выполните подозрительные действия в облаке, например, создайте сервисный аккаунт с избыточными правами или предоставьте публичный доступ к бакету {{ objstorage-name }};
   * используйте систему автогенерации тестовых атак на основе [Stratus Red Team](https://stratus-red-team.cloud/).
1. Убедитесь, что по этим событиям в интерфейсе {{ ycdr-name }} появились алерты.

## Что дальше {#whats-next}

* Узнайте больше о [расследованиях](investigations/manage-investigations.md).
* Управляйте [запросами](queries/manage-queries.md) на языке KQL (Kusto Query Language).
