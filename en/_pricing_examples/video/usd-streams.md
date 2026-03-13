Broadcast transcoding cost — `60 minutes`:

> 60 × $0.0213 = $1.28

Broadcast recording storage cost — `3 GB` per month (720 hours):

> 3 × 720 × $0.0000251 = $0.0542

Outgoing traffic cost — `20 GB`:

> 20 × {{ sku|USD|video.cdn.traffic.egress|string }} = {% calc [currency=USD] 20 × {{ sku|USD|video.cdn.traffic.egress|number }} %}

Total broadcast cost per month:

> $1.28 + $0.0542 + {% calc [currency=USD] 20 × {{ sku|USD|video.cdn.traffic.egress|number }} %} = {% calc [currency=USD] 1.28 + 0.0542 + 20 × {{ sku|USD|video.cdn.traffic.egress|number }} %}