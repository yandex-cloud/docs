#### Квоты {#baremetal-quotas}

#|
|| Вид ограничения | Значение ||
|| Количество [серверов](../baremetal/concepts/servers.md)
`baremetal.servers.count` для юридических лиц | 5 ||
|| Количество серверов
`baremetal.servers.count` для физических лиц^1^ | 2 ||
|| Количество [VRF](../baremetal/concepts/private-network.md#vrf-segment)
`baremetal.vrfs.count` | 20 ||
|| Количество образов
`baremetal.images.count` | 10 ||
|| Количество [приватных подсетей](../baremetal/concepts/private-network.md#private-subnet)
`baremetal.privateSubnets.count` | 2 ||
|| Количество приватных подсетей, которые могут быть привязаны к одному серверу
`baremetal.privateSubnetsPerServerInterface.count` | 1 ||
|| Количество [выделенных публичных подсетей](../baremetal/concepts/public-network.md#public-subnet)
`baremetal.dedicatedPublicSubnets.count` | 1 ||
|| Количество пулов в выделенных публичных подсетях
`baremetal.dedicatedPublicSubnetsHardwarePools.count` | 1 ||
|#

^1^ Квота определяется автоматически. Для увеличения квоты обратитесь в [службу поддержки]({{ link-console-support }}).
