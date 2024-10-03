---
title: Как посмотреть детализацию расходов {{ ml-platform-full-name }}
description: Из статьи вы узнаете, как посмотреть детализацию расходов {{ ml-platform-name }}.
---

# Посмотреть детализацию расходов {{ ml-platform-name }}

Вы можете получить подробные сведения о расходах в {{ ml-platform-name }} в интерфейсе [{{ billing-name }}]({{ link-console-billing }}) :

1. Выберите платежный аккаунт, привязанный к сообществу {{ ml-platform-name }}.
1. Перейдите в раздел **{{ ui-key.yacloud_billing.billing.account.switch_detail }}** на вкладку **{{ ui-key.yacloud_billing.billing.account.detail.tab_service}}**.
1. В поле **{{ ui-key.yacloud_billing.billing.account.detail.filter_label-services }}** выберите {{ ml-platform-name }}.
1. Перейдите на вкладку **{{ ui-key.yacloud_billing.billing.account.detail.tab_label}}**.
1. Выберите нужные параметры отображения диаграммы:
   * В поле **{{ ui-key.yacloud_billing.billing.account.detail.label_title-usage-short }}** выберите временной диапазон для построения диаграммы.
   * В поле **{{ ui-key.yacloud_billing.billing.account.detail.filter_label_label-key }}** выберите ресурсы {{ ml-platform-name }}, по которым вы хотите посмотреть детализацию.
   * В поле **{{ ui-key.yacloud_billing.billing.account.detail.filter_label_aggregation }}** выберите диапазон для агрегации данных.
   * При необходимости задайте дополнительные фильтры в поле **{{ ui-key.yacloud_billing.billing.account.detail.filter_label_all-filters }}**.

При изменении параметров диаграмма автоматически обновляется.
