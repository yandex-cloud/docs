# Создание L7-балансировщика с профилем безопасности Smart Web Security через Ingress-контроллер Application Load Balancer

Приложения в кластере Yandex Managed Service for Kubernetes можно защитить от DDoS-атак и ботов с помощью сервиса [Yandex Smart Web Security](../../smartwebsecurity/concepts/index.md). Для этого опубликуйте приложения через ресурс Ingress, которому назначен [профиль безопасности](../../smartwebsecurity/concepts/profiles.md) Smart Web Security и который использует [контроллер Gwin](../../application-load-balancer/tools/gwin/index.md) или [Ingress-контроллер Application Load Balancer](../../application-load-balancer/tools/k8s-ingress-controller/index.md).

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](../../application-load-balancer/tools/gwin/index.md).

{% endnote %}

Опираясь на ресурс Ingress будет развернут L7-балансировщик с профилем безопасности, подключенным к виртуальным хостам балансировщика. Бэкенды приложений, которые указаны в ресурсе Ingress, будут защищены с помощью Smart Web Security: все поступающие к бэкендам HTTP-запросы [будут обработаны](../../smartwebsecurity/concepts/rules.md#rule-action) в соответствии с правилами в профиле безопасности.

Чтобы через Ingress создать L7-балансировщик с подключенным профилем безопасности:

1. [Установите инструмент для управления балансировщиком](#deploy-controller).
1. [Создайте тестовое приложение](#deploy-app).
1. [Создайте профиль безопасности](#create-security-profile).
1. [Создайте ресурс Ingress](#deploy-ingress).
1. [Создайте DNS-запись для домена](#create-dns-record).
1. [Проверьте результат](#check-the-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за DNS-зону и DNS-запросы (см. [тарифы Cloud DNS](../../dns/pricing.md)).
* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик (см. [тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за использование вычислительных ресурсов L7-балансировщика (см. [тарифы Application Load Balancer](../../application-load-balancer/pricing.md)).
* Плата за публичные IP-адреса для узлов кластера и L7-балансировщика (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).
* Плата за количество запросов в сервис Smart Web Security (см. [тарифы Smart Web Security](../../smartwebsecurity/pricing.md)).


## Перед началом работы {#before-you-begin}

1. Подготовьте необходимую инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md), который будет использоваться Ingress-контроллером Application Load Balancer.

            Назначьте аккаунту следующие [роли](../../application-load-balancer/operations/k8s-ingress-controller-install.md#before-you-begin) на каталог, в котором будет создан кластер:

            * [alb.editor](../../application-load-balancer/security/index.md#alb-editor)
            * [vpc.publicAdmin](../../vpc/security/index.md#vpc-public-admin)
            * [compute.viewer](../../compute/security/index.md#compute-viewer)
            * [smart-web-security.editor](../../smartwebsecurity/security/index.md#smart-web-security-editor)
            * [k8s.viewer](../../managed-kubernetes/security/index.md#k8s-viewer)
            * [certificate-manager.editor](../../certificate-manager/security/index.md#certificate-manager-editor)

                {% note warning %}

                Эта роль необходима для корректной интеграции L7-балансировщика Application Load Balancer с профилем безопасности.

                {% endnote %}

        1. Создайте сервисный аккаунт, который будет использоваться кластером и группой узлов.

            Назначьте аккаунту следующие [роли](../../managed-kubernetes/security/index.md#sa-annotation) на каталог, в котором будет создан кластер:
            * [k8s.clusters.agent](../../managed-kubernetes/security/index.md#k8s-clusters-agent)
            * [vpc.publicAdmin](../../vpc/security/index.md#vpc-public-admin)

        1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

            Также [настройте](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md) группы безопасности, необходимые для работы Application Load Balancer.

            {% note warning %}
            
            От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
            
            {% endnote %}

        1. [Создайте кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md). При создании кластера выберите:

            * Созданный ранее сервисный аккаунт. Используйте его для ресурсов и для узлов.
            * Созданные ранее группы безопасности, которые должны быть назначены кластеру.
            * Опцию, которая назначает кластеру публичный адрес. Такой адрес нужен, чтобы можно было использовать Kubernetes API из интернета.

        1. [Создайте группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) в кластере. При создании группы узлов выберите:

            * Созданные ранее группы безопасности, которые должны быть назначены группе узлов.
            * Опцию, которая назначает узлам публичный адрес. Такой адрес нужен, чтобы можно было скачивать образы из интернета.

    - Terraform {#tf}

        1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации кластера [alb-ready-k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-alb-mk8s-with-sws-profile/blob/main/alb-ready-k8s-cluster.tf). В файле описаны:
            * [Сеть](../../vpc/concepts/network.md#network).
            * [Подсеть](../../vpc/concepts/network.md#subnet).
            * Кластер Kubernetes.
            * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и группы узлов Managed Service for Kubernetes.
            * Сервисный аккаунт, необходимый для работы Ingress-контроллера Application Load Balancer.
            * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

                [Часть правил](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md) необходима для работы Application Load Balancer.

                {% note warning %}
                
                От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
                
                {% endnote %}
                
            * [Профиль безопасности](../../smartwebsecurity/concepts/profiles.md) Smart Web Security с [правилом Smart Protection](../../smartwebsecurity/concepts/rules.md#smart-protection-rules) и простым правилом для [проверки](#check-the-result) работы профиля, которое будет разрешать трафик только с определенного IP-адреса.
              
              [Базовое правило](../../smartwebsecurity/concepts/rules.md#base-rules) по умолчанию не указывается в манифесте и создается автоматически.

        1. Укажите в файле конфигурации:

            * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
            * Версию Kubernetes для кластера и групп узлов Kubernetes.
            * CIDR кластера Kubernetes, CIDR сервисов.
            * Имя сервисного аккаунта кластера Managed Service for Kubernetes.
            * Имя сервисного аккаунта Application Load Balancer.
            * Имя профиля безопасности Smart Web Security.
            * IP-адрес, трафик с которого будет разрешен.

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
            
        {% note info %}

        Если вы развернули инфраструктуру с помощью Terraform, выполнять шаг с [Созданием профиля безопасности](#create-security-profile) не нужно.

        {% endnote %}

    {% endlist %}

1. Убедитесь, что у вас есть [домен](../../glossary/fqdn.md) и вы можете управлять ресурсными записями в зоне [DNS](../../glossary/dns.md) для этого домена. Тестовое приложение будут доступно через Ingress на поддомене этого домена.

    Если у вас еще нет домена, зарегистрируйте домен у любого регистратора доменных имен. Чтобы управлять ресурсными записями домена с помощью Yandex Cloud DNS, [создайте публичную зону DNS и делегируйте домен](../../dns/operations/zone-create-public.md).

    {% note info %}

    В качестве примера используется домен `example.com` и поддомен `demo.example.com`.

    Используйте ваши домены при прохождении этого практического руководства.

    {% endnote %}

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

## Установите инструмент для управления балансировщиком {#deploy-controller}

{% list tabs group=alb_controller %}

- Gwin {#gwin}

  1. [Установите контроллер Gwin](../../application-load-balancer/tools/gwin/quickstart.md) в пространство имен `gwin-space`.

      При установке укажите сервисный аккаунт, который [был создан ранее для использования с контроллером](#before-you-begin).

      Использование отдельного пространства имен `gwin-space` позволит отделить ресурсы контроллера от ресурсов [тестового приложения](#deploy-app) и [Ingress](#deploy-ingress).

  1. Убедитесь, что контроллер был успешно установлен:

      ```bash
      kubectl logs deployment.apps/gwin -n gwin-space
      ```

      В логах должны содержаться сообщения об успешном старте контроллера Gwin.

      {% cut "Пример части результата выполнения команды" %}

      ```text
      level=INFO source=/yc_gwin/cmd/gwin/app/serve.go:467 msg="Server setup completed successfully"
      level=INFO source=/yc_gwin/cmd/gwin/app/serve.go:488 msg="Starting ALB observer"
      level=INFO source=/yc_gwin/cmd/gwin/app/serve.go:490 msg="ALB observer started successfully"
      level=INFO source=/yc_gwin/cmd/gwin/app/serve.go:492 msg="Starting address updater"
      level=INFO source=/yc_gwin/cmd/gwin/app/serve.go:494 msg="Address updater started successfully"
      level=INFO source=/yc_gwin/cmd/gwin/app/serve.go:496 msg="All services configured successfully, starting controller manager"
      ```

      {% endcut %}

- Ingress-контроллер {#alb-ingress}

  1. [Установите Ingress-контроллер Application Load Balancer](../../application-load-balancer/operations/k8s-ingress-controller-install.md) в пространство имен `yc-alb`.

      При установке укажите сервисный аккаунт, который [был создан ранее для использования с контроллером](#before-you-begin).

      Использование отдельного пространства имен `yc-alb` позволит отделить ресурсы контроллера от ресурсов [тестового приложения](#deploy-app) и [Ingress](#deploy-ingress).

  1. Убедитесь, что контроллер был успешно установлен:

      ```bash
      kubectl logs deployment.apps/yc-alb-ingress-controller -n yc-alb
      ```

      В логах должны содержаться сообщения об успешном старте Ingress-контроллера.

      {% cut "Пример части результата выполнения команды" %}

      ```text
      ...    INFO    Starting EventSource    {"controller": "ingressgroup", ...}
      ...    INFO    Starting Controller     {"controller": "ingressgroup"}
      ...    INFO    Starting EventSource    {"controller": "grpcbackendgroup", "controllerGroup": "alb.yc.io", ...}
      ...    INFO    Starting Controller     {"controller": "grpcbackendgroup", "controllerGroup": "alb.yc.io", ...}
      ...    INFO    Starting EventSource    {"controller": "httpbackendgroup", "controllerGroup": "alb.yc.io", ...}
      ...    INFO    Starting Controller     {"controller": "httpbackendgroup", "controllerGroup": "alb.yc.io", ...}

      ...

      ...    INFO    Starting workers        {"controller": "ingressgroup", ...}
      ...    INFO    Starting workers        {"controller": "grpcbackendgroup", "controllerGroup": "alb.yc.io", ...}
      ...    INFO    Starting workers        {"controller": "httpbackendgroup", "controllerGroup": "alb.yc.io", ...}
      ```

      {% endcut %}

{% endlist %}

## Создайте тестовое приложение {#deploy-app}

Создайте приложение и соответствующий ему сервис, который будет опубликован (exposed) с помощью Ingress:

1. Создайте манифест `demo-app1.yaml` для развертывания приложения:

    {% cut "`demo-app1.yaml`" %}

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: demo-app1
      labels:
        tutorial: sws
    data:
      nginx.conf: |
        worker_processes auto;
        events {
        }
        http {
          server {
            listen 80 ;
            location = /_healthz {
              add_header Content-Type text/plain;
              return 200 'ok';
            }
            location / {
              add_header Content-Type text/plain;
              return 200 'Index';
            }
            location = /app1 {
              add_header Content-Type text/plain;
              return 200 'This is APP#1';
            }
          }
        }
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: demo-app1
      labels:
        app: demo-app1
        tutorial: sws
        version: v1
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: demo-app1
      strategy:
        type: RollingUpdate
        rollingUpdate:
          maxSurge: 1
          maxUnavailable: 0
      template:
        metadata:
          labels:
            app: demo-app1
            version: v1
        spec:
          terminationGracePeriodSeconds: 5
          volumes:
            - name: demo-app1
              configMap:
                name: demo-app1
          containers:
            - name: demo-app1
              image: nginx:latest
              ports:
                - name: http
                  containerPort: 80
              livenessProbe:
                httpGet:
                  path: /_healthz
                  port: 80
                initialDelaySeconds: 3
                timeoutSeconds: 2
                failureThreshold: 2
              volumeMounts:
                - name: demo-app1
                  mountPath: /etc/nginx
                  readOnly: true
              resources:
                limits:
                  cpu: 250m
                  memory: 128Mi
                requests:
                  cpu: 100m
                  memory: 64Mi
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: demo-app1
      labels:
        tutorial: sws
    spec:
      selector:
        app: demo-app1
      type: NodePort
      ports:
        - name: http
          port: 80
          targetPort: 80
          protocol: TCP
    ```

    {% endcut %}

1. Разверните приложение:

    ```bash
    kubectl apply -f demo-app1.yaml
    ```

    Будут созданы объекты `ConfigMap`, `Deployment` и `Service` для приложения `demo-app1`.

1. Убедитесь, что все объекты были созданы успешно:

    ```bash
    kubectl get configmap,deployment,svc -l tutorial=sws
    ```

    {% cut "Пример результата выполнения команды" %}

    ```text
    NAME                  DATA   AGE
    configmap/demo-app1   1      ...

    NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/demo-app1   2/2     2            2           ...

    NAME                TYPE       CLUSTER-IP   EXTERNAL-IP   PORT(S)      AGE
    service/demo-app1   NodePort   ...          <none>        80:.../TCP   ...
    ```

    {% endcut %}

## Создайте профиль безопасности {#create-security-profile}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Создайте профиль безопасности с простым правилом, чтобы работу профиля было легко [проверить](#check-the-result). Правила в профиле будут разрешать трафик только с определенного IP-адреса.

  Создайте профиль безопасности:

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите создать профиль.
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **Профили безопасности**.
  1. Нажмите кнопку **Создать профиль** и выберите **По преднастроенному шаблону**.

      Профиль будет содержать несколько преднастроенных правил безопасности:

      * [Правило Smart Protection](../../smartwebsecurity/concepts/rules.md#smart-protection-rules) с полной защитой для всего трафика. Это правило является приоритетным по отношению к базовому правилу по умолчанию.
      * [Базовое правило](../../smartwebsecurity/concepts/rules.md#base-rules) по умолчанию, которое запрещает весь трафик, не попавший под более приоритетные правила.

          {% note tip %}
          
          Создание преднастроенного профиля с полной защитой Smart Protection является предпочтительным. Рекомендуем использовать его, чтобы обеспечить наибольшую безопасность защищаемого ресурса.
          
          {% endnote %}

  1. Задайте данные профиля:

      * **Имя** — имя профиля, например `test-sp1`.
      * **Действие для базового правила по умолчанию** — действие, которое должно выполнять базовое правило.

          Оставьте выбранным действие `Запретить`, чтобы базовое правило запрещало весь трафик.

  1. Добавьте правило безопасности:

      1. Нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **Добавить правило**.

      1. Укажите основные настройки правила:

          * **Имя** — имя правила, например `test-rule1`.

          * **Приоритет** — укажите такое значение, чтобы правило имело приоритет над преднастроенными правилами. Например, можно указать значение `999800`.

              {% note info %}
              
              Чем меньше значение параметра, тем больший приоритет у правила. Приоритеты преднастроенных правил:
              * базовое правило по умолчанию — `1000000`;
              * правило Smart Protection с полной защитой — `999900`.
              
              {% endnote %}

          * **Тип правила** — выберите `Базовое`.

          * **Действие** — выберите `Разрешить`.

      1. В блоке **Условия** настройте условия так, чтобы разрешался трафик только с определенного IP-адреса:

          1. Выберите область действия правила на трафик `При условии`.
          1. Выберите условие `IP`.
          1. Выберите условие на IP `Совпадает или принадлежит диапазону`.
          1. Укажите публичный IP-адрес, например `203.0.113.200`.

      1. Нажмите кнопку **Добавить**.

      В списке правил безопасности появится созданное правило.

  1. Нажмите кнопку **Создать**.

  В списке профилей безопасности появится созданный профиль. Запишите идентификатор этого профиля безопасности — он потребуется позднее.

- Terraform {#tf}

  Если вы использовали файл конфигурации [alb-ready-k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-alb-mk8s-with-sws-profile/blob/main/alb-ready-k8s-cluster.tf), то профиль безопасности [уже создан](#before-you-begin) и дополнительные действия не требуются.

{% endlist %}

## Создайте ресурс Ingress {#deploy-ingress}

В этом ресурсе Ingress будут описаны параметры балансировщика Application Load Balancer. Инструмент для управления балансировщиком, [установленный ранее](#deploy-controller), развернет балансировщик с указанными параметрами после создания ресурса Ingress.

Согласно правилам Ingress, трафик к виртуальному хосту `demo.example.com` по пути `/app1` будет направляться к бэкенду [service/demo-app1](#deploy-app). [Созданный ранее профиль безопасности](#create-security-profile) будет использоваться, чтобы защитить этот бэкенд.

Чтобы создать ресурс Ingress:

1. Создайте файл `demo-ingress.yaml` с описанием ресурса Ingress:

    {% list tabs group=alb_controller %}

    - Gwin {#gwin}

      ```yaml
      apiVersion: networking.k8s.io/v1
      kind: Ingress
      metadata:
        name: demo-ingress
        annotations:
          gwin.yandex.cloud/subnets: "<список_идентификаторов_подсетей>"
          gwin.yandex.cloud/securityGroups: "<идентификатор_группы_безопасности>"
          gwin.yandex.cloud/externalIPv4Address: "auto"
          gwin.yandex.cloud/groupName: "demo-sws"
          gwin.yandex.cloud/hosts.securityProfileID: "<идентификатор_профиля_безопасности>"
      spec:
        ingressClassName: gwin-default
        rules:
          - host: demo.example.com
            http:
              paths:
                - path: /app1
                  pathType: Exact
                  backend:
                    service:
                      name: demo-app1
                      port:
                        number: 80
      ```

      Где:

      * [gwin.yandex.cloud/subnets](../../application-load-balancer/gwin-ref/ingress.md#load-balancer-configuration) — список идентификаторов подсетей, в которых будет расположен балансировщик.

          Если вы [создали инфраструктуру с помощью Terraform](#before-you-begin), используйте идентификатор подсети, которая имеет имя `subnet-a`.

      * [gwin.yandex.cloud/security-groups](../../application-load-balancer/gwin-ref/ingress.md#load-balancer-configuration) — идентификатор группы, [созданной ранее](#before-you-begin) для балансировщика.

          Если вы создали инфраструктуру с помощью Terraform, укажите идентификатор группы, которая имеет имя `alb-traffic`.

      * [gwin.yandex.cloud/hosts.securityProfileID](../../application-load-balancer/gwin-ref/ingress.md#security-configuration) — идентификатор профиля безопасности, [созданного ранее](#create-security-profile) в сервисе Smart Web Security.

          {% note info %}

          Профиль безопасности будет применен только к виртуальным хостам для ресурса Ingress, в котором задана аннотация. Для ресурса Ingress, который описан выше, профиль будет применен к единственному виртуальному хосту `demo.example.com`.

          Этот ресурс Ingress — единственный в группе Ingress `demo-sws`. Профиль безопасности не будет применен к виртуальным хостам других ресурсов Ingress, если такие ресурсы будут позднее добавлены в группу.

          {% endnote %}

      Подробнее об аннотациях см. в разделе [Поля и аннотации ресурса Ingress](../../application-load-balancer/gwin-ref/ingress.md).

    - Ingress-контроллер {#alb-ingress}

      ```yaml
      apiVersion: networking.k8s.io/v1
      kind: Ingress
      metadata:
        name: demo-ingress
        annotations:
          ingress.alb.yc.io/subnets: "<список_идентификаторов_подсетей>"
          ingress.alb.yc.io/security-groups: "<идентификатор_группы_безопасности>"
          ingress.alb.yc.io/external-ipv4-address: "auto"
          ingress.alb.yc.io/group-name: "demo-sws"
          ingress.alb.yc.io/security-profile-id: "<идентификатор_профиля_безопасности>"
      spec:
        rules:
          - host: demo.example.com
            http:
              paths:
                - path: /app1
                  pathType: Exact
                  backend:
                    service:
                      name: demo-app1
                      port:
                        number: 80
      ```

      Где:

      * [ingress.alb.yc.io/subnets](../../application-load-balancer/k8s-ref/ingress.md#annot-subnets) — список идентификаторов подсетей, в которых будет расположен балансировщик.

          Если вы [создали инфраструктуру с помощью Terraform](#before-you-begin), используйте идентификатор подсети, которая имеет имя `subnet-a`.

      * [ingress.alb.yc.io/security-groups](../../application-load-balancer/k8s-ref/ingress.md#annot-security-groups) — идентификатор группы, [созданной ранее](#before-you-begin) для балансировщика.

          Если вы создали инфраструктуру с помощью Terraform, укажите идентификатор группы, которая имеет имя `alb-traffic`.

      * [ingress.alb.yc.io/security-profile-id](../../application-load-balancer/k8s-ref/ingress.md#annot-security-profile-id) — идентификатор профиля безопасности, [созданного ранее](#create-security-profile) в сервисе Smart Web Security.

          {% note info %}

          Профиль безопасности будет применен только к [виртуальным хостам](../../application-load-balancer/tools/k8s-ingress-controller/principles.md#mapping) для ресурса Ingress, в котором задана аннотация. Для ресурса Ingress, который описан выше, профиль будет применен к единственному виртуальному хосту `demo.example.com`.

          Этот ресурс Ingress — единственный в группе Ingress `demo-sws`. Профиль безопасности не будет применен к виртуальным хостам других ресурсов Ingress, если такие ресурсы будут позднее добавлены в группу.

      {% endnote %}

      Подробнее об аннотациях см. в разделе [Поля и аннотации ресурса Ingress](../../application-load-balancer/k8s-ref/ingress.md).

    {% endlist %}

1. Создайте ресурс Ingress:

    ```bash
    kubectl apply -f demo-ingress.yaml
    ```

    Ingress-контроллер Application Load Balancer запустит процесс создания целевых групп, групп бэкендов, HTTP-роутеров и балансировщика нагрузки.

1. Периодически проверяйте статус ресурса Ingress, пока в столбце `ADDRESS` не появится IP-адрес балансировщика:

    ```bash
    kubectl get ingress demo-ingress
    ```

    Это будет означать, что балансировщик создан успешно и может принимать трафик.

    {% cut "Пример результата выполнения команды" %}

    ```bash
    NAME             CLASS    HOSTS              ADDRESS         PORTS   AGE
    demo-ingress     <none>   demo.example.com   158.1*.*.*      80      ...
    ```

    {% endcut %}

### Создайте DNS-запись для домена {#create-dns-record}

1. [Создайте](../../dns/operations/resource-record-create.md) A-запись для домена `demo.example.com` в зоне `example.com`. В значении укажите IP-адрес балансировщика, который был создан ранее.

1. Дождитесь, пока завершится распространение DNS-записей (DNS propagation).

    Проверить, что DNS-записи распространились, можно либо с помощью онлайн-сервисов, либо с помощью запросов вручную к разным DNS-серверам:

    ```bash
    nslookup -type=a demo.example.com <IP_адрес_DNS_сервера>
    ```

## Проверьте результат {#check-the-result}

Запросы к приложению, развернутому в кластере Kubernetes, проходят через балансировщик нагрузки Application Load Balancer. Виртуальные хосты, на которые направляются запросы, защищены с помощью профиля безопасности. Этот профиль [был настроен так](#create-security-profile), чтобы разрешать трафик только с определенного IP-адреса (например, с `203.0.113.200`).

Проверьте, что балансировщик работает корректно с учетом настроенного профиля безопасности:

1. Проверьте с хоста с разрешенным IP-адресом `203.0.113.200`, что выполняется маршрутизация трафика по правилу, заданному в ресурсе Ingress:

    ```bash
    curl http://demo.example.com/app1
    ```

    Ожидаемый результат:

    ```text
    This is demo-app1
    ```

1. Проверьте с хоста с другим IP-адресом, который не входит в список разрешенных (например `203.0.113.100`), что маршрутизация трафика не выполняется:

    ```bash
    curl http://demo.example.com/app1
    ```

    Ожидаемый результат: ответ от балансировщика с кодом [HTTP 403 Forbidden](https://developer.mozilla.org/ru/docs/Web/HTTP/Status/403) и сообщением об ограничении доступа к ресурсу.

Если маршрутизация трафика не выполняется так, как ожидается, то убедитесь, что заданы необходимые настройки:

* Сервисному аккаунту для Ingress-контроллера [должны быть назначены необходимые роли](#before-you-begin), в том числе для работы с сервисом Smart Web Security.
* Группы безопасности для кластера Managed Service for Kubernetes и его групп узлов [должны быть настроены корректно](../../managed-kubernetes/operations/connect/security-groups.md). Если отсутствует какое-либо из правил — [добавьте его](../../vpc/operations/security-group-add-rule.md).
* Профиль безопасности [должен быть настроен корректно](#create-security-profile), чтобы разрешать трафик с нужного адреса.

{% note tip %}

После подтверждения работоспособности профиля добавьте нужные правила, если это необходимо.

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. Удалите созданный ресурс Ingress:

    ```bash
    kubectl delete ingress demo-ingress
    ```

    Будет удален балансировщик нагрузки, а также HTTP-роутер, связанный с балансировщиком.

    Профиль безопасности Smart Web Security будет отключен от виртуальных хостов, указанных в ресурсе Ingress.

1. Удалите кластер Managed Service for Kubernetes и связанную с ним инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        [Удалите кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).

        При необходимости удалите сервисные аккаунты и группы безопасности, [созданные перед началом работы](#before-you-begin).

    - Terraform {#tf}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        
            {% note warning %}
        
            Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
        
            {% endnote %}
        
        1. Удалите ресурсы:
        
            1. Выполните команду:
        
                ```bash
                terraform destroy
                ```
        
            1. Подтвердите удаление ресурсов и дождитесь завершения операции.
        
            Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

    {% endlist %}