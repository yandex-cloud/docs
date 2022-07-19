# Запуск рабочих нагрузок с GPU

Чтобы запустить рабочие нагрузки с GPU на подах кластера {{ k8s }} выполните следующие действия:
1. Создайте кластер {{ k8s }}.

   Вы можете использовать уже работающий кластер {{ k8s }} или создать новый. Убедитесь, что в поле **Версия {{ k8s }}** выбрана версия 1.16 или выше.

   {% cut "Как создать кластер {{ k8s }}" %}

   {% list tabs %}

   - Консоль управления

     {% include [create-cluster](../../_includes/managed-kubernetes/cluster-create.md) %}

   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Создайте кластер {{ k8s }}:

     ```bash
     yc managed-kubernetes cluster create \
       --name k8s-gpu-cluster \
       --service-account-name k8s \
       --node-service-account-name docker \
       --zone {{ region-id }}-a \
       --network-name k8s-gpu
     ```

     Где:
     * `--name` — имя кластера {{ k8s }}.
     * `--service-account-id` — уникальный идентификатор сервисного аккаунта для ресурсов. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
     * `--node-service-account-id` — уникальный идентификатор сервисного аккаунта для узлов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.
     * `--zone` — зона доступности.
     * `--network-name` — имя сети.

     Результат:

     ```bash
     done (6m9s)
     id: catsk2s5f0fmb5h0pd94
     folder_id: b1g12ga82mev0cljderg
     ...
     service_account_id: ajedclfluactb5868n99
     node_service_account_id: ajeo8f063dmnicot7t7j
     release_channel: REGULAR
     ```

   - API

     Чтобы создать кластер {{ k8s }}, воспользуйтесь методом [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster).

   {% endlist %}

   {% endcut %}

