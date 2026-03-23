# Настройка внешнего доступа к поду в кластере

{{ stackland-name }} позволяет пользователям запускать собственные приложения в кластере и создавать внешний доступ к ним. В этом руководстве мы разберем пример создания внешнего доступа к HTML-странице в кластере.

## Перед началом работы {#before-begin}

1. Если проект еще не создан, создайте его: `kubectl create namespace <название проекта>`.
1. Выберите ссылку для внешнего доступа. Например, `test.{{ cluster-domain }}`.

    При необходимости получить домен кластера можно с помощью команды `kubectl get platformenvironments main -o jsonpath='{.status.clusterDomain}'`.

## Как создать внешний доступ {#how-to}

### Шаг 1. Создайте Ingress {#create-ingress}

1. Создайте файл ресурса `Ingress`. Например, с помощью команды `touch ingress.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    {% include notitle [YAML-файл](../_includes/yamls/tutorials/expose-app-domain/create-ingress.md) %}

1. Подставьте в параметр:

    * `metadata.namespace` — название проекта.
    * `spec.rules[0].host` — ссылку для внешнего доступа.
    * `spec.tls[0].hosts[0]` — ссылку для внешнего доступа.

1. Примените манифест: `kubectl apply -f ingress.yaml`.

### Шаг 2. Создайте HTML-страницу {#create-HTML}

1. Создайте файл ресурса `ConfigMap`. Например, с помощью команды `touch configmap.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    {% include notitle [YAML-файл](../_includes/yamls/tutorials/expose-app-domain/create-configmap.md) %}

1. Подставьте в параметр `metadata.namespace` название проекта.
1. Примените манифест: `kubectl apply -f configmap.yaml`.

### Шаг 3. Создайте Deployment для HTML-страницы {#create-deployment}

1. Создайте файл ресурса `Deployment`. Например, с помощью команды `touch deployment.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    {% include notitle [YAML-файл](../_includes/yamls/tutorials/expose-app-domain/create-deployment.md) %}

1. Подставьте в параметр `metadata.namespace` название проекта.
1. Примените манифест: `kubectl apply -f deployment.yaml`.

### Шаг 4. Создайте Service для HTML-страницы {#create-service}

1. Создайте файл ресурса `Service`. Например, с помощью команды `touch service.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    {% include notitle [YAML-файл](../_includes/yamls/tutorials/expose-app-domain/create-service.md) %}

1. Подставьте в параметр `metadata.namespace` название проекта.
1. Примените манифест: `kubectl apply -f service.yaml`.

### Шаг 5. Проверьте работу доступа {#check-access}

Откройте в браузере выбранную ссылку для внешнего доступа. Вы должны увидеть тестовую HTML-страницу.
