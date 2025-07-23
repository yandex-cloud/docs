Справа сверху нажмите кнопку ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:

1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** укажите уникальный идентификатор поставщика услуг (Service Provider).

    Значение должно совпадать на стороне поставщика услуг и на стороне {{ org-name }}.
1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** укажите URL-адрес, на который {{ org-name }} будет отправлять SAML-ответ.

    {% include [saml-app-acs-url-paragraph](./saml-app-acs-url-paragraph.md) %}

    При необходимости воспользуйтесь кнопкой **{{ ui-key.yacloud_org.organization.apps.SamlAppAcsUrlsField.add-acs-url_eMunC }}**, чтобы указать несколько URL/индексов ACS.

    {% include [saml-app-acs-url-warn](./saml-app-acs-url-warn.md) %}

1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-signature-mode_ipXQ7 }}** выберите элементы SAML-ответа, которые будут подписываться электронной подписью:

    {% include [saml-app-sign-mode](./saml-app-sign-mode.md) %}

1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.