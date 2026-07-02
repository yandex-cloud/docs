[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Router](../index.md) > Сценарии использования > Все сценарии использования

# Сценарии использования Cloud Interconnect и Cloud Router

## Сценарии с резервированием {#cr-ha}

- [On-Prem с резервированием и 1 VPC](ri-1_prc-2ha_vpc-1.md)
- [On-Prem с резервированием и несколько VPC](ri-1_prc-2ha_vpc-few.md)
- [Резервирование подключения On-Prem через VPN-шлюз](prc-ha-via-vpn-gw.md)
- [Равномерное распределение трафика из On-Prem (Active-Active)](prc-ha-with-active-active.md)
- [Приоритизация трафика из On-Prem по направлению (Active-Standby)](prc-ha-with-active-standby.md)
- [Равномерное распределение трафика для маршрута 0.0.0.0/0](prc-ha-with-default-active-active.md)
- [Приоритизация трафика по направлению для маршрута 0.0.0.0/0](prc-ha-with-default-active-standby.md)
- [Приоритет статического маршрута VPC перед маршрутами из On-Prem](static-priority-via-vpn-gw.md)

## Сценарии без резервирования {#cr-noha}

- [On-Prem без резервирования и 1 VPC](ri-1_prc-1noha_vpc-1.md)
- [On-Prem без резервирования и несколько VPC](ri-1_prc-1noha_vpc-few.md)
- [Два отдельных RI без резервирования On-Prem](ri-2_prc-1noha_vpc-1.md)

## Сценарии VPC Stitching {#cr-vpcs}
- [Организация сетевой связности между двумя и более облачными сетями (VPC Stitching)](vpc-st-with-two-vpc.md)
- [Организация сетевой связности между двумя и более облачными сетями и On-Prem ресурсами (VPC Stitching)](vpc-st-with-two-vpc-and-onprem.md)

## Сценарии интеграции с Yandex BareMetal {#cr-bms}

- [Организация сетевой связности между подсетями Yandex BareMetal и Yandex Virtual Private Cloud с помощью Yandex Cloud Interconnect](../tutorials/bm-vrf-and-vpc-interconnect.md)