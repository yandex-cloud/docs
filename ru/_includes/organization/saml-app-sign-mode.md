* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.signature-mode-assertions_thJgN }}` — будут подписываться только передаваемые атрибуты. Значение по умолчанию.
* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.signature-mode-response_x7SKD }}` — будет подписываться весь SAML-ответ целиком.
* `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.signature-mode-response-and-assertions_u2j6T }}` — будут подписываться как целиком весь SAML-ответ, так и (отдельно) передаваемые атрибуты.

{% note warning %}

Режим подписи, заданный для SAML-приложения на стороне {{ org-name }}, должен соответствовать режиму подписи, заданному на стороне поставщика услуг.

{% endnote %}