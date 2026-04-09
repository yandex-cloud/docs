```bash
{{ yc-k8s }} node-group create \
  --name k8s-multizone-reserved-ng \
  --cluster-id <идентификатор_кластера> \
  --platform-id standard-v4a \
  --cores 4 \
  --memory 8 \
  --disk-size 64 \
  --disk-type network-ssd \
  --fixed-size 3 \
  --location zone={{ region-id }}-a,subnet-id=<идентификатор_подсети_в_зоне_a> \
  --location zone={{ region-id }}-b,subnet-id=<идентификатор_подсети_в_зоне_b> \
  --location zone={{ region-id }}-d,subnet-id=<идентификатор_подсети_в_зоне_d> \
  --network-interface security-group-ids=[<идентификаторы_групп_безопасности>] \
  --reserved-instance-pool-id '{pool_{instance.zone_id}}' \
  --variables \
pool_ru-central1-a=<идентификатор_пула_в_зоне_a>,\
pool_ru-central1-b=<идентификатор_пула_в_зоне_b>,\
pool_ru-central1-d=<идентификатор_пула_в_зоне_d>
```

Где:
* `--cluster-id` — [идентификатор](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md) кластера.
* `--location` — зоны доступности и [идентификаторы](../../vpc/operations/subnet-get-info.md) подсетей в них.
* `--network-interface security-group-ids` — [идентификаторы](../../vpc/operations/security-group-get-info.md) групп безопасности.
* `--reserved-instance-pool-id` — [идентификаторы](../../compute/cli-ref/reserved-instance-pool/list.md) пулов резервов ВМ, которые будут получены в результате подстановки [системной переменной](../../compute/concepts/instance-groups/variables-in-the-template.md#first-stage) `instance.zone_id` (зона доступности конкретного узла) и [пользовательских переменных](../../compute/concepts/instance-groups/variables-in-the-template.md#second-stage), заданных в параметре `--variables`.
* `--variables` — пользовательские переменные с идентификаторами пулов резервов ВМ в разных зонах доступности.
