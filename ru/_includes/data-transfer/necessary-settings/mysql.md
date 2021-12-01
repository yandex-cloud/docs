{% list tabs %}

* Пользовательская инсталляция

    Подключение к БД с явным указанием ее сетевого адреса и порта.

    Для подключения задайте обязательные параметры:

    * **IP или FQDN хоста** — укажите IP-адрес или FQDN хоста-мастера, к которому необходимо подключиться.
    * **Порт базы данных** — укажите номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
    * **Сертификат CA** — если требуется шифрование передаваемых данных, например для соответствия требованиям [PCI DSS]({% if lang == "ru" %}{{ link-pci-dss-ru }}{% endif %}{% if lang =="en" %}{{ link-pci-dss-en }}{% endif %}), загрузите файл [сертификата](../../../managed-mysql/operations/connect.md#get-ssl-cert) или добавьте его содержимое в текстовом виде.
    * {% include [Field Database name](../fields/database-name.md) %}
    * {% include [Field Username](../fields/username.md) %}
    * {% include [Field Password](../fields/password.md) %}

* Кластер MDB

    Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}. Доступно только для кластеров, развернутых в сервисе [{{ mmy-name }}](../../../managed-mysql/).

    Для подключения задайте обязательные параметры:

    * {% include [Field Cluster ID](../fields/cluster-id.md) %}
    * {% include [Field Database name](../fields/database-name.md) %}
    * {% include [Field Username](../fields/username.md) %}
    * {% include [Field Password](../fields/password.md) %}

{% endlist %}
