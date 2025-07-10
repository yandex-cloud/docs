
# Базовая настройка защиты в {{ sws-name }}

[{{ sws-name }}](../../smartwebsecurity/concepts/index.md) (SWS) защищает веб-ресурсы от интернет-угроз, фильтруя вредоносный трафик. Для индивидуальной настройки можно подключить несколько инструментов {{ sws-name }}: базовые правила для простой фильтрации, правила Smart Protection для защиты от DDoS, [{{ captcha-name }}](../../smartcaptcha/) для защиты от ботов, Web Application Firewall (WAF) — от эксплуатации уязвимостей, а также Advanced Rate Limiter (ARL) для ограничения трафика.

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
   1. [Настройте набор базовых правил](#waf-configure-rules)
   1. [Создайте правило-исключение](#create-exclusion)
   1. [Добавьте профиль WAF к профилю безопасности](#waf-add-to-profile)
   1. [Проверьте работу правил WAF](#test-waf-rules)

## Необходимые платные ресурсы {#paid-resources}

* [Плата за количество запросов](../../smartwebsecurity/pricing.md) в сервис {{ sws-name }}.
* Плата за инфраструктуру [{{ alb-name }}](../../application-load-balancer/pricing.md) или [{{ api-gw-name }}](../../api-gateway/pricing.md) при ее использовании. Инфраструктура [доменов](../../smartwebsecurity/concepts/domain-protect.md) не тарифицируется.

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте защищаемый ресурс {#resource-create}

{% include [sws-type-resources](../../_includes/smartwebsecurity/sws-type-resources.md) %}

Руководство предполагает, что у вас уже есть настроенный веб-ресурс. Если ресурс находится вне {{ yandex-cloud }} или вы не используете {{ alb-name }} и {{ api-gw-name }}, создайте домен по инструкции ниже. Также можно ознакомиться с документацией других сервисов, которые работают с {{ sws-name }}, и настроить соответствующую инфраструктуру.

{% list tabs group=resources %}

- L7-балансировщик {#balancer}

  [{{ alb-name }}](../../smartwebsecurity/tutorials/balancer-with-sws-profile/index.md) равномерно распределяет входящий трафик между узлами, что позволяет избежать перегрузки и повысить отказоустойчивость.

- API-шлюз {#api-gateway}

  [API-шлюз](../../api-gateway/tutorials/api-gw-sws-integration.md) — единая точка входа для API различных сервисов, которая позволяет управлять запросами, маршрутизацией, аутентификацией и так далее.

- Домен {#domain}

  Домен — сервер, сайт, приложение, которое обрабатывает внешние запросы по веб-адресу. Для защиты домена {{ sws-name }} предоставляет прокси-сервер с балансировкой нагрузки, анализом и маршрутизацией запросов, а также базовой [защитой от DDoS](../../vpc/ddos-protection/).

  На прокси-сервере установлено ограничение MTU для всех пакетов — 1450 байт.

  {% include [preview-domain](../../_includes/smartwebsecurity/preview-domain.md)%}

  ### Подготовьте данные о ресурсе {#domain-info}

  * Адрес домена, на котором работает веб-приложение. У вас должен быть доступ к кабинету управления доменом, чтобы изменить A-запись.
  * IP-адрес сервера, порт и протокол, на котором работает веб-приложение.
  * Действительный приватный ключ и TLS-сертификат для этого домена в [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded формате. Поддерживаются сертификаты с ключами RSA-2048 и RSA-4096.

  ### Создайте прокси-сервер {#create-proxy}

  {% list tabs group=instructions %}

  - Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
    1. На панели слева выберите ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.ProxyServers.createProxyServer_jatYQ }}**.
    1. Введите произвольное имя для прокси-сервера, например, `test-proxy`.
    1. Включите опцию **Логировать запросы**.
    1. Выберите существующую лог-группу или [создайте новую](../../logging/operations/create-group.md).
    1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.ProxyServerFormCreate.createServer_sycVk }}**.

        {% include [after-proxy-create](../../_includes/smartwebsecurity/after-proxy-create.md) %}

  {% endlist %}

  ### Добавьте домен {#add-domain}

  {% list tabs group=instructions %}

  - Консоль управления {#console}

    1. В меню слева перейдите на вкладку ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}** и нажмите кнопку **{{ ui-key.yacloud.smart-web-security.ProxyServer.Domains.createDomain_49MGX }}**.
    1. Введите адрес домена, на котором находится ваше веб-приложение, например, `example.com`.
    1. Нажмите **{{ ui-key.yacloud.common.continue }}**.
    1. Выберите тип соединения, которое используется в вашем приложении. Рекомендуем выбрать защищенный протокол **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.https_qWPJb }}**.
    1. Если вы используете сервис [{{ certificate-manager-name }}](../../certificate-manager/) и добавляли в него сертификат вашего домена, выберите его из списка. 
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

  1. {% include [create-proxy-a-record](../../_includes/smartwebsecurity/create-proxy-a-record.md) %}
  1. {% include [limit-traffic-to-yc](../../_includes/smartwebsecurity/limit-traffic-to-yc.md) %}

  ### Проверьте статус вашего ресурса {#check-status}

  {% list tabs group=instructions %}

  - Консоль управления {#console}

    {% include [validate-resource-stats](../../_includes/smartwebsecurity/validate-resource-stats.md) %}

  {% endlist %}

{% endlist %}  

## Настройте защиту от DDoS и ботов {#antiddos-antibot-protection}

### Создайте профиль безопасности {#security-profile-create}

{% include [setting-by-expert](../../_includes/smartwebsecurity/setting-by-expert.md) %}

В этом руководстве при настройке используется готовый шаблон профиля безопасности.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находятся защищаемые ресурсы.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.action_empty }}** и выберите **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

      Преднастроенный профиль содержит:

      * [базовое правило](../../smartwebsecurity/concepts/rules.md#base-rules) по умолчанию, включенное для всего трафика с [типом действия](../../smartwebsecurity/concepts/rules.md#rule-action) `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}`;
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
     1. Нажмите **{{ ui-key.yacloud.smart-web-security.match-lists.ip-list_add-addresses }}**.
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

{% include [allow-captcha](../../_includes/smartwebsecurity/allow-captcha.md) %}

### Проверьте порядок выполнения правил {#rules-execution-order}

Правила в профиле безопасности применяются к трафику согласно приоритету: чем меньше число, тем выше приоритет. Порядок выполнения правил приведен в таблице.

Приоритет | Имя правила | Действие | Описание правила
--- | --- | --- | ---
8000 | allow-captcha | Разрешить | Базовое для капчи
9000 | allow-by-list | Разрешить | Базовое для белых IP-адресов
9100 | block-by-list | Запретить | Базовое для черных IP-адресов
9200 | block-by-geo  | Запретить | Базовое по регионам
900000  | api-protection | Защита API | Smart Protection для публичного API
999900 | sp-rule-1 | Полная защита | Smart Protection из готового шаблона
1000000 |  | Разрешить | Базовое по умолчанию

Для базового правила по умолчанию устанавливается действие `Разрешить`, пока остальные правила находятся в режиме `Только логирование`. При переключении правил в боевой режим установите базовому правилу по умолчанию действие `Запретить`.

### Подключите профиль безопасности к ресурсам {#profile-connect}

{% list tabs group=instructions %}

- L7-балансировщик {#balancer}

  Чтобы подключить виртуальный хост в сервисе {{ alb-name }}:
  1. Если балансировщик управляется [Ingress-контроллером](../../application-load-balancer/tools/k8s-ingress-controller/index.md) {{ alb-name }}, используйте [аннотацию ресурса Ingress](../../application-load-balancer/k8s-ref/ingress.md#annot-security-profile-id).
  1. Если балансировщик управляется вами, в разделе ![image](../../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** выберите созданный профиль.
  1. Справа сверху нажмите ![plug](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
  1. В открывшемся окне последовательно выберите:

     * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}**](../../application-load-balancer/concepts/application-load-balancer.md).
     * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}**](../../application-load-balancer/concepts/http-router.md).
     * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}**](../../application-load-balancer/concepts/http-router.md#virtual-host). Вы можете подключить профиль безопасности сразу к нескольким хостам.

      Чтобы подключить профиль к еще одному L7-балансировщику, нажмите **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_add-balancer }}**.

  1. Нажмите **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.

    На вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_connected-to-the-hosts }}** появится подключенный виртуальный хост.

