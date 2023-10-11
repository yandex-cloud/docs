## Подготовьте ресурсы {{ k8s }} {#create-k8s-res}

### Создайте кластер {{ managed-k8s-name }} {#create-cluster}

Создайте [кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и укажите ранее созданные [сервисные аккаунты](../../iam/concepts/users/service-accounts.md) в параметрах `--service-account-id` и `--node-service-account-id`.

{% list tabs %}

- Bash

  Выполните команду:

  ```bash
  yc managed-kubernetes cluster create \
    --name k8s-demo --network-name yc-auto-network \
    --zone {{ region-id }}-a --subnet-name yc-auto-subnet-0 \
    --public-ip \
    --service-account-id $RES_SA_ID \
    --node-service-account-id $NODE_SA_ID
  ```

- PowerShell

  Выполните команду:

  ```shell script
  > yc managed-kubernetes cluster create `
    --name k8s-demo --network-name yc-auto-network `
    --zone {{ region-id }}-a --subnet-name yc-auto-subnet-0 `
    --public-ip `
    --service-account-id $RES_SA_ID `
    --node-service-account-id $NODE_SA_ID
  ```

{% endlist %}

### Создайте группу узлов {#create-node-groups}

1. Проверьте, что создание кластера {{ managed-k8s-name }} успешно завершено.
   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором был создан кластер {{ managed-k8s-name }}.
   1. В списке сервисов выберите **{{ managed-k8s-name }}**.
   1. Проверьте, что кластер {{ managed-k8s-name }} успешно создан:
      * В столбце **Статус** должно быть указано `Running`.
      * В столбце **Состояние** должно быть указано `Healthy`.
1. Создайте группу узлов {{ managed-k8s-name }}:

   {% list tabs %}

   - Bash

     ```bash
     yc managed-kubernetes node-group create \
       --name k8s-demo-ng \
       --cluster-name k8s-demo \
       --platform standard-v3 \
       --cores 2 \
       --memory 4 \
       --core-fraction 50 \
       --disk-type network-ssd \
       --fixed-size 2 \
       --network-interface security-group-ids={{ security-group }},subnets=yc-auto-subnet-0,ipv4-address=nat \
       --async
     ```

   - PowerShell

     ```shell script
     > yc managed-kubernetes node-group create `
       --name k8s-demo-ng `
       --cluster-name k8s-demo `
       --platform standard-v3 `
       --cores 2 `
       --memory 4 `
       --core-fraction 50 `
       --disk-type network-ssd `
       --fixed-size 2 `
       --network-interface security-group-ids={{ security-group }},subnets=yc-auto-subnet-0,ipv4-address=nat `
       --async
     ```

   {% endlist %}