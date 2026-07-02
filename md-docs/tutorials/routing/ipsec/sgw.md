[Документация Yandex Cloud](../../../index.md) > [Практические руководства](../../index.md) > Базовая инфраструктура > VPNs > [Организация сетевой связности с помощью IPsec-шлюзов](index.md) > Решение SGW от команды архитекторов Yandex Cloud

# Решение Security GateWay от команды архитекторов Yandex Cloud

Для организации защищенного соединения между ресурсами в Yandex Cloud и инфраструктурой клиента по схеме из [подраздела](index.md) можно воспользоваться решением от команды архитекторов Yandex Cloud — [Security GateWay (SGW)](https://github.com/yandex-cloud-examples/yc-site-to-site-vpn-with-ipsec-strongswan).

Основные характеристики решения:

* Разработано в виде Terraform-модуля.
* strongSwan в Docker-контейнере.
* strongSwan [Route-based VPN](https://docs.strongswan.org/docs/5.9/features/routeBasedVpn.html).
* Генерация файлов конфигурации для [сетевого оборудования](https://github.com/yandex-cloud-examples/yc-site-to-site-vpn-with-ipsec-strongswan/tree/main/samples).

Подробнее о решении SGW в [репозитории на GitHub](https://github.com/yandex-cloud-examples/yc-site-to-site-vpn-with-ipsec-strongswan).