- API-шлюз {#api-gateway}
  
  Чтобы подключить API-шлюз:
  1. В разделе ![image](../../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** скопируйте идентификатор нужного профиля.
  1. При создании API-шлюза или в спецификации уже созданного API-шлюза задайте расширение [x-yc-apigateway:smartWebSecurity](../../api-gateway/concepts/extensions/sws.md).
  1. Укажите в расширении скопированный идентификатор.

- Домен {#domain}

  Чтобы подключить домен:
  1. В разделе ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}** → ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}** выберите нужный домен.
  1. В меню сверху нажмите ![plug-connection](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.DomainsTable.connectSecurityProfile_g5MA4 }}** и выберите профиль безопасности `site-protection`.

{% endlist %}

### Проверьте профиль безопасности в режиме логирования {#test-sp-rules}

{% note info %}

Оставьте правила в режиме **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** на несколько дней. Это поможет найти ложные срабатывания, при этом не остановит работу вашего сервиса.

{% endnote %}

Чтобы посмотреть работу правил в профиле безопасности, изучите логи.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Если вы используете L7-балансировщик:
     1. Убедитесь, что настроено [логирование](../../smartwebsecurity/operations/configure-logging.md).
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
     1. Выберите балансировщик, к которому привязан профиль безопасности.
  1. Если вы используете API-шлюз:
     1. Убедитесь, что настроено [логирование](../../api-gateway/operations/api-gw-logs-write.md).
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
     1. Выберите API-шлюз, к которому привязан профиль безопасности.
  1. Если вы используете домен:
     1. Убедитесь, что настроено [логирование](../../smartwebsecurity/operations/proxy-create.md).
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
     1. На панели слева выберите ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**.
     1. Выберите прокси-сервер, к которому привязан профиль безопасности.
  1. Выберите раздел **{{ ui-key.yacloud.common.logs }}**.
  1. Выберите количество сообщений на одной странице и период, например, `1 час`.
  1. В строке **Запрос** укажите запрос на [языке фильтрующих выражений](../../logging/concepts/filter.md) и нажмите кнопку **Выполнить**.

      Примеры запросов:

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

  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
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
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
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

