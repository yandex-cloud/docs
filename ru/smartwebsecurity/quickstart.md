# Как начать работать с профилем безопасности

Создайте первый [профиль безопасности](./concepts/profiles.md) и подключите его к имеющемуся [виртуальному хосту](../application-load-balancer/concepts/http-router.md#virtual-host) L7-балансировщика {{ alb-full-name }}.

Если у вас еще не настроен L7-балансировщик, вы можете опробовать {{ sws-name }} на тестовой инфраструктуре. Подробнее см. [{#T}](./tutorials/balancer-with-sws-profile.md).

Чтобы начать работу с профилем безопасности:
1. [Создайте профиль безопасности](#profile-create).
1. [Проверьте настройки профиля безопасности](#profile-check).
1. [Подключите профиль безопасности к виртуальному хосту](#profile-connect).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте профиль безопасности {#profile-create}

Профиль безопасности является основным элементом сервиса {{ sws-name }} и состоит из набора правил, каждое из которых содержит условия для фильтрации входящих пользовательских запросов к защищаемому ресурсу.

Чтобы создать профиль безопасности:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать профиль.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.action_empty }}** и выберите **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

      Преднастроенный профиль содержит:
      * [базовое правило](concepts/rules.md#base-rules) по умолчанию, включенное для всего трафика с [типом действия](concepts/rules.md#rule-action) — `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}`;
      * [правило Smart Protection](concepts/rules.md#smart-protection-rules), включенное для всего трафика, с типом действия — `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`.

      {% include [smart-protection-tip](../_includes/smartwebsecurity/smart-protection-tip.md) %}

  1. Введите имя профиля, например `test-sp1`.
  1. В поле **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** выберите `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Проверьте настройки профиля безопасности {#profile-check}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите профиль `test-sp1`, созданный ранее.
  1. Убедитесь, что на вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** есть правило со следующими параметрами:
      * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}** — `{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}** — `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `{{ ui-key.yacloud.smart-web-security.overview.condition_full-trafic }}`.

      Это правило отправляет весь трафик, приходящий к защищаемому ресурсу, на автоматическую оценку с помощью алгоритмов машинного обучения и поведенческого анализа. По результатам автоматической оценки:
      * Легитимные запросы направляются к защищаемому ресурсу.
      * Нелегитимные запросы и атаки блокируются.
      * Подозрительные запросы направляются в [{{ captcha-name }}](../smartcaptcha/) для дополнительной верификации.

  Вы также можете подключить к профилю безопасности [профиль WAF](./concepts/waf.md). Подробнее см. на странице [{#T}](./quickstart/quickstart-waf.md).

  {% include [note-preview-waf](../_includes/smartwebsecurity/note-preview-waf.md) %}

{% endlist %}

## Подключите профиль безопасности к виртуальному хосту {#profile-connect}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Справа сверху нажмите кнопку ![plug](../_assets/smartwebsecurity/plug.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
  1. В открывшемся окне выберите:
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}**](../application-load-balancer/concepts/application-load-balancer.md).
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}**](../application-load-balancer/concepts/http-router.md).
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}**](../application-load-balancer/concepts/http-router.md#virtual-host). Вы можете подключить профиль безопасности сразу к нескольким хостам.

        Чтобы подключить профиль к еще одному L7-балансировщику, нажмите кнопку **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_add-balancer }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.

      На вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_connected-to-the-hosts }}** появится подключенный виртуальный хост.

{% endlist %}

### См. также {#see-also}

* [{#T}](./quickstart/quickstart-waf.md)
* [{#T}](./concepts/profiles.md)
* [{#T}](./operations/profile-create.md)
* [Создать L7-балансировщик с профилем безопасности](./tutorials/balancer-with-sws-profile.md)
