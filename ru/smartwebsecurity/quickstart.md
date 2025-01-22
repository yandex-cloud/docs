# Как начать работать с {{ sws-full-name }}

{{ sws-name }} позволяет защитить вашу инфраструктуру от информационных угроз на прикладном уровне L7 модели OSI. Например, [DDoS-атак](../glossary/ddos.md), ботов, SQL-инъекций. Дополнительно вы можете подключить защиту от DDoS-атак на уровнях L3 и L4 с помощью [{{ ddos-protection-full-name }}](../vpc/ddos-protection/index.md).

{{ sws-name }} — это это набор инструментов, которые можно использовать по отдельности или сочетать, чтобы настроить оптимальную защиту ваших ресурсов. Основной элемент в {{ sws-name }} — _профиль безопасности_, к нему можно подключить:

* Базовые правила — для простой фильтрации трафика по некоторым условиям.
* Правила Smart Protection — для анализа трафика с помощью алгоритмов машинного обучения и поведенческого анализа.
* Правила из профиля WAF — позволяют использовать наборы правил от распространенных угроз безопасности, такие как OWASP Core Rule Set (CRS). Защищают веб-приложения от множества известных угроз, например, SQL-инъекций, командных инъекций, межсайтового скриптинга, несанкционированного доступа к серверным ресурсам и других.
* CAPTCHA — после проверки правилами трафик можно дополнительно направить в [{{ captcha-full-name }}](../smartcaptcha) для защиты от ботов и спама.
* Профиль ARL — для ограничения количества запросов к защищаемому ресурсу по различным условиям.

Для защиты ресурсов профиль безопасности подключается к [виртуальному хосту](../application-load-balancer/concepts/http-router.md#virtual-host) или [Ingress-контроллеру](../application-load-balancer/tools/k8s-ingress-controller/index.md#smart-web-security) сервиса {{ alb-full-name }}.

Чтобы начать работу с сервисом:

* [Подготовьте облако к работе](#before-you-begin)
* [Создайте и проверьте профиль безопасности](#security-profile)
* [Подключите профиль безопасности к виртуальному хосту](#profile-connect)
* (Опционально) [Создайте и подключите профиль WAF](#waf)
* (Опционально) [Создайте и подключите профиль ARL](#arl)
* [Настройте L7-балансировщик для дополнительной защиты](#configure-balancer)


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}


## Создайте и проверьте профиль безопасности {#security-profile}

Создайте первый [профиль безопасности](concepts/profiles.md) и подключите его к имеющемуся [виртуальному хосту](../application-load-balancer/concepts/http-router.md#virtual-host) L7-балансировщика {{ alb-full-name }}.

Если у вас еще не настроен L7-балансировщик, вы можете развернуть [тестовую инфраструктуру](tutorials/balancer-with-sws-profile.md).

### Создайте профиль безопасности {#profile-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать профиль.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.action_empty }}** и выберите **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

      Преднастроенный профиль содержит:

      * [базовое правило](concepts/rules.md#base-rules) по умолчанию, включенное для всего трафика с [типом действия](concepts/rules.md#rule-action) `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}`;
      * [правило Smart Protection](concepts/rules.md#smart-protection-rules), включенное для всего трафика, с типом действия `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`.

      {% include [smart-protection-tip](../_includes/smartwebsecurity/smart-protection-tip.md) %}

  1. Введите имя профиля, например `test-sp1`.
  1. В поле **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** выберите `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`.
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


## Подключите профиль безопасности к виртуальному хосту {#profile-connect}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Справа сверху нажмите ![plug](../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
  1. В открывшемся окне выберите:

      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}**](../application-load-balancer/concepts/application-load-balancer.md).
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}**](../application-load-balancer/concepts/http-router.md).
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}**](../application-load-balancer/concepts/http-router.md#virtual-host). Вы можете подключить профиль безопасности сразу к нескольким хостам.

        Чтобы подключить профиль к еще одному L7-балансировщику, нажмите **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_add-balancer }}**.

  1. Нажмите **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.

      На вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_connected-to-the-hosts }}** появится подключенный виртуальный хост.

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

  1. Перейдите на вкладку ![image](../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.label_profiles-list }}**.
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


## Настройте L7-балансировщик для дополнительной защиты {#configure-balancer}

{% include [alb-settings-recommendation](../_includes/smartwebsecurity/alb-settings-recommendation.md) %}


#### См. также {#see-also}

* [{#T}](operations/profile-create.md)
