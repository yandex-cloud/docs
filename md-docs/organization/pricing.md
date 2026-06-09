# Правила тарификации в {{ org-full-name }}



Стоимость использования сервиса {{ org-full-name }} входит в стоимость оплачиваемых сервисов. Дополнительно тарифицируется только подключение к внешним приложениям.

## Из чего складывается стоимость использования {{ org-full-name }} {#rules}

Средства за выбранное количество пользователей списываются в начале каждого месяца.

При покупке лимита на определенное количество пользователей средства списываются сразу.

[Управлять тарификацией](#pricing-management) сервиса {{ org-full-name }} вы можете через [интерфейс {{ cloud-center }}]({{ link-org-cloud-center }}). Подробнее см. в разделе [{#T}](operations/manage-billing.md).

## Цены для региона Россия {#prices}

{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}


| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |




## Управление тарификацией {{ org-full-name }} {#pricing-management}

С помощью [SAML-приложений](concepts/applications.md#saml) и [OIDC-приложений](concepts/applications.md#oidc) пользователи {{ org-full-name }} могут аутентифицироваться во [внешних приложениях](tutorials/single-sign-on/index.md), таких как [Grafana Cloud](https://grafana.com/products/cloud/), [Zabbix](https://www.zabbix.com) и др. Подключение пользователей {{ org-full-name }} к таким внешним приложениям [тарифицируется](#rules). [Управлять тарификацией](operations/manage-billing.md) сервиса {{ org-full-name }} вы можете через [интерфейс {{ cloud-center }}]({{ link-org-cloud-center }}).

Чтобы управлять тарификацией {{ org-full-name }} и использовать тарифицируемые возможности сервиса, привяжите [платежный аккаунт](../billing/concepts/billing-account.md) к {{ org-full-name }}.

{% note info %}

Чтобы привязать платежный аккаунт к {{ org-full-name }}, необходимы следующие роли:

* [роль](security/index.md#organization-manager-idpInstances-billingAdmin) `organization-manager.idpInstances.billingAdmin` или выше на организацию {{ org-full-name }}.
* [роль](../billing/security/index.md#billing-accounts-editor) `billing.accounts.editor` или выше на платежный аккаунт.

{% endnote %}

### Месячный лимит подключений {#monthly-limit}

При первом входе в любое из внешних приложений пользователь {{ org-full-name }} начинает расходовать месячный _лимит подключений_ [организации](concepts/organization.md). Далее, до конца месяца, этот пользователь может без ограничений входить в любые внешние приложения.

По умолчанию для организации установлен нетарифицируемый лимит в 15 пользователей в месяц, которые могут аутентифицироваться во внешних приложениях. После достижения этого лимита дополнительные пользователи не смогут входить во внешние приложения.

Вы в любой момент можете [посмотреть](operations/manage-billing.md#view-stats) данные о пользователях, расходующих лимит подключений в текущем месяце. В начале каждого нового месяца данные о расходовании лимита подключений обнуляются.

{% note info %}

Чтобы просматривать данные о расходовании лимита подключений в организации, необходима [роль](security/index.md#organization-manager-idpInstances-billingViewer) `organization-manager.idpInstances.billingViewer` или выше на эту организацию.

{% endnote %}

### Изменение лимита подключений {#modify-limit}

Вы можете в любой момент [увеличить](operations/manage-billing.md#modify-limit) лимит подключений. При этом дополнительные пользователи сверх нетарифицируемого лимита будут [тарифицироваться](#rules). Увеличение лимита подключений происходит сразу после оплаты.

Вы также можете уменьшить лимит подключений. При этом уже оплаченные подключения продолжат действовать до конца текущего месяца, а изменения вступят в силу начиная с первого числа следующего месяца. Минимальное значение — 15 подключений.

{% note info %}

Чтобы изменять лимит подключений в организации, необходима [роль](security/index.md#organization-manager-idpInstances-billingAdmin) `organization-manager.idpInstances.billingAdmin` или выше на эту организацию.

{% endnote %}



## Примеры расчета стоимости {#examples}

### Пример 1 {#example-1}

В организации 10 пользователей, которым нужен доступ ко внешним приложениям.

По умолчанию для организации установлен бесплатный лимит — 15 пользователей в месяц, которые могут аутентифицироваться во внешних приложениях. Поэтому использование {{ org-full-name }} не тарифицируется.


### Пример 2 {#example-2}

На начало месяца в организации было 15 пользователей, которым нужен доступ ко внешним приложениям. Необходимо увеличить лимит пользователей до 130.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > (130 - 15) × {{ sku|RUB|identity-hub.users.101-500|string }} = {% calc 130 - 15 %} × {{ sku|RUB|identity-hub.users.101-500|string }} = {% calc [currency=RUB] (130 - 15) × {{ sku|RUB|identity-hub.users.101-500|number }} %}
  > Итого: {% calc [currency=RUB] (130 - 15) × {{ sku|RUB|identity-hub.users.101-500|number }} %}.
  
  Где:
  
  * 130 — лимит платных пользователей.
  * 15 — нетарифицируемое количество пользователей.
  * {{ sku|RUB|identity-hub.users.101-500|string }} — стоимость за пользователя в месяц для количества от 101 до 500 пользователей.
  
  
  Сразу после увеличения лимита будет списано {% calc [currency=RUB] (130 - 15) × {{ sku|RUB|identity-hub.users.101-500|number }} %}.
  
  В начале каждого следующего месяца будет списываться так же {% calc [currency=RUB] (130 - 15) × {{ sku|RUB|identity-hub.users.101-500|number }} %}.

- Расчет в тенге {#prices-kzt}

  > (130 - 15) × {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %} = {% calc 130 - 15 %} × {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %} = {% calc [currency=KZT] (130 - 15) × round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %}
  > Итого: {% calc [currency=KZT] (130 - 15) × round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %}.
  
  Где:
  
  * 130 — лимит платных пользователей.
  * 15 — нетарифицируемое количество пользователей.
  * {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %} — стоимость за пользователя в месяц для количества от 101 до 500 пользователей.
  
  
  Сразу после увеличения лимита будет списано {% calc [currency=KZT] (130 - 15) × round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %}.
  
  В начале каждого следующего месяца будет списываться так же {% calc [currency=KZT] (130 - 15) × round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %}.

{% endlist %}




### Пример 3 {#example-3}

На начало месяца в организации было 130 пользователей, которым нужен доступ ко внешним приложениям. Необходимо увеличить лимит пользователей до 600.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > (600 - 130) × {{ sku|RUB|identity-hub.users.501-1000|string }} = {% calc 600 - 130 %} × {{ sku|RUB|identity-hub.users.501-1000|string }} = {% calc [currency=RUB] (600 - 130) × {{ sku|RUB|identity-hub.users.501-1000|number }} %}
  > Итого: {% calc [currency=RUB] (600 - 130) × {{ sku|RUB|identity-hub.users.501-1000|number }} %} — разовое списание.
  
  > (600 - 15) × {{ sku|RUB|identity-hub.users.501-1000|string }} = {% calc 600 - 15 %} × {{ sku|RUB|identity-hub.users.501-1000|string }} = {% calc [currency=RUB] (600 - 15) × {{ sku|RUB|identity-hub.users.501-1000|number }} %}
  > Итого: {% calc [currency=RUB] (600 - 15) × {{ sku|RUB|identity-hub.users.501-1000|number }} %} — в месяц.
  
  Где:
  
  * 600 — новый лимит платных пользователей.
  * 130 — старый лимит платных пользователей.
  * 15 — нетарифицируемое количество пользователей.
  * {{ sku|RUB|identity-hub.users.501-1000|string }} — стоимость за пользователя в месяц для количества от 501 до 1000 пользователей.
  
  Сразу после увеличения лимита будет списано {% calc [currency=RUB] (600 - 130) × {{ sku|RUB|identity-hub.users.501-1000|number }} %}.
  
  В начале каждого следующего месяца будет списываться {% calc [currency=RUB] (600 - 15) × {{ sku|RUB|identity-hub.users.501-1000|number }} %}.

- Расчет в тенге {#prices-kzt}

  > (600 - 130) × {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %} = {% calc 600 - 130 %} × {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %} = {% calc [currency=KZT] (600 - 130) × round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %}
  > Итого: {% calc [currency=KZT] (600 - 130) × round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %} — разовое списание.
  
  > (600 - 15) × {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %} = {% calc 600 - 15 %} × {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %} = {% calc [currency=KZT] (600 - 15) × round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %}
  > Итого: {% calc [currency=KZT] (600 - 15) × round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %} — в месяц.
  
  Где:
  
  * 600 — новый лимит платных пользователей.
  * 130 — старый лимит платных пользователей.
  * 15 — нетарифицируемое количество пользователей.
  * {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %} — стоимость за пользователя в месяц для количества от 501 до 1000 пользователей.
  
  Сразу после увеличения лимита будет списано {% calc [currency=KZT] (600 - 130) × round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %}.
  
  В начале каждого следующего месяца будет списываться {% calc [currency=KZT] (600 - 15) × round({{ sku|KZT|identity-hub.users.501-1000|number }} × 100) / 100 %}.

{% endlist %}




### Пример 4 {#example-4}

На начало месяца в организации было 600 пользователей, которым нужен доступ ко внешним приложениям. Необходимо уменьшить лимит пользователей до 400.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  > (400 - 15) × {{ sku|RUB|identity-hub.users.101-500|string }} = {% calc 400 - 15 %} × {{ sku|RUB|identity-hub.users.101-500|string }} = {% calc [currency=RUB] (400 - 15) × {{ sku|RUB|identity-hub.users.101-500|number }} %}
  > Итого: {% calc [currency=RUB] (400 - 15) × {{ sku|RUB|identity-hub.users.101-500|number }} %} — в месяц.
  
  Где:
  
  * 400 — новый лимит платных пользователей.
  * 15 — нетарифицируемое количество пользователей.
  * {{ sku|RUB|identity-hub.users.101-500|string }} — стоимость за пользователя в месяц для количества от 101 до 500 пользователей.
  
  Текущий месяц уже оплачен, поэтому после уменьшения лимита не будет списания.
  
  В начале каждого следующего месяца будет списываться {% calc [currency=RUB] (400 - 15) × {{ sku|RUB|identity-hub.users.101-500|number }} %}.

- Расчет в тенге {#prices-kzt}

  > (400 - 15) × {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %} = {% calc 400 - 15 %} × {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %} = {% calc [currency=KZT] (400 - 15) × round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %}
  > Итого: {% calc [currency=KZT] (400 - 15) × round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %} — в месяц.
  
  Где:
  
  * 400 — новый лимит платных пользователей.
  * 15 — нетарифицируемое количество пользователей.
  * {% calc [currency=KZT] round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %} — стоимость за пользователя в месяц для количества от 101 до 500 пользователей.
  
  Текущий месяц уже оплачен, поэтому после уменьшения лимита не будет списания.
  
  В начале каждого следующего месяца будет списываться {% calc [currency=KZT] (400 - 15) × round({{ sku|KZT|identity-hub.users.101-500|number }} × 100) / 100 %}.

{% endlist %}





#### См. также {#see-also}

* [{#T}](operations/manage-billing.md)