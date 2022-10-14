* `onPremise` — параметры подключения к базе данных:
    * {% include [Field API Hosts](../../fields/common/api/hosts.md) %}
    * {% include [Field API Port](../../fields/common/api/port.md) %}
    * `tlsMode` — параметры шифрования передаваемых данных, если оно требуется, например для соответствия требованиям {% if product == "yandex-cloud" %}[PCI DSS]({% if lang == "ru" %}{{ link-pci-dss-ru }}{% endif %}{% if lang =="en" %}{{ link-pci-dss-en }}{% endif %}){% endif %}{% if product == "cloud-il" %}PCI DSS{% endif %}.
        * `disabled` — отключено.
        * `enabled` — включено
            * `caCertificate` — сертификат CA.
    * {% include [Field API Subnet ID](../../fields/common/api/subnet-id.md) %}
{% if audience != "internal" %}
* {% include [Field API Security Group](../../fields/common/api/security-groups.md) %}
{% endif %}
* {% include [Field API Database](../../fields/mysql/api/database-target.md) %}
* {% include [Field API User](../../fields/common/api/user.md) %}
* {% include [Field API Password](../../fields/common/api/password.md) %}
