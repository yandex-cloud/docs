* `onPremise` — параметры подключения к базе данных:
    * {% include [Field API Hosts](../../fields/common/api/hosts.md) %}
    * {% include [Field API Port](../../fields/common/api/port.md) %}
    * `tlsMode` — параметры шифрования передаваемых данных, если оно требуется, например для соответствия требованиям PCI DSS.
        * `disabled` — отключено.
        * `enabled` — включено
            * `caCertificate` — сертификат CA.

              {% include [certificate](../../../../_includes/data-transfer/fields/certificate-needed.md) %}

    * {% include [Field API Subnet ID](../../fields/common/api/subnet-id.md) %}
* {% include [Field API Security Group](../../fields/common/api/security-groups.md) %}
* {% include [Field API Database](../../fields/mysql/api/database-source.md) %}
* {% include [Field API User](../../fields/common/api/user.md) %}
* {% include [Field API Password](../../fields/common/api/password.md) %}
