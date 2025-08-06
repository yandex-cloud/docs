# Проверка состояния приложений в кластере {{ managed-k8s-full-name }} с помощью L7-балансировщика {{ alb-full-name }}


Вы можете автоматически проверять работоспособность приложений, которые развернуты в кластере {{ managed-k8s-name }} с помощью [Ingress-контроллера {{ alb-name }}](../../application-load-balancer/tools/k8s-ingress-controller/index.md).

Ingress-контроллер, установленный в кластер, разворачивает [L7-балансировщик](../../application-load-balancer/concepts/application-load-balancer.md) со всеми необходимыми ресурсами {{ alb-name }}, основываясь на конфигурации созданных вами ресурсов [Ingress](../../managed-kubernetes/alb-ref/ingress.md) и [HttpBackendGroup](../../managed-kubernetes/alb-ref/http-backend-group.md).

L7-балансировщик автоматически проверяет работоспособность приложения в кластере. В зависимости от результатов проверки L7-балансировщик открывает или закрывает внешний трафик к бэкенду (ресурсу [Service](../../managed-kubernetes/alb-ref/service-for-ingress.md)). Подробнее см. в [Проверки состояния](../../application-load-balancer/concepts/backend-group.md#health-checks).

По умолчанию Ingress-контроллер {{ alb-name }} принимает от L7-балансировщика запросы для проверок состояния приложения на TCP-порт `10501` и проверяет работоспособность подов [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) на каждом узле кластера. Суть проверки состояния заключается в том, что когда kube-proxy работоспособен, то даже если приложение в конкретном поде не отвечает, {{ k8s }} перенаправит трафик в другой под с этим приложением или на другой узел.

С помощью этого руководства вы настроите собственные проверки состояния приложения в параметрах ресурса [HttpBackendGroup](../../managed-kubernetes/alb-ref/http-backend-group.md) и откроете для этих проверок отдельный порт на узлах кластера в параметрах ресурса [Service](../../managed-kubernetes/alb-ref/service-for-ingress.md) типа `NodePort`.

Результат проверок состояния приложения можно будет посмотреть в [консоли управления]({{ link-console-main }}).

{% include [alb-custom-hc-enabling](../../_includes/managed-kubernetes/alb-custom-hc-enabling.md) %}

Чтобы развернуть приложение в кластере {{ managed-k8s-name }} и настроить к нему доступ и проверки состояния через L7-балансировщик {{ alb-name }}:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте Docker-образ](#docker-image).
1. [Разверните тестовое приложение](#test-app).
1. [Подготовьте адрес для L7-балансировщика](#prepare-address).
1. [Создайте ресурсы Ingress и HttpBackendGroup](#create-ingress).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за DNS-зону и DNS-запросы (см. [тарифы {{ dns-name }}](../../dns/pricing.md)).
* Плата за кластер {{ managed-k8s-name }}: использование мастера и исходящий трафик (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).
* Плата за использование вычислительных ресурсов L7-балансировщика (см. [тарифы {{ alb-name }}](../../application-load-balancer/pricing.md)).
* Плата за публичные IP-адреса для узлов кластера и L7-балансировщика (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md#prices-public-ip)).
* Плата за [использование хранилища](../../container-registry/pricing) {{ container-registry-name }}.


## Подготовьте облако к работе {#before-begin}

### Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Вручную {#manual}

   1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

      {% include [configure-sg-alb-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-alb-manual.md) %}

      Приложение будет доступно на узлах кластера {{ managed-k8s-name }} на порте `30080`. Проверка состояния приложения будет доступна на порте `30081`. Убедитесь, что эти порты открыты для L7-балансировщика в группе безопасности группы узлов. Вы также можете [сделать эти порты доступными из интернета](../../managed-kubernetes/operations/connect/security-groups.md#rules-nodes).

      {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

   1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}
   1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}
   1. [Создайте реестр](../../container-registry/operations/registry/registry-create.md) {{ container-registry-full-name }}.

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
   1. Скачайте в ту же рабочую директорию файл конфигурации [k8s-custom-health-checks.tf](https://github.com/yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks/blob/main/terraform-manifests/k8s-custom-health-checks.tf).

      В этом файле описаны:

      * [сеть](../../vpc/concepts/network.md#network);
      * [подсеть](../../vpc/concepts/network.md#subnet);
      * [группы безопасности](../../vpc/concepts/security-groups.md), необходимые для кластера и группы узлов {{ managed-k8s-name }}, а также для балансировщика {{ alb-name }};
      * сервисный аккаунт, необходимый для работы кластера {{ k8s }};
      * кластер {{ k8s }};
      * группа узлов {{ k8s }};
      * реестр {{ container-registry-full-name }}.

   1. Укажите в файле `k8s-custom-health-checks.tf`:

      * `folder_id` — идентификатор облачного каталога, такой же, как в настройках провайдера.
      * `k8s_version` — версия {{ k8s }}. Доступные версии перечислены в разделе [{#T}](../../managed-kubernetes/concepts/release-channels-and-updates.md).

   1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

   1. Создайте необходимую инфраструктуру:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Установите Ingress-контроллер {{ alb-name }} {#install-alb-ingress-controller}

Установите приложение [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) согласно [инструкции](../../managed-kubernetes/operations/applications/alb-ingress-controller.md) в отдельном пространстве имен `yc-alb`. Далее в этом пространстве имен будут созданы все нужные ресурсы {{ k8s }}.

### Установите дополнительные зависимости {#prepare}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

   {% include [Run kubectl cluster-info](../../_includes/managed-kubernetes/kubectl-info.md) %}

1. [Установите Docker](https://docs.docker.com/get-docker/).
1. [Аутентифицируйтесь в {{ container-registry-full-name }}](../../container-registry/operations/authentication.md#cred-helper) с помощью Docker Credential helper.

## Создайте Docker-образ {#docker-image}

Исходные файлы для создания Docker-образа размещены в репозитории [yc-mk8s-alb-ingress-health-checks](https://github.com/yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks).

Docker-образ будет создан из файла `app/Dockerfile` и будет содержать код тестового приложения из файла `app/healthchecktest.go`. Из полученного Docker-образа вы [развернете приложение в кластере {{ managed-k8s-name }}](#test-app).

Приложение будет отвечать на HTTP-запросы следующим образом в зависимости от порта пода:
* `80` — возвращать в теле ответа path-параметры запроса, например `/test-path`. Это основная функциональность приложения, которая будет доступна через L7-балансировщик.
* `8080` — возвращать в теле ответа сообщение `OK`. Эта функциональность будет использоваться для проверки состояния приложения.

Успешное выполнение запроса будет сопровождаться HTTP-кодом `200 OK`.

Чтобы создать Docker-образ:
1. Склонируйте репозиторий `yc-mk8s-alb-ingress-health-checks`:

   ```bash
   git clone git@github.com:yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks.git
   ```

1. В терминале перейдите в корень директории с репозиторием.
1. Получите идентификатор реестра {{ container-registry-name }}. Его можно [запросить вместе со списком реестров](../../container-registry/operations/registry/registry-list.md#registry-list) в каталоге.
1. В переменную окружения добавьте название Docker-образа, который будет создан:

   ```bash
   export TEST_IMG={{ registry }}/<идентификатор_реестра>/example-app1:latest
   ```

1. Соберите Docker-образ:

   ```bash
   docker build -t ${TEST_IMG} -f ./app/Dockerfile .
   ```

   В команде указан путь для корневой директории репозитория.

1. Загрузите Docker-образ в реестр:

   ```bash
   docker push ${TEST_IMG}
   ```

   Если не получается загрузить образ, выполните следующие действия:

   * Убедитесь, что вы [аутентифицировались в {{ container-registry-name }}](../../container-registry/operations/authentication.md#cred-helper) с помощью Docker Credential helper.
   * [Настройте доступ к реестру](../../container-registry/operations/registry/registry-access.md) — предоставьте разрешение PUSH на загрузку Docker-образов для IP-адреса вашего компьютера.

## Разверните тестовое приложение {#test-app}

Соберите тестовое приложение из созданного Docker-образа и конфигурационного файла [app/testapp.yaml](https://github.com/yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks/blob/main/app/testapp.yaml).

Файл содержит описание {{ k8s }}-ресурсов: `Deployment` и `Service` типа `NodePort`.

Ресурс `Service` содержит описание портов, через которые приложение будет доступно на узлах кластера:
* `spec.ports.name: http` — порт для доступа к основной функциональности приложения. `80` на поде и `30080` на узле.
* `spec.ports.name: health` — порт для проверок состояния приложения. `8080` на поде и `30081` на узле.

Чтобы собрать тестовое приложение:

1. Укажите значение переменной окружения `TEST_IMG` в поле `spec.template.spec.containers.image` в файле `app/testapp.yaml`. Получите это значение с помощью команды:

   ```bash
   printenv TEST_IMG
   ```

1. Создайте приложение из файла `app/testapp.yaml`:

   ```bash
   kubectl apply -f ./app/testapp.yaml --namespace=yc-alb
   ```

   В команде указан путь для корневой директории репозитория.

1. Убедитесь, что поды с приложением запустились:

   ```bash
   kubectl get po --namespace=yc-alb
   ```

   Результат:

   ```text
   NAME                               READY   STATUS    RESTARTS   AGE
   alb-demo-1-54b95979b4-***          1/1     Running   0          71s
   alb-demo-1-54b95979b4-***          1/1     Running   0          71s
   yc-alb-ingress-controller-***      1/1     Running   0          11m
   yc-alb-ingress-controller-hc-***   1/1     Running   0          11m
   ```

1. Протестируйте функциональность приложения, указав в запросе IP-адрес узла кластера {{ managed-k8s-name }}. Вы можете узнать IP-адрес узла в [консоли управления]({{ link-console-main }}).

   * Основная функциональность:

     ```bash
     curl --include http://<IP-адрес_узла>:30080/test-path
     ```

     Результат:

     ```bash
     HTTP/1.1 200 OK
     Date: Thu, 18 Jul 2024 11:55:52 GMT
     Content-Length: 10
     Content-Type: text/plain; charset=utf-8

     /test-path%
     ```

   * Проверка состояния приложения:

     ```bash
     curl --include http://<IP-адрес_узла>:30081
     ```

     Результат:

     ```bash
     HTTP/1.1 200 OK
     Date: Thu, 18 Jul 2024 12:00:57 GMT
     Content-Length: 2
     Content-Type: text/plain; charset=utf-8

     OK%
     ```

## Подготовьте адрес для L7-балансировщика {#prepare-address}

По полученному адресу приложение будет доступно из интернета.

Чтобы подготовить адрес для балансировщика:

{% list tabs group=instructions %}

- Вручную {#manual}

   1. [Зарезервируйте статический публичный IP-адрес](../../vpc/operations/get-static-ip.md) для балансировщика {{ alb-name }}.

   1. {% include [create-zone](../../_includes/managed-kubernetes/create-public-zone.md) %}
   
   1. Чтобы привязать адрес к домену, [создайте A-запись](../../dns/operations/resource-record-create.md) для делегированного домена. В качестве значения записи укажите зарезервированный IP-адрес.
   1. Убедитесь, что A-запись добавилась:

      ```bash
      host <домен>
      ```

      Результат:

      ```text
      <домен> has address <IP-адрес>
      ```

- {{ TF }} {#tf}

   1. Расположите файл конфигурации [address-for-k8s-health-checks.tf](https://github.com/yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks/blob/main/terraform-manifests/address-for-k8s-health-checks.tf) в той же рабочей директории, где находится файл `k8s-custom-health-checks.tf`.

      В файле `address-for-k8s-health-checks.tf` описаны:

      
      * [статический публичный IP-адрес](../../vpc/concepts/address.md#public-addresses);
      * [публичная DNS-зона](../../dns/concepts/dns-zone.md#public-zones);
      * [A-запись](../../dns/concepts/resource-record.md#a) для этой зоны, чтобы привязать зарезервированный IP-адрес к делегированному домену.


   1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

   1. Создайте необходимую инфраструктуру:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   1. Убедитесь, что A-запись добавилась:

      ```bash
      host <домен>
      ```

      Результат:

      ```text
      <домен> has address <IP-адрес>
      ```

{% endlist %}

## Создайте ресурсы Ingress и HttpBackendGroup {#create-ingress}

На основании ресурсов [Ingress](../../managed-kubernetes/alb-ref/ingress.md) и [HttpBackendGroup](../../managed-kubernetes/alb-ref/http-backend-group.md) Ingress-контроллер развернет [L7-балансировщик](../../application-load-balancer/concepts/application-load-balancer.md) со всеми необходимыми ресурсами {{ alb-name }}.

Конфигурационные файлы `ingress.yaml` и `httpbackendgroup.yaml` для указанных ресурсов расположены в репозитории [yc-mk8s-alb-ingress-health-checks](https://github.com/yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks).

Настройки пользовательских проверок состояния приложения задаются в ресурсе `HttpBackendGroup` в параметре `spec.backends.healthChecks`.

Чтобы создать ресурсы:

1. В файле `ingress.yaml` укажите следующие значения для аннотаций:

   * `ingress.alb.yc.io/subnets` — одна или несколько подсетей, в которых будет расположен L7-балансировщик {{ alb-name }}.
   * `ingress.alb.yc.io/security-groups` — одна или несколько [групп безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) для балансировщика. Если параметр не задан, используется группа безопасности по умолчанию. Хотя бы одна из групп безопасности должна разрешать исходящее TCP-соединение к порту `10501` в подсети группы узлов {{ managed-k8s-name }} или в ее группу безопасности.
   * `ingress.alb.yc.io/external-ipv4-address` — предоставление публичного доступа к балансировщику из интернета. Укажите зарезервированный ранее статический публичный IP-адрес.

1. В этом же файле `ingress.yaml` укажите делегированный домен в параметре `spec.rules.host`.
1. Чтобы создать ресурсы `Ingress` и `HttpBackendGroup`, выполните следующую команду из корня директории с репозиторием:

   ```bash
   kubectl apply -f ingress.yaml --namespace=yc-alb &&
   kubectl apply -f httpbackendgroup.yaml --namespace=yc-alb
   ```

1. Дождитесь создания ресурсов, развертывания балансировщика и назначения ему публичного IP-адреса, это может занять несколько минут.

   Чтобы отслеживать создание балансировщика и убедиться в отсутствии ошибок, откройте логи пода, в котором запущен процесс создания:

   1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Нажмите на имя нужного кластера и на панели слева выберите **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}**.
   1. Выберите под `yc-alb-ingress-controller-*` (не `yc-alb-ingress-controller-hc-*`), в котором запущен процесс создания ресурсов.
   1. На странице пода перейдите на вкладку **{{ ui-key.yacloud.k8s.workloads.label_tab-logs }}**.

      В режиме реального времени записываются и отображаются логи о создании балансировщика. Если возникла ошибка во время создания, она появится в логах.

## Проверьте результат {#check-result}

1. Убедитесь, что балансировщик создан. Для этого выполните команду и проверьте, что в поле `ADDRESS` в выводе команды появилось значение:

   ```bash
   kubectl get ingress alb-demo --namespace=yc-alb
   ```

   Результат:

   ```bash
   NAME       CLASS    HOSTS     ADDRESS      PORTS   AGE
   alb-demo   <none>   <домен>   <IP-адрес>   80      15h
   ```

1. Проверьте доступность развернутого приложения через L7-балансировщик:

   ```bash
   curl --include http://<домен>/test-path
   ```

   Результат:

   ```bash
   HTTP/1.1 200 OK
   date: Thu, 18 Jul 2024 12:23:51 GMT
   content-length: 10
   content-type: text/plain; charset=utf-8
   server: ycalb

   /test-path%
   ```

   {% include [Настройка групп безопасности при недоступности ресурса](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

1. Проверьте, что работают проверки состояния приложения:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
      1. Нажмите на имя нужного балансировщика и на панели слева выберите **{{ ui-key.yacloud.alb.label_healthchecks }}**.
      1. Проверьте состояние целевых ресурсов. Если они в статусе `HEALTHY`, значит, приложение доступно и работает.

   {% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [L7-балансировщик](../../application-load-balancer/operations/application-load-balancer-delete.md) {{ alb-name }}.
1. [HTTP-роутер](../../application-load-balancer/operations/http-router-delete.md) {{ alb-name }}.
1. [Группу бэкендов](../../application-load-balancer/operations/backend-group-delete.md) {{ alb-name }}.
1. [Целевую группу](../../application-load-balancer/operations/target-group-delete.md) {{ alb-name }}.
1. [Группу узлов](../../managed-kubernetes/operations/node-group/node-group-delete.md) {{ managed-k8s-name }}.
1. [Кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) {{ managed-k8s-name }}.
1. [Реестр](../../container-registry/operations/registry/registry-delete.md) {{ container-registry-name }}.
1. [Публичную доменную зону](../../dns/operations/zone-delete.md) {{ dns-name }}.
1. [Группы безопасности](../../vpc/operations/security-group-delete.md) {{ vpc-name }}.
1. [Статический публичный IP-адрес](../../vpc/operations/address-delete.md) {{ vpc-name }}.
