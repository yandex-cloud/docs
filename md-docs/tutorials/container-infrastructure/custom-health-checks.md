# Проверка состояния приложений в кластере Yandex Managed Service for Kubernetes с помощью L7-балансировщика Yandex Application Load Balancer

Вы можете автоматически проверять работоспособность приложений, которые развернуты в кластере Managed Service for Kubernetes с помощью [Ingress-контроллера Application Load Balancer](../../application-load-balancer/tools/k8s-ingress-controller/index.md).

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](../../application-load-balancer/tools/gwin/index.md).

{% endnote %}

Ingress-контроллер, установленный в кластер, разворачивает [L7-балансировщик](../../application-load-balancer/concepts/application-load-balancer.md) со всеми необходимыми ресурсами Application Load Balancer, основываясь на конфигурации созданных вами ресурсов [Ingress](../../managed-kubernetes/alb-ref/ingress.md) и [HttpBackendGroup](../../managed-kubernetes/alb-ref/http-backend-group.md).

L7-балансировщик автоматически проверяет работоспособность приложения в кластере. В зависимости от результатов проверки L7-балансировщик открывает или закрывает внешний трафик к бэкенду (ресурсу [Service](../../managed-kubernetes/alb-ref/service-for-ingress.md)). Подробнее в разделе [Проверки состояния](../../application-load-balancer/concepts/backend-group.md#health-checks).

По умолчанию Ingress-контроллер Application Load Balancer принимает от L7-балансировщика запросы для проверок состояния приложения на TCP-порт `10501` и проверяет работоспособность подов [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) на каждом узле кластера. Суть проверки состояния заключается в том, что когда kube-proxy работоспособен, то даже если приложение в конкретном поде не отвечает, Kubernetes перенаправит трафик в другой под с этим приложением или на другой узел.

С помощью этого руководства вы настроите собственные проверки состояния приложения в параметрах ресурса [HttpBackendGroup](../../managed-kubernetes/alb-ref/http-backend-group.md) и откроете для этих проверок отдельный порт на узлах кластера в параметрах ресурса [Service](../../managed-kubernetes/alb-ref/service-for-ingress.md) типа `NodePort`.

Результат проверок состояния приложения можно будет посмотреть в [консоли управления](https://console.yandex.cloud).

{% note info %}

Настроить проверки состояния приложения также можно с помощью аннотации [ingress.alb.yc.io/health-checks](../../application-load-balancer/k8s-ref/service-for-ingress.md#annot-health-checks) ресурса [Service](../../application-load-balancer/k8s-ref/service-for-ingress.md).

{% endnote %}

Чтобы развернуть приложение в кластере Managed Service for Kubernetes и настроить к нему доступ и проверки состояния через L7-балансировщик Application Load Balancer:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте Docker-образ](#docker-image).
1. [Разверните тестовое приложение](#test-app).
1. [Подготовьте адрес для L7-балансировщика](#prepare-address).
1. [Создайте ресурсы Ingress и HttpBackendGroup](#create-ingress).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за DNS-зону и DNS-запросы ([тарифы Cloud DNS](../../dns/pricing.md)).
* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик ([тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища ([тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за использование вычислительных ресурсов L7-балансировщика ([тарифы Application Load Balancer](../../application-load-balancer/pricing.md)).
* Плата за публичные IP-адреса для узлов кластера и L7-балансировщика ([тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).
* Плата за [использование хранилища](../../container-registry/pricing.md) Container Registry.


## Подготовьте облако к работе {#before-begin}

### Подготовьте инфраструктуру {#infra}

{% list tabs group=instructions %}

- Вручную {#manual}

   1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

      Также [настройте](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md) группы безопасности, необходимые для работы Application Load Balancer.

      Приложение будет доступно на узлах кластера Managed Service for Kubernetes на порте `30080`. Проверка состояния приложения будет доступна на порте `30081`. Убедитесь, что эти порты открыты для L7-балансировщика в группе безопасности группы узлов. Вы также можете [сделать эти порты доступными из интернета](../../managed-kubernetes/operations/connect/security-groups.md#rules-nodes).

      {% note warning %}
      
      От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
      
      {% endnote %}

   1. [Создайте кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) Managed Service for Kubernetes. При создании укажите группы безопасности, подготовленные ранее.
      
      Если вы планируете работать с кластером в пределах сети Yandex Cloud, выделять кластеру публичный IP-адрес не нужно. Для подключений извне предоставьте кластеру публичный адрес.
   1. [Создайте группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md). Выделите ей публичный адрес, чтобы предоставить доступ в интернет и возможность скачивать Docker-образы и компоненты. Укажите группы безопасности, подготовленные ранее.
   1. [Создайте реестр](../../container-registry/operations/registry/registry-create.md) Yandex Container Registry.

- Terraform {#tf}

   1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
   1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
   1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
   1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.
   1. Скачайте в ту же рабочую директорию файл конфигурации [k8s-custom-health-checks.tf](https://github.com/yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks/blob/main/terraform-manifests/k8s-custom-health-checks.tf).

      В этом файле описаны:

      * [сеть](../../vpc/concepts/network.md#network);
      * [подсеть](../../vpc/concepts/network.md#subnet);
      * [группы безопасности](../../vpc/concepts/security-groups.md), необходимые для кластера и группы узлов Managed Service for Kubernetes, а также для балансировщика Application Load Balancer;
      * сервисный аккаунт, необходимый для работы кластера Kubernetes;
      * кластер Kubernetes;
      * группа узлов Kubernetes;
      * реестр Yandex Container Registry.

   1. Укажите в файле `k8s-custom-health-checks.tf`:

      * `folder_id` — идентификатор облачного каталога как в настройках провайдера.
      * `k8s_version` — версия Kubernetes. Доступные версии перечислены в разделе [Релизные каналы](../../managed-kubernetes/concepts/release-channels-and-updates.md).

   1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, Terraform на них укажет.

   1. Создайте необходимую инфраструктуру:

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

      В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

{% note warning %}

Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.

{% endnote %}

### Установите Ingress-контроллер Application Load Balancer {#install-alb-ingress-controller}

Установите приложение [ALB Ingress Controller](https://yandex.cloud/ru/marketplace/products/yc/alb-ingress-controller) согласно [инструкции](../../managed-kubernetes/operations/applications/alb-ingress-controller.md) в отдельном пространстве имен `yc-alb`. Далее в этом пространстве имен будут созданы все нужные ресурсы Kubernetes.

### Установите дополнительные зависимости {#prepare}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

   Если для кластера не предоставлен публичный адрес и `kubectl` настроен через внутренний адрес кластера, выполняйте команды `kubectl` на ВМ Yandex Cloud, находящейся в одной сети с кластером.

1. [Установите Docker](https://docs.docker.com/get-docker/).
1. [Аутентифицируйтесь в Yandex Container Registry](../../container-registry/operations/authentication.md#cred-helper) с помощью Docker credential helper.

## Создайте Docker-образ {#docker-image}

Исходные файлы для создания Docker-образа размещены в репозитории [yc-mk8s-alb-ingress-health-checks](https://github.com/yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks).

Docker-образ будет создан из файла `app/Dockerfile` и будет содержать код тестового приложения из файла `app/healthchecktest.go`. Из полученного Docker-образа вы [развернете приложение в кластере Managed Service for Kubernetes](#test-app).

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
1. Получите идентификатор реестра Container Registry. Его можно [запросить вместе со списком реестров](../../container-registry/operations/registry/registry-list.md#registry-list) в каталоге.
1. В переменную окружения добавьте название Docker-образа, который будет создан:

   ```bash
   export TEST_IMG=cr.yandex/<идентификатор_реестра>/example-app1:latest
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

   * Убедитесь, что вы [аутентифицировались в Container Registry](../../container-registry/operations/authentication.md#cred-helper) с помощью Docker credential helper.
   * [Настройте доступ к реестру](../../container-registry/operations/registry/registry-access.md) — предоставьте разрешение PUSH на загрузку Docker-образов для IP-адреса вашего компьютера.

## Разверните тестовое приложение {#test-app}

Соберите тестовое приложение из созданного Docker-образа и конфигурационного файла [app/testapp.yaml](https://github.com/yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks/blob/main/app/testapp.yaml).

Файл содержит описание Kubernetes-ресурсов: `Deployment` и `Service` типа `NodePort`.

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

1. Протестируйте функциональность приложения, указав в запросе IP-адрес узла кластера Managed Service for Kubernetes. Вы можете узнать IP-адрес узла в [консоли управления](https://console.yandex.cloud).

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

   1. [Зарезервируйте статический публичный IP-адрес](../../vpc/operations/get-static-ip.md) для балансировщика Application Load Balancer.

   1. [Зарегистрируйте публичную доменную зону и делегируйте домен](../../dns/operations/zone-create-public.md).
   
   1. Чтобы привязать адрес к домену, [создайте A-запись](../../dns/operations/resource-record-create.md) для делегированного домена. В качестве значения записи укажите зарезервированный IP-адрес.
   1. Убедитесь, что A-запись добавилась:

      ```bash
      host <домен>
      ```

      Результат:

      ```text
      <домен> has address <IP-адрес>
      ```

- Terraform {#tf}

   1. Расположите файл конфигурации [address-for-k8s-health-checks.tf](https://github.com/yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks/blob/main/terraform-manifests/address-for-k8s-health-checks.tf) в той же рабочей директории, где находится файл `k8s-custom-health-checks.tf`.

      В файле `address-for-k8s-health-checks.tf` описаны:

      
      * [статический публичный IP-адрес](../../vpc/concepts/address.md#public-addresses);
      * [публичная DNS-зона](../../dns/concepts/dns-zone.md#public-zones);
      * [A-запись](../../dns/concepts/resource-record.md#a) для этой зоны, чтобы привязать зарезервированный IP-адрес к делегированному домену.


   1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, Terraform на них укажет.

   1. Создайте необходимую инфраструктуру:

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

      В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

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

На основании ресурсов [Ingress](../../managed-kubernetes/alb-ref/ingress.md) и [HttpBackendGroup](../../managed-kubernetes/alb-ref/http-backend-group.md) Ingress-контроллер развернет [L7-балансировщик](../../application-load-balancer/concepts/application-load-balancer.md) со всеми необходимыми ресурсами Application Load Balancer.

Конфигурационные файлы `ingress.yaml` и `httpbackendgroup.yaml` для указанных ресурсов расположены в репозитории [yc-mk8s-alb-ingress-health-checks](https://github.com/yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks).

Настройки пользовательских проверок состояния приложения задаются в ресурсе `HttpBackendGroup` в параметре `spec.backends.healthChecks`.

Чтобы создать ресурсы:

1. В файле `ingress.yaml` укажите следующие значения для аннотаций:

   * `ingress.alb.yc.io/subnets` — одна или несколько подсетей, в которых будет расположен L7-балансировщик Application Load Balancer.
   * `ingress.alb.yc.io/security-groups` — одна или несколько [групп безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) для балансировщика. Если параметр не задан, используется группа безопасности по умолчанию. Хотя бы одна из групп безопасности должна разрешать исходящее TCP-соединение к порту `10501` в подсети группы узлов Managed Service for Kubernetes или в ее группу безопасности.
   * `ingress.alb.yc.io/external-ipv4-address` — предоставление публичного доступа к балансировщику из интернета. Укажите зарезервированный ранее статический публичный IP-адрес.

1. В этом же файле `ingress.yaml` укажите делегированный домен в параметре `spec.rules.host`.
1. Чтобы создать ресурсы `Ingress` и `HttpBackendGroup`, выполните следующую команду из корня директории с репозиторием:

   ```bash
   kubectl apply -f ingress.yaml --namespace=yc-alb &&
   kubectl apply -f httpbackendgroup.yaml --namespace=yc-alb
   ```

1. Дождитесь создания ресурсов, развертывания балансировщика и назначения ему публичного IP-адреса, это может занять несколько минут.

   Чтобы отслеживать создание балансировщика и убедиться в отсутствии ошибок, откройте логи пода, в котором запущен процесс создания:

   1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога.
   1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
   1. Нажмите на имя нужного кластера и на панели слева выберите **Рабочая нагрузка**.
   1. Выберите под `yc-alb-ingress-controller-*` (не `yc-alb-ingress-controller-hc-*`), в котором запущен процесс создания ресурсов.
   1. На странице пода перейдите на вкладку **Логи**.

      В режиме реального времени записываются и отображаются логи о создании балансировщика. Если возникла ошибка во время создания, она появится в логах.

   {% note warning %}
   
   Не изменяйте и не удаляйте балансировщик нагрузки и его дочерние ресурсы, созданные с помощью Managed Service for Kubernetes, через интерфейсы Yandex Cloud (консоль управления, Terraform, CLI и API). Это может привести к некорректной работе кластера.
   
   {% endnote %}

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

   {% note info %}
   
   Если ресурс недоступен по указанному URL, то [убедитесь](../../managed-kubernetes/operations/connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../vpc/operations/security-group-add-rule.md).
   
   {% endnote %}

1. Проверьте, что работают проверки состояния приложения:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога.
      1. Перейдите в сервис **Application Load Balancer**.
      1. Нажмите на имя нужного балансировщика и на панели слева выберите **Проверки состояния**.
      1. Проверьте состояние целевых ресурсов. Если они в статусе `HEALTHY`, значит, приложение доступно и работает.

   {% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

1. [L7-балансировщик](../../application-load-balancer/operations/application-load-balancer-delete.md) Application Load Balancer.
1. [HTTP-роутер](../../application-load-balancer/operations/http-router-delete.md) Application Load Balancer.
1. [Группу бэкендов](../../application-load-balancer/operations/backend-group-delete.md) Application Load Balancer.
1. [Целевую группу](../../application-load-balancer/operations/target-group-delete.md) Application Load Balancer.
1. [Группу узлов](../../managed-kubernetes/operations/node-group/node-group-delete.md) Managed Service for Kubernetes.
1. [Кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) Managed Service for Kubernetes.
1. [Реестр](../../container-registry/operations/registry/registry-delete.md) Container Registry.
1. [Публичную доменную зону](../../dns/operations/zone-delete.md) Cloud DNS.
1. [Группы безопасности](../../vpc/operations/security-group-delete.md) Virtual Private Cloud.
1. [Статический публичный IP-адрес](../../vpc/operations/address-delete.md) Virtual Private Cloud.