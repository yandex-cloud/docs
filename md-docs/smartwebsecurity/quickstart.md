# Как начать работать с {{ sws-full-name }}

{{ sws-name }} позволяет защитить инфраструктуру от информационных угроз на прикладном уровне L7 модели OSI. Например, [DDoS-атак](../glossary/ddos.md), ботов, SQL-инъекций. Дополнительно можно подключить защиту от DDoS-атак на уровнях L3 и L4 с помощью [{{ ddos-protection-full-name }}](../vpc/ddos-protection/index.md).

{{ sws-name }} — это набор инструментов для защиты инфраструктуры разного уровня сложности и масштаба. Защита заключается в очистке входящего трафика от вредоносного. Трафик проверяется правилами и условиями фильтрации в профиле безопасности. Очищенный трафик можно дополнительно обработать правилами профиля ARL, чтобы снизить нагрузку на приложение.

Профиль безопасности может содержать:

* Базовые правила — для простой фильтрации трафика по заданным условиям.
* Правила Smart Protection — для автоматической защиты от DDoS-атак при помощи алгоритмов машинного обучения и поведенческого анализа.
* Правила профиля WAF — для защиты от эксплуатации уязвимостей веб-приложения или сайта. Правила блокируют множество известных угроз, например SQL-инъекции и командные инъекции, межсайтовый скриптинг и другие. В профиль WAF можно добавить несколько наборов правил: [OWASP Core Rule Set](https://owasp.org/www-project-modsecurity-core-rule-set/) (CRS), [Yandex Ruleset](concepts/waf.md#yandex-ruleset) и [ML WAF (Yandex Malicious Score)](concepts/waf.md#yandex-ml-ruleset).
* Встроенную [{{ captcha-full-name }}](../smartcaptcha/index.md) — для проверки типа [CAPTCHA](https://ru.wikipedia.org/wiki/Капча) от ботов и спама.
* Списки фильтрации IP-адресов — для разрешения или блокировки запросов от указанных IP-адресов.

Профиль ARL содержит правила для ограничения количества запросов к защищаемому ресурсу по различным условиям.

Профиль безопасности можно подключить к разным типам ресурсов:

* [Виртуальный хост](../application-load-balancer/concepts/http-router.md#virtual-host) или [Ingress-контроллер](../application-load-balancer/tools/k8s-ingress-controller/index.md#smart-web-security) для защиты ресурсов, использующих {{ alb-full-name }}. 
* API-шлюз [{{ api-gw-name }}](../api-gateway/concepts/index.md) для защиты API ваших приложений.
* [Домен](concepts/domain-protect.md) для защиты вашего сайта или веб-приложения, расположенного в {{ yandex-cloud }}, в вашей внутренней инфраструктуре или на других хостингах.

{{ sws-name }} позволяет создать несколько профилей безопасности и комбинировать в них различные наборы инструментов защиты.

## Порядок настройки {#steps}

* [Подготовьте облако к работе](#before-you-begin)
* [Создайте и настройте защищаемый ресурс](#resource-create)
* [Создайте и проверьте профиль безопасности](#security-profile)
* [Подключите профиль безопасности к защищаемому ресурсу](#profile-connect)
* [Посмотрите работу профиля безопасности](#monitoring)
* (Опционально) [Создайте и подключите профиль WAF](#waf)
* (Опционально) [Создайте и подключите профиль ARL](#arl)

{{ sws-name }} — это набор инструментов защиты, которые рекомендуется настраивать последовательно. Включайте каждое новое изменение в режиме **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** и [анализируйте логи](operations/configure-logging.md). Это облегчит отслеживание и корректировку правил.

Если не получается настроить {{ sws-name }}:

* Для Бизнес и Премиум [тарифов поддержки](../support/pricing.md) — обратитесь в [поддержку]({{ link-console-support }}).
* В других случаях обратитесь к аккаунт-менеджеру для связи со специалистами сервиса.

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md) и [привяжите](../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../resource-manager/concepts/resources-hierarchy.md).


## Создайте и настройте защищаемый ресурс {#resource-create}

{% list tabs group=resources %}

- L7-балансировщик {#balancer}

  {{ alb-name }} равномерно распределяет входящий трафик между узлами, что позволяет избежать перегрузки и повысить отказоустойчивость. Если у вас еще не настроен L7-балансировщик, вы можете развернуть [тестовую инфраструктуру](tutorials/balancer-with-sws-profile/index.md).

- API-шлюз {#api-gateway}

  API-шлюз — единая точка входа для API различных сервисов, которая позволяет управлять запросами, маршрутизацией, аутентификацией и так далее. Если у вас еще не настроен API-шлюз, вы можете развернуть шлюз с [тестовой спецификацией](../api-gateway/tutorials/api-gw-sws-integration.md).

- Домен {#domain}

  Домен — сервер, сайт, приложение, которое обрабатывает внешние запросы по веб-адресу. Для защиты домена {{ sws-name }} предоставляет прокси-сервер с балансировкой нагрузки, анализом и маршрутизацией запросов. А также базовой [защитой от DDoS](../vpc/ddos-protection/index.md).
  
  На прокси-сервере установлено ограничение MTU для всех пакетов — 1450 байт.

  {% note info %}
  
  Функциональность защиты доменов находится на стадии [Preview](../overview/concepts/launch-stages.md).
  
  {% endnote %}

  ### Подготовьте данные о ресурсе {#domain-info}
  
    * Адрес домена, на котором работает веб-приложение. У вас должен быть доступ к кабинету управления доменом, чтобы изменить А-запись.
    * IP-адрес сервера, порт и протокол, на котором работает веб-приложение.
    * Действительный приватный ключ и TLS-сертификат для этого домена в [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded формате. Поддерживаются сертификаты с ключами RSA-2048 и RSA-4096.

  ### Создайте прокси-сервер {#create-proxy}

  {% note info %}
  
  Чтобы создать [прокси-сервер](concepts/domain-protect.md#proxy), пользователю должны быть [назначены](../iam/operations/roles/grant.md#cloud-or-folder) роли [`smart-web-security.admin`](security/index.md#smart-web-security-admin), [`resource-manager.admin`](../resource-manager/security/index.md#resource-manager-admin) и [`iam.serviceAccounts.admin`](../iam/security/index.md#iam-serviceAccounts-admin) на [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается прокси-сервер.
  
  {% endnote %}

  {% list tabs group=instructions %}

  - Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
    1. На панели слева выберите ![domain-protection-icon](../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.ProxyServers.createProxyServer_jatYQ }}**.
    1. Введите произвольное имя для прокси-сервера, например, `test-proxy`.
    1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.ProxyServerFormCreate.createServer_sycVk }}**.
    
        Для работы с прокси-сервером будет создан сервисный аккаунт с ролями `monitoring.editor`, `smart-web-security.admin`, `certificate-manager.admin`, `logging.writer`.
                
        Создание прокси-сервера может занять несколько минут. Дождитесь, когда сервер перейдет в статус `Active`. После этого можно добавить домен.

  {% endlist %}

  ### Добавьте домен {#add-domain}

  {% list tabs group=instructions %}

  - Консоль управления {#console}

    1. В меню слева перейдите на вкладку ![globe](../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}** и нажмите кнопку **{{ ui-key.yacloud.smart-web-security.ProxyServer.Domains.createDomain_49MGX }}**.
    1. Введите адрес домена, на котором находится ваше веб-приложение, например, `example.com`.
    1. Нажмите **{{ ui-key.yacloud.common.continue }}**.
    1. Выберите тип соединения, которое используется в вашем приложении. Рекомендуем выбрать защищенный протокол **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.https_qWPJb }}**.
    1. Если вы используете сервис [{{ certificate-manager-name }}](../certificate-manager/index.md) и добавляли в него сертификат вашего домена, выберите его из списка. 
    1. Если вы не используете {{ certificate-manager-name }}, нажмите кнопку **{{ ui-key.yacloud.common.create }}** → **{{ ui-key.yacloud.certificate-manager.CertificateField.userCertificate_bChXn }}**.
       1. Введите произвольное имя сертификата.
       1. Скопируйте или загрузите файлом приватный ключ, сертификат и цепочку промежуточных сертификатов в формате PEM.
       1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.CertificateImportDialog.createCertificate_x7Ww3 }}**.
    1. Нажмите **{{ ui-key.yacloud.common.continue }}**.

    1. В блоке **{{ ui-key.yacloud.smart-web-security.DomainForm.TargetResourcesSection.targetResources_hqBQm }}** задайте настройки целевых ресурсов:
       1. IP-адрес и порт, на котором работает ваше веб-приложение.
       1. (Опционально) Разверните блок **{{ ui-key.yacloud.smart-web-security.DomainForm.TargetResourcesSection.connectTargetResources_1mGNK }}**, чтобы выбрать протокол, на котором работает ваше веб-приложение.
    1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.CreateDomain.createDomain_b2Ykj }}**.

    После создания домена откроется страница обзора параметров домена. В разделе **{{ ui-key.yacloud.smart-web-security.Domain.Overview.howToActivateProtection_dK3yy }}** скопируйте IP-адрес прокси-сервера, он потребуется на следующем шаге.
  
  {% endlist %}

  ### Настройте вашу инфраструктуру {#infrastructure-settings}
  
  1. Добавьте ресурсную [А-запись](../dns/concepts/resource-record.md#a) в публичную DNS-зону вашего домена, указав в ней значения:
     
     * `Имя записи` — адрес вашего домена, заканчивающийся на точку. Например: `example.com.` или `my.first.example.com.`.
     * `Значение` — полученный на предыдущем шаге IPv4-адрес прокси-сервера.
     
     Эта запись перенаправляет запросы, которые поступают на ваш домен, на IP-адрес прокси-сервера.
     
     {% note info %}
     
     Если ваш домен делегирован {{ dns-full-name }}, создайте ресурсную запись по [инструкции](../dns/operations/resource-record-create.md). В остальных случаях воспользуйтесь личным кабинетом вашего регистратора доменных имен. Если нужна помощь, обратитесь к документации регистратора или в его поддержку.
     
     {% endnote %}
  1. В настройках вашего сервера запретите все соединения и разрешите только соединения для [IP-адресов {{ yandex-cloud }}](../overview/concepts/public-ips.md).
  
  ### Проверьте статус вашего ресурса {#check-status}

  {% list tabs group=instructions %}

  - Консоль управления {#console}

    1. В разделе ![domain-protection-icon](../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}** выберите созданный прокси-сервер.
    1. В меню слева перейдите на вкладку ![globe](../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}** и выберите созданный домен.
    1. В блоке **{{ ui-key.yacloud.smart-web-security.Domain.Overview.targetResources_cNZPL }}** убедитесь, что ваш ресурс находится в статусе **{{ ui-key.yacloud.smart-web-security.DomainTargetStateStatus.statusHealthy_5F2ks }}**.
    
        Если это не так, прокси-сервер не может соединиться с вашим ресурсом. Проверьте адрес вашего веб-сервера и настройки сети. Убедитесь, что к веб-серверу разрешен доступ с [IP-адресов {{ yandex-cloud }}](../overview/concepts/public-ips.md).
    1. На панели слева убедитесь, что ваш домен находится в статусе **{{ ui-key.yacloud.smart-web-security.DomainTargetStateStatus.statusHealthy_5F2ks }}**. 
        
        Если это не так, проверьте адрес домена и А-запись, а также валидность сертификата.

  {% endlist %}

{% endlist %}

## Создайте и проверьте профиль безопасности {#security-profile}

### Создайте профиль безопасности {#profile-create}

{% note info %}

Чтобы сделать вашу защиту более эффективной, мы используем информацию об HTTP-запросах для развития моделей машинного обучения (ML). Вы можете отключить использование этой информации в [консоли управления]({{ link-console-main }}) при создании профиля безопасности или позднее в его настройках.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находятся защищаемые ресурсы.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![shield-check](../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.action_empty }}** и выберите **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

      Преднастроенный профиль содержит:
      
      * [базовое правило](concepts/rules.md#base-rules) по умолчанию, включенное для всего трафика с [типом действия](concepts/rules.md#rule-action) `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-allow }}`;
      * [правило Smart Protection](concepts/rules.md#smart-protection-rules) `sp-rule-1`, включенное для всего трафика, с типом действия `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`.

      {% note tip %}
      
      Создание преднастроенного профиля с полной защитой Smart Protection является предпочтительным. Рекомендуем использовать его, чтобы обеспечить наибольшую безопасность защищаемого ресурса.
      
      {% endnote %}

  1. Введите имя профиля, например `test-sp1`.
  1. В поле **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** выберите `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`.
  1. (Опционально) Включите или отключите использование информации об HTTP-запросах для улучшения моделей машинного обучения в разделе **{{ ui-key.yacloud.component.disallow-data-processing.title_ml-model-training }}**.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

Рекомендации по настройке профиля безопасности см. в руководстве [{#T}](tutorials/sws-basic-protection.md).

### Проверьте настройки профиля безопасности {#profile-check}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите профиль `test-sp1`, созданный ранее.
  1. Убедитесь, что на вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** есть правило со следующими параметрами:

      * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}** — `{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}** — `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `{{ ui-key.yacloud.component.condition-column.condition_full-trafic }}`.

      Это правило отправляет весь трафик, приходящий к защищаемому ресурсу, на автоматическую оценку с помощью алгоритмов машинного обучения и поведенческого анализа. По результатам автоматической оценки:

      * Легитимные запросы направляются к защищаемому ресурсу.
      * Нелегитимные запросы и атаки блокируются.
      * Подозрительные запросы направляются в {{ captcha-name }} для дополнительной верификации.

{% endlist %}


## Подключите профиль безопасности к ресурсу {#profile-connect}

Способ подключения зависит от типа ресурса.

{% list tabs %}
  
- L7-балансировщик {#balancer}
  
  Если балансировщик управляется [Ingress-контроллером](../application-load-balancer/tools/k8s-ingress-controller/index.md) {{ alb-name }}, используйте [аннотацию ресурса Ingress](../application-load-balancer/k8s-ref/ingress.md#annot-security-profile-id).
  
  Чтобы подключить виртуальный хост:
  
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный [профиль безопасности](concepts/profiles.md).
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
    1. На панели слева выберите ![shield-check](../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
    1. Выберите профиль безопасности, который вы хотите подключить к [виртуальному хосту](../application-load-balancer/concepts/http-router.md#virtual-host) сервиса [{{ alb-full-name }}](../application-load-balancer/index.md).
    1. Нажмите кнопку ![plug](../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
    1. В открывшемся окне нажмите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_add-resource_v4U3g }}** и выберите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_virtual-host_tYim5 }}**.
    1. Последовательно установите значения в полях [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}**](../application-load-balancer/concepts/application-load-balancer.md), [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}**](../application-load-balancer/concepts/http-router.md) и [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}**](../application-load-balancer/concepts/http-router.md#virtual-host). Вы можете подключить профиль безопасности сразу к нескольким хостам.
  
        Чтобы подключить профиль к еще одному L7-балансировщику, нажмите кнопку **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_add-resource_v4U3g }}** и выберите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_virtual-host_tYim5 }}**.
      
    1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**. Если выбранные хосты уже подключены к другому профилю безопасности, подтвердите подключение.
  
        В разделе ![cubes-3-overlap](../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.common.connected_resources }}** появятся подключенные виртуальные хосты.
  
- API-шлюз {#api-gateway}
    
  Чтобы подключить API-шлюз:
  
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный [профиль безопасности](concepts/profiles.md).
    1. На панели слева выберите ![shield-check](../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
    1. Выберите профиль безопасности, который вы хотите подключить к API-шлюзу.
    1. Нажмите кнопку ![plug](../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
    1. В открывшемся окне нажмите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_add-resource_v4U3g }}** и выберите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_api-gateway_sKMCK }}**.
    1. Установите значение в поле **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.ApiGatewayItem.label_api-gateway_5Nttt }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.
  
        В разделе ![cubes-3-overlap](../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.common.connected_resources }}** появятся подключенные API-шлюзы.
  
- Домен {#domain}
  
  Чтобы подключить домен:
  
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный [профиль безопасности](concepts/profiles.md).
    1. На панели слева выберите ![shield-check](../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
    1. Выберите профиль безопасности, который вы хотите подключить к домену.
    1. Нажмите кнопку ![plug](../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
    1. В открывшемся окне нажмите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_add-resource_v4U3g }}** и выберите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_domain_9Bo38 }}**.
    1. Последовательно установите значения в полях **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.ProxyServerItem.label_proxy-server_w9BGG }}** и **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.ProxyServerItem.label_domain_1hgsY }}**. Вы можете подключить профиль безопасности сразу к нескольким доменам.
    1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.
  
        В разделе ![cubes-3-overlap](../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.common.connected_resources }}** появятся подключенные домены.

