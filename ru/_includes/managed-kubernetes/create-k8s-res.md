## Подготовьте ресурсы {{ k8s }} {#create-k8s-res}

### Создайте кластер {{ k8s }} {#create-cluster}

Создайте кластер {{ k8s }} и укажите ранее созданные сервисные аккаунты в параметрах `--service-account-id` и `--node-service-account-id`.

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

1. Проверьте, что создание кластера {{ k8s }} успешно завершено.
   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором был создан кластер {{ k8s }}.
   1. В списке сервисов выберите **{{ managed-k8s-name }}**.
   1. Проверьте, что кластер {{ k8s}} успешно создан:
      * В столбце **Статус** должно быть указано `Running`.
      * В столбце **Состояние** должно быть указано `Healthy`.
1. Создайте группу узлов:

   {% list tabs %}

   - Bash

     ```bash
     yc managed-kubernetes node-group create \
       --name k8s-demo-ng \
       --cluster-name k8s-demo \
       --platform standard-v3 \
       --public-ip \
       --cores 2 \
       --memory 4 \
       --core-fraction 50 \
       --disk-type network-ssd \
       --fixed-size 2 \
       --location subnet-name=yc-auto-subnet-0,zone={{ region-id }}-a \
       --async
     ```

   - PowerShell

     ```shell script
     > yc managed-kubernetes node-group create `
       --name k8s-demo-ng `
       --cluster-name k8s-demo `
       --platform standard-v3 `
       --public-ip `
       --cores 2 `
       --memory 4 `
       --core-fraction 50 `
       --disk-type network-ssd `
       --fixed-size 2 `
       --location subnet-name=yc-auto-subnet-0,zone={{ region-id }}-a `
       --async
     ```

   {% endlist %}