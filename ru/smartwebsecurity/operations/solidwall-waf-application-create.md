---
title: Как создать приложение SolidWall WAF и подключить к нему домен в {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете добавить приложение в профиль SolidWall WAF в {{ sws-name }} и подключить к нему домены своего сайта или API.
---

# Создать приложение SolidWall WAF и подключить к нему домен

[Приложение SolidWall WAF](../concepts/solidwall-waf.md#resources) объединяет [домены](../concepts/domain-protect.md#domain) — адреса, по которым доступен ваш сайт или сервис. Добавьте приложение в профиль и подключите к нему домены, чтобы WAF проверял входящие запросы.

Перед подключением добавьте домен на прокси-сервер и подключите к домену профиль безопасности с правилом Smart Protection. Если ресурсы еще не созданы, подготовьте их по [общему порядку настройки](solidwall-waf-profile-create.md#setup).

## Создайте приложение {#create-application}

Первое приложение входит в стоимость тарифа. Дополнительные активные приложения оплачиваются отдельно.

Чтобы создать приложение:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Убедитесь, что у вашей учетной записи есть роль [smart-web-security.editor](../security/index.md#smart-web-security-editor) на каталог с ресурсами SolidWall WAF.

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с профилем SolidWall WAF.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}** и откройте нужный профиль SolidWall WAF.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.SolidWall.SolidWallProfileOverviewPage.label_add-application_4pETp }}**.
  1. Введите имя приложения.
  1. (Опционально) Введите описание.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.Application.CreateApplicationPage.actionCreate_pi4Bb }}**.

{% endlist %}

Новое приложение работает в режиме мониторинга и не блокирует запросы. На странице приложения появится автоматически созданное от вашего имени обращение в службу поддержки с параметрами приложения. Используйте его для настройки защиты и согласования перехода в режим активной защиты. Подробнее о [настройке приложения](../tutorials/solidwall-waf.md#create-application).

## Подключите домен {#connect-domain}

Чтобы подключить домен к приложению:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице приложения нажмите **{{ ui-key.yacloud.smart-web-security.SolidWallApplicationActions.label_connect-domain_cAaqD }}**.
  1. В поле **{{ ui-key.yacloud.smart-web-security.ConnectDomainSolidWallDialog.FormFieldDomainSelect.title_domain_aHoh1 }}** выберите домен, который нужно защитить. Если домена нет в списке, сначала [добавьте его](domain-create.md) в {{ sws-name }}.
  1. В поле **{{ ui-key.yacloud.smart-web-security.ConnectDomainSolidWallDialog.FormFieldSecurityProfileSelect.title_security-profile_v6r5o }}** выберите профиль безопасности с правилом Smart Protection.

      Если подходящего профиля нет, нажмите **{{ ui-key.yacloud.common.create }}**, [создайте профиль](profile-create.md) в новой вкладке, затем вернитесь к подключению домена и обновите список профилей.

  1. (Опционально) Чтобы подключить еще один домен к этому приложению, нажмите **{{ ui-key.yacloud.smart-web-security.ConnectDomainSolidWallDialog.DomainsFieldArray.button_add-domain_cVb2C }}** и повторите выбор домена и профиля безопасности.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.ConnectDomainSolidWallDialog.button_connect_8BBRL }}**.
  1. Убедитесь, что домены появились в списке на странице приложения.

{% endlist %}

После подключения доменов [проверьте обработку трафика](../tutorials/solidwall-waf.md#check-traffic) по практическому руководству.

#### Полезные ссылки {#see-also}

* [{#T}](../concepts/solidwall-waf.md)
* [{#T}](solidwall-waf-profile-create.md)
* [{#T}](setup-infrastructure.md)
* [{#T}](../tutorials/solidwall-waf.md)
