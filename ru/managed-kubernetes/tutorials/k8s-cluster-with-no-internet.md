# Создание и настройка кластера {{ managed-k8s-name }} без доступа в интернет


Вы можете создать и настроить кластер {{ managed-k8s-name }}, для которого недоступно подключение к интернету. Для этого используется следующая конфигурация:

* У кластера и группы узлов {{ managed-k8s-name }} нет публичного адреса. К такому кластеру можно подключиться только с виртуальной машины {{ yandex-cloud }}.
* Кластер и группа узлов размещены в подсетях без доступа в интернет.
* У сервисных аккаунтов нет ролей на работу с ресурсами, имеющими доступ в интернет, например [{{ network-load-balancer-full-name }}](../../network-load-balancer/index.yaml).
* Группы безопасности кластера ограничивают входящий и исходящий трафик.

Чтобы создать кластер {{ managed-k8s-name }} без доступа в интернет:

1. [{#T}](#infra).
1. [{#T}](#vm).
1. [{#T}](#check).
1. [{#T}](#cert).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте инфраструктуру для {{ managed-k8s-name }} {#infra}

{% list tabs group=instructions %}

- Вручную {#manual}

   1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):

      * `resource-sa` с [ролями](../../iam/concepts/access-control/roles.md) `{{ roles.k8s.clusters.agent }}`, `{{ roles-logging-writer }}` и `kms.keys.encrypterDecrypter` на каталог, в котором создается кластер {{ k8s }}. От имени этого аккаунта будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
      * `node-sa` с ролью `{{ roles-cr-puller }}`. От имени этого аккаунта узлы будут скачивать из реестра необходимые Docker-образы.

      {% note tip %}

      Вы можете использовать один и тот же сервисный аккаунт для управления кластером {{ k8s }} и его группами узлов.

      {% endnote %}

   1. [Создайте симметричный ключ шифрования](../../kms/operations/key.md#create) {{ kms-full-name }} с параметрами:

      * **{{ ui-key.yacloud.common.name }}** — `my-kms-key`.
      * **{{ ui-key.yacloud.kms.symmetric-key.form.field_algorithm }}** — `AES-256`.
      * **{{ ui-key.yacloud.kms.symmetric-key.form.field_rotation }}** — 365 дней.

   1. [Создайте сеть](../../vpc/operations/network-create.md) `my-net`.
   1. [Создайте подсеть](../../vpc/operations/subnet-create.md) `my-subnet` с доменным именем `internal.`.
   1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

   1. [Создайте кластер](../operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) {{ managed-k8s-name }} с параметрами:

      * **{{ ui-key.yacloud.k8s.clusters.create.field_service-account }}** — `resource-sa`.
      * **{{ ui-key.yacloud.k8s.clusters.create.field_node-service-account }}** — `node-sa`.
      * **{{ ui-key.yacloud.k8s.clusters.create.field_kms-key }}** — `my-kms-key`.
      * **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}** — без адреса.
      * **{{ ui-key.yacloud.k8s.clusters.create.field_network }}** — `my-net`.
      * **{{ ui-key.yacloud.k8s.clusters.create.field_subnetwork }}** — `my-subnet`.
      * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — выберите созданные ранее группы безопасности, которые содержат правила для служебного трафика и для доступа к API {{ k8s }}.
      * **{{ ui-key.yacloud.k8s.clusters.create.field_cluster-cidr }}** — `172.19.0.0/16`.
      * **{{ ui-key.yacloud.k8s.clusters.create.field_service-cidr }}** — `172.20.0.0/16`.
      * **{{ ui-key.yacloud.k8s.clusters.create.label_logging-enabled }}** — включена.
      * **{{ ui-key.yacloud.k8s.clusters.create.label_stream-cluster-autoscaler }}** — включены.
      * **{{ ui-key.yacloud.k8s.clusters.create.label_stream-events }}** — включены.
      * **{{ ui-key.yacloud.k8s.clusters.create.label_stream-kube-apiserver }}** — включены.

   1. В кластере {{ managed-k8s-name }} [создайте группу узлов](../operations/node-group/node-group-create.md) с параметрами:

      * **{{ ui-key.yacloud.k8s.node-groups.create.field_address-type }}** — без адреса.
      * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — выберите созданные ранее группы безопасности, которые содержат правила для служебного трафика, для подключения к сервисам из интернета и для подключения к узлам по SSH.
      * **{{ ui-key.yacloud.k8s.node-groups.create.field_locations }}** — подсеть `my-subnet`.

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
   1. Скачайте в ту же рабочую директорию файл конфигурации [k8s-cluster-with-no-internet.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-without-internet/blob/main/k8s-cluster-with-no-internet.tf). С помощью файла будут созданы ресурсы:

      * Сеть.
      * Таблица маршрутизации.
      * Подсети.
      * Кластер {{ managed-k8s-name }}.
      * Группа узлов {{ managed-k8s-name }}.
      * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

      * [Сервисные аккаунты](../../iam/concepts/users/service-accounts.md) для ресурсов и узлов {{ k8s }}.
      * [Симметричный ключ шифрования](../../kms/concepts/key.md) {{ kms-full-name }}.

      Файл подготовлен с помощью библиотек модулей [terraform-yc-vpc](https://github.com/terraform-yc-modules/terraform-yc-vpc) и [terraform-yc-kubernetes](https://github.com/terraform-yc-modules/terraform-yc-kubernetes). Подробнее о конфигурации ресурсов, которые создаются с помощью этих модулей, см. на страницах библиотек.

   1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

   1. Создайте необходимую инфраструктуру:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте виртуальную машину {#vm}

Так как у кластера {{ managed-k8s-name }} нет доступа в интернет, к нему можно подключиться только с ВМ, находящейся в одной сети с кластером. Поэтому, чтобы проверить доступность кластера, подготовьте инфраструктуру:

1. Создайте необходимые ресурсы:

   {% list tabs group=instructions %}

   - Вручную {#manual}

      1. Создайте сервисный аккаунт `vm-sa` с ролями `{{ roles.k8s.cluster-api.cluster-admin }}` и `{{ roles.k8s.admin }}`. От имени этого аккаунта вы подключитесь к кластеру {{ managed-k8s-name }}.
      1. Создайте группу безопасности `vm-security-group` и укажите в ней правило для входящего трафика:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

      1. [Создайте ВМ Linux](../../compute/operations/vm-create/create-linux-vm.md) с параметрами:

         * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** — `my-subnet`.
         * **{{ ui-key.yacloud.component.compute.network-select.field_external }}** — `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, либо можно [зарезервировать статический публичный IP-адрес](../../vpc/operations/get-static-ip.md) и привязать его к новой ВМ.
         * **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** — `vm-security-group`.
         * **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** — `vm-sa`.

   - {{ TF }} {#tf}

      1. В директорию с файлом `k8s-cluster-with-no-internet.tf` скачайте файл конфигурации [virtual-machine-for-k8s.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-without-internet/blob/main/virtual-machine-for-k8s.tf).

         В этом файле описаны:

         * сервисный аккаунт для ВМ;
         * группа безопасности для ВМ;
         * ВМ.

      1. Укажите в файле `virtual-machine-for-k8s.tf`:

         * Идентификатор каталога.
         * Идентификатор сети, созданной вместе с кластером {{ managed-k8s-name }}.
         * Идентификатор подсети, созданной вместе с кластером {{ managed-k8s-name }} и располагающейся в зоне доступности `{{ region-id }}-a`. Эта зона указана в настройках ВМ.
         * Имя пользователя, от лица которого будет выполняться подключение к ВМ по SSH.
         * Абсолютный путь до публичной части SSH-ключа для подключения к ВМ.

      1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

         ```bash
         terraform validate
         ```

         Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

      1. Создайте необходимую инфраструктуру:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. [Подключитесь к ВМ](../../compute/operations/vm-connect/ssh.md#vm-connect) по протоколу SSH:

   ```bash
   ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
   ```

   Где `<имя_пользователя>` — имя учетной записи пользователя ВМ.

1. [Установите интерфейс командной строки](../../cli/operations/install-cli.md#interactive) {{ yandex-cloud }} (YC CLI).
1. [Создайте профиль](../../cli/operations/profile/profile-create.md#create) для YC CLI.
1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/#kubectl).

## Проверьте доступность кластера {#check}

На ВМ выполните команду:

```bash
kubectl cluster-info
```

Команда вернет информацию о кластере {{ managed-k8s-name }}:

```text
Kubernetes control plane is running at https://<адрес_кластера>
CoreDNS is running at https://<адрес_кластера>/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

## (Опционально) Подключите приватный реестр Docker-образов {#cert}

Вы можете подключить [приватный реестр Docker-образов](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/) к кластеру {{ managed-k8s-name }}. Для аутентификации в реестре и подключения к нему по протоколу HTTPS кластеру нужны сертификаты, выданные CA (Certificate Authority — доверенный центр сертификации). Чтобы добавить и позднее автоматически обновлять сертификаты на узлах кластера, используйте контроллер [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/). Он запускает следующий процесс в подах:

1. При помощи Bash-скрипта на узлах кластера постоянно проверяется наличие нужных сертификатов.
1. Если их нет, они копируются из [секрета](https://kubernetes.io/docs/concepts/configuration/secret/) {{ k8s }} и обновляются.
1. Перезагружается среда запуска контейнеров containerd.

Чтобы настроить обновление сертификатов с помощью DaemonSet, на ВМ:

1. Разместите файлы сертификатов с расширением `.crt`.
1. Создайте файл `certificate-updater-namespace.yaml` c конфигурацией пространства имен. Это пространство будет использовано для работы и изоляции DaemonSet.

   ```yaml
   apiVersion: v1
   kind: Namespace
   metadata:
     name: certificate-updater
     labels:
       name: certificate-updater
   ```

1. Создайте файл `certificate-updater-daemonset.yaml` с конфигурацией DaemonSet:

   {% cut "Содержимое файла" %}

   ```yaml
   ---
   kind: NetworkPolicy
   apiVersion: networking.k8s.io/v1
   metadata:
     name: certificate-updater-deny-all
     namespace: certificate-updater
   spec:
     podSelector:
       matchLabels:
         k8s-app: certificate-updater
     policyTypes:
       - Ingress
       - Egress
     ingress: []
     egress:  []
   ---
   apiVersion: "apps/v1"
   kind: DaemonSet
   metadata:
     name: certificate-updater
     namespace: certificate-updater
     labels:
       k8s-app: certificate-updater
       version: 1v
   spec:
     selector:
       matchLabels:
         k8s-app: certificate-updater
     template:
       metadata:
         labels:
           k8s-app: certificate-updater
       spec:
         hostPID: true
         hostIPC: true
         containers:
         - name: certificate-updater
           image: cr.yandex/yc/mk8s-openssl:stable
           command: 
             - sh
             - -c
             - |
               while true; do
                 diff -x '.*' -r /mnt/user-cert-path/ /usr/local/share/ca-certificates
                 if [ $? -ne 0 ];
                   then
                       echo "Removing all old certificates"
                       rm -r /usr/local/share/ca-certificates/*
                       echo "Copying certificates from configmap"
                       cp /mnt/sbin/update-ca-certificates /usr/sbin/
                       cp /mnt/user-cert-path/* /usr/local/share/ca-certificates
         
                       echo "Updating cerfificates authorities"
                       update-ca-certificates 

                       echo "Restarting containerd"
                       ps -x -o pid= -o comm= | awk '$2 ~ "^(containerd|dockerd)$" { print $1 }' | xargs kill
                       #systemd will get them back less than a minute
                   else
                     echo "Doing Nothing as no certs has not been changed"
                   fi
                 sleep 60
               done
           imagePullPolicy: Never
           securityContext:
             privileged: true
           resources:
             limits:
               memory: 200Mi
             requests:
               cpu: 100m
               memory: 200Mi
           volumeMounts:
           - mountPath: /etc/
             name: etc
           - mountPath: /usr/local/share/ca-certificates
             name: docker-cert
           - name: secret
             mountPath: /mnt/user-cert-path
           - name: sbin
             mountPath: /mnt/sbin
             readOnly: true
           - name: ca-cert
             mountPath: /usr/share/ca-certificates
         volumes:
         - name: secret
           secret:
             secretName: crt
         - name: sbin
           hostPath:
             path: /usr/sbin/
             type: Directory
         - name: ca-cert
           hostPath:
             path: /usr/share/ca-certificates
             type: Directory
         - name: docker-cert
           hostPath:
             path: /usr/local/share/ca-certificates
             type: DirectoryOrCreate
         - name: etc
           hostPath:
             path: /etc/
             type: Directory
   ```

   {% endcut %}

1. Создайте пространство имен:

   ```bash
   kubectl apply -f certificate-updater-namespace.yaml
   ```

1. Создайте секрет с содержимым сертификатов, выпущенных CA:

   ```bash
   kubectl create secret generic crt \
      --from-file=<путь_к_файлу_с_сертификатом>.crt \
      --namespace="certificate-updater"
   ```

   В команде укажите сертификат с расширением `.crt`. Если надо добавить несколько сертификатов, передайте каждый из них в команде с помощью флага `--from-file`.

   Вы можете проверить конфигурацию секрета с помощью команды ниже и убедиться, что конфигурация содержит информацию о сертификатах:

   ```bash
   kubectl get secret crt -o yaml
   ```

1. Создайте DaemonSet:

   ```bash
   kubectl apply -f certificate-updater-daemonset.yaml
   ```

Далее можно отслеживать состояние контроллера DaemonSet. Когда обновятся сертификаты, в кластере перезагрузятся процессы среды запуска контейнеров containerd.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать.

{% list tabs group=instructions %}

- Вручную {#manual}

   Удалите:

   1. [Сервисные аккаунты](../../iam/operations/sa/delete.md).
   1. [Ключ шифрования](../../kms/operations/key.md#delete) {{ kms-name }}.
   1. [Группы безопасности](../../vpc/operations/security-group-delete.md).
   1. [Группу узлов](../operations/node-group/node-group-delete.md) {{ managed-k8s-name }}.
   1. [Кластер](../operations/kubernetes-cluster/kubernetes-cluster-delete.md) {{ managed-k8s-name }}.
   1. [Виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
   1. [Подсеть](../../vpc/operations/subnet-delete.md).
   1. [Сеть](../../vpc/operations/network-delete.md).

- {{ TF }} {#tf}

   1. В командной строке перейдите в директорию, в которой расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
   1. Удалите конфигурационные файлы `k8s-cluster-with-no-internet.tf` и `virtual-machine-for-k8s.tf`.
   1. Проверьте корректность конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в конфигурации есть ошибки, {{ TF }} на них укажет.

   1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      Все ресурсы, которые были описаны в конфигурационных файлах `k8s-cluster-with-no-internet.tf` и `virtual-machine-for-k8s.tf`, будут удалены.

{% endlist %}

Если для ВМ использовался статический публичный IP-адрес, [освободите и удалите его](../../vpc/operations/address-delete.md).
