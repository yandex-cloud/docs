```bash
{{ yc-k8s }} node-group create \
  --name k8s-reserved-ng \
  --cluster-id <идентификатор_кластера> \
  --platform-id standard-v4a \
  --cores 4 \
  --memory 8 \
  --disk-size 64 \
  --disk-type network-ssd \
  --fixed-size 2 \
  --location zone={{ region-id }}-a,subnet-id=<идентификатор_подсети> \
  --network-interface security-group-ids=[<идентификаторы_групп_безопасности>] \
  --reserved-instance-pool-id <идентификатор_пула_резервов>
```

Где:
* `--cluster-id` — [идентификатор](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md) кластера.
* `--location` — зона доступности и [идентификатор](../../vpc/operations/subnet-get-info.md) подсети.
* `--network-interface security-group-ids` — [идентификаторы](../../vpc/operations/security-group-get-info.md) групп безопасности.
* `--reserved-instance-pool-id` — [идентификатор](../../compute/cli-ref/reserved-instance-pool/list.md) пула резервов ВМ.