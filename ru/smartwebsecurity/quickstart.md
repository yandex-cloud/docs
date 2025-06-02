# Как начать работать с {{ sws-full-name }}

{% include [about-sws](../_includes/smartwebsecurity/about-sws.md) %}

## Порядок настройки {#steps}

* [Подготовьте облако к работе](#before-you-begin)
* [Создайте и настройте защищаемый ресурс](#resource-create)
* [Создайте и проверьте профиль безопасности](#security-profile)
* [Подключите профиль безопасности к защищаемому ресурсу](#profile-connect)
* [Посмотрите работу профиля безопасности](#monitoring)
* (Опционально) [Создайте и подключите профиль WAF](#waf)
* (Опционально) [Создайте и подключите профиль ARL](#arl)


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}


## Создайте и настройте защищаемый ресурс {#resource-create}

{% list tabs group=resources %}

- L7-балансировщик {#balancer}

  {{ alb-name }} равномерно распределяет входящий трафик между узлами, что позволяет избежать перегрузки и повысить отказоустойчивость. Если у вас еще не настроен L7-балансировщик, вы можете развернуть [тестовую инфраструктуру](tutorials/balancer-with-sws-profile/index.md).

- API-шлюз {#api-gateway}

  API-шлюз — единая точка входа для API различных сервисов, которая позволяет управлять запросами, маршрутизацией, аутентификацией и так далее. Если у вас еще не настроен API-шлюз, вы можете развернуть шлюз с [тестовой спецификацией](../api-gateway/tutorials/api-gw-sws-integration.md).

- Домен {#domain}

  Домен — сервер, сайт, приложение, которое обрабатывает внешние запросы по веб-адресу. Для защиты домена {{ sws-name }} предоставляет прокси-сервер с балансировкой нагрузки, анализом и маршрутизацией запросов. А также базовой [защитой от DDoS](../vpc/ddos-protection/).
  
  На прокси-сервере установлено ограничение MTU для всех пакетов — 1450 байт.

  {% include [preview-domain](../_includes/smartwebsecurity/preview-domain.md)%}

  ### Подготовьте данные о ресурсе {#domain-info}
  
    * Адрес домена, на котором работает веб-приложение. У вас должен быть доступ к кабинету управления доменом, чтобы изменить А-запись.
    * IP-адрес сервера, порт и протокол, на котором работает веб-приложение.
    * Действительный приватный ключ и TLS-сертификат для этого домена в [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded формате. Поддерживаются сертификаты с ключами RSA-2048 и RSA-4096.

  ### Создайте прокси-сервер {#create-proxy}

  {% list tabs group=instructions %}

  - Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
    1. На панели слева выберите раздел **Защита доменов**.
    1. Нажмите кнопку **Создать прокси-сервер**.
    1. Введите произвольное имя для прокси-сервера, например, `test-proxy`.
    1. Нажмите кнопку **Создать**.
    
        {% include [after-proxy-create](../_includes/smartwebsecurity/after-proxy-create.md) %}

  {% endlist %}

  ### Добавьте домен {#add-domain}

  {% list tabs group=instructions %}

  - Консоль управления {#console}

    1. В разделе **Домены** нажмите кнопку **Добавить домен**.
    1. Введите адрес домена, на котором находится ваше веб-приложение, например, `example.com`.
    1. Нажмите **Продолжить**.
    1. Выберите тип соединения, которое используется в вашем приложении. Рекомендуем выбрать защищенный протокол **HTTPS**.
    1. Если вы используете сервис [{{ certificate-manager-name }}](../../certificate-manager/) и добавляли в него сертификат вашего домена, выберите его из списка. 
    1. Если вы не используете {{ certificate-manager-name }}, нажмите кнопку **Создать** → **Пользовательский сертификат**.
       1. Введите произвольное имя сертификата.
       1. Скопируйте или загрузите файлом приватный ключ, сертификат и цепочку промежуточных сертификатов в формате PEM.
       1. Нажмите кнопку **Создать сертификат**.
    1. Нажмите **Продолжить**.

    1. Укажите настройки **Целевых ресурсов**:
       1. IP-адрес и порт, на котором работает ваше веб-приложение.
       1. Протокол, на котором работает ваше веб-приложение.
    1. Нажмите кнопку **Сохранить**.

    После создания домена откроется страница обзора параметров домена. В разделе **Как активировать защиту** скопируйте IP-адрес прокси-сервера, он потребуется на следующем шаге.
  
  {% endlist %}

  ### Настройте вашу инфраструктуру {#infrastructure-settings}
  
  * Зайдите в панель управления DNS на сайте вашего хостинг-провайдера или регистратора доменов.
  * Добавьте А-запись с параметрами:
     * `Имя хоста` — `адрес вашего домена (example.com)`, 
     * `Значение` — `IP-адрес прокси-сервера`.
  
     Эта запись перенаправляет запросы, которые приходят на ваш домен, на IP-адрес прокси-сервера.

  * В настройках вашего сервера запретите все соединения и разрешите только соединения для [IP-адресов {{ yandex-cloud }}](../overview/concepts/public-ips.md).
  
  ### Проверьте статус вашего ресурса {#check-status}

  {% list tabs group=instructions %}

  - Консоль управления {#console}

    1. В разделе **Прокси-сервер** выберите созданный прокси-сервер.
    1. Перейдите в раздел **Домены** и выберите созданный домен.
    1. В разделе **Целевые ресурсы** проверьте, что ваш ресурс находится в статусе **Healthy**.
  
       Если это не так, прокси-сервер не может соединиться с вашим ресурсом. Проверьте адрес вашего веб-сервера и настройки сети. Убедитесь, что к веб-серверу разрешен доступ с IP-адресов {{ yandex-cloud }}.
    
    1. На панели слева проверьте, что ваш домен находится в статусе **Healthy**. 
       
       Если это не так, проверьте адрес домена и А-запись, а также валидность сертификата.

  {% endlist %}

{% endlist %}

## Создайте и проверьте профиль безопасности {#security-profile}

### Создайте профиль безопасности {#profile-create}

{% include [user-data-to-ml](../_includes/smartwebsecurity/user-data-to-ml.md)%}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находятся защищаемые ресурсы.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.action_empty }}** и выберите **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

      Преднастроенный профиль содержит:

      * [базовое правило](concepts/rules.md#base-rules) по умолчанию, включенное для всего трафика с [типом действия](concepts/rules.md#rule-action) `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}`;
      * [правило Smart Protection](concepts/rules.md#smart-protection-rules), включенное для всего трафика, с типом действия `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`.

      {% include [smart-protection-tip](../_includes/smartwebsecurity/smart-protection-tip.md) %}

  1. Введите имя профиля, например `test-sp1`.
  1. В поле **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** выберите `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`.
  1. (Опционально) Включите или отключите использование информации об HTTP-запросах для улучшения моделей машинного обучения в разделе **{{ ui-key.yacloud.component.disallow-data-processing.title_ml-model-training }}**.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


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

{% list tabs group=instructions %}

- Консоль управления {#console}

  Способ подключения зависит от типа ресурса.

  * Чтобы подключить домен: 
    1. В разделе **Защита доменов** → **Домены** выберите нужный домен. 
    1. Нажмите **Подключить профиль безопасности** и выберите профиль.
  
  * Чтобы подключить виртуальный хост в сервисе {{ alb-name }}:

    1. Если балансировщик управляется [Ingress-контроллером](../application-load-balancer/tools/k8s-ingress-controller/index.md) {{ alb-name }}, используйте [аннотацию ресурса Ingress](../application-load-balancer/k8s-ref/ingress.md#annot-security-profile-id).
    1. Если балансировщик управляется вами, в разделе **Профили безопасности** выберите созданный профиль.
    1. Справа сверху нажмите ![plug](../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
    1. В открывшемся окне выберите:

       * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}**](../application-load-balancer/concepts/application-load-balancer.md).
       * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}**](../application-load-balancer/concepts/http-router.md).
       * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}**](../application-load-balancer/concepts/http-router.md#virtual-host). Вы можете подключить профиль безопасности сразу к нескольким хостам.

        Чтобы подключить профиль к еще одному L7-балансировщику, нажмите **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_add-balancer }}**.

    1. Нажмите **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.

      На вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_connected-to-the-hosts }}** появится подключенный виртуальный хост.

  * Чтобы подключить API-шлюз:
    1. В разделе **Профили безопасности** скопируйте идентификатор нужного профиля.
    1. При создании API-шлюза или в спецификации уже созданного API-шлюза задайте расширение [x-yc-apigateway:smartWebSecurity](../api-gateway/concepts/extensions/sws.md).
    1. Укажите в расширении скопированный идентификатор.


{% endlist %}


## Посмотрите работу профиля безопасности {#monitoring}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице сервиса **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}** на панели слева выберите раздел **Мониторинг**.
  1. Посмотрите [графики](operations/monitoring.md) разрешенных и заблокированных запросов.

{% endlist %}

## Создайте и подключите профиль WAF {#waf}

WAF позволяет использовать наборы правил для защиты веб-приложений от множества информационных атак.

### Создайте профиль WAF {#waf-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать профиль WAF.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Перейдите на вкладку ![image](../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}** и нажмите **{{ ui-key.yacloud.smart-web-security.waf.label_create-profile }}**.
  1. Введите имя профиля, например `test-waf-profile-1`.
  1. По умолчанию в профиле WAF включен набор базовых правил [OWASP Core Rule Set](https://coreruleset.org/). Чтобы посмотреть правила в наборе, нажмите на строку с его описанием.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


### Настройте набор базовых правил {#waf-configure-rules}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На открывшейся обзорной странице профиля WAF нажмите **{{ ui-key.yacloud.smart-web-security.waf.action_setup-base-rules }}**.
  1. Установите необходимый **{{ ui-key.yacloud.smart-web-security.waf.label_anomaly-threshold }}** — суммарную [аномальность](concepts/waf.md#anomaly) сработавших правил, при которой запрос будет заблокирован, например `{{ ui-key.yacloud.smart-web-security.waf.label_anomaly-medium }}`.

      Рекомендуется начинать с порога аномальности `25` и постепенно снижать его до `5`. Чтобы снизить порог аномальности, отработайте ложные срабатывания WAF на легитимные запросы. Для этого подберите правила из базового набора и настройте [правила-исключения](#create-exclusion). Также для тестирования разных порогов аномальности используйте в профиле безопасности режим **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry-run)**.

  1. Установите необходимый **{{ ui-key.yacloud.smart-web-security.waf.label_paranoia-level }}**, например `{{ ui-key.yacloud.smart-web-security.waf.label_paranoia-option-2 }}`.

      [Уровень паранойи](concepts/waf.md#paranoia) классифицирует правила по степени агрессивности. Чем выше уровень паранойи, тем лучше уровень защиты, но и больше вероятность ложных срабатываний WAF.

  1. Проверьте включенные в набор правила, при необходимости включите дополнительные или уберите ненужные. При работе с правилами обращайте внимание на значение их аномальности и уровень паранойи.

  Любое правило из набора можно сделать блокирующим. Запрос, соответствующий таком правилу, будет заблокирован независимо от установленного порога аномальности. Чтобы сделать правило блокирующим, нажмите ![image](../_assets/console-icons/ban.svg) справа от него. Если в профиле безопасности включен режим **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry-run)**, запросы не будут заблокированы, даже если они соответствуют блокирующим правилам.

{% endlist %}


### Создайте правило-исключение {#create-exclusion}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на вкладку ![image](../_assets/console-icons/file-xmark.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_exclusion-rules }}** и нажмите **{{ ui-key.yacloud.smart-web-security.waf.label_create-exclusion-rule }}**.
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
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
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
