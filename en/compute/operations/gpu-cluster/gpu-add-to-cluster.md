# Adding a VM to a GPU cluster

In clusters, you can only create VMs running {{ a100-epyc }} with 8 GPUs. You will need to prepare a disk image with drivers by following this [guide](../image-create/custom-image.md) and use it when creating your VM.

{% list tabs %}

- CLI

   ```bash
   export YC_GPU_CLUSTER=$(yc compute gpu-cluster list --format=json | jq -r .[].id)
   export YC_ZONE="ru-central1-a"
   export SUBNET_NAME="my-subnet-name"
   export SUBNET_ID=$(yc vpc subnet get --name=$SUBNET_NAME --format=json | jq -r .id)
   yc compute instance create --name node-gpu-test \
   --create-boot-disk size=64G,image-id=<ID of image with drivers>,type=network-ssd \
   --ssh-key=$HOME/.ssh/id_rsa.pub \
   --gpus 8 --cores 224 --memory=952G \
   --zone $YC_ZONE \
   --network-interface subnet-id=$SUBNET_ID,nat-ip-version=ipv4 \
   --platform gpu-standard-v3 \
   --gpu-cluster-id=$YC_GPU_CLUSTER
   ```

{% endlist %}