{% endlist %}


## Посмотрите работу профиля безопасности {#monitoring}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице сервиса **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}** на панели слева выберите раздел ![display-pulse](../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud_billing.common.monitoring }}**.
  1. Посмотрите [графики](operations/monitoring.md) разрешенных и заблокированных запросов.

{% endlist %}

## Создайте и подключите профиль WAF {#waf}

WAF позволяет использовать наборы правил для защиты веб-приложений от множества информационных атак. Рекомендуется настраивать профиль WAF после того, как будут настроены и протестированы базовые правила и Smart Protection в профиле безопасности.

### Создайте профиль WAF {#waf-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать профиль WAF.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Перейдите на вкладку ![image](../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}** и нажмите **{{ ui-key.yacloud.smart-web-security.waf.label_create-profile }}**.
  1. Введите имя профиля, например `test-waf-profile-1`.
  1. Включите набор правил, например [OWASP Core Rule Set](https://coreruleset.org/), и последнюю версию набора. Чтобы посмотреть правила в наборе, нажмите на строку с его описанием.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


### Настройте набор правил {#waf-configure-rules}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На открывшейся обзорной странице профиля WAF напротив нужного набора нажмите кнопку ![image](../_assets/console-icons/gear.svg) **Настроить**.
  1. Установите **{{ ui-key.yacloud.smart-web-security.waf.label_anomaly-threshold }}** — суммарную [аномальность](concepts/waf.md#anomaly) сработавших правил, при которой запрос будет заблокирован, например `{{ ui-key.yacloud.smart-web-security.waf.label_anomaly-medium }}`.

      Рекомендуется начинать с порога аномальности `25` и постепенно снижать его до `5`. Чтобы снизить порог аномальности, отработайте ложные срабатывания WAF на легитимные запросы. Для этого подберите правила из базового набора и настройте [правила-исключения](#create-exclusion). Также для тестирования разных порогов аномальности используйте в профиле безопасности режим **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry-run)**.

  1. Установите **{{ ui-key.yacloud.smart-web-security.waf.label_paranoia-level }}**, например `{{ ui-key.yacloud.smart-web-security.waf.label_paranoia-option-1 }}`.

      [Уровень паранойи](concepts/waf.md#paranoia) классифицирует правила по степени агрессивности. Чем выше уровень паранойи, тем лучше уровень защиты, но и больше вероятность ложных срабатываний WAF.

  1. Проверьте включенные в набор правила, при необходимости включите дополнительные или уберите ненужные. При работе с правилами обращайте внимание на значение их аномальности и уровень паранойи.

  Любое правило из набора можно сделать блокирующим. Запрос, соответствующий таком правилу, будет заблокирован независимо от установленного порога аномальности. Чтобы сделать правило блокирующим, нажмите ![image](../_assets/console-icons/ban.svg) справа от него. Если в профиле безопасности включен режим **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry-run)**, запросы не будут заблокированы, даже если они соответствуют блокирующим правилам.

{% endlist %}


### Создайте правило-исключение {#create-exclusion}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на вкладку ![image](../_assets/console-icons/file-xmark.svg) **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rules }}** и нажмите **{{ ui-key.yacloud.smart-web-security.waf.label_create-exclusion-rule }}**.
  1. Введите имя [правила-исключения](concepts/waf.md#exclusion-rules), например `exception-rule-1`.
  1. В блоке **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-rules-section }}** укажите правила из базового набора, для которых будет срабатывать исключение. Вы можете выбрать `{{ ui-key.yacloud.smart-web-security.waf.value_exclude-all-yes }}` или указать конкретные.
  1. В блоке **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-condition-section }}** выберите [условия](concepts/conditions.md) для срабатывания правила-исключения.

      Если оставить поле **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** пустым, правило-исключение будет применено ко всему трафику.

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


