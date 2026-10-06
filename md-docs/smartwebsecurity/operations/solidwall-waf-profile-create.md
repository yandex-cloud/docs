[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > [Пошаговые инструкции](index.md) > Профили SolidWall WAF > Создать профиль

# Создать профиль SolidWall WAF

{% note info %}

Функциональность SolidWall WAF находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

[Профиль SolidWall WAF](../concepts/solidwall-waf.md#resources) объединяет приложения и задает общий тариф и пиковую нагрузку. Каждое приложение объединяет домены одного сайта или сервиса.

## Порядок настройки {#setup}

Чтобы начать работу с SolidWall WAF:

* Выберите существующий [прокси-сервер](../concepts/domain-protect.md#proxy) Smart Web Security или [создайте новый](proxy-create.md). Он принимает запросы пользователей и передает их на сервер вашего веб-приложения.
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

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **Профили WAF**.
  1. Если доступ к SolidWall WAF еще не предоставлен, заполните форму запроса доступа: опишите, как планируете использовать SolidWall WAF, отправьте запрос и дождитесь предоставления доступа.
  1. При создании первого профиля примите соглашение об использовании данных HTTP-запросов.
  1. Нажмите **Создать профиль** и выберите **Профиль SolidWall WAF**.
  1. Введите имя профиля.
  1. (Опционально) Введите описание профиля.
  1. В блоке **Пиковая нагрузка на приложения** выберите [полосу RPS](../concepts/solidwall-waf.md#tariffs) — количество запросов в секунду. Учитывайте суммарную нагрузку на все приложения профиля и ориентируйтесь на пиковый суточный RPS.
  1. В блоке **Тариф** выберите [тариф](../tutorials/solidwall-waf.md#select-tariff).


  1. Проверьте выбранный тариф и нагрузку в калькуляторе стоимости справа от формы.
  1. Нажмите **Создать**.
  1. В окне **Ознакомьтесь с правилами оплаты** прочитайте условия и нажмите **Продолжить**.

{% endlist %}

Созданный профиль появится в списке. Теперь можно [добавить приложение и подключить к нему домен](solidwall-waf-application-create.md).

#### Полезные ссылки {#see-also}

* [SolidWall WAF](../concepts/solidwall-waf.md)
* [Создать приложение SolidWall WAF и подключить к нему домен](solidwall-waf-application-create.md)
* [Удалить профиль SolidWall WAF](solidwall-waf-profile-delete.md)
* [Подключение SolidWall WAF к веб-приложению](../tutorials/solidwall-waf.md)