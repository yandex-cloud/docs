### {{ roles-data-transfer-private-admin }} {#data-transfer-privateadmin}

Роль `{{ roles-data-transfer-private-admin }}` позволяет создавать, активировать и деактивировать [трансферы](../../../data-transfer/concepts/index.md#transfer) с передачей данных только в сетях {{ yandex-cloud }}.

Если вы хотите запретить пользователям создавать или активировать трансферы, передающие данные через интернет, отзовите роль `{{ roles-data-transfer-admin }}` и назначьте роль `{{ roles-data-transfer-private-admin }}`.

{% include [roles-restriction-only-parents](../roles-restriction-only-parents.md) %}
