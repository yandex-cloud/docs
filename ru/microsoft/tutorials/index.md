# Практические руководства

{% if product == "cloud-il" %}

* [Развертывание Active Directory](active-directory.md)
{% if audience == "draft" %}
* [Развертывание Microsoft Exchange](exchange.md)
* [Развертывание Remote Desktop Services](rds.md)
{% endif %}
* [Развертывание группы доступности Always On с внутренним сетевым балансировщиком](mssql-alwayson-lb.md)
* [Настройка Remote Desktop Gateway](rds-gw.md)
{% if audience == "draft" %}
* [Обновление редакции Windows Server до Datacenter](edition-update-datacenter.md)
{% endif %}

{% endif %}

{% if product == "yandex-cloud" %}

* [Подготовка собственных образов с продуктами Microsoft](../prepare-image.md)
* [Использование своей лицензии для продуктов Microsoft](../byol.md)

{% endif %}
