{% note warning %}

Если вы используете сетевой или L7-балансировщик в связке с группой ВМ с [автоматическим масштабированием](../../compute/concepts/instance-groups/scale.md#auto-scale), перед включением зоны в балансировщике сначала [включите](../../compute/operations/instance-groups/disable-enable-zone.md#enable) эту зону для группы ВМ, чтобы количество ВМ распределилось по зонам.

{% endnote %}