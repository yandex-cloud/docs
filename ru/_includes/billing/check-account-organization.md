{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
  1. У аккаунтов, [добавленных в организацию](../../billing/concepts/organization.md), появится ее идентификатор в столбце **{{ ui-key.yacloud_billing.billing.account.overview.account-data_label_organization }}**.
  1. Выберите платежный аккаунт.
  1. На странице **{{ ui-key.yacloud_billing.billing.account.switch_overview }}** в разделе **{{ ui-key.yacloud_billing.billing.account.overview.section_account-data }}** вы увидите ссылку на организацию. На этой же странице вы сможете [изменить организацию](../../billing/operations/change-organization.md) вашего платежного аккаунта.

{% endlist %}
