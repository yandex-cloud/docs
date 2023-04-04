# Добавить виртуальную машину в кластер GPU

В кластерах можно создавать только виртуальные машины на платформе {{ a100-epyc }} c 8 GPU. Вам понадобится подготовить образ диска с драйверами [по инструкции](../image-create/custom-image.md) и использовать его при создании ВМ.

{% list tabs %}

- CLI

  ```bash
  export YC_GPU_CLUSTER=$(yc compute gpu-cluster list --format=json | jq -r .[].id)
  export YC_ZONE="ru-central1-a"
  export SUBNET_NAME="my-subnet-name"
  export SUBNET_ID=$(yc vpc subnet get --name=$SUBNET_NAME --format=json | jq -r .id)
  yc compute instance create --name node-gpu-test \
  --create-boot-disk size=64G,image-id=<идентификатор образа с драйверами>,type=network-ssd \
  --ssh-key=$HOME/.ssh/id_rsa.pub \
  --gpus 8 --cores 224 --memory=952G \
  --zone $YC_ZONE \
  --network-interface subnet-id=$SUBNET_ID,nat-ip-version=ipv4 \
  --platform gpu-standard-v3 \
  --gpu-cluster-id=$YC_GPU_CLUSTER
  ```

{% endlist %}