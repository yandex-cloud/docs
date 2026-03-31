Cost of broadcast transcoding, `60 minutes`:

> 60 × {{ sku|USD|video.transcoding.live.v1|string }} = {% calc [currency=USD] 60 × {{ sku|USD|video.transcoding.live.v1|number }} %}

Cost of storing a broadcast recording, `3 GB` per month (720 hours):

> 3 × 720 × {{ sku|USD|video.used_space.live.v1|string }} = {% calc [currency=USD] 3 × 720 × {{ sku|USD|video.used_space.live.v1|number }} %}

Cost of outgoing traffic, `20 GB`:

> 20 × {{ sku|USD|video.cdn.traffic.egress|string }} = {% calc [currency=USD] 20 × {{ sku|USD|video.cdn.traffic.egress|number }} %}

The total monthly cost of the broadcast will be:

> {% calc [currency=USD] 60 × {{ sku|USD|video.transcoding.live.v1|number }} %} + {% calc [currency=USD] 3 × 720 × {{ sku|USD|video.used_space.live.v1|number }} %} + {% calc [currency=USD] 20 × {{ sku|USD|video.cdn.traffic.egress|number }} %} = {% calc [currency=USD] 60 × {{ sku|USD|video.transcoding.live.v1|number }} + 3 × 720 × {{ sku|USD|video.used_space.live.v1|number }} + 20 × {{ sku|USD|video.cdn.traffic.egress|number }} %}