1. Создайте группу узлов с GPU.

   При создании группы узлов выберите платформу **Intel Broadwell with Nvidia Tesla v100** и укажите необходимое **количество GPU**.

   {% cut "Как создать группу узлов с GPU" %}

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан кластер {{ k8s }}.
     1. В списке сервисов выберите **{{ managed-k8s-name }}**.
     1. Выберите кластер {{ k8s }}, для которого необходимо создать группу узлов.
     1. На странице кластера {{ k8s }} перейдите на вкладку **Группы узлов**.
     1. Нажмите кнопку **Создать группу узлов**.
     1. Введите имя и описание группы узлов.
     1. Укажите **Версию {{ k8s }}** для узлов.
     1. В блоке **Масштабирование**:
        * Выберите тип политики масштабирования.
        * Укажите количество узлов в группе узлов.
     1. В блоке **В процессе создания и обновления разрешено** укажите максимальное количество виртуальных машин, на которое можно превысить и уменьшить размер группы.
     1. В блоке **Вычислительные ресурсы**:
        * Выберите [платформу](../../compute/concepts/vm-platforms.md) **Intel Broadwell with Nvidia Tesla v100**.
        * Выберите [конфигурацию](../../compute/concepts/gpus.md#config) виртуальной машины, указав необходимое количество GPU. Значения vCPU и RAM будут выбраны автоматически.
        * (опционально) Укажите, что виртуальная машина должна быть [прерываемой](../../compute/concepts/preemptible-vm.md). 
     1. В блоке **Хранилище**:
        * Укажите **Тип диска** узла:
          * **HDD** — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
          * **SSD** — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
        * Укажите размер диска узла.
     1. В блоке **Сетевые настройки**:
        * В поле **Публичный адрес** выберите способ назначения адреса:
          * **Автоматически** — чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}.
          * **Без адреса** — чтобы не назначать публичный IP-адрес.
        * Укажите расположение узлов по зонам доступности и сетям.

        
        * (опционально) Нажмите кнопку **Добавить расположение** и укажите дополнительную зону доступности и сеть, чтобы создать узлы в разных зонах доступности.


     1. В блоке **Доступ** укажите данные для доступа на узел:
        * В поле **Логин** введите имя пользователя.
        * В поле **SSH-ключ** вставьте содержимое файла [публичного ключа](../operations/node-connect-ssh.md#creating-ssh-keys).
     1. В блоке **Настройки окна обновлений**:
        * В поле **Частота обновлений / Отключение** выберите окно для обновлений:
          * **Отключено** — отключение автоматических обновлений.
          * **В любое время** — обновления разрешены в любое время.
          * **Ежедневно** — обновления будут происходить во временной интервал, указанный в поле **Время (UTC) и продолжительность**.
          * **В выбранные дни** — обновления будут происходить во временной интервал, указанный в поле **Расписание по дням**.
     1. Нажмите кнопку **Создать группу узлов**.

   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Создайте группу узлов:

     ```bash
     yc managed-kubernetes node-group create \
       --name k8s-gpu-cluster \
       --cluster-name k8s-gpu-cluster \
       --gpus 1 \
       --network-interface subnets=<имя подсети для группы узлов>,ipv4-address=nat \
       --location zone={{ region-id }}-a \
       --fixed-size 1
      ```

     Где:

     * `--name` — имя группы узлов.
     * `--cluster-name` — имя кластера {{ k8s }}, в котором будет создана группа узлов.
     * `--gpus` — количество GPU для узлов.
     * `--network-interface` — настройки сети:

       {% include [network-interface](../../_includes/managed-kubernetes/cli-network-interface.md) %}

     * `--location` — зона доступности, в которой будут расположены узлы. Можно указать несколько вариантов.
     * `--fixed-size` — количество узлов в группе.

     Результат:

     ```bash
     done (3m53s)
     id: cat3rmrrna8p93kafdce
     cluster_id: cattv5gvhqdbhi5f234m
     ...
       auto_repair: true
       maintenance_window:
         anytime: {}
     ```

   - API

     Чтобы создать группу узлов, воспользуйтесь методом [create](../api-ref/NodeGroup/create.md) для ресурса [NodeGroup](../api-ref/NodeGroup).

   {% endlist %}

   {% endcut %}

1. Создайте под с GPU.

   Сохраните следующую спецификацию для создания пода с GPU в YAML-файл с названием `cuda-vector-add.yaml`:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: cuda-vector-add
    spec:
      restartPolicy: OnFailure
      containers:
        - name: cuda-vector-add
          # https://github.com/kubernetes/kubernetes/blob/v1.7.11/test/images/nvidia-cuda/Dockerfile
          image: "k8s.gcr.io/cuda-vector-add:v0.1"
          resources:
            limits:
              nvidia.com/gpu: 1 # Запрос 1 GPU.
    ```

   Подробнее о спецификации для создания пода читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#pod-v1-core).

1. Выполните команду:

   ```
   kubectl create -f cuda-vector-add.yaml
   ```

   Результат:

   ```
   pod/cuda-vector-add created
   ```

1. Посмотрите информацию о созданном поде:

   ```
   kubectl describe pod cuda-vector-add
   ```

   Результат:

   ```
   Name:         cuda-vector-add
   Namespace:    default
   Priority:     0
   ...
     Normal  Pulling    16m   kubelet, cl1i7hcbti99j6bbua6u-ebyq  Successfully pulled image "k8s.gcr.io/cuda-vector-add:v0.1"
     Normal  Created    16m   kubelet, cl1i7hcbti99j6bbua6u-ebyq  Created container cuda-vector-add
     Normal  Started    16m   kubelet, cl1i7hcbti99j6bbua6u-ebyq  Created container
   ```

1. Посмотрите логи работы пода:

   ```
   kubectl logs -f cuda-vector-add
   ```

   Результат:

   ```
   [Vector addition of 50000 elements]
   Copy input data from the host memory to the CUDA device
   CUDA kernel launch with 196 blocks of 256 threads
   Copy output data from the CUDA device to the host memory
   Test PASSED
   Done
   ```