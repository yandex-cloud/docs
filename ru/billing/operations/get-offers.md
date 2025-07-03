---
title: Как принять коммерческое предложение {{ billing-name }}
description: Следуя данной инструкции, вы сможете просматривать и принимать коммерческие предложения.
---

# Принять предложения

{{ yandex-cloud }} в сервисе {{ billing-name }} может направлять клиентам специальные коммерческие предложения, в рамках которых пользователи могут получать скидки, гранты, уточнения по резервируемому объему ресурсов, подписки и корректировки.

Статусы коммерческих предложений:
* `{{ ui-key.yacloud_org.billing.account.proposals.tariff_available-title }}` — активные предложения.
* `{{ ui-key.yacloud_org.billing.account.proposals.tariff_accepted-title }}` — принятые предложения.
* `{{ ui-key.yacloud_org.billing.account.proposals.tariff_activating-title }}` — принимаемые предложения. Обычно требуется до 5 минут, затем статус изменится на `{{ ui-key.yacloud_org.billing.account.proposals.tariff_accepted-title }}`. Если статус изменился на `{{ ui-key.yacloud_org.billing.account.proposals_page.type_Error }}`, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.
* `{{ ui-key.yacloud_org.billing.account.proposals.tariff_blocked-title }}` — чтобы принять предложение, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.
* `Завершено` — все завершенные предложения и предложения, срок которых истек. Отображаются на вкладке **{{ ui-key.yacloud_org.billing.account.proposals.label_from-archive }}**.

{% note info %}

Чтобы просматривать предложения, пользователю необходима [роль](../security/index.md#billing-accounts-viewer) `billing.accounts.viewer`.
Чтобы принимать предложения, пользователю необходима [роль](../security/index.md#billing-accounts-owner) `billing.accounts.owner` или `billing.accounts.editor`.

{% endnote %}

Для просмотра предложений и их применения:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. Перейдите в сервис [**{{ billing-name }}**]({{ link-console-billing }}).
  1. Выберите аккаунт на странице **{{ ui-key.yacloud_billing.billing.title_accounts }}**. Если для выбранного платежного аккаунта есть предложения, они будут перечислены в верхнем информационном блоке.
  1. Для просмотра всех предложений на панели слева выберите ![image](../../_assets/console-icons/tag-dollar.svg) **{{ ui-key.yacloud_org.billing.account.switch_proposals }}**.
  1. На странице **{{ ui-key.yacloud_org.billing.account.proposals.label_title }}** вы сможете просмотреть активные предложения на вкладке **{{ ui-key.yacloud_org.billing.account.proposals.label_from-current }}**. Там отображаются предложения в статусе `{{ ui-key.yacloud_org.billing.account.proposals.tariff_available-title }}`. Для удобства просмотра отфильтруйте список предложений по типу условий или сервисам, а также отсортируйте их по сроку действия.
  1. Чтобы принять предложение, выберите его в списке, ознакомьтесь с его деталями, подтвердите согласие с условиями использования и нажмите кнопку **{{ ui-key.yacloud_org.billing.account.proposals.button_confirm }}**.

{% endlist %}