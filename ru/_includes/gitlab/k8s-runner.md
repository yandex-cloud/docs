## Подключите кластер {{ k8s }} к сборкам GitLab {#runners}

Для того, чтобы запускать задачи сборки на кластере {{ k8s }}, подключите кластер в настройках GitLab.

1. Откройте в браузере ссылку вида `http://<публичный IP-адрес ВМ GitLab>/root`.
1. Выберите проект с именем `gitlab-test`.
1. В открывшемся окне слева нажмите на **Operations** и выберите пункт **Kubernetes**.
1. Нажмите кнопку **Add Kubernetes cluster**.
1. В открывшемся окне нажмите **Add existing cluster**.
1. В поле **Kubernetes cluster name** введите имя кластера.
1. В поле **API URL** введите адрес узла [мастера](../../managed-kubernetes/concepts/index.md#master). Узнайте его с помощью команды:

    {% list tabs %}
    
    - Bash
    
      ```
      $ yc managed-kubernetes cluster get <cluster-id> --format=json \
      | jq -r .master.endpoints.external_v4_endpoint
      ```
    
    {% endlist %}
1. В поле **CA Certificate** введите сертификат мастера. Узнайте его с помощью команды:

    {% list tabs %}
    
    - Bash
    
      ```
      $ yc managed-kubernetes cluster get <cluster-id> --format=json \
      | jq -r .master.master_auth.cluster_ca_certificate
      ```
    
    {% endlist %}
1. В поле **Service Token** введите токен, который GitLab будет использовать для создания ресурсов {{ k8s }}. 
Используйте токен, полученный перед началом работы.
1. Нажмите кнопку **Add Kubernetes cluster**.
1. Установите на кластер {{ k8s }} приложения, необходимые для корректной работы GitLab Runner:
    - Напротив надписи **Helm Tiller** нажмите кнопку **Install**.
    - Напротив надписи **GitLab Runner** нажмите кнопку **Install**. 

Теперь вы можете запускать автоматизированные сборки внутри своего {{ k8s }}-кластера. 

Подробнее про настройки подключения кластера {{ k8s }} к сборкам GitLab читайте в [документации GitLab](https://docs.gitlab.com/ee/user/project/clusters/#add-existing-kubernetes-cluster).
