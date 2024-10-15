# {{ interconnect-name }} pricing policy




The service is provided if technically feasible.

Automatic billing for the service starts with the earliest of the two events:
* The [BGP session](./concepts/priv-con.md#bgp-peering) of any [private connection](./concepts/priv-con.md) in the trunk connection goes `Active`.
* More than 90 days elapses since the [trunk connection](./concepts/trunk.md) (port reservation) was created on {{ yandex-cloud }} hardware. The state of the trunk connection's physical port (ports) is irrelevant.


## Data volume {#data}



{% include [usd-data](../_pricing/interconnect/usd-data.md) %}


## Other services {#other-services}



{% include [usd-other-services](../_pricing/interconnect/usd-other-services.md) %}

