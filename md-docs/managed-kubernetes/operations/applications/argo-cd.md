# Установка Argo CD


[Argo CD](https://argo-cd.readthedocs.io) — декларативный инструмент для непрерывной доставки в {{ k8s }} по модели GitOps.

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера {{ managed-k8s-name }} и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Argo CD](https://yandex.cloud/ru/marketplace/products/yc/argo-cd) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `argo-cd-space`). Если вы оставите пространство имен по умолчанию, Argo CD может работать некорректно.
   * **Название приложения** — укажите название приложения.
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Argo CD выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_argo-cd.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_argo-cd.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     argo-cd ./argo-cd/
   ```

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, Argo CD может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `argo-cd-space`).

## Доступ к приложению {#application-access}

Вы можете открыть приложение Argo CD через [localhost](#open-via-localhost), по [выделенному IP-адресу](#go-to-static-address) через сетевой балансировщик [{{ network-load-balancer-full-name }}](../../../network-load-balancer/index.md) или по [URL](#open-via-alb) через L7-балансировщик [{{ alb-full-name }}](../../../application-load-balancer/index.md). Первый способ проще в настройке и не требует дополнительных затрат на балансировщики. Однако через `localhost` приложение доступно, только пока активна переадресация портов, а балансировщики обеспечивают постоянный доступ к Argo CD.

Перед тем как настроить доступ к Argo CD, получите пароль администратора (`admin`):

```bash
kubectl --namespace <пространство_имен> get secret argocd-initial-admin-secret \
  --output jsonpath="{.data.password}" | base64 -d
```

Пароль понадобится для аутентификации в Argo CD.

### Открыть приложение через localhost {#open-via-localhost}

1. Настройте переадресацию порта Argo CD на локальный компьютер:

   ```bash
   kubectl port-forward service/<название_приложения>-argocd-server \
     --namespace <пространство_имен> 8080:443
   ```

   В команде укажите название приложения, которое вы задали при установке.

1. Перейдите по ссылке `https://localhost:8080` и авторизуйтесь с учетными данными администратора.

### Открыть приложение по выделенному IP-адресу через {{ network-load-balancer-name }}{#go-to-static-address}

1. Сохраните следующую спецификацию для создания сервиса типа `LoadBalancer` в файл `load-balancer.yaml`. В результате вы создадите балансировщик [{{ network-load-balancer-name }}](../../../network-load-balancer/index.md):

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: argocd-load-balancer
     namespace: <пространство_имен>
   spec:
     type: LoadBalancer
     ports:
     - port: 443
       name: load-balancer-port-ssl
       targetPort: 8080
     # {{ k8s }}-метка селектора, использованная в объекте Deployment с именем <название_приложения>-argocd-server.
     selector:
       app.kubernetes.io/name: argocd-server
   ```

   В спецификации укажите пространство имен, в котором вы установили приложение Argo CD.

   Так как в спецификации не задан IP-адрес, балансировщику будет присвоен динамический публичный IP-адрес. Вы можете добавить поле `spec.loadBalancerIP` и указать в нем [заранее зарезервированный](../../../vpc/operations/get-static-ip.md) статический IP-адрес.

   Подробнее о спецификации см. в [справочнике сервиса](../../nlb-ref/service.md).

1. Примените спецификацию и создайте сетевой балансировщик нагрузки:

   ```bash
   kubectl apply -f load-balancer.yaml --namespace <пространство_имен>
   ```

1. Получите IP-адрес созданного сетевого балансировщика:

   {% list tabs group=instructions %}

   * Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, где развернут кластер {{ managed-k8s-name }}.
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.

         В разделе **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_list }}** отображен сетевой балансировщик нагрузки с префиксом `k8s` в имени и уникальным идентификатором кластера {{ k8s }} в описании.

      1. Скопируйте значение поля **{{ ui-key.yacloud.load-balancer.network-load-balancer.column_ip-address }}** для нужного балансировщика.

   {% endlist %}

1. Перейдите по ссылке `https://<IP-адрес_балансировщика>` и авторизуйтесь с учетными данными администратора.

### Открыть приложение по URL через {{ alb-name }} {#open-via-alb}

1. [Зарегистрируйте публичную доменную зону и делегируйте домен](../../../dns/operations/zone-create-public.md).

1. Если у вас уже есть сертификат для доменной зоны, [добавьте сведения о нем](../../../certificate-manager/operations/import/cert-create.md) в сервис [{{ certificate-manager-full-name }}](../../../certificate-manager/index.md). Если нет, выпустите новый сертификат от {{ lets-encrypt }} и [добавьте](../../../certificate-manager/operations/managed/cert-create.md) его в {{ certificate-manager-name }}.

1. Получите идентификатор сертификата:
   
     ```bash
     yc certificate-manager certificate list
     ```
   
     Результат выполнения команды:
   
     ```text
     +----------------------+-----------+----------------+---------------------+----------+--------+
     |          ID          |   NAME    |    DOMAINS     |      NOT AFTER      |   TYPE   | STATUS |
     +----------------------+-----------+----------------+---------------------+----------+--------+
     | fpq8diorouhp******** | cert-test |    test.ru     | 2022-01-06 17:19:37 | IMPORTED | ISSUED |
     +----------------------+-----------+----------------+---------------------+----------+--------+
     ```

1. [Настройте](../../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md) группы безопасности, необходимые для работы L7-балансировщика {{ alb-name }}.

1. [Установите Ingress-контроллер {{ alb-name }}](alb-ingress-controller.md).

   {% note tip %}
   
   Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [{{ yandex-cloud }} Gwin](../../../application-load-balancer/tools/gwin/index.md).
   
   {% endnote %}

1. Для работы с L7-балансировщиком {{ alb-name }} требуется сервис типа `NodePort`, но Argo CD запускает сервер с сервисом типа `ClusterIP`. Измените тип сервиса:

   1. Откройте файл с описанием объекта `Service`:

      ```bash
      kubectl -n <пространство_имен> edit svc <название_приложения>-argocd-server
      ```

   1. Замените значение `type` на `NodePort`:

        ```yaml
        spec:
          ... 
          type: NodePort
          ...
        ```

1. L7-балансировщик {{ alb-name }} снимает TLS-шифрование с входящего трафика. Чтобы избежать бесконечного перенаправления, отключите для Argo CD перенаправление с HTTP на HTTPS:

   1. Откройте конфигурационный файл `argocd-cmd-params-cm`:

      ```bash
      kubectl -n <пространство_имен> edit configmap argocd-cmd-params-cm
      ```

   1. Замените значение `server.insecure` на `true`:

      ```yaml
      data:
        ...
        server.insecure: "true"
        ...
      ```

1. Создайте файл `ingress.yaml` и укажите в нем настройки L7-балансировщика {{ alb-name }}:

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: argocd-ingress
      namespace: argo-cd-space
      annotations:
        ingress.alb.yc.io/subnets: <идентификатор_подсети_балансировщика>
        ingress.alb.yc.io/security-groups: <идентификатор_группы_безопасности_балансировщика>
        ingress.alb.yc.io/external-ipv4-address: auto
        ingress.alb.yc.io/group-name: my-ingress-group
    spec:
      tls:
        - hosts:
            - <доменное_имя>
          secretName: yc-certmgr-cert-id-<идентификатор_TLS-сертификата>
      rules:
        - host: <доменное_имя>
          http:
            paths:
              - path: /
                pathType: Prefix
                backend:
                  service:
                    name: argo-cd-argocd-server
                    port:
                      number: 80
    ```

    Подробнее о настройках см. в разделе [Настройка L7-балансировщика {{ alb-full-name }} с помощью Ingress-контроллера](../../tutorials/alb-ingress-controller.md#create-ingress-and-apps).

1. В директории с файлом `ingress.yaml` выполните команду:

    ```bash
    kubectl apply -f ingress.yaml
    ```

    Будет создан ресурс `Ingress`. По его конфигурации ALB Ingress Controller автоматически развернет L7-балансировщик {{ alb-name }}.

1. Убедитесь, что L7-балансировщик создан. Для этого выполните команду:

    ```bash
    kubectl get ingress argocd-ingress
    ```

    Изучите результат выполнения команды. Если L7-балансировщик создан, в поле `ADDRESS` должен отображаться его IP-адрес:

    ```bash
    NAME            CLASS   HOSTS           ADDRESS        PORTS    AGE
    argocd-ingress  <none>  <доменное_имя>  51.250.**.***  80, 443  15h
    ```    

1. [Добавьте A-запись в зону](../../../dns/operations/resource-record-create.md) вашего домена. В поле **{{ ui-key.yacloud.dns.label_records }}** укажите публичный IP-адрес L7-балансировщика {{ alb-name }}.

1. Откройте в браузере ссылку `https://<доменное_имя>` и авторизуйтесь с учетными данными администратора.

   {% note info %}
   
   Если ресурс недоступен по указанному URL, то [убедитесь](../connect/security-groups.md), что группы безопасности для кластера {{ managed-k8s-name }} и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../../vpc/operations/security-group-add-rule.md).
   
   {% endnote %}

## Примеры использования {#examples}

* [{#T}](../../tutorials/marketplace/argo-cd.md).

## См. также {#see-also}

* [Документация Argo CD](https://argo-cd.readthedocs.io/en/stable/operator-manual/).