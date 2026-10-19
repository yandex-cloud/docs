[Документация Yandex Cloud](../../../index.md) > [Yandex Virtual Private Cloud](../../index.md) > [Практические руководства](../index.md) > Организация VPN-подключений > [Организация сетевой связности с помощью IPsec-шлюзов](index.md) > Решение SGW от команды архитекторов Yandex Cloud

# Решение Security GateWay от команды архитекторов Yandex Cloud

Для организации защищенного соединения между ресурсами в Yandex Cloud и инфраструктурой клиента по схеме из [подраздела](index.md) можно воспользоваться решением от команды архитекторов Yandex Cloud — [Security GateWay (SGW)](https://github.com/yandex-cloud-examples/yc-site-to-site-vpn-with-ipsec-strongswan).

Основные характеристики решения:

* Разработано в виде Terraform-модуля.
* strongSwan в Docker-контейнере.
* strongSwan [Route-based VPN](https://docs.strongswan.org/docs/5.9/features/routeBasedVpn.html): в ВМ создается XFRM-интерфейс `ipsec0`, через который трафик направляется в IPsec-туннель стандартной командой Linux `ip route`.
* Генерация файлов конфигурации для [сетевого оборудования](https://github.com/yandex-cloud-examples/yc-site-to-site-vpn-with-ipsec-strongswan/tree/main/samples), например Cisco IOS-XE и Mikrotik CHR.

В результате развертывания решения в облаке будут созданы:

* отдельная подсеть для ВМ шлюза безопасности YC-SGW;
* таблица маршрутизации с маршрутами до удаленных подсетей, привязанная к защищаемым подсетям;
* ВМ YC-SGW из предварительно подготовленного образа, с публичным статическим IP-адресом и группой безопасности;
* конфигурационный файл для согласованной настройки шлюза безопасности на стороне ЦОД.

Для развертывания требуется Terraform версии не ниже 0.13 и провайдер Yandex Cloud версии не ниже 0.89.0.

Подробнее о решении SGW в [репозитории на GitHub](https://github.com/yandex-cloud-examples/yc-site-to-site-vpn-with-ipsec-strongswan).