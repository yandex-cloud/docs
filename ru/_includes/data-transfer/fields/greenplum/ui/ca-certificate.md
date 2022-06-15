{% if audience != "internal" %}

**Сертификат CA** — загрузите файл {% if product == "yandex-cloud" %}[сертификата](../../../../../managed-greenplum/operations/connect.md#get-ssl-cert){% endif %}{% if product == "cloud-il" %}сертификата{% endif %} или добавьте его содержимое в текстовом виде, если требуется шифрование передаваемых данных, например, для соответствия требованиям {% if product == "yandex-cloud" %}[PCI DSS]({% if lang == "ru" %}{{ link-pci-dss-ru }}{% endif %}{% if lang =="en" %}{{ link-pci-dss-en }}{% endif %}){% endif %}{% if product == "cloud-il" %}PCI DSS{% endif %}.

{% else %}

**Сертификат CA** — загрузите файл сертификата или добавьте его содержимое в текстовом виде, если требуется шифрование передаваемых данных, например, для соответствия требованиям {% if product == "yandex-cloud" %}[PCI DSS]({% if lang == "ru" %}{{ link-pci-dss-ru }}{% endif %}{% if lang =="en" %}{{ link-pci-dss-en }}{% endif %}){% endif %}{% if product == "cloud-il" %}PCI DSS{% endif %}.

{% endif %}