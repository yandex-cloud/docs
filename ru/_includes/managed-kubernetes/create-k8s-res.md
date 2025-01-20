## Подготовьте ресурсы {{ k8s }} {#create-k8s-res}

### Создайте кластер {{ managed-k8s-name }} {#create-cluster}

{% note tip %}

В данном примере используются базовые параметры кластера. Часть настроек, например выбор [Container Network Interface](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/), [шифрование секретов](../../managed-kubernetes/concepts/encryption.md#k8s-secrets-encryption) с помощью {{ kms-full-name }} и ряд других, нельзя изменить после создания кластера. Рекомендуем ознакомиться с подробной [инструкцией по созданию кластера {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create).

{% endnote %}

Создайте [кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и укажите ранее созданные [сервисные аккаунты](../../iam/concepts/users/service-accounts.md) во флагах `--service-account-id` и `--node-service-account-id` и группы безопасности во флаге `--security-group-ids`.

{% list tabs group=programming_language %}

- Bash {#bash}

  Выполните команду:

  ```bash
  yc managed-kubernetes cluster create \
    --name k8s-demo \
    --network-name yc-auto-network \
    --zone {{ region-id }}-a \
    --subnet-name yc-auto-subnet-0 \
    --public-ip \
    --service-account-id $RES_SA_ID \
    --node-service-account-id $NODE_SA_ID \
    --security-group-ids <идентификаторы_групп_безопасности>
  ```

- PowerShell {#powershell}

  Выполните команду:

  ```shell script
  yc managed-kubernetes cluster create `
    --name k8s-demo `
    --network-name yc-auto-network `
    --zone {{ region-id }}-a `
    --subnet-name yc-auto-subnet-0 `
    --public-ip `
    --service-account-id $RES_SA_ID `
    --node-service-account-id $NODE_SA_ID `
    --security-group-ids <идентификаторы_групп_безопасности>
  ```

{% endlist %}

### Создайте группу узлов {{ managed-k8s-name }} {#create-node-groups}

1. Проверьте, что создание кластера {{ managed-k8s-name }} успешно завершено.
   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором был создан кластер {{ managed-k8s-name }}.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Проверьте, что кластер {{ managed-k8s-name }} успешно создан:
      * В столбце **{{ ui-key.yacloud.k8s.cluster.overview.label_status }}** должно быть указано `Running`.
      * В столбце **{{ ui-key.yacloud.k8s.cluster.overview.label_health }}** должно быть указано `Healthy`.
1. Создайте [группу узлов {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#node-group) и укажите ранее созданные группы безопасности во флаге `--network-interface security-group-ids`:

   {% list tabs group=programming_language %}

   - Bash {#bash}

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
       --network-interface subnets=yc-auto-subnet-0,ipv4-address=nat,security-group-ids=[<идентификаторы_групп_безопасности>] \
       --async
     ```

   - PowerShell {#powershell}

     ```shell script
     yc managed-kubernetes node-group create `
       --name k8s-demo-ng `
       --cluster-name k8s-demo `
       --platform standard-v3 `
       --cores 2 `
       --memory 4 `
       --core-fraction 50 `
       --disk-type network-ssd `
       --fixed-size 2 `
       --network-interface subnets=yc-auto-subnet-0,ipv4-address=nat,security-group-ids=[<идентификаторы_групп_безопасности>] `
       --async
     ```

   {% endlist %}
