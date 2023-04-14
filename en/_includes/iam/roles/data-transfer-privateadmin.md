### data-transfer.privateAdmin {#data-transfer-privateadmin}

The `{{ roles-data-transfer-private-admin }}` role enables you to create, activate, and deactivate [transfers](../../../data-transfer/concepts/index.md#transfer) that transmit data only on {{ yandex-cloud }} networks.

If you wish to prevent users from creating or activating transfers that transmit data over the internet, revoke the `{{ roles-data-transfer-admin }}` role and assign the `{{ roles-data-transfer-private-admin }}` role.

{% include [roles-restriction-only-parents](../roles-restriction-only-parents.md) %}
