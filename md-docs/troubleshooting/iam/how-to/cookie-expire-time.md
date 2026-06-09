# Какое время жизни сессии при аутентификации федеративного пользователя


## Описание сценария {#case-description}

Необходимо разобраться, какое максимальное значение параметра `Время жизни cookie` при настройке федерации.

## Решение {#case-resolution}

Максимальное время жизни сессии составляет 12 часов. Изменить его в бо́льшую сторону возможности нет, но вы можете воспользоваться опцией **{{ ui-key.yacloud_org.entity.federation.field.forceAuthn }}**. При включении этой опции IdP-провайдер запрашивает у пользователя аутентификацию по истечении сессии в {{ yandex-cloud }}.

Подробнее вы можете ознакомиться с изменениями в разделе **Создайте федерацию в организации** по ссылкам ниже:

* [ADFS](../../../organization/operations/federations/integration-adfs#create-federation);
* [Google Workspace](../../../organization/operations/federations/integration-gworkspace#yc-settings);
* [{{ microsoft-idp.entra-id-short }}](../../../organization/operations/federations/integration-azure#yc-settings);
* [Keycloak](../../../organization/operations/federations/integration-keycloak#yc-settings);
* [SAML-совместимая](../../../organization/operations/federations/integration-common#create-federation).