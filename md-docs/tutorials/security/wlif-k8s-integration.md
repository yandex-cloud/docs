# Получение значения секрета Yandex Lockbox на стороне пользовательской инсталляции Kubernetes

[Федерации сервисных аккаунтов](../../iam/concepts/workload-identity.md) (Workload Identity Federation) позволяют настроить связь между внешними системами и Yandex Cloud по протоколу [OpenID Connect](https://openid.net/developers/how-connect-works/) (OIDC). За счет этого внешние системы могут выполнять действия с ресурсами Yandex Cloud от имени [сервисных аккаунтов](../../iam/concepts/users/service-accounts.md) IAM без использования [авторизованных ключей](../../iam/concepts/authorization/key.md). Это более безопасный способ, минимизирующий риск утечки учетных данных и возможность несанкционированного доступа.

В этом руководстве для примера показано, как получить значение [секрета](../../lockbox/concepts/secret.md) [Yandex Lockbox](../../lockbox/index.md) со стороны Kubernetes от имени сервисного аккаунта в Yandex Cloud. Аналогичным образом можно выполнить любое действие через Yandex Cloud [CLI](../../cli/quickstart.md), [API](../../api-design-guide/index.md) или [Terraform](../../terraform/index.md).

{% note info %}

В руководстве представлен пример интеграции пользовательской инсталляции Kubernetes с федерацией сервисных аккаунтов. Руководство по интеграции Managed Service for Kubernetes см. на странице [Доступ к API Yandex Cloud из кластера Managed Service for Kubernetes с помощью федерации сервисных аккаунтов Identity and Access Management](wlif-managed-k8s-integration.md).

{% endnote %}

Чтобы получить значение секрета Yandex Lockbox от имени аккаунта в Kubernetes:

1. [Подготовьте кластер Kubernetes](#prepare-k8s-cluster).
1. [Подготовьте облако к работе](#prepare-cloud).
1. [Настройте сценарий в Kubernetes](#k8s-workflow).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте кластер Kubernetes {#prepare-k8s-cluster}

1. Создайте новый кластер Kubernetes или используйте существующий.

   Убедитесь, что ваш кластер соответствует следующим требованиям:

   * Вы используете Kubernetes версии 1.20 или новее.
      Более ранние версии Kubernetes используют другой формат токенов `ServiceAccount`, который не совместим с инструкциями в этом руководстве.
   * Вы настроили `kube-apiserver` так, чтобы он [поддерживал проекцию токенов `ServiceAccount`](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#serviceaccount-token-volume-projection).

   {% note info %}

   Это руководство подходит как для публично доступных, так и для приватных кластеров Kubernetes.

   {% endnote %}

1. Создайте манифест `service-account.yaml` со следующим содержимым:

   ```yaml
   apiVersion: v1
   kind: ServiceAccount
   metadata:
     name: wlif
   ```

1. Примените манифест:

   ```bash
   kubectl apply -f service-account.yaml
   ```

1. Чтобы проверить созданный ресурс `ServiceAccount` выполните команду:

   ```bash
   kubectl describe serviceaccount wlif
   ```

   Результат:
   ```
   Name:                wlif
   Namespace:           default
   ```

   Значения полей `Name` и `Namespace` понадобятся для дальнейшей настройки интеграции на стороне Yandex Cloud.

1. Создайте манифест `pod.yaml` со следующим содержимым:

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: test-wlif
   spec:
     containers:
     - image: nginx
       name: nginx
       volumeMounts:
       - mountPath: /var/run/secrets/tokens
         name: sa-token
     serviceAccountName: wlif
     volumes:
     - name: sa-token
       projected:
         sources:
         - serviceAccountToken:
             path: sa-token
             expirationSeconds: 7200
             audience: ycaud
   ```

   В поле `audience` укажите получателя токена, например `ycaud`.

1. Примените манифест:

   ```bash
   kubectl apply -f pod.yaml
   ```

1. Убедитесь, что созданный под имеет статус `RUNNING`:

   ```bash
   kubectl get pod test-wlif
   ```

   Результат:

   ```
   NAME        READY   STATUS    RESTARTS   AGE
   test-wlif   1/1     Running   0          1m
   ```

1. Получите `URL Issuer` вашего Kubernetes кластера:

   ```bash
   kubectl get --raw /.well-known/openid-configuration | jq -r .issuer
   ```

1. Создайте файл с набором публичных ключей (JWKS):
   
   ```bash
   kubectl get --raw /openid/v1/jwks > cluster-jwks.json
   ```

## Подготовьте облако к работе {#prepare-cloud}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
1. Плата за хранение [секрета](../../lockbox/concepts/secret.md) и запросы к нему (см. [тарифы Yandex Lockbox](../../lockbox/pricing.md));
1. Плата за хранение данных в бакете и операции с ними (см. [тарифы Object Storage](../../storage/pricing.md)).

### Загрузите файл с набором публичных ключей в публичный бакет

1. Создайте публичный бакет:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать бакет.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
      1. На панели сверху нажмите кнопку **Создать бакет**.
      1. На странице создания бакета:
         1. Введите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
         
         1. В поле **Чтение объектов** выберите `Для всех`.

         1. Нажмите кнопку **Создать бакет** для завершения операции.

   {% endlist %}

1. Загрузите созданный ранее файл `cluster-jwks.json` в бакет:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Перейдите в созданный бакет.
      1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **Объекты**.
      1. Нажмите **Загрузить объекты**.
      1. На верхней панели нажмите ![image](../../_assets/console-icons/arrow-up-from-line.svg) **Загрузить**.
      1. В появившемся окне выберите файл `cluster-jwks.json` и нажмите **Открыть**.
      1. Нажмите **Загрузить**.
      1. Обновите страницу.

   {% endlist %}

1. Получите ссылку на загруженный файл:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Нажмите на имя файла.
      1. Нажмите ![link](../../_assets/storage/link.svg) **Получить ссылку** в правом верхнем углу.
      1. Скопируйте полученную ссылку.

   {% endlist %}

### Создайте федерацию сервисных аккаунтов {#federation-iam-accounts}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите создать федерацию сервисных аккаунтов.
   1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
   1. На панели слева выберите ![cpus](../../_assets/console-icons/cpus.svg) **Федерации сервисных аккаунтов**.
   1. Нажмите **Создать федерацию**.
   1. В поле **Значение Issuer (iss)** введите `URL Issuer` вашего Kubernetes кластера, полученный ранее, например `https://kubernetes.default.svc.cluster.local`.
   1. В поле **Допустимые значения Audience (aud)** введите получателя токена, указанного при создании пода, например `ycaud`.
   1. В поле **Адрес JWKS** введите ссылку на файл `cluster-jwks.json` в бакете.
   1. В поле **Имя** введите имя федерации, например `test-iam-federation`.
   1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте пользовательский секрет

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создан секрет.
   1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Lockbox**.
   1. Нажмите кнопку **Создать секрет**.
   1. В поле **Имя** введите имя секрета `MY_SECRET`.
   1. Выберите **Тип секрета** `Пользовательский`.
   1. В поле **Ключ** введите неконфиденциальный идентификатор, например `secret`.
   1. В поле **Значение** введите конфиденциальные данные для хранения.
   1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте сервисный аккаунт

1. Создайте сервисный аккаунт:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать сервисный аккаунт.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
      1. Нажмите кнопку **Создать сервисный аккаунт**.
      1. Введите имя сервисного аккаунта, например `sa-lockbox`.
      1. Нажмите кнопку **Создать**.

   {% endlist %}

1. Назначьте сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) `lockbox.payloadViewer` на каталог: 

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. На [стартовой странице](https://console.yandex.cloud) консоли управления выберите каталог.
      1. Перейдите на вкладку **Права доступа**.
      1. Найдите аккаунт `sa-lockbox` в списке и нажмите значок ![image](../../_assets/console-icons/ellipsis.svg).
      1. Нажмите кнопку **Изменить роли**.
      1. В открывшемся диалоге нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `lockbox.payloadViewer`.

   {% endlist %}

### Привяжите сервисный аккаунт к Федерации

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором был создан сервисный аккаунт.
   1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
   1. В списке выберите сервисный аккаунт `sa-lockbox`.
   1. Перейдите на вкладку **Федерации сервисных аккаунтов**.
   1. Нажмите кнопку **Привязать к федерации**.
   1. В поле **Федерация сервисных аккаунтов** выберите ранее созданную федерацию.
   1. В поле **Значение Subject (sub)** укажите идентификатор внешнего аккаунта `system:serviceaccount:<пространство_имен>:<имя_аккаунта>`.
   
      Где:
      * `пространство_имен` — значение поля `Namespace` в выводе команды `kubectl describe serviceaccount <имя_аккаунта>`, например `default`;
      * `имя_аккаунта` — название созданного аккаунта, например `wlif`.

   1. Нажмите кнопку **Привязать**.

{% endlist %}

## Настройте сценарий в Kubernetes { #k8s-workflow }

1. Заполните переменные:

   ```bash
   SA_ID="<идентификатор_сервисного_аккаунта>"
   SECRET_ID="<идентификатор_секрета>"
   ```

   Где:
   * `SA_ID` — идентификатор сервисного аккаунта;
   * `SECRET_ID` — идентификатор пользовательского секрета.

1. Получите токен сервисного аккаунта Kubernetes:

   ```bash
   SA_TOKEN=`kubectl exec -it test-wlif -- cat /var/run/secrets/tokens/sa-token`
   ```

1. Обменяйте токен сервисного аккаунта Kubernetes на IAM-токен сервисного аккаунта в Yandex Cloud:
   
   ```bash
   IAMTOKEN=$(curl -sH "Content-Type: application/x-www-form-urlencoded" -d "grant_type=urn:ietf:params:oauth:grant-type:token-exchange&requested_token_type=urn:ietf:params:oauth:token-type:access_token&audience=$SA_ID&subject_token=$SA_TOKEN&subject_token_type=urn:ietf:params:oauth:token-type:id_token" -X POST https://auth.yandex.cloud/oauth/token | jq -r '.access_token')
   ```

1. Запросите значение секрета через API, используя IAM-токен в Yandex Cloud:

   ```bash
   SECRET_DATA=$(curl -sH "Authorization: Bearer ${IAMTOKEN}" https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SECRET_ID/payload)
   echo ${SECRET_DATA}
   ```

   Результат:

   ```json
   { "entries": [ { "key": "secret", "textValue": "67cH2£?pO********" } ], "versionId": "e6q8isknpcp7********" }
   ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

* [секрет Yandex Lockbox](../../lockbox/operations/secret-delete.md);
* [бакет Object Storage](../../storage/operations/buckets/delete.md);
* [сервисный аккаунт](../../iam/operations/sa/delete.md).

## Смотрите также {#see-also}

* [Федерации сервисных аккаунтов](../../iam/concepts/workload-identity.md)
* [Доступ к API Yandex Cloud из кластера Managed Service for Kubernetes с помощью федерации сервисных аккаунтов Identity and Access Management](wlif-managed-k8s-integration.md)
* [Получение значения секрета Yandex Lockbox на стороне GitLab](wlif-gitlab-integration.md)
* [Получение значения секрета Yandex Lockbox на стороне GitHub](wlif-github-integration.md)