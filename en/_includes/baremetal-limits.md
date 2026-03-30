#### Quotas {#baremetal-quotas}

#|
|| Type of limit | Value ||
|| Number of [servers](../baremetal/concepts/servers.md)
`baremetal.servers.count` for businesses | 5 ||
|| Number of servers
`baremetal.servers.count` for individuals^1^ | 2 ||
|| Number of [VRFs](../baremetal/concepts/private-network.md#vrf-segment)
`baremetal.vrfs.count` | 20 ||
|| Number of images
`baremetal.images.count` | 10 ||
|| Number of [private subnets](../baremetal/concepts/private-network.md#private-subnet)
`baremetal.privateSubnets.count` | 2 ||
|| Number of private subnets per server interface
`baremetal.privateSubnetsPerServerInterface.count` | 1 ||
|| Number of [dedicated public subnets](../baremetal/concepts/public-network.md#public-subnet)
`baremetal.dedicatedPublicSubnets.count` | 1 ||
|| Number of pools in dedicated public subnets
`baremetal.dedicatedPublicSubnetsHardwarePools.count` | 1 ||
|| Number of all static routes in a cloud
`baremetal.staticRoutes.count` | 10 ||
|#

^1^ This quota is defined automatically. Contact [support]({{ link-console-support }}) to increase your quota.