### Подключите профиль WAF к профилю безопасности {#waf-connect}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на вкладку ![image](../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. В списке выберите профиль безопасности, к которому вы хотите подключить профиль WAF, например `test-sp1`.
  1. Нажмите ![plus-sign](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Введите имя правила, например `waf-rule-1`.
  1. В поле **{{ ui-key.yacloud.smartcaptcha.field_security-rule_priority }}** задайте значение выше, чем у правил Smart Protection, уже имеющихся в профиле безопасности, например `888800`.
  1. (Опционально) Чтобы протестировать профиль WAF и отработать ложные срабатывания на легитимные запросы, используйте в профиле безопасности режим **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry-run)**.
  1. В поле **Тип правила** выберите `{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}`.
  1. В поле **{{ ui-key.yacloud.smart-web-security.overview.title_waf-profile }}** выберите `test-waf-profile-1`, созданный ранее.
  1. В поле **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}** выберите `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`.
  1. При необходимости задайте [условия](concepts/conditions.md) для сопоставления трафика.
  1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}


## Создайте и подключите профиль ARL {#arl}

ARL позволяет устанавливать лимиты на количество запросов к защищаемому ресурсу, чтобы избежать чрезмерной нагрузки.

### Создайте профиль ARL {#arl-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать профиль ARL.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Перейдите на вкладку ![image](../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}** и нажмите **{{ ui-key.yacloud.smart-web-security.arl.label_create-profile }}**.
  1. Введите имя профиля, например `test-arl-profile-1`.
  1. При необходимости добавьте описание профиля и метки.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


