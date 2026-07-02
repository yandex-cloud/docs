[Документация Yandex Cloud](../../index.md) > [Yandex BareMetal](../index.md) > [Концепции](index.md) > Квоты и лимиты

# Квоты и лимиты в Yandex BareMetal

В сервисе Yandex BareMetal действуют следующие ограничения:

* [_Квоты_](https://console.yandex.cloud/cloud?section=quotas) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.
* _Лимиты_ — технические ограничения, обусловленные особенностями архитектуры Yandex Cloud. Изменить лимиты невозможно.

Если вам необходимо больше ресурсов, увеличьте квоты одним из способов:

* [Сформируйте запрос на увеличение](https://console.yandex.cloud/cloud?section=quotas).
* Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [Cloud Quota Manager](../../quota-manager/quickstart.md).

#### Квоты {#baremetal-quotas}

#|
|| Вид ограничения | Значение ||
|| Количество [серверов](servers.md)
`baremetal.servers.count` для юридических лиц | 5 ||
|| Количество серверов
`baremetal.servers.count` для физических лиц^1^ | 2 ||
|| Количество [серверов своей конфигурации](server-custom-configurations.md) в процессе сборки в облаке
`baremetal.assemblingServers.count` | 0 ||
|| Количество [VRF](private-network.md#vrf-segment)
`baremetal.vrfs.count` | 20 ||
|| Количество образов
`baremetal.images.count` | 10 ||
|| Количество [приватных подсетей](private-network.md#private-subnet)
`baremetal.privateSubnets.count` | 2 ||
|| Количество приватных подсетей на одном интерфейсе сервера
`baremetal.privateSubnetsPerServerInterface.count` | 1 ||
|| Количество [выделенных публичных подсетей](public-network.md#public-subnet)
`baremetal.dedicatedPublicSubnets.count` | 1 ||
|| Количество пулов в выделенных публичных подсетях
`baremetal.dedicatedPublicSubnetsHardwarePools.count` | 1 ||
|| Количество всех статических маршрутов в облаке
`baremetal.staticRoutes.count` | 10 ||
|#

^1^ Квота определяется автоматически. Для увеличения квоты обратитесь в [службу поддержки](https://center.yandex.cloud/support).

#### Полезные ссылки {#see-also}

* [Ограничения в сетях BareMetal](network-restrictions.md)