---
title: Подключение SolidWall WAF к веб-приложению в {{ sws-full-name }}
description: 'Подключите веб-приложение к SolidWall WAF через {{ sws-name }}: создайте профиль и приложение, добавьте домены и проверьте анализ трафика.'
---

# Подключение SolidWall WAF к веб-приложению

{% include [solidwall-waf-preview](../../_includes/smartwebsecurity/solidwall-waf-preview.md) %}

[SolidWall WAF](../../smartwebsecurity/concepts/solidwall-waf.md) анализирует трафик и выявляет атаки. Аналитики сервиса настраивают защиту под приложения со сложной бизнес-логикой и чувствительными данными, чтобы снизить риск ложных срабатываний.

Вы подключите работающее приложение к SolidWall WAF и проверите анализ трафика в режиме мониторинга, без блокировки. В примере используется интернет-магазин с доменами `shop.example.com` и `auth.shop.example.com` для основного сайта и аутентификации. Замените их на свои; для приложения с одним доменом выполните шаги только для него.

## Порядок работы {#steps}

Чтобы подключить приложение:

1. [Подготовьте ресурсы и проверьте доступ](#before-you-begin).
1. [Создайте профиль SolidWall WAF](#create-profile).
1. [Добавьте приложение](#create-application).
1. [Подключите домены](#connect-domains).
1. [Проверьте обработку трафика](#check-traffic).

Если данные не появляются, выполните [диагностику](#troubleshooting). Если созданные для проверки ресурсы больше не нужны, [удалите их](#clear-out).

## Необходимые платные ресурсы {#paid-resources}

В стоимость входят:

* Плата за [обработку запросов и ресурсы прокси-сервера](../../smartwebsecurity/pricing.md) {{ sws-name }}.
* Плата за инфраструктуру, в которой работает ваше веб-приложение.

## Подготовьте ресурсы и проверьте доступ {#before-you-begin}

1. Убедитесь, что у вашей учетной записи есть роли:

    * [smart-web-security.editor](../../smartwebsecurity/security/index.md#smart-web-security-editor) на каталог с ресурсами SolidWall WAF.
    * [iam.serviceAccounts.admin](../../iam/security/index.md#iam-serviceAccounts-admin) на каталог — для создания прокси-сервера.
    * [smart-web-security.admin](../../smartwebsecurity/security/index.md#smart-web-security-admin) хотя бы на одно облако организации — для принятия соглашения об использовании данных HTTP-запросов. Соглашение принимается один раз для организации при создании первого профиля SolidWall WAF. Чтобы отозвать согласие, обратитесь в [службу поддержки](../../support/overview.md).

1. Выберите или [создайте](../../smartwebsecurity/operations/proxy-create.md) прокси-сервер. Убедитесь, что он находится в статусе `Active`.
1. [Добавьте на прокси-сервер](../../smartwebsecurity/operations/domain-create.md) домены `shop.example.com` и `auth.shop.example.com`.
1. Выберите или [создайте](../../smartwebsecurity/operations/profile-create.md) профиль безопасности с правилом Smart Protection.
1. [Подключите](../../smartwebsecurity/operations/host-connect.md#domain) профиль безопасности к каждому домену.
1. На странице прокси-сервера откройте вкладку **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}** и проверьте настройки каждого домена:

    * Указан один целевой ресурс (IP-адрес и порт); домены обслуживают один бэкенд с общей бизнес-логикой.
    * Соединение с целевым ресурсом использует `HTTP/1.1`; HTTP/2 не поддерживается.
    * Подключен профиль безопасности с правилом Smart Protection.
    * Подключение к целевому ресурсу — в статусе **{{ ui-key.yacloud.smart-web-security.target-state.healthy_4tpQh }}**.

    Чтобы изменить настройки домена, в строке с ним нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.

1. [Настройте инфраструктуру](../../smartwebsecurity/operations/setup-infrastructure.md): A-запись каждого домена должна указывать на IP-адрес прокси-сервера.
1. [Проверьте доступность ресурсов](../../smartwebsecurity/operations/validate-availability.md) и убедитесь, что приложение открывается в браузере по доменному имени.

SolidWall WAF поддерживает HTTP-трафик и WebSocket (WSS).

## Создайте профиль SolidWall WAF {#create-profile}

При создании профиля потребуется выбрать тариф:

* `{{ ui-key.yacloud.smart-web-security.solidWallBasicTariff_hB5xS }}` — до 1 000 RPS, негативная модель защиты, анализ отдельных запросов.
* `{{ ui-key.yacloud.smart-web-security.solidWallAdvancedTariff_6mLtW }}` — позитивная и негативная модели, анализ запросов, ответов и сессий с учетом бизнес-логики. Рекомендуется выбрать этот тариф для знакомства со всеми возможностями.

Подробнее о моделях защиты в [документации SolidWall WAF](https://docs.solidwall.yandex.cloud/ru/concepts/positive-vs-negative).

Чтобы создать профиль SolidWall WAF:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с прокси-сервером и доменами.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Если у вас нет доступа к SolidWall WAF, заполните и отправьте форму запроса.
  1. При создании первого профиля примите соглашение об использовании данных HTTP-запросов.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.WafCreateProfileAction.createWafOrSolidWallProfileButton_6J5WK }}** и выберите **{{ ui-key.yacloud.smart-web-security.solidWallProfile_jVUUm }}**.
  1. Введите имя профиля `solidwall-demo` и описание, например `Защита интернет-магазина`.
  1. В блоке **{{ ui-key.yacloud.smart-web-security.SolidWallProfileForm.titleRpsLimit_b67eQ }}** выберите суммарную нагрузку всех приложений профиля. Укажите `100 RPS` для теста или ступень, покрывающую пиковую суточную нагрузку рабочего приложения.
  1. В блоке **{{ ui-key.yacloud.smart-web-security.SolidWallProfileForm.titleTariff_6j471 }}** выберите `{{ ui-key.yacloud.smart-web-security.solidWallAdvancedTariff_6mLtW }}`.
  1. Проверьте тариф, нагрузку и стоимость в калькуляторе справа от формы. Блок **{{ ui-key.yacloud.smart-web-security.SolidWallProfileForm.titleApplications_rKJfh }}** оставьте пустым.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.
  1. В окне **{{ ui-key.yacloud.smart-web-security.SolidWallProfileForm.ConfirmPurchaseDialog.dialogTitle_fomvt }}** прочитайте условия и нажмите **{{ ui-key.yacloud.common.continue }}**.

{% endlist %}

Откройте профиль `solidwall-demo` и проверьте тариф и нагрузку. Чтобы посмотреть настройки SolidWall WAF, нажмите кнопку **{{ ui-key.yacloud.smart-web-security.controlPanel_nsbwt }}**.

## Добавьте приложение {#create-application}

Объедините домены магазина в приложение `shop`. Для веб-приложений с разной бизнес-логикой создавайте отдельные приложения в профиле.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице профиля `solidwall-demo` нажмите **{{ ui-key.yacloud.smart-web-security.SolidWall.SolidWallProfileOverviewPage.label_add-application_4pETp }}**.
  1. Введите имя приложения `shop` и описание, например `Основной сайт магазина и аутентификация`.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.Application.CreateApplicationPage.actionCreate_pi4Bb }}**.

{% endlist %}

На странице приложения появится автоматически созданное от вашего имени обращение в поддержку с параметрами приложения. Используйте его для настройки правил и разбора ложных срабатываний.

Аналитики настраивают модель по реальному трафику: обычно за две недели, для сложных приложений — до месяца. До завершения настройки не удаляйте приложение, чтобы сохранить статистику. Транзакции доступны после подключения доменов и появления трафика.

## Подключите домены {#connect-domains}

В одном профиле домен можно подключить только к одному приложению.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте приложение `shop` и нажмите **{{ ui-key.yacloud.smart-web-security.SolidWallApplicationActions.label_connect-domain_cAaqD }}**.
  1. В поле **{{ ui-key.yacloud.smart-web-security.ConnectDomainSolidWallDialog.FormFieldDomainSelect.title_domain_aHoh1 }}** выберите `shop.example.com`.
  1. В поле **{{ ui-key.yacloud.smart-web-security.ConnectDomainSolidWallDialog.FormFieldSecurityProfileSelect.title_security-profile_v6r5o }}** выберите профиль безопасности с правилом Smart Protection, который вы подключили к домену ранее.

  1. Нажмите **{{ ui-key.yacloud.smart-web-security.ConnectDomainSolidWallDialog.DomainsFieldArray.button_add-domain_cVb2C }}**. Выберите `auth.shop.example.com` и профиль безопасности для него.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.ConnectDomainSolidWallDialog.button_connect_8BBRL }}**.

{% endlist %}

Проверьте результат подключения:

1. На странице приложения `shop` убедитесь, что в списке есть оба домена с правильными IP-адресами, портами, прокси-сервером и профилями безопасности.
1. На странице профиля `solidwall-demo` найдите приложение `shop` в таблице **{{ ui-key.yacloud.smart-web-security.SolidWall.SolidWallProfileOverviewPage.section-title_applications_5DnfM }}**. В столбце с доменами должны отображаться оба адреса.
1. В разделе **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}** откройте прокси-сервер и его вкладку **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}**. У каждого домена в столбце **{{ ui-key.yacloud.smart-web-security.solidWallProfile_jVUUm }}** должен быть указан профиль `solidwall-demo`.

Записи о создании ресурсов и подключении доменов доступны на вкладках **{{ ui-key.yacloud.common.operations }}** профиля и приложения.

В столбце **{{ ui-key.yacloud.smart-web-security.solid-wall.domain_session-bindings_t5Jor }}** указана привязка сессии к серверу SolidWall WAF. По умолчанию привязка **{{ ui-key.yacloud.smart-web-security.solid-wall.domain_session-bindings_by-ip_pRD7K }}**, изменить ее можно через поддержку.

## Проверьте обработку трафика {#check-traffic}

Отправьте запросы к приложению и найдите их в панели SolidWall WAF:

1. Откройте основной сайт по доменному имени. Перейдите по нескольким страницам, воспользуйтесь поиском и формой входа. Выполните около 20–30 запросов, включая обращения к обоим доменам.

    Используйте доменные имена, чтобы трафик прошел через прокси-сервер. После изменения DNS проверьте IP-адрес командой `nslookup <домен>`: он должен совпадать с адресом прокси-сервера.

1. В консоли {{ sws-name }} откройте профиль `solidwall-demo` и нажмите **{{ ui-key.yacloud.smart-web-security.controlPanel_nsbwt }}**.
1. В новой вкладке, в разделе **Обзор**, найдите приложение и выберите период **Час**.

    В панели SolidWall WAF имя приложения имеет вид `webapp-<идентификатор_профиля>-<идентификатор_приложения>`. Сопоставьте его с идентификаторами в консоли {{ sws-name }}. Подробнее о [выборе приложений и настройке обзора](https://docs.solidwall.yandex.cloud/ru/monitoring/overview#nabory-prilozhenij).

1. Проверьте показатели приложения:

    #|
    || **Показатель** | **Ожидаемый результат** ||
    || График на вкладке **Статусы** | Есть данные за период проверки. Зеленый цвет — ответы `1xx`, `2xx` и `3xx`; желтый — `4xx` и запросы без ответа; красный — `5xx`. ||
    || Счетчик **Транзакций** | Значение больше нуля и увеличивается после новых запросов. ||
    || Статус | **Мониторинг** — WAF анализирует трафик и фиксирует срабатывания правил, но не блокирует запросы. ||
    |#

    Подробнее о [графиках и показателях](https://docs.solidwall.yandex.cloud/ru/monitoring/overview#grafiki) и [режиме мониторинга](https://docs.solidwall.yandex.cloud/ru/concepts/detection-modes#rezhim-monitoringa).

1. В разделе **Приложения** откройте нужное приложение и перейдите на вкладку **Транзакции**. Выберите период проверки и при необходимости отфильтруйте запросы по домену. Откройте транзакцию двойным нажатием, чтобы посмотреть запрос, ответ и результат анализа. Подробнее о [просмотре транзакций](https://docs.solidwall.yandex.cloud/ru/monitoring/inspect-transaction#kak-najti-tranzakciyu).
1. Вернитесь в консоль {{ sws-name }} и убедитесь, что приложение `shop` перешло в статус `Active`. Статус `Active` в консоли не означает, что в SolidWall WAF включена блокировка запросов.

Статические запросы могут не попадать на графики, а обычные транзакции сохраняются с семплированием: их число может быть меньше числа отправленных запросов.

При обнаружении аномалий в разделе **Обзор** появятся [события безопасности](https://docs.solidwall.yandex.cloud/ru/monitoring/security-events). Разбирайте их через обращение в поддержку приложения.

После появления трафика проверьте показатель **{{ ui-key.yacloud.smart-web-security.solid-wall.5j7yt }}** на странице профиля в консоли {{ sws-name }}. Если фактическая нагрузка регулярно превышает выбранную, пересмотрите значение RPS в профиле.

### Результат {#result}

Подключение завершено, если выполняются следующие условия:

* Оба домена подключены к приложению `shop` в профиле `solidwall-demo`.
* Приложение активно, а в панели SolidWall WAF отображаются его транзакции и графики.
* Приложение работает в режиме мониторинга.
* На странице приложения доступно обращение в поддержку для настройки защиты.

Продолжайте направлять обычный трафик через WAF для настройки модели. После проверки правил и ложных срабатываний согласуйте включение [активной защиты](https://docs.solidwall.yandex.cloud/ru/concepts/detection-modes#rezhim-aktivnoj-zashity) через обращение в поддержку приложения.

## Если данные не появляются {#troubleshooting}

#|
|| **Проблема** | **Что проверить** ||
|| Домен открывается, но транзакций нет | A-записи должны указывать на прокси-сервер {{ sws-name }}. Убедитесь, что запросы не обслуживаются из кеша и не отправляются напрямую на целевой ресурс. ||
|| DNS настроен правильно, но транзакций нет | Проверьте подключение домена к приложению и наличие правила Smart Protection в профиле безопасности. ||
|| Приложение не отображается в панели SolidWall WAF | Подождите несколько минут после создания и обновите страницу. Сопоставьте техническое имя с идентификатором приложения в консоли {{ sws-name }}. ||
|| Графики пустые | Проверьте выбранное приложение и период. Попробуйте период **День**. Выполните запросы к динамическим страницам приложения. ||
|| На графиках есть ответы `5xx` | Проверьте [доступность целевого ресурса](../../smartwebsecurity/operations/validate-availability.md), его IP-адрес и порт. Убедитесь, что сервер принимает трафик от прокси-сервера {{ sws-name }}. ||
|#

Подробнее о [причинах отсутствия данных на графиках](https://docs.solidwall.yandex.cloud/ru/monitoring/overview#tipichnye-problemy) и [поиске транзакций](https://docs.solidwall.yandex.cloud/ru/monitoring/inspect-transaction#tipichnye-problemy).

## Как удалить созданные ресурсы {#clear-out}

Если профиль `solidwall-demo` больше не нужен, удалите его. Если аналитики сервиса еще работают с приложением, дождитесь завершения настройки или напишите в поддержку.

Удалите ресурсы в следующем порядке:

1. [Отключите домены и удалите приложение](../../smartwebsecurity/operations/solidwall-waf-application-delete.md) `shop`. Повторите для других приложений, если они есть в профиле.
1. [Удалите профиль](../../smartwebsecurity/operations/solidwall-waf-profile-delete.md) `solidwall-demo`.

Домены, их профили безопасности и инфраструктура веб-приложения сохраняются и продолжают работать и тарифицироваться по своим условиям.

#### Полезные ссылки {#see-also}

* [{#T}](../../smartwebsecurity/operations/solidwall-waf-profile-create.md)
* [{#T}](../../smartwebsecurity/operations/solidwall-waf-application-create.md)
* [{#T}](../../smartwebsecurity/operations/solidwall-waf-profile-delete.md)
* [{#T}](../../smartwebsecurity/concepts/solidwall-waf.md)
* [Документация SolidWall WAF](https://docs.solidwall.yandex.cloud/ru/)