### Настройте правила {#arl-configure-rules}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На открывшейся обзорной странице профиля ARL нажмите **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Введите имя правила, например `arl-rule-1`.
  1. В поле **{{ ui-key.yacloud.smartcaptcha.field_security-rule_priority }}** задайте приоритет выполнения правила в рамках профиля ARL, например `1000`.
  1. (Опционально) Чтобы протестировать правило ARL, включите режим **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (Dry run)**. В этом режиме запросы блокироваться не будут.
  1. В блоке **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-condition-section }}** выберите `Весь трафик` или `При условии`.
  1. Чтобы задать [условия на трафик](concepts/conditions.md), в списке **Условия** выберите один или несколько пунктов:

      * `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}` — IP-адрес, диапазон адресов, регион IP-адресов или [список адресов](concepts/lists.md);
      * `{{ ui-key.yacloud.component.condition-column.condition_name-header }}` — строка в заголовке HTTP;
      * `{{ ui-key.yacloud.component.condition-column.condition_name-host }}` — домен, на который пришел запрос;
      * `{{ ui-key.yacloud.component.condition-column.condition_name-httpMethod }}` — метод запроса;
      * `{{ ui-key.yacloud.component.condition-column.condition_name-cookie }}` — строка в заголовке cookie.

  1. В блоке **Подсчет запросов** выберите, как считать запросы для применения лимита:

      * `{{ ui-key.yacloud.smart-web-security.arl.label_rule-without-grouping }}` — подсчет каждого запроса в отдельности;
      * `По характеристикам` — подсчет количества групп запросов, объединенных одной или несколькими характеристиками.

      1. Выберите характеристику для группировки:

          * `Request path` — путь запроса;
          * `{{ ui-key.yacloud.component.condition-column.condition_name-httpMethod }}` — метод запроса;
          * `IP адрес` — IP-адрес, с которого пришел запрос;
          * `Регион` — регион, которому принадлежат IP-адреса запросов;
          * `{{ ui-key.yacloud.component.condition-column.condition_name-host }}` — домен, на который пришел запрос;
          * `HTTP cookie` — строка в заголовке cookie;
          * `{{ ui-key.yacloud.component.condition-column.condition_name-header }}` — строка в заголовке HTTP;
          * `Query params` — строка в параметрах запроса.

      1. (Опционально) Включите опцию **Учитывать регистр**, чтобы характеристики с одинаковыми значениями, но в разном регистре попадали в разные группы.

  1. Укажите лимит запросов и выберите промежуток времени, например `1000` запросов за `1` минуту.
  
  1. В блоке **При превышении лимита запросов** выберите действие:
     
     * **Блокировать запросы свыше лимита** (доступно без группировки запросов) — заблокировать все запросы, которые поступят в период, заданный в лимите запросов.
     * **Временно блокировать все запросы** (доступно при группировке запросов) и укажите период времени, в течение которого запросы будут блокироваться.
     * **Показать капчу для запросов свыше лимита** — отправлять на капчу все запросы, которые поступят в период, заданный в лимите запросов. Капчу можно настроить в [профиле безопасности](operations/profile-create.md), к которому подключен профиль ARL.
  
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.arl.label_save-rule }}**.

{% endlist %}


### Подключите профиль ARL к профилю безопасности {#arl-connect}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на вкладку ![image](../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. В списке выберите профиль безопасности, к которому вы хотите подключить профиль ARL, например `test-sp1`.
  1. Нажмите ![image](../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. В списке **{{ ui-key.yacloud.smart-web-security.form.label_arl-profile }}** выберите `test-arl-profile-1`, созданный ранее.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}


#### См. также {#see-also}

* [{#T}](operations/profile-create.md)
* [{#T}](tutorials/sws-basic-protection.md)