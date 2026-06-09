# Базовая настройка защиты в {{ sws-name }}

[{{ sws-name }}](../../smartwebsecurity/concepts/index.md) (SWS) защищает веб-ресурсы от интернет-угроз, фильтруя вредоносный трафик.

Для индивидуальной настройки можно подключить несколько инструментов {{ sws-name }}:

* базовые правила для простой фильтрации;
* правила Smart Protection для защиты от DDoS;
* [{{ captcha-name }}](../../smartcaptcha/index.md) для защиты от ботов;
* Web Application Firewall (WAF) — от эксплуатации уязвимостей;
* Advanced Rate Limiter (ARL) для ограничения трафика.

Каждый инструмент настраивается по этапам: добавление правил, проверка в реальных условиях и корректировка. Рекомендуется настраивать инструменты последовательно, начиная с базовых правил и Smart Protection. Это позволит быстро включить защиту и облегчить отслеживание и корректировку правил.

В этом руководстве вы настроите защиту веб-ресурса с помощью инструментов SWS, которые будут подключаться к профилю безопасности — центральному элементу SWS. Настройка профиля безопасности включает калибровку правил на основе реального трафика веб-приложения. Поэтому предполагается, что у вас уже есть настроенный веб-ресурс в {{ yandex-cloud }} или в другой инфраструктуре. 

## Порядок работы {#steps}

