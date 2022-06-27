## Настройте автоматическое развертывание {{ k8s }} ресурсов из CI {#k8s-apply}

Чтобы настроить автоматическое развертывание, необходимо прописать адрес [мастера {{ k8s }}](../../managed-kubernetes/concepts/index.md#master) и токен [сервисного аккаунта](../../iam/concepts/index.md#sa) в настройках {{ GL }}.
1. Создайте [переменные окружения {{ GL }}](https://docs.gitlab.com/ee/ci/variables/README.html):
   * `KUBE_URL` – адрес мастера {{ k8s }}. Узнайте его с помощью команды:

     {% list tabs %}

     - Bash

       ```bash
       yc managed-kubernetes cluster get <cluster-id> --format=json \
         | jq -r .master.endpoints.external_v4_endpoint
       ```

     {% endlist %}

   * `KUBE_TOKEN` – токен, который будет использовать {{ GL }} для применения конфигурации. Используйте токен, полученный перед началом работы.
1. Используйте переменные окружения на этапе развертывания приложения.

   Файл [конфигурации](https://docs.gitlab.com/ee/ci/README.html) `.gitlab-ci.yml` в этом случае будет выглядеть следующим образом:

   ```yaml
   deploy:
     image:
       name: gcr.io/cloud-builders/kubectl:latest
       entrypoint: [""]
     stage: deploy
     script:
       - kubectl config set-cluster k8s --server="$KUBE_URL" --insecure-skip-tls-verify=true
       - kubectl config set-credentials admin --token="$KUBE_TOKEN"
       - kubectl config set-context default --cluster=k8s --user=admin
       - kubectl config use-context default
       - kubectl apply -f k8s.yaml
   ```

Теперь, при каждом запуске автоматизированной сборки, будет создаваться задача по изменению конфигурации ресурсов {{ k8s }}.