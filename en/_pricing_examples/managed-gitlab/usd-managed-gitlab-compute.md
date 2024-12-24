> 720 × (2 × {{ sku|USD|gitlab.instance.free.cpu|string }} + 8 × {{ sku|USD|gitlab.instance.free.ram|string }}) = {% calc [currency=USD] 720 × (2 × {{ sku|USD|gitlab.instance.free.cpu|number }} + 8 × {{ sku|USD|gitlab.instance.free.ram|number }}) %}

  Where:

  * 720: Number of hours in 30 days.
  * 2: Number of vCPUs.
  * {{ sku|USD|gitlab.instance.free.cpu|string }}: Cost of using a vCPU per hour.
  * 8: Amount of RAM (in GB).
  * {{ sku|USD|gitlab.instance.free.ram|string }}: Cost of using 1 GB of RAM per hour.