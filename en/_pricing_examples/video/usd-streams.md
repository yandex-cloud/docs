Stream transcoding cost — `60 minutes`:

> 60 × $0.0213 = $1.28

Stream recording storage cost — `3 GB`:

> 3 × $0.0181 = $0.0543

Outgoing traffic cost — `20 GB`:

> 20 × {{ sku|USD|video.cdn.traffic.egress|string }} = {% calc [currency=USD] 20 × {{ sku|USD|video.cdn.traffic.egress|number }} %}

Total stream cost per month:

> $1.28 + $0.0543 + {% calc [currency=USD] 20 × {{ sku|USD|video.cdn.traffic.egress|number }} %} = {% calc [currency=USD] 1.28 + 0.0543 + 20 × {{ sku|USD|video.cdn.traffic.egress|number }} %}