# Экстренная защита сервисов в {{ alb-name }} от DDoS на уровне L7


Руководство поможет остановить [DDoS-атаку](https://ru.wikipedia.org/wiki/DoS-атака), которая происходит в реальном времени.

## Условия применения руководства {#tutorial-conditions}

* Ваши сервисы находятся в {{ yandex-cloud }} или подключены к [{{ alb-name }}](../../application-load-balancer/) через [{{ interconnect-name }}](../../interconnect/).
* Сервисы опубликованы в интернете через L7-балансировщик {{ alb-name }}.
* DDoS-атака происходит на уровне L7 — поступает аномально большое количество HTTP-запросов (GET/POST).

{% note tip %}

Определите типовую нагрузку на ваш сервис. Это можно сделать в сервисе {{ alb-name }}, в разделе **{{ ui-key.yacloud_billing.common.monitoring }}**. На графике **RPS** отображается общее количество входящих запросов в секунду, поступающих на балансировщик. Для анализа нормальной нагрузки выберите период до DDoS-атаки.

{% endnote %}

## Порядок настройки защиты {#setup-stages}

Защита от DDoS-атаки состоит в подключении сервиса [{{ sws-name }}](../../smartwebsecurity/) и настройке правил, блокирующих вредоносный трафик.

1. [Создайте профиль безопасности](#setup-security-profile).
1. [Подключите профиль безопасности](#connect-profile) к виртуальному хосту.
   
   Если профиль безопасности был создан ранее и уже подключен к хосту, [проверьте его настройки](#setup-existing-profile).

1. [Проверьте работу профиля безопасности](#check-the-result).
1. [Настройте дополнительные правила защиты от DDoS](#anti-ddos).

После остановки атаки можно настроить индивидуальную защиту вашего сервиса с помощью [{{ sws-name }}](../../smartwebsecurity/concepts/). Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/sws-protection-ddos/paid-resources.md) %}

## Создайте профиль безопасности {#setup-security-profile}

_Профиль безопасности_ — основной элемент {{ sws-name }}. Профиль состоит из набора правил для обработки HTTP-трафика. Правила содержат условия фильтрации и действия, которые применяются к трафику, проходящему через виртуальный хост L7-балансировщика.

Для быстрого включения защиты используйте преднастроенный шаблон. В шаблоне собраны оптимальные настройки для базовой защиты веб-сервисов.

Чтобы создать профиль безопасности:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находятся защищаемые ресурсы.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.action_empty }}** и выберите **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.
  1. Введите имя профиля, например `anti-ddos`.
  1. В поле **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** выберите `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`.
  1. В списке **{{ ui-key.yacloud.smart-web-security.form.label_smartcaptcha }}** оставьте значение `{{ ui-key.yacloud.smart-web-security.label_default-smartcaptcha-name }}`.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.


{% endlist %}

## Подключите профиль безопасности к виртуальному хосту {#connect-profile}

Если балансировщик управляется [Ingress-контроллером](../../application-load-balancer/tools/k8s-ingress-controller/index.md) {{ alb-name }}, используйте [аннотацию ресурса Ingress](../../application-load-balancer/k8s-ref/ingress.md#annot-security-profile-id).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице свойств профиля безопасности вверху справа нажмите кнопку ![plug](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
  1. Последовательно выберите:
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}**](../../application-load-balancer/concepts/application-load-balancer.md).
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}**](../../application-load-balancer/concepts/http-router.md).

      * **{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}**. Вы можете подключить профиль безопасности сразу к нескольким хостам.

        Чтобы подключить другой L7-балансировщик, нажмите кнопку **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_add-balancer }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.

      На вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_connected-to-the-hosts }}** появятся подключенные виртуальные хосты.

{% endlist %}

## Настройте существующий профиль безопасности {#setup-existing-profile}

Если профиль безопасности был создан ранее, проверьте и скорректируйте его параметры:

1. **{{ ui-key.yacloud.smart-web-security.form.label_smartcaptcha }}** — `{{ ui-key.yacloud.smart-web-security.label_default-smartcaptcha-name }}`.

1. Проверьте наличие правила `sp-rule-1` с параметрами:
   * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}** — `{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}`.
   * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}** — `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` (защита сайтов, подозрительные запросы отправляются в {{ captcha-name }}) или `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}` (подозрительные запросы блокируются).
   * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `{{ ui-key.yacloud.component.condition-column.condition_full-trafic }}`.
   * **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** — `999900`.

1. Проверьте наличие базового правила с параметрами:
   * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}** — `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`.
   * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `{{ ui-key.yacloud.component.condition-column.condition_full-trafic }}`.
   * **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** — `1000000`.
   
## Проверьте работу профиля безопасности {#check-the-result}

Проверить работу профиля безопасности можно с помощью графиков мониторинга и записей в логах.

### Мониторинг {#monitoring}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Выберите раздел **{{ ui-key.yacloud.common.monitoring }}**.
  1. Посмотрите информацию на графиках:
     * **Denied by Security Profile RPS** — количество входящих запросов в секунду, которые были проверены и заблокированы профилем безопасности.
     * **Redirected to SmartCaptcha RPS** — количество входящих запросов в секунду, направленных в {{ captcha-name }} для дополнительной верификации.
     * **Denied by ARL Profile RPS** — количество входящих запросов в секунду, превысивших лимит профиля ARL и заблокированных.

