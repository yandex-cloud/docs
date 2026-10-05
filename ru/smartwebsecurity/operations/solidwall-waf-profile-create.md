---
title: Как создать профиль SolidWall WAF в {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете создать профиль SolidWall WAF в {{ sws-name }}, выбрать тариф и пиковую нагрузку на приложения.
---

# Создать профиль SolidWall WAF

{% include [solidwall-waf-preview](../../_includes/smartwebsecurity/solidwall-waf-preview.md) %}

[Профиль SolidWall WAF](../concepts/solidwall-waf.md#resources) объединяет приложения и задает общий тариф и пиковую нагрузку. Каждое приложение объединяет домены одного сайта или сервиса.

## Порядок настройки {#setup}

Чтобы начать работу с SolidWall WAF:

* Выберите существующий [прокси-сервер](../concepts/domain-protect.md#proxy) {{ sws-name }} или [создайте новый](proxy-create.md). Он принимает запросы пользователей и передает их на сервер вашего веб-приложения.
* [Добавьте на прокси-сервер домен](domain-create.md) вашего сайта или API. Укажите один целевой ресурс и версию `HTTP/1.1` для соединения с ним. Если домен уже добавлен, проверьте эти настройки.
* [Подключите к домену](host-connect.md#domain) профиль безопасности хотя бы с одним правилом Smart Protection. Используйте существующий профиль или [создайте новый](profile-create.md).
* [Настройте DNS](setup-infrastructure.md), чтобы A-запись домена указывала на IP-адрес прокси-сервера. [Проверьте доступность целевого ресурса](validate-availability.md) и убедитесь, что сайт или API отвечает на запросы по доменному имени.
* [Создайте профиль SolidWall WAF](#create-profile) с нужным тарифом и нагрузкой.
* [Создайте приложение](solidwall-waf-application-create.md#create-application) в профиле и [подключите к нему домены](solidwall-waf-application-create.md#connect-domain), чтобы их трафик начал поступать в SolidWall WAF.

Домен и профиль SolidWall WAF можно создать в любом порядке.

## Создайте профиль SolidWall WAF {#create-profile}

Чтобы создать профиль:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Убедитесь, что у вашей учетной записи есть роль [smart-web-security.editor](../security/index.md#smart-web-security-editor) на каталог с ресурсами SolidWall WAF.

      Для создания прокси-сервера дополнительно потребуется роль [iam.serviceAccounts.admin](../../iam/security/index.md#iam-serviceAccounts-admin) на каталог.

      Если вы создаете первый профиль, для принятия соглашения об использовании данных HTTP-запросов потребуется роль [smart-web-security.admin](../security/index.md#smart-web-security-admin) хотя бы на одно облако организации. Соглашение принимается один раз для организации. Чтобы отозвать согласие, обратитесь в [службу поддержки](../../support/overview.md).

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Если доступ к SolidWall WAF еще не предоставлен, заполните форму запроса доступа: опишите, как планируете использовать SolidWall WAF, отправьте запрос и дождитесь предоставления доступа.
  1. При создании первого профиля примите соглашение об использовании данных HTTP-запросов.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.WafCreateProfileAction.createWafOrSolidWallProfileButton_6J5WK }}** и выберите **{{ ui-key.yacloud.smart-web-security.solidWallProfile_jVUUm }}**.
  1. Введите имя профиля.
  1. (Опционально) Введите описание профиля.
  1. В блоке **{{ ui-key.yacloud.smart-web-security.SolidWallProfileForm.titleRpsLimit_b67eQ }}** выберите [полосу RPS](../concepts/solidwall-waf.md#tariffs) — количество запросов в секунду. Учитывайте суммарную нагрузку на все приложения профиля и ориентируйтесь на пиковый суточный RPS.
  1. В блоке **{{ ui-key.yacloud.smart-web-security.SolidWallProfileForm.titleTariff_6j471 }}** выберите [тариф](../tutorials/solidwall-waf.md#select-tariff).


  1. Проверьте выбранный тариф и нагрузку в калькуляторе стоимости справа от формы.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.
  1. В окне **{{ ui-key.yacloud.smart-web-security.SolidWallProfileForm.ConfirmPurchaseDialog.dialogTitle_fomvt }}** прочитайте условия и нажмите **{{ ui-key.yacloud.common.continue }}**.

{% endlist %}

Созданный профиль появится в списке. Теперь можно [добавить приложение и подключить к нему домен](solidwall-waf-application-create.md).

#### Полезные ссылки {#see-also}

* [{#T}](../concepts/solidwall-waf.md)
* [{#T}](solidwall-waf-application-create.md)
* [{#T}](solidwall-waf-profile-delete.md)
* [{#T}](../tutorials/solidwall-waf.md)
