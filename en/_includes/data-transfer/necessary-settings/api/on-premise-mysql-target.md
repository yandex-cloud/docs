* `onPremise`: Database connection parameters:
   * {% include [Field API Hosts](../../fields/common/api/hosts.md) %}
   * {% include [Field API Port](../../fields/common/api/port.md) %}
   * `tlsMode`: Parameters for encrypting transmitted data if it is required, for example, to meet PCI DSS requirements.
      * `disabled`: Disabled.
      * `enabled`: Enabled.
         * `caCertificate`: CA certificate.
   * {% include [Field API Subnet ID](../../fields/common/api/subnet-id.md) %}
* {% include [Field API Database](../../fields/mysql/api/database-target.md) %}
* {% include [Field API User](../../fields/common/api/user.md) %}
* {% include [Field API Password](../../fields/common/api/password.md) %}