{% endlist %}

Подробное описание графиков см. в разделе [{#T}](../../smartwebsecurity/operations/monitoring.md).

### Логирование {#logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Убедитесь, что для L7-балансировщика настроено [логирование](../../smartwebsecurity/operations/configure-logging.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Выберите балансировщик, к которому привязан профиль безопасности.
  1. Выберите раздел **{{ ui-key.yacloud.common.logs }}**.
  1. Выберите количество сообщений на одной странице и период. Например, `1 час`.
  1. В строке **Запрос** укажите запрос на [языке фильтрующих выражений](../../logging/concepts/filter.md) и нажмите кнопку **Выполнить**.

      Примеры запросов:

      * Показать запросы, для которых сработало правило Smart Protection с отправкой на капчу:
        ```
        json_payload.smartwebsecurity.matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.matched_rule.verdict = CAPTCHA
        ```

      * Показать запросы, заблокированные правилами профиля ARL:
        ```
        json_payload.smartwebsecurity.advanced_rate_limiter.verdict = DENY
        ```

{% endlist %}

Подробное описание работы с логами см. в разделе [{#T}](../../smartwebsecurity/operations/configure-logging.md).

## Настройте дополнительные правила защиты от DDoS {#anti-ddos}

Чтобы ограничить нетипичную нагрузку на ваш сервис, настройте лимит запросов в профиле [ARL (Advanced Rate Limiter)](../../smartwebsecurity/concepts/arl.md).

### Настройте лимит запросов {#setup-arl}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.arl.label_create-profile }}**.
  1. Введите имя профиля, например `anti-ddos-arl`.
  1. Нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}** и укажите:
        
     {% include [arl-rule-properties](../_tutorials_includes/sws-protection-ddos/arl-rule-properties.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.arl.label_save-rule }}**.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. Напротив профиля `anti-ddos` нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. В списке профилей ARL выберите `anti-ddos-arl`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Настройте блокировку по спискам IP-адресов {#block-by-list}

[Списки](../../smartwebsecurity/concepts/lists.md) ненадежных адресов предустановлены в {{ sws-name }} и регулярно обновляются. Вы можете [составить свои списки](../../smartwebsecurity/operations/list-create.md) надежных или ненадежных адресов и добавлять их в условия фильтрации запросов.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
   1. Выберите профиль безопасности `anti-ddos`.
   1. Нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
   1. Введите **{{ ui-key.yacloud_billing.common.name }}**, например, `block-by-list`.
   1. Укажите параметры правила:
      * **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** — выше, чем у правила `sp-rule-1`. Например, `1000`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}** — `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}** — `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` или `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}`.
      * **Трафик** — `При условии`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`.
      * **Условия на IP** — `IP принадлежит списку`.
      * Выберите списки адресов. Запросы с этих адресов будут блокироваться:
         * `is_ddoser` — список IP-адресов, которые участвовали в DDoS-атаках.
         * Нажмите кнопку **+ или** и выберите `is_tor` — IP-адреса сети TOR, которая используется для анонимизации трафика.
         * Нажмите кнопку **+ или** и выберите `is_anonimous` — IP-адреса анонимных сетей, которые часто используются для сокрытия личности.
    1. Нажмите кнопку **{{ ui-key.yacloud_billing.common.add }}**.

{% endlist %}

### Настройте блокировку по региону IP-адресов {#block-by-geo}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Заблокируйте запросы из региона, откуда происходит атака. Если ваш сервис не работает в определенных регионах, можно сразу заблокировать трафик из этих регионов. Часто DDoS-атаки происходят с IP-адресов нецелевых стран.

   1. Выберите профиль безопасности `anti-ddos`.
   1. Нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
   1. Введите **{{ ui-key.yacloud_billing.common.name }}**, например, `block-by-geo`.
   1. Укажите параметры правила:
      * **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** — выше, чем у правила `sp-rule-1`, но ниже, чем у `block-by-list`. Например, `2000`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}** — `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}** — `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` или `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}`.
      * **Трафик** — `При условии`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`.
      * **Условия на IP** — `IP принадлежит региону`.
      * Выберите регион, из которого происходит атака. Например, `CN`, `US`, `IN`.
  
         Чтобы добавить еще регион, нажмите кнопку **+ или**.

      {% note tip %}

      Если ваш сервис работает только в некоторых регионах, выберите условие `IP не принадлежит региону`. В списке укажите целевой регион, например, `RU`. Трафик из других регионов будет блокироваться.

      Уточнить регион по IP-адресу можно на сайте [ipinfo.io](https://ipinfo.io/) или с помощью [ASN провайдера](https://ru.wikipedia.org/wiki/Автономная_система_(Интернет)).

      {% endnote %}

   1. Нажмите кнопку **{{ ui-key.yacloud_billing.common.add }}**.

{% endlist %}

Проверьте работу правил с помощью графиков мониторинга и логов. При необходимости скорректируйте лимит запросов в профиле ARL.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, воспользуйтесь одним из способов:

1. [Отключите профиль безопасности](../../smartwebsecurity/operations/host-delete.md) от виртуального хоста.
1. [Удалите профиль безопасности](../../smartwebsecurity/operations/profile-delete.md).