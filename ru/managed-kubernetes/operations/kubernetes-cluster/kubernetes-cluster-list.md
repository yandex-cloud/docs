# Получить информацию об имеющихся кластерах {{ k8s }}

Чтобы узнать `ID` или `NAME` кластера {{ k8s }}, получите список кластеров {{ k8s }} в каталоге или подробную информацию об кластере {{ k8s }}.

## Получить список кластеров {{ k8s }} в каталоге {#list}

Получите список [кластеров {{ k8s }}](../../concepts/index.md#kubernetes-cluster) в каталоге по умолчанию.

{% list tabs %}

- Консоль управления

    Чтобы получить список кластеров Kubernetes перейдите на страницу каталога и выберите сервис **{{ managed-k8s-name }}**.

- CLI

    Выполните команду: 
        
    ```
    $ yc managed-kubernetes cluster list
    +----------------------+------------------+---------------------+---------+---------+-------------------------+-------------------+
    |          ID          |       NAME       |     CREATED AT      | HEALTH  | STATUS  |    EXTERNAL ENDPOINT    | INTERNAL ENDPOINT |
    +----------------------+------------------+---------------------+---------+---------+-------------------------+-------------------+
    | cata9ertn6tcr09bh9rm | test-k8s-cluster | 2019-04-12 10:00:27 | HEALTHY | RUNNING | https://84.201.150.176/ | https://10.0.0.3/ |
    +----------------------+------------------+---------------------+---------+---------+-------------------------+-------------------+
    ```

- API
  
    Чтобы получить список кластеров {{ k8s }} в каталоге по умолчанию, воспользуйтесь методом [list](../../api-ref/Cluster/list.md) для ресурса [Cluster](../../api-ref/Cluster/).

{% endlist %}

## Получить подробную информацию о кластере {{ k8s }} {#get}

Для обращения к кластеру {{ k8s }} используйте параметры `ID` или `NAME` из [предыдущего](kubernetes-cluster-list.md#list) пункта.

{% list tabs %}

- Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ managed-k8s-name }}**.
    1. Нажмите на имя нужного кластера {{ k8s }}.

- CLI

    Получите подробную информацию о кластере {{ k8s }}:
    
    ```
    $ yc managed-kubernetes cluster get test-k8s-cluster
    id: cata9ertn6tcr09bh9rm
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-04-12T10:00:27Z"
    name: test-k8s-cluster
    status: RUNNING
    health: HEALTHY
    network_id: enpg0laccbrtg60hh9ro
    master:
      zonal_master:
        zone_id: ru-central1-c
        internal_v4_address: 10.0.0.3
        external_v4_address: 84.201.150.176
      version: 1.13.3
      endpoints:
        internal_v4_endpoint: https://10.0.0.3/
        external_v4_endpoint: https://84.201.150.176/
      master_auth:
        cluster_ca_certificate: |
          -----BEGIN CERTIFICATE-----
          MIICyDCCAbCgAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl
          ...
          wF/FFl2tcdh/0gUE9SBvTDyzebJhJp5zHIVa8brUflr1oA5XlN+licDRurY=
          -----END CERTIFICATE-----
    ip_allocation_policy:
      cluster_ipv4_cidr_block: 10.13.0.0/16
      service_ipv4_cidr_block: 10.14.0.0/16
    ```
  
- API
  
  Чтобы получить подробную информацию о кластере {{ k8s }}, воспользуйтесь методом [get](../../api-ref/Cluster/get.md) для ресурса [Cluster](../../api-ref/Cluster/).  

{% endlist %}
