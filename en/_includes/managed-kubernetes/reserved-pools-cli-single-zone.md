```bash
{{ yc-k8s }} node-group create \
  --name k8s-reserved-ng \
  --cluster-id <cluster_ID> \
  --platform-id standard-v4a \
  --cores 4 \
  --memory 8 \
  --disk-size 64 \
  --disk-type network-ssd \
  --fixed-size 2 \
  --location zone={{ region-id }}-a,subnet-id=<subnet_ID> \
  --network-interface security-group-ids=[<security_group_IDs>] \
  --reserved-instance-pool-id <reserved_instance_pool_ID>
```

Where:
* `--cluster-id`: [Cluster ID](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md).
* `--location`: Availability zone and subnet [ID](../../vpc/operations/subnet-get-info.md).
* `--network-interface security-group-ids`: Security group [IDs](../../vpc/operations/security-group-get-info.md).
* `--reserved-instance-pool-id`: Reserved instance pool [ID](../../compute/cli-ref/reserved-instance-pool/list.md).