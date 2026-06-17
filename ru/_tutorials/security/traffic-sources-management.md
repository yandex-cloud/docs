---
title: Управление источниками трафика
description: Как настроить правила обработки трафика по предустановленным спискам IP-адресов и регионам в {{ sws-name }}.
---

# Управление источниками трафика

{{ sws-name }} позволяет настраивать правила обработки запросов в зависимости от источника трафика. Например, можно отдельно обрабатывать запросы из сети Tor, VPN, анонимных сетей, от публичных прокси или из определенных стран.

Для этого используются предустановленные [списки IP-адресов](../../smartwebsecurity/concepts/lists.md) {{ yandex-cloud }}. Они содержат IP-адреса и сети, объединенные по определенному признаку, например по принадлежности к Tor или VPN. Списки поддерживает сервис и регулярно обновляет их.

В этом руководстве описана настройка распространенных правил фильтрации трафика по его источнику.

## Порядок настройки {#steps}

1. [Создайте профиль безопасности](#profile-create)
1. [Настройте правило для Tor, прокси и анонимных сетей](#configure-source-rules)
1. [Настройте правило для VPN-трафика](#configure-vpn-rules)
1. [Настройте правило по регионам](#configure-geo-rules)
1. [Проверьте порядок выполнения правил](#rules-order)
1. [Подключите профиль безопасности к ресурсам](#profile-connect)
1. [Проверьте правила в режиме логирования](#dry-run)
1. [Включите рабочий режим](#production)

## Необходимые платные ресурсы {#paid-resources}

* Плата за количество запросов в сервис {{ sws-name }} по тарифам из раздела [{#T}](../../smartwebsecurity/pricing.md).
* Плата за инфраструктуру защищаемого ресурса в зависимости от его расположения.

Руководство предполагает, что у вас уже есть настроенный веб-ресурс в инфраструктуре {{ yandex-cloud }}. Если веб-ресурс находится в другой инфраструктуре, подключите его к прокси-серверу по руководству [{#T}](../../smartwebsecurity/tutorials/sws-basic-protection.md).

## Создайте профиль безопасности {#profile-create}

В этом руководстве используется готовый шаблон профиля безопасности.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находятся защищаемые ресурсы.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.action_empty }}** и выберите **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

      {% include [pre-configured-profile](../../_includes/smartwebsecurity/pre-configured-profile.md) %}
   
  1. Введите имя профиля, например `sources-manage`.

  1. Включите тестовый режим для правила Smart Protection `sp-rule-1`:
     1. Для опции **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** выберите `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
     1. Напротив правила `sp-rule-1` нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
     1. Включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
     1. Нажмите **{{ ui-key.yacloud.common.save-changes }}**.

  1. В разделе **{{ ui-key.yacloud.component.disallow-data-processing.title_ml-model-training }}** оставьте включенным согласие об использовании информации об HTTP-запросах для улучшения моделей машинного обучения. Иначе в сервис {{ sws-name }} не будут поступать данные для расследования инцидентов безопасности.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


## Настройте правило для Tor, прокси и анонимных сетей {#configure-source-rules}

Для определения такого трафика используются списки `is_tor`, `is_proxy` и `is_anonymous`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте созданный ранее профиль безопасности.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Введите имя правила, например `traffic-sources-rule`.
  1. Включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
  1. Задайте приоритет выше, чем у правил Smart Protection. Например, `9100`.
  1. Укажите параметры правила:
     * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}** — `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`;
     * **Трафик** — `При условии`;
     * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`;
     * **Условия на IP** — `IP принадлежит списку`.
  1. Для списка `is_tor` выберите действие `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`.
  1. Создайте отдельное правило или добавьте дополнительное условие для списков `is_proxy` и `is_anonymous` с действием `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}`.
  1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

Такой набор правил помогает сразу блокировать трафик из Tor и отдельно проверять запросы из публичных прокси и анонимных сетей через {{ captcha-name }}.

## Настройте правило для VPN-трафика {#configure-vpn-rules}

Для определения VPN-трафика используются списки `is_vpn` и `is_ml_vpn`.

Для такого трафика можно задать отдельные правила обработки в соответствии с политикой безопасности: разрешать, блокировать, принудительно отправлять на капчу или применять дополнительные ограничения в профиле ARL.

{% note warning %}

Определение VPN-трафика основано на базе IP-адресов {{ yandex-cloud }} и не гарантирует полной точности. Возможны ложноположительные и ложноотрицательные срабатывания. Принимайте решение о блокировке VPN-трафика с учетом бизнес-сценариев, поскольку часть реальных пользователей может использовать VPN.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В профиле безопасности нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Введите имя правила, например `vpn-traffic-rule`.
  1. Включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
  1. Задайте приоритет так, чтобы правило выполнялось в нужном порядке относительно других правил по спискам.
  1. Укажите параметры правила:
     * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}** — `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`;
     * **Трафик** — `При условии`;
     * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`;
     * **Условия на IP** — `IP принадлежит списку`.
  1. Выберите список `is_vpn` или `is_ml_vpn`.
  1. Выберите действие для VPN-трафика:
     * `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}` — если VPN-трафик допустим.
     * `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` — если VPN-трафик нужно блокировать.
     * `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}` — если нужна дополнительная проверка.
  1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

Чтобы ограничивать частоту запросов для VPN-трафика, [создайте профиль ARL](../../smartwebsecurity/operations/arl-profile-create.md) и добавьте в него [правило](../../smartwebsecurity/operations/arl-rule-add.md) с условиями для списков `is_vpn` и `is_ml_vpn`.

## Настройте правило по регионам {#configure-geo-rules}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В профиле безопасности нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Введите имя правила, например `geo-traffic-rule`.
  1. Включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
  1. Задайте приоритет выше, чем у правил Smart Protection, но с учетом уже созданных правил по спискам.
  1. Укажите параметры правила:
     * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}** — `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`;
     * **Трафик** — `При условии`;
     * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`;
     * **Условия на IP** — `IP принадлежит региону` или `IP не принадлежит региону`.
  1. Выберите нужные страны по двухбуквенному коду. Например, `RU`, `KZ`, `BY`.
  1. Выберите действие:
     * `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}` — чтобы разрешить трафик;
     * `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` — чтобы блокировать трафик;
     * `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}` — чтобы отправлять запросы в {{ captcha-name }}.
  1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

Если ваш сервис ориентирован только на несколько стран, удобнее использовать условие `IP не принадлежит региону`. Тогда вы сможете явно указать разрешенные регионы, а остальной трафик ограничить.

## Проверьте порядок выполнения правил {#rules-order}

Правила в профиле безопасности применяются по принципу первого сработавшего правила. Поэтому заранее определите порядок обработки:

* сначала разрешающие правила для доверенного трафика;
* затем правила для источников повышенного риска;
* затем правила по регионам;
* после этого правила Smart Protection и другие общие правила.

Подробнее о порядке выполнения правил — [{#T}](../../smartwebsecurity/concepts/rules.md#rules-order).

## Проверьте правила в режиме логирования {#dry-run}

Оставьте новые правила в режиме **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** на несколько дней. За это время:

* проверьте, какие запросы попадают под правила;
* оцените долю легитимного трафика;
* скорректируйте списки, регионы и действия.

Для анализа используйте логи и мониторинг сервиса. Подробнее в разделах [{#T}](../../smartwebsecurity/operations/configure-logging.md) и [{#T}](../../smartwebsecurity/operations/monitoring.md).

## Включите рабочий режим {#production}

После тестирования отключите для правил опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**. После этого продолжайте следить за работой правил и при необходимости корректировать их.

#### Полезные ссылки {#see-also}

* [{#T}](../../smartwebsecurity/concepts/lists.md)
* [{#T}](../../smartwebsecurity/concepts/conditions.md)
* [{#T}](../../smartwebsecurity/concepts/botes.md)
* [{#T}](../../smartwebsecurity/tutorials/sws-basic-protection.md)