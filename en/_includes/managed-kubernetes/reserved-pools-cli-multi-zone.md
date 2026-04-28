```bash
{{ yc-k8s }} node-group create \
  --name k8s-multizone-reserved-ng \
  --cluster-id <cluster_ID> \
  --platform-id standard-v4a \
  --cores 4 \
  --memory 8 \
  --disk-size 64 \
  --disk-type network-ssd \
  --fixed-size 3 \
  --location zone={{ region-id }}-a,subnet-id=<subnet_ID_in_zone_a> \
  --location zone={{ region-id }}-b,subnet-id=<subnet_ID_in_zone_b> \
  --location zone={{ region-id }}-d,subnet-id=<subnet_ID_in_zone_d> \
  --network-interface security-group-ids=[<security_group_IDs>] \
  --reserved-instance-pool-id '{pool_{instance.zone_id}}' \
  --variables \
pool_ru-central1-a=<pool_ID_in_zone_a>,\
pool_ru-central1-b=<pool_ID_in_zone_b>,\
pool_ru-central1-d=<pool_ID_in_zone_d>
```

Where:
* `--cluster-id`: [Cluster ID](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md).
* `--location`: Availability zones and their relevant subnet [IDs](../../vpc/operations/subnet-get-info.md).
* `--network-interface security-group-ids`: Security group [IDs](../../vpc/operations/security-group-get-info.md).
* `--reserved-instance-pool-id`: Reserved instance pool [IDs](../../compute/cli-ref/reserved-instance-pool/list.md) you will get as a result of substituting the `instance.zone_id` [system variable](../../compute/concepts/instance-groups/variables-in-the-template.md#first-stage) (availability zone of a specific node) and the [user-defined variables](../../compute/concepts/instance-groups/variables-in-the-template.md#second-stage) specified in the `--variables` parameter.
* `--variables`: User-defined variables with IDs of reserved instance pools in different availability zones.