Для выполнения нагрузочного тестирования можно воспользоваться сервисом [{{ load-testing-name }}](../../load-testing/). Подробнее о настройке нагрузки по протоколу HTTP см. [{#T}](../../load-testing/tutorials/loadtesting-https-phantom.md).

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

  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Выберите раздел **{{ ui-key.yacloud.common.monitoring }}**.
  1. Посмотрите информацию на графиках:
     * **Allowed by ARL Profile RPS** — количество входящих запросов в секунду, которое не превышает лимит в профиле ARL.
     * **Denied by ARL Profile RPS** — количество входящих запросов в секунду, превысивших лимит профиля ARL и заблокированных.

{% endlist %}

## Настройте Web Application Firewall {#firewall}

Web Application Firewall (WAF) защищает от эксплуатации различных уязвимостей веб-приложений и требует тонкой настройки, исходя из особенностей вашего сервиса.

При создании профиля WAF в него добавляется предустановленный набор правил [OWASP Core Ruleset](https://coreruleset.org/), который необходимо адаптировать к вашему сервису. Возможно, потребуется отключить некоторые правила для предотвращения ложных срабатываний и создать правила-исключения. Поскольку каждый сервис уникален, настройка может занять некоторое время.

Чтобы оптимизировать работу {{ sws-name }}, можно настраивать проверку WAF только для определенных маршрутов, а не для всего трафика.

Профиль WAF подключается к профилю безопасности в виде правила, наряду с базовыми правилами и Smart Protection. Правила WAF должны иметь более высокий приоритет, чем правила Smart Protection. Если условия на входящий трафик для правила WAF и Smart Protection одинаковые, Smart Protection можно отключить, поскольку согласно архитектуре сервиса до проверки правилом WAF всегда отрабатывает правило Smart Protection.

В профиле WAF нужно настроить два параметра:

* **Уровень паранойи** — определяет количество активных правил. Чем выше уровень, тем больше проверок. Первый уровень паранойи соответствует наиболее выверенному набору правил, которые дают наименьшее число ложноположительных срабатываний. Начинайте с первого уровня в тестовом режиме, постепенно повышая его.

* **Порог аномальности** — совокупный балл опасности запроса. Баллы добавляются за каждое сработавшее правило, и при превышении порога запрос блокируется. Начинайте настройку с порога `25` и постепенно его снижайте.

  Любое правило, которое вы считаете критичным для сервиса, можно сделать блокирующим. Тогда запрос, попавший под это правило, будет остановлен независимо от общего балла.
  
Чтобы избежать ложных срабатываний для вашего сервиса, можно создать исключения для всех или отдельных правил.

### Создайте профиль WAF {#waf-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль безопасности.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Перейдите на вкладку ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}** и нажмите **{{ ui-key.yacloud.smart-web-security.waf.label_create-profile }}**.
  1. Введите имя профиля, например `waf-site-protection`.
  1. По умолчанию в профиле WAF включен набор базовых правил [OWASP Core Rule Set](https://coreruleset.org/). Чтобы посмотреть правила в наборе, нажмите на строку с его описанием.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Настройте набор базовых правил {#waf-configure-rules}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице профиля WAF нажмите **{{ ui-key.yacloud.smart-web-security.waf.action_setup-base-rules }}**.
  1. Установите **{{ ui-key.yacloud.smart-web-security.waf.label_anomaly-threshold }}** — суммарную [аномальность](../../smartwebsecurity/concepts/waf.md#anomaly) сработавших правил, при которой запрос будет заблокирован. Например `{{ ui-key.yacloud.smart-web-security.waf.label_anomaly-medium }}`.

      Рекомендуется начинать с порога аномальности `25` и постепенно снижать его до `5`. Чтобы снизить порог аномальности, отработайте ложные срабатывания WAF на легитимные запросы. Для этого подберите правила из базового набора и настройте правила-исключения.
  1. Установите **{{ ui-key.yacloud.smart-web-security.waf.label_paranoia-level }}** — `{{ ui-key.yacloud.smart-web-security.waf.label_paranoia-option-1 }}`.

      [Уровень паранойи](../../smartwebsecurity/concepts/waf.md#paranoia) классифицирует правила по степени агрессивности. Чем выше уровень паранойи, тем лучше уровень защиты, но и больше вероятность ложных срабатываний WAF.
  1. Проверьте включенные в набор правила, при необходимости включите дополнительные или уберите ненужные. При работе с правилами обращайте внимание на значение их аномальности и уровень паранойи.

  1. При необходимости назначьте одно или несколько правил блокирующими, нажав ![image](../../_assets/console-icons/ban.svg) справа от правила. Запрос, соответствующий такому правилу, будет заблокирован независимо от порога аномальности.

{% endlist %}

### Создайте правило-исключение {#create-exclusion}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на вкладку ![image](../../_assets/console-icons/file-xmark.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_exclusion-rules }}** и нажмите **{{ ui-key.yacloud.smart-web-security.waf.label_create-exclusion-rule }}**.
  1. Введите имя [правила-исключения](../../smartwebsecurity/concepts/waf.md#exclusion-rules), например `exception-rule-1`.
  1. В блоке **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-rules-section }}** укажите правила из базового набора, для которых будет срабатывать исключение. Вы можете выбрать `{{ ui-key.yacloud.smart-web-security.waf.value_exclude-all-yes }}` или указать конкретные правила.
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

{% endlist %}

Поскольку WAF настраивается индивидуально под особенности каждого веб-сервиса, тестируйте WAF в режиме логирования не менее недели. На этом этапе будет много ложных срабатываний, отслеживайте их в логах и корректируйте параметры правил. Например, при использовании HTTP/2 неправильно срабатывает правило с идентификатором `id920280`, его можно сразу отключить. В случае с HTTP/1.1 это правило работает корректно.

После того как WAF будет настроен и переведен в боевой режим, регулярно проверяйте работу правил по логам и графикам мониторинга. Это позволит отследить нетипичные ситуации и донастроить защиту под ваше веб-приложение.

## Дальнейшая настройка политик безопасности {#further-configuration}

При каждом изменении или добавлении новых правил для профилей безопасности, WAF и ARL включайте режим **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**. Активируйте правило только после того, как логи подтвердят его корректную работу. Это поможет избежать ложных срабатываний и обеспечит стабильную работу вашего веб-приложения.