1. Подключение ресурсов к {{ yandex-cloud }}:
   1. [Подготовьте облако к работе](#before-you-begin)
   1. [Создайте защищаемый ресурс](#resource-create)

1. [Настройте защиту от DDoS и ботов](#antiddos-antibot-protection):

   1. [Создайте профиль безопасности](#security-profile-create)
   1. [Настройте фильтрацию по спискам адресов](#list-filters)
   1. (Опционально) [Настройте фильтрацию по регионам](#region-filters)
   1. [Настройте разрешающее правило для капчи](#captcha-rule)
   1. [Проверьте порядок выполнения правил](#rules-execution-order)
   1. [Подключите профиль безопасности к ресурсам](#profile-connect)
   1. [Проверьте профиль безопасности в режиме логирования](#test-sp-rules)
   1. [Проверьте профиль безопасности в реальном режиме](#check-sp-rules)

1. [Настройте ограничение нагрузки](#rate-limiter):

   1. [Создайте профиль ARL](#arl-create)
   1. [Настройте правила ARL](#arl-configure-rules)
   1. [Добавьте профиль ARL к профилю безопасности](#arl-add-to-profile)
   1. [Проверьте работу правил ARL](#test-arl-rules)

1. (Опционально) [Настройте Web Application Firewall](#firewall)

   1. [Создайте профиль WAF](#waf-create)
   1. [Настройте набор правил Yandex Ruleset](#waf-configure-rules)
   1. [Создайте правило-исключение](#create-exclusion)
   1. [Добавьте профиль WAF к профилю безопасности](#waf-add-to-profile)
   1. [Проверьте работу правил WAF](#test-waf-rules)

## Необходимые платные ресурсы {#paid-resources}

* [Плата за количество запросов](../../smartwebsecurity/pricing.md) в сервис {{ sws-name }}.
* Плата за инфраструктуру [{{ alb-name }}](../../application-load-balancer/pricing.md) или [{{ api-gw-name }}](../../api-gateway/pricing.md) при ее использовании.
* Плата за ресурсы [прокси-сервера](../../smartwebsecurity/pricing.md) при использовании [доменов](../../smartwebsecurity/concepts/domain-protect.md).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

## Создайте защищаемый ресурс {#resource-create}

Профиль безопасности можно подключить к разным типам ресурсов:

* [Виртуальный хост](../../application-load-balancer/concepts/http-router.md#virtual-host) или [Ingress-контроллер](../../application-load-balancer/tools/k8s-ingress-controller/index.md#smart-web-security) для защиты ресурсов, использующих {{ alb-full-name }}. 
* API-шлюз [{{ api-gw-name }}](../../api-gateway/concepts/index.md) для защиты API ваших приложений.
* [Домен](../../smartwebsecurity/concepts/domain-protect.md) для защиты вашего сайта или веб-приложения, расположенного в {{ yandex-cloud }}, в вашей внутренней инфраструктуре или на других хостингах.

Руководство предполагает, что у вас уже есть настроенный веб-ресурс. Если ресурс находится вне {{ yandex-cloud }} или вы не используете {{ alb-name }} и {{ api-gw-name }}, создайте домен по инструкции ниже. Также можно ознакомиться с документацией других сервисов, которые работают с {{ sws-name }}, и настроить соответствующую инфраструктуру.

{% list tabs group=resources %}

- L7-балансировщик {#balancer}

  [{{ alb-name }}](../../smartwebsecurity/tutorials/balancer-with-sws-profile/index.md) равномерно распределяет входящий трафик между узлами, что позволяет избежать перегрузки и повысить отказоустойчивость.

- API-шлюз {#api-gateway}

  [API-шлюз](../../api-gateway/tutorials/api-gw-sws-integration.md) — единая точка входа для API различных сервисов, которая позволяет управлять запросами, маршрутизацией, аутентификацией и так далее.

- Домен {#domain}

  Домен — сервер, сайт, приложение, которое обрабатывает внешние запросы по веб-адресу. Для защиты домена {{ sws-name }} предоставляет прокси-сервер с балансировкой нагрузки, анализом и маршрутизацией запросов, а также базовой [защитой от DDoS](../../vpc/ddos-protection/index.md).

  На прокси-сервере установлено ограничение MTU для всех пакетов — 1450 байт.

  {% note info %}
  
  Функциональность защиты доменов находится на стадии [Preview](../../overview/concepts/launch-stages.md).
  
  {% endnote %}

  ### Подготовьте данные о ресурсе {#domain-info}

  * Адрес домена, на котором работает веб-приложение. У вас должен быть доступ к кабинету управления доменом, чтобы изменить A-запись.
  * IP-адрес сервера, порт и протокол, на котором работает веб-приложение.
  * Действительный приватный ключ и TLS-сертификат для этого домена в [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded формате. Поддерживаются сертификаты с ключами RSA-2048 и RSA-4096.

  ### Создайте прокси-сервер {#create-proxy}

  {% note info %}
  
  Чтобы создать [прокси-сервер](../../smartwebsecurity/concepts/domain-protect.md#proxy), пользователю должны быть [назначены](../../iam/operations/roles/grant.md#cloud-or-folder) роли [`smart-web-security.admin`](../../smartwebsecurity/security/index.md#smart-web-security-admin), [`resource-manager.admin`](../../resource-manager/security/index.md#resource-manager-admin) и [`iam.serviceAccounts.admin`](../../iam/security/index.md#iam-serviceAccounts-admin) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается прокси-сервер.
  
  {% endnote %}

  {% list tabs group=instructions %}

  - Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
    1. На панели слева выберите ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.ProxyServers.createProxyServer_jatYQ }}**.
    1. Введите произвольное имя для прокси-сервера, например, `test-proxy`.
    1. Включите опцию **Логировать запросы**.
    1. Выберите существующую лог-группу или [создайте новую](../../logging/operations/create-group.md).
    1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.ProxyServerFormCreate.createServer_sycVk }}**.

        Для работы с прокси-сервером будет создан сервисный аккаунт с ролями `monitoring.editor`, `smart-web-security.admin`, `certificate-manager.admin`, `logging.writer`.
                
        Создание прокси-сервера может занять несколько минут. Дождитесь, когда сервер перейдет в статус `Active`. После этого можно добавить домен.

  {% endlist %}

  ### Добавьте домен {#add-domain}

  {% list tabs group=instructions %}

  - Консоль управления {#console}

    1. В меню слева перейдите на вкладку ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}** и нажмите кнопку **{{ ui-key.yacloud.smart-web-security.ProxyServer.Domains.createDomain_49MGX }}**.
    1. Введите адрес домена, на котором находится ваше веб-приложение, например, `example.com`.
    1. Нажмите **{{ ui-key.yacloud.common.continue }}**.
    1. Выберите тип соединения, которое используется в вашем приложении. Рекомендуем выбрать защищенный протокол **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.https_qWPJb }}**.
    1. Если вы используете сервис [{{ certificate-manager-name }}](../../certificate-manager/index.md) и добавляли в него сертификат вашего домена, выберите его из списка. 
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

  1. Добавьте ресурсную [А-запись](../../dns/concepts/resource-record.md#a) в публичную DNS-зону вашего домена, указав в ней значения:
     
     * `Имя записи` — адрес вашего домена, заканчивающийся на точку. Например: `example.com.` или `my.first.example.com.`.
     * `Значение` — полученный на предыдущем шаге IPv4-адрес прокси-сервера.
     
     Эта запись перенаправляет запросы, которые поступают на ваш домен, на IP-адрес прокси-сервера.
     
     {% note info %}
     
     Если ваш домен делегирован {{ dns-full-name }}, создайте ресурсную запись по [инструкции](../../dns/operations/resource-record-create.md). В остальных случаях воспользуйтесь личным кабинетом вашего регистратора доменных имен. Если нужна помощь, обратитесь к документации регистратора или в его поддержку.
     
     {% endnote %}
  1. В настройках вашего сервера запретите все соединения и разрешите только соединения для [IP-адресов {{ yandex-cloud }}](../../overview/concepts/public-ips.md).

  ### Проверьте статус вашего ресурса {#check-status}

  {% list tabs group=instructions %}

  - Консоль управления {#console}

    1. В разделе ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}** выберите созданный прокси-сервер.
    1. В меню слева перейдите на вкладку ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}** и выберите созданный домен.
    1. В блоке **{{ ui-key.yacloud.smart-web-security.Domain.Overview.targetResources_cNZPL }}** убедитесь, что ваш ресурс находится в статусе **{{ ui-key.yacloud.smart-web-security.DomainTargetStateStatus.statusHealthy_5F2ks }}**.
    
        Если это не так, прокси-сервер не может соединиться с вашим ресурсом. Проверьте адрес вашего веб-сервера и настройки сети. Убедитесь, что к веб-серверу разрешен доступ с [IP-адресов {{ yandex-cloud }}](../../overview/concepts/public-ips.md).
    1. На панели слева убедитесь, что ваш домен находится в статусе **{{ ui-key.yacloud.smart-web-security.DomainTargetStateStatus.statusHealthy_5F2ks }}**. 
        
        Если это не так, проверьте адрес домена и А-запись, а также валидность сертификата.

  {% endlist %}

{% endlist %}

## Настройте защиту от DDoS и ботов {#antiddos-antibot-protection}

### Создайте профиль безопасности {#security-profile-create}

Профиль безопасности настраивается в соответствии с моделью угроз — описанием возможных рисков, атакующих сторон и уязвимостей с учетом особенностей вашего сервиса. Если вы настраиваете защиту без участия специалистов по информационной безопасности, рекомендуется использовать готовый шаблон профиля, настроенный экспертами {{ yandex-cloud }}. Это обеспечит базовый уровень защиты и поможет сократить вероятность ошибок при настройке.

В этом руководстве при настройке используется готовый шаблон профиля безопасности.

{% note info %}

Правило WAF содержит защиту DDoS L7, поэтому при его добавлении в профиль безопасности правило Smart Protection можно не добавлять.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находятся защищаемые ресурсы.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.action_empty }}** и выберите **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

      Преднастроенный профиль содержит:
      
      * [базовое правило](../../smartwebsecurity/concepts/rules.md#base-rules) по умолчанию, включенное для всего трафика с [типом действия](../../smartwebsecurity/concepts/rules.md#rule-action) `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-allow }}`;
      * [правило Smart Protection](../../smartwebsecurity/concepts/rules.md#smart-protection-rules) `sp-rule-1`, включенное для всего трафика, с типом действия `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`.
   
  1. Введите имя профиля, например `site-protection`.

  1. Включите тестовый режим для правила Smart Protection `sp-rule-1`:
     1. Для опции **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** выберите `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
     1. Напротив правила `sp-rule-1` нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
     1. Включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
     1. Нажмите **{{ ui-key.yacloud.common.save-changes }}**.

      {% note info %}

      Правила в профиле безопасности применяются по принципу первого сработавшего правила в порядке приоритета. Правила, которые находятся в режиме **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**, фактически не срабатывают. В логи записывается информация только о возможном срабатывании правил. Поэтому первым сработавшим правилом будет базовое правило по умолчанию с типом действия `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}`. Это заблокирует весь трафик к вашему ресурсу. Чтобы этого не случилось, переведите базовое правило по умолчанию в режим `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.

      Трафик, обработанный правилами в режиме **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**, тарифицируется. Подробнее см. раздел [{#T}](../../smartwebsecurity/pricing.md).
      
      {% endnote %}

  1. (Опционально) Настройте политики безопасности для API-вызовов.
   
      Если ваш сервис дополнительно обрабатывает запросы к публичному API, настройте отдельное правило Smart Protection с действием `Защита API`. В отличие от полной защиты, в таком режиме запросы не отправляются в {{ captcha-name }} для дополнительной проверки на автоматизированный трафик. Для этого правила тоже включите режим **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.

     1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
     1. Введите имя правила, например `api-protection`.
     1. Задайте приоритет выше, чем у правила с полной защитой. Например, `900000`.
     1. Включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
     1. Укажите параметры правила:
        * **Тип правила** — `{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}`.
        * **Действие** — `Защита API`.
        * **Трафик** — `При условии`.
        * **Условия** — `Request URI`.
        * **Request path** — относительный путь для запросов к API. Например, ваш основной домен — `example.com`, а запросы к API принимаются по адресу `example.com/api`. Тогда в условии выберите `Начинается с` и укажите относительный путь — `/api`.
     1. Нажмите **{{ ui-key.yacloud.smart-web-security.action_empty }}**.
  
  1. В разделе **{{ ui-key.yacloud.component.disallow-data-processing.title_ml-model-training }}** оставьте включенным согласие об использовании информации об HTTP-запросах для улучшения моделей машинного обучения. Иначе в сервис {{ sws-name }} не будут поступать данные для расследования инцидентов безопасности.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Настройте фильтрацию по спискам адресов {#list-filters}

[Списки адресов](../../smartwebsecurity/concepts/lists.md) помогают оптимизировать проверку трафика, разрешая запросы для заведомо надежных (белых) адресов. Небезопасные или сомнительные адреса можно сразу блокировать или отправлять в {{ captcha-name }}.

В {{ sws-name }} предустановлены списки ненадежных (черных) IP-адресов. Списки белых адресов, например, адреса ваших контрагентов или партнеров, вы добавляете вручную. Также можно добавить собственные списки черных адресов.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Добавьте свои черные и белые списки адресов.

     1. На панели слева выберите **{{ ui-key.yacloud.smart-web-security.match-lists.label_match-lists }}**.
     1. Нажмите **{{ ui-key.yacloud.smart-web-security.match-lists.label_create-list }}**.
     1. Введите имя списка, например, `my-partners`, и нажмите **{{ ui-key.yacloud.smart-web-security.match-lists.label_create-match-list }}**.
     1. Нажмите **{{ ui-key.yacloud.smart-web-security.MatchListTable.button_add-to-list_1kKXh }}**.
     1. Введите или загрузите список белых адресов, которые не нуждаются в фильтрации.
     1. Нажмите **{{ ui-key.yacloud.common.save-changes }}**.
     1. При необходимости добавьте список черных адресов.
  
  1. Настройте правило блокировки по спискам IP-адресов.
     1. На панели слева выберите **{{ ui-key.yacloud.smart-web-security.title_profiles }}** и выберите профиль `site-protection`.
     1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
     1. Введите имя правила, например `block-by-list`.
     1. Задайте **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** выше, чем у правил Smart Protection. Например, `9100`.
     1. Включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
     1. Укажите параметры правила:
        * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}** — `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
        * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}** — `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` или `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}`.
        * **Трафик** — `При условии`.
        * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`.
        * **Условия на IP** — `IP принадлежит списку`.
        * Выберите список `is_ddoser` (IP-адреса, которые участвовали в DDoS-атаках). Запросы с этих адресов будут блокироваться.
        * Чтобы добавить еще один список, нажмите кнопку **+ или** и выберите список.
  
          Добавьте предустановленные списки `is_tor` (IP-адреса сети TOR, которая используется для анонимизации трафика), `is_anonimous` (IP-адреса анонимных сетей, которые часто используются для сокрытия личности) и свои черные списки.
       1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

  1. Настройте разрешающее правило, которое будет пропускать все запросы с белых IP-адресов.
     1. В профиле `site-protection` нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
     1. Введите имя правила, например `allow-by-list`.
     1. Задайте **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** выше, чем у блокирующего правила для черных списков. Например, `9000`.
     1. Включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
     1. Укажите параметры правила:
        * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}** — `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
        * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}** — `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
        * **Трафик** — `При условии`.
        * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`.
        * **Условия на IP** — `IP принадлежит списку`.
        * Выберите созданные ранее белые списки адресов.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

### Настройте фильтрацию по регионам {#region-filters}

Если ваш сервис не ожидает трафика из определенных стран, можно настроить политики его обработки. Например, блокировать или отправлять на капчу.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В профиле `site-protection` нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Введите имя правила, например `block-by-geo`.
  1. Включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
  1. Задайте **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** выше, чем у правил Smart Protection, но ниже, чем у правил по спискам IP-адресов. Например, `9200`.
  1. Укажите параметры правила:
      * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}** — `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}** — `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` или `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}`.
      * **Трафик** — `При условии`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`.
      * **Условия на IP** — `IP принадлежит региону`.
      * Выберите регион, в котором ваш сервис не работает. Например, `CN`, `US`, `IN`.
  
         Чтобы добавить еще регион, нажмите кнопку **+ или**.

      {% note tip %}

      Если ваш сервис работает только в некоторых регионах, выберите условие `IP не принадлежит региону`. В списке укажите целевой регион, например, `RU`. Трафик из других регионов будет блокироваться.

      Уточнить регион по IP-адресу можно на сайте [ipinfo.io](https://ipinfo.io/) или с помощью [ASN провайдера](https://ru.wikipedia.org/wiki/Автономная_система_(Интернет)).

      {% endnote %}

   1. Нажмите кнопку **{{ ui-key.yacloud_billing.common.add }}**.

{% endlist %}

### Настройте разрешающее правило для капчи {#captcha-rule}

Разрешающее правило для {{ captcha-name }} необходимо, когда для базового правила по умолчанию установлено действие `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` и запросы отправляются на проверку в {{ captcha-name }}.

1. На панели слева нажмите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** и выберите `site-protection`.
1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}** и в открывшемся окне:
   
   1. Введите имя правила, например `allow-captcha`.
   1. Задайте **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** выше, чем у правил, которые отправляют запросы на капчу.
   1. Включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
   1. Укажите параметры правила:
   
      * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}** — `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}** — `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
      * **Трафик** — `При условии`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `{{ ui-key.yacloud.component.condition-column.condition_name-requestUri }}`.
      * **Request path** — `Соответствует регулярному выражению`.
      * Введите выражение `{{ allowed-captcha-request }}`.
   
   1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% note info %}

Если для базового правила по умолчанию установлено действие `Запретить` и запросы отправляются на проверку в {{ captcha-name }}, добавьте базовое правило, разрешающее запросы к капче. Адрес разрешенного запроса соответствует регулярному выражению: `{{ allowed-captcha-request }}`. Установите для правила приоритет выше, чем у правил, которые отправляют запросы на капчу.

{% endnote %}

### Проверьте порядок выполнения правил {#rules-execution-order}

Правила в профиле безопасности применяются к трафику согласно приоритету: чем меньше число, тем выше приоритет.

**Рекомендуемый порядок приоритетов**

1. Разрешающее правило для служебных маршрутов капчи.
1. Разрешающие правила с условиями на трафик.
1. Блокирующие правила с условиями на трафик.
1. Правила Smart Protection и WAF + Smart Protection в режиме _Защита API_ с условиями на трафик для эндпоинтов, где нельзя показывать капчу.
1. Правила Smart Protection и WAF + Smart Protection в режиме _Полная защита_ с условиями на трафик.
1. Правила Smart Protection и WAF + Smart Protection в режиме _Полная защита_ на весь трафик.

**Пример настройки правил**

Приоритет | Имя правила | Действие | Описание правила
--- | --- | --- | ---
8000 | allow-captcha | Разрешить | Правило для разрешения служебных путей капчи
9000 | allow-by-list | Разрешить | Базовое для белых IP-адресов
9100 | block-by-list | Запретить | Базовое для черных IP-адресов
9200 | block-by-geo | Запретить | Базовое по регионам
900000  | api-protection | Защита API | Smart Protection для публичного API
999900 | sp-rule-1 | Полная защита | Smart Protection из готового шаблона
1000000 |  | Разрешить | Базовое по умолчанию

Для базового правила по умолчанию устанавливается действие `Разрешить`, пока остальные правила находятся в режиме `Только логирование`. При переключении правил в боевой режим установите базовому правилу по умолчанию действие `Запретить`.

Подробнее о приоритете правил см. в разделе [{#T}](../../smartwebsecurity/concepts/rules.md#rules-order).

### Подключите профиль безопасности к ресурсам {#profile-connect}

{% list tabs group=instructions %}

- L7-балансировщик {#balancer}

  Если балансировщик управляется [Ingress-контроллером](../../application-load-balancer/tools/k8s-ingress-controller/index.md) {{ alb-name }}, используйте [аннотацию ресурса Ingress](../../application-load-balancer/k8s-ref/ingress.md#annot-security-profile-id).

  {% note tip %}
  
  Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [{{ yandex-cloud }} Gwin](../../application-load-balancer/tools/gwin/index.md).
  
  {% endnote %}

  Чтобы подключить виртуальный хост:

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный [профиль безопасности](../../smartwebsecurity/concepts/profiles.md).
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
    1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
    1. Выберите профиль безопасности, который вы хотите подключить к [виртуальному хосту](../../application-load-balancer/concepts/http-router.md#virtual-host) сервиса [{{ alb-full-name }}](../../application-load-balancer/index.md).
    1. Нажмите кнопку ![plug](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
    1. В открывшемся окне нажмите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_add-resource_v4U3g }}** и выберите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_virtual-host_tYim5 }}**.
    1. Последовательно установите значения в полях [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}**](../../application-load-balancer/concepts/application-load-balancer.md), [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}**](../../application-load-balancer/concepts/http-router.md) и [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}**](../../application-load-balancer/concepts/http-router.md#virtual-host). Вы можете подключить профиль безопасности сразу к нескольким хостам.
  
        Чтобы подключить профиль к еще одному L7-балансировщику, нажмите кнопку **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_add-resource_v4U3g }}** и выберите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_virtual-host_tYim5 }}**.
      
    1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**. Если выбранные хосты уже подключены к другому профилю безопасности, подтвердите подключение.
  
        В разделе ![cubes-3-overlap](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.common.connected_resources }}** появятся подключенные виртуальные хосты.

  Профиль безопасности подключается к определенному виртуальному хосту L7-балансировщика, при этом анализируется весь трафик, поступающий на хост. Если трафик к некоторым маршрутам хоста анализировать не требуется, отключите профиль безопасности от этого маршрута. Это можно сделать при [добавлении](../../application-load-balancer/operations/http-router-update.md#add-virtual-host) или [изменении](../../application-load-balancer/operations/manage-routes.md) маршрута через CLI, API или {{ TF }} с помощью параметра `--disable-security-profile` (`disableSecurityProfile`).
  
  При добавлении маршрутов учитывайте их порядок: запрос будет направлен по первому маршруту, предикату которого он соответствует. Наиболее специфичные маршруты располагайте первыми в списке. Иначе общий маршрут может перехватить запросы и специфичные правила не будут применяться.

- API-шлюз {#api-gateway}
  
  Чтобы подключить API-шлюз:

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный [профиль безопасности](../../smartwebsecurity/concepts/profiles.md).
    1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
    1. Выберите профиль безопасности, который вы хотите подключить к API-шлюзу.
    1. Нажмите кнопку ![plug](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
    1. В открывшемся окне нажмите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_add-resource_v4U3g }}** и выберите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_api-gateway_sKMCK }}**.
    1. Установите значение в поле **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.ApiGatewayItem.label_api-gateway_5Nttt }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.
  
        В разделе ![cubes-3-overlap](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.common.connected_resources }}** появятся подключенные API-шлюзы.

- Домен {#domain}

  Чтобы подключить домен:

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный [профиль безопасности](../../smartwebsecurity/concepts/profiles.md).
    1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
    1. Выберите профиль безопасности, который вы хотите подключить к домену.
    1. Нажмите кнопку ![plug](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
    1. В открывшемся окне нажмите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_add-resource_v4U3g }}** и выберите **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.label_domain_9Bo38 }}**.
    1. Последовательно установите значения в полях **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.ProxyServerItem.label_proxy-server_w9BGG }}** и **{{ ui-key.yacloud.smart-web-security.AttachSecurityProfileDialog.ProxyServerItem.label_domain_1hgsY }}**. Вы можете подключить профиль безопасности сразу к нескольким доменам.
    1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.
  
        В разделе ![cubes-3-overlap](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.common.connected_resources }}** появятся подключенные домены.

{% endlist %}

### Проверьте профиль безопасности в режиме логирования {#test-sp-rules}

{% note info %}

Оставьте правила в режиме **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** на несколько дней. Это поможет найти ложные срабатывания, при этом не остановит работу вашего сервиса.

{% endnote %}

Чтобы посмотреть работу правил в профиле безопасности, изучите логи.

{% list tabs group=instructions %}

- L7-балансировщик {#balancer}

  1. Убедитесь, что настроено [логирование](../../smartwebsecurity/operations/configure-logging.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Выберите балансировщик, к которому привязан профиль безопасности.
  1. Выберите раздел **{{ ui-key.yacloud.common.logs }}**:
     
     * Выберите количество сообщений на одной странице и период, например, `1 час`.
     
     * В строке **Запрос** укажите запрос на [языке фильтрующих выражений](../../logging/concepts/filter.md) и нажмите кнопку **Выполнить**.
     
        **Примеры запросов**
     
       * Показать запросы, для которых сработало правило Smart Protection с отправкой на капчу (в режиме логирования):
     
         ```
         json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.dry_run_matched_rule.verdict = CAPTCHA
         ```
     
       * Аналогичный запрос без режима логирования:
     
         ```
         json_payload.smartwebsecurity.matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.matched_rule.verdict = CAPTCHA
         ```
     
       * Показать запросы, заблокированные базовыми правилами с любыми условиями (в режиме логирования):
     
         ```
         json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = RULE_CONDITION and json_payload.smartwebsecurity.matched_rule.verdict = DENY
         ```
     
       * Аналогичный запрос без режима логирования:
     
         ```
         json_payload.smartwebsecurity.matched_rule.rule_type = RULE_CONDITION and json_payload.smartwebsecurity.matched_rule.verdict = DENY
         ```

- API-шлюз {#api-gateway}
  
  1. Убедитесь, что настроено [логирование](../../api-gateway/operations/api-gw-logs-write.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Выберите API-шлюз, к которому привязан профиль безопасности.
  1. Выберите раздел **{{ ui-key.yacloud.common.logs }}**:
     
     * Выберите количество сообщений на одной странице и период, например, `1 час`.
     
     * В строке **Запрос** укажите запрос на [языке фильтрующих выражений](../../logging/concepts/filter.md) и нажмите кнопку **Выполнить**.
     
        **Примеры запросов**
     
       * Показать запросы, для которых сработало правило Smart Protection с отправкой на капчу (в режиме логирования):
     
         ```
         json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.dry_run_matched_rule.verdict = CAPTCHA
         ```
     
       * Аналогичный запрос без режима логирования:
     
         ```
         json_payload.smartwebsecurity.matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.matched_rule.verdict = CAPTCHA
         ```
     
       * Показать запросы, заблокированные базовыми правилами с любыми условиями (в режиме логирования):
     
         ```
         json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = RULE_CONDITION and json_payload.smartwebsecurity.matched_rule.verdict = DENY
         ```
     
       * Аналогичный запрос без режима логирования:
     
         ```
         json_payload.smartwebsecurity.matched_rule.rule_type = RULE_CONDITION and json_payload.smartwebsecurity.matched_rule.verdict = DENY
         ```

- Домен {#domain}

  1. Убедитесь, что настроено [логирование](../../smartwebsecurity/operations/proxy-create.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**.
  1. Выберите прокси-сервер, к которому привязан профиль безопасности.
  1. Выберите раздел **{{ ui-key.yacloud.common.logs }}**:
     
     * Выберите количество сообщений на одной странице и период, например, `1 час`.
     
     * В строке **Запрос** укажите запрос на [языке фильтрующих выражений](../../logging/concepts/filter.md) и нажмите кнопку **Выполнить**.
     
        **Примеры запросов**
     
       * Показать запросы, для которых сработало правило Smart Protection с отправкой на капчу (в режиме логирования):
     
         ```
         json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.dry_run_matched_rule.verdict = CAPTCHA
         ```
     
       * Аналогичный запрос без режима логирования:
     
         ```
         json_payload.smartwebsecurity.matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.matched_rule.verdict = CAPTCHA
         ```
     
       * Показать запросы, заблокированные базовыми правилами с любыми условиями (в режиме логирования):
     
         ```
         json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = RULE_CONDITION and json_payload.smartwebsecurity.matched_rule.verdict = DENY
         ```
     
       * Аналогичный запрос без режима логирования:
     
         ```
         json_payload.smartwebsecurity.matched_rule.rule_type = RULE_CONDITION and json_payload.smartwebsecurity.matched_rule.verdict = DENY
         ```

{% endlist %}

Подробное описание работы с логами см. в разделе [{#T}](../../smartwebsecurity/operations/configure-logging.md).

После тестирования правил внесите необходимые корректировки и снова проверьте их работу в режиме **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.

### Проверьте профиль безопасности в реальном режиме {#check-sp-rules}

Когда вы убедитесь, что правила отрабатывают корректно:
  1. Отключите режим **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** для всех правил профиля безопасности.
  1. Назначьте базовому правилу по умолчанию действие `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}`.

Проверьте работу правил в логах и на графиках мониторинга:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Выберите раздел **{{ ui-key.yacloud.common.monitoring }}**.
  1. Посмотрите информацию на графиках:
     * **Denied by Security Profile RPS** — количество входящих запросов в секунду, которые были проверены и заблокированы профилем безопасности.
     * **Redirected to SmartCaptcha RPS** — количество входящих запросов в секунду, направленных в {{ captcha-name }} для дополнительной верификации.

{% endlist %}

Подробное описание графиков см. в разделе [{#T}](../../smartwebsecurity/operations/monitoring.md).

## Настройте ограничение нагрузки {##rate-limiter}

После настройки и тестирования профиля безопасности задайте ограничения для количества запросов. Это сохранит ваш сервис работоспособным при случайных скачках трафика или внезапном увеличении количества запросов при DDoS-атаках.

Ограничение запросов настраивается в профиле Advanced Rate Limiter (ARL). Он работает после профиля безопасности, проверяя только трафик, прошедший первичную проверку. В отличие от правил в профиле безопасности, правила ARL могут срабатывать одновременно. При этом к трафику применяется правило с более высоким приоритетом.

Чтобы задать ограничение запросов, сначала определите типовую нагрузку на ваш сервис. Если вы используете L7-балансировщик, это можно сделать в сервисе {{ alb-name }}, в разделе **{{ ui-key.yacloud.common.monitoring }}**. На графике **RPS** отображается общее количество входящих запросов в секунду, поступающих на балансировщик. Для лимита запросов устанавливайте значение с небольшим запасом. Можно задать лимит не на весь трафик, а по определенным [условиям](../../smartwebsecurity/concepts/conditions.md). Например, по региону, диапазону IP-адресов или по списку IP-адресов, по адресу запроса и так далее.

### Создайте профиль ARL {#arl-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль безопасности.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}** и нажмите **{{ ui-key.yacloud.smart-web-security.arl.label_create-profile }}**.
  1. Введите имя профиля, например `arl-site-protection`.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Настройте правила ARL {#arl-configure-rules}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице профиля ARL нажмите ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Введите имя правила, например `arl-rule-1`.
  1. В поле **{{ ui-key.yacloud.smart-web-security.arl.column_rule-priority }}** задайте приоритет выполнения правила, например `1000`. 
  
     Поскольку правила ARL выполняются после всех правил профиля безопасности, этот приоритет действует только на профиль ARL и не пересекается с приоритетом в профиле безопасности.
  1. Включите режим `dry-run (только логирование)`.
  1. В блоке **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-condition-section }}** выберите `Весь трафик` или `При условии`.
  1. (Опционально) Задайте [условия на трафик](../../smartwebsecurity/concepts/conditions.md), по которым будет применяться правило.

  1. В блоке **Подсчет запросов** выберите, как считать запросы для применения лимита:

      * `{{ ui-key.yacloud.smart-web-security.arl.label_rule-without-grouping }}` — подсчет каждого запроса в отдельности;
      * `По характеристикам` — подсчет количества групп запросов, объединенных одной или несколькими характеристиками.
      1. (Опционально) Включите опцию **Учитывать регистр**, чтобы характеристики с одинаковыми значениями, но в разном регистре, попадали в разные группы.

  1. Укажите лимит запросов и выберите промежуток времени, например, `1000` за `1` минуту.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.arl.label_save-rule }}**.

{% endlist %}

### Добавьте профиль ARL к профилю безопасности {#arl-add-to-profile}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. Откройте профиль безопасности `site-protection`.
  1. Нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В списке профилей ARL выберите `arl-site-protection`.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Проверьте работу правил ARL {#test-arl-rules}

Для правил ARL обычно достаточно одного тестирования, после этого можно включать защиту в боевой режим. Но в некоторых случаях может потребоваться более длительное тестирование и корректировка правил.

Для выполнения нагрузочного тестирования можно воспользоваться сервисом [{{ load-testing-name }}](../../load-testing/index.md). Подробнее о настройке нагрузки по протоколу HTTP см. [{#T}](../../load-testing/tutorials/loadtesting-https-phantom.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте L7-балансировщик, API-шлюз или прокси-сервер, к которому привязан профиль безопасности.
  1. Выберите раздел **{{ ui-key.yacloud.common.logs }}**.
  1. В строке **Запрос** укажите запрос для поиска правил ARL и нажмите **Выполнить**.

      Примеры запросов:

      * Показать запросы, заблокированные правилами профиля ARL (в режиме логирования):
        ```
        json_payload.smartwebsecurity.dry_run_advanced_rate_limiter.verdict = DENY
        ```
      * Аналогичный запрос без режима логирования:
        ```
        json_payload.smartwebsecurity.advanced_rate_limiter.verdict = DENY
        ```
{% endlist %}

После отключения режима **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** проверьте работу профиля по логам и графикам мониторинга.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Выберите раздел **{{ ui-key.yacloud.common.monitoring }}**.
  1. Посмотрите информацию на графиках:
     * **Allowed by ARL Profile RPS** — количество входящих запросов в секунду, которое не превышает лимит в профиле ARL.
     * **Denied by ARL Profile RPS** — количество входящих запросов в секунду, превысивших лимит профиля ARL и заблокированных.

{% endlist %}

## Настройте Web Application Firewall {#firewall}

Web Application Firewall (WAF) защищает от эксплуатации различных уязвимостей веб-приложений и требует тонкой настройки, исходя из особенностей вашего сервиса.

При создании профиля WAF можно подключить несколько наборов правил. Для быстрого запуска рекомендуется начать с наборов [ML WAF](../../smartwebsecurity/concepts/waf.md#yandex-ml-ruleset) (Yandex Malicious Score) и [Yandex Ruleset](../../smartwebsecurity/concepts/waf.md#yandex-ruleset), они дают минимальное число ложноположительных срабатываний.

Чтобы повысить уровень защиты, используйте дополнительные наборы правил и адаптируйте их к особенностям вашего сервиса.

Любое правило, которое вы считаете критичным для сервиса, можно сделать блокирующим. Тогда запрос, попавший под это правило, будет остановлен независимо от общего балла.

Возможно, потребуется отключить некоторые правила для предотвращения ложных срабатываний и создать правила-исключения. Поскольку каждый сервис уникален, настройка WAF может занять некоторое время.

### Создайте профиль WAF {#waf-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль безопасности.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Перейдите на вкладку ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}** и нажмите **{{ ui-key.yacloud.smart-web-security.waf.label_create-profile }}**.
  1. Введите имя профиля, например `waf-site-protection`.
  1. Включите наборы правил, например ML WAF и Yandex Ruleset. Чтобы посмотреть правила в наборе, нажмите на строку с его описанием.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Настройте набор правил Yandex Ruleset {#waf-configure-rules}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице профиля WAF напротив нужного набора нажмите кнопку ![image](../../_assets/console-icons/gear.svg) **Настроить**.
  1. Для каждой группы правил:

      1. Нажмите ![image](../../_assets/console-icons/chevron-down.svg) возле названия группы правил, чтобы раскрыть ее.
      1. Проверьте включенные в набор правила, при необходимости включите дополнительные или уберите ненужные. При работе с правилами обращайте внимание на значение их аномальности.
      1. При необходимости назначьте одно или несколько правил блокирующими, нажав ![image](../../_assets/console-icons/ban.svg) справа от правила. Запрос, соответствующий такому правилу, будет заблокирован независимо от порога аномальности.


{% endlist %}

### Создайте правило-исключение {#create-exclusion}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на вкладку ![image](../../_assets/console-icons/file-xmark.svg) **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rules }}** и нажмите **{{ ui-key.yacloud.smart-web-security.waf.label_create-exclusion-rule }}**.
  1. Введите имя [правила-исключения](../../smartwebsecurity/concepts/waf.md#exclusion-rules), например `exception-rule-1`.
  1. В блоке **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-rules-section }}** укажите правила из активных наборов, для которых будет срабатывать исключение. Вы можете выбрать `{{ ui-key.yacloud.smart-web-security.waf.value_exclude-all-yes }}` или указать конкретные правила из определенных наборов.
  1. В блоке **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-condition-section }}** выберите [условия](../../smartwebsecurity/concepts/conditions.md) для срабатывания правила-исключения.

      Если оставить поле **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** пустым, правило-исключение будет применено ко всему трафику.

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Добавьте профиль WAF к профилю безопасности {#waf-add-to-profile}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. Откройте профиль безопасности `site-protection`.
  1. Нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Введите имя правила, например `waf-rule-1`.
  1. Укажите приоритет выполнения правила выше, чем у правил Smart Protection. Например, `1111`.
  1. Включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
  1. Выберите **{{ ui-key.yacloud.smart-web-security.overview.column_type }}** — `{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}`.
  1. В списке профилей WAF выберите `waf-site-protection`.

{% endlist %}

### Проверьте работу правил WAF {#test-waf-rules}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте L7-балансировщик, API-шлюз или прокси-сервер, к которому привязан профиль безопасности.
  1. Выберите раздел **{{ ui-key.yacloud.common.logs }}**.
  1. В строке **Запрос** укажите запрос для поиска правил WAF и нажмите **Выполнить**.

      Примеры запросов:

      * Показать запросы, заблокированные по профилю WAF — правилами WAF из профиля безопасности (в режиме логирования):
        ```
        json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = WAF and json_payload.smartwebsecurity.matched_rule.verdict = DENY
        ```
      * Аналогичный запрос без режима логирования:
        ```
        json_payload.smartwebsecurity.matched_rule.rule_type = WAF and json_payload.smartwebsecurity.matched_rule.verdict = DENY
        ```

Также можно просматривать расширенные логи в интерфейсе {{ sws-name }}.

{% endlist %}

Поскольку WAF настраивается индивидуально под особенности каждого веб-сервиса, тестируйте WAF в режиме логирования не менее недели. Для наборов ML WAF и Yandex Ruleset период настройки может быть меньше. На этом этапе могут возникать ложные срабатывания, отслеживайте их в логах и корректируйте параметры правил. Например, при использовании HTTP/2 неправильно срабатывает правило с идентификатором `id920280`, его можно сразу отключить. В случае с HTTP/1.1 это правило работает корректно.

После того как WAF будет настроен и переведен в боевой режим, регулярно проверяйте работу правил по логам и графикам мониторинга. Это позволит отследить нетипичные ситуации и донастроить защиту под ваше веб-приложение.

## Дальнейшая настройка политик безопасности {#further-configuration}

При каждом изменении или добавлении новых правил для профилей безопасности, WAF и ARL включайте режим **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**. Активируйте правило только после того, как логи подтвердят его корректную работу. Это поможет избежать ложных срабатываний и обеспечит стабильную работу вашего веб-приложения.