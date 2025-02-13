# Получение значения секрета {{ lockbox-full-name }} на стороне {{ k8s }}

{% include [move-groups-api](../../_includes/iam/wlif-instructions-intro.md) %}

В этом руководстве для примера показано, как получить значение [секрета](../../lockbox/concepts/secret) [{{ lockbox-full-name }}](../../lockbox/) со стороны {{ k8s }} от имени сервисного аккаунта в {{ yandex-cloud }}. Аналогичным образом можно выполнить любое действие через {{ yandex-cloud }} [CLI](../../cli/quickstart.md), [API](../../api-design-guide/index.yaml) или [{{ TF }}]({{ tf-provider-link }}).

{% note warning %}

В данный момент нельзя настроить связь между федерацией сервисных аккаунтов и кластером {{ managed-k8s-full-name }}. Поддерживается только работа с пользовательскими инсталляциями {{ k8s }}.

{% endnote %}

Чтобы получить значение секрета {{ lockbox-name }} от имени аккаунта в {{ k8s }}:

1. [Подготовьте кластер {{ k8s }}](#prepare-k8s-cluster).
1. [Подготовьте облако к работе](#prepare-cloud).
1. [Настройте сценарий в {{ k8s }}](#k8s-workflow).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте кластер {{ k8s }} {#prepare-k8s-cluster}

1. Создайте новый кластер {{ k8s }} или используйте существующий.

   Убедитесь, что ваш кластер соответствует следующим требованиям:

   * Вы используете {{ k8s }} версии 1.20 или новее.
      Более ранние версии {{ k8s }} используют другой формат токенов `ServiceAccount`, который не совместим с инструкциями в этом руководстве.
   * Вы настроили `kube-apiserver` так, чтобы он [поддерживал проекцию токенов `ServiceAccount`](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#serviceaccount-token-volume-projection).

   {% note info %}

   Это руководство подходит как для публично доступных, так и для приватных кластеров {{ k8s }}.

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

   Значения полей `Name` и `Namespace` понадобятся для дальнейшей настройки интеграции на стороне {{ yandex-cloud }}.

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

1. Получите `URL Issuer` вашего {{ k8s }} кластера:

   ```bash
   kubectl get --raw /.well-known/openid-configuration | jq -r .issuer
   ```

1. Создайте файл с набором публичных ключей (JWKS):
   
   ```bash
   kubectl get --raw /openid/v1/jwks > cluster-jwks.json
   ```

## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
1. Плата за хранение [секрета](../../lockbox/concepts/secret.md) и запросы к нему (см. [тарифы {{ lockbox-name }}](../../lockbox/pricing.md));
1. Плата за хранение данных в бакете и операции с ними (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).

### Загрузите файл с набором публичных ключей в публичный бакет

1. Создайте публичный бакет:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
      1. Выберите сервис **{{ objstorage-name }}**.
      1. На панели сверху нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
      1. На странице создания бакета:
         1. Введите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
         
         1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** выберите `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.

         1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}** для завершения операции.

   {% endlist %}

1. Загрузите созданный ранее файл `cluster-jwks.json` в бакет:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Перейдите в созданный бакет.
      1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
      1. Нажмите **{{ ui-key.yacloud.storage.bucket.button_empty-create }}**.
      1. На верхней панели нажмите ![image](../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
      1. В появившемся окне выберите файл `cluster-jwks.json` и нажмите **Открыть**.
      1. Нажмите **{{ ui-key.yacloud.storage.button_upload }}**.
      1. Обновите страницу.

   {% endlist %}

1. Получите ссылку на загруженный файл:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Нажмите на имя файла.
      1. Нажмите ![link](../../_assets/storage/link.svg) **{{ ui-key.yacloud.storage.file.button_generate }}** в правом верхнем углу.
      1. Скопируйте полученную ссылку.

   {% endlist %}

### Создайте федерацию сервисных аккаунтов {#federation-iam-accounts}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать федерацию сервисных аккаунтов.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. На панели слева выберите ![cpus](../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.iam.label_federations }}**.
   1. Нажмите **{{ ui-key.yacloud.iam.label_create-wli-federation }}**.
   1. В поле **{{ ui-key.yacloud.iam.federations.field_issuer }}** введите `URL Issuer` вашего {{ k8s }} кластера, полученный ранее, например `https://kubernetes.default.svc.cluster.local`.
   1. В поле **{{ ui-key.yacloud.iam.federations.field_audiences }}** введите получателя токена, указанного при создании пода, например `ycaud`.
   1. В поле **{{ ui-key.yacloud.iam.federations.field_jwks }}** введите ссылку на файл `cluster-jwks.json` в бакете.
   1. В поле **{{ ui-key.yacloud.iam.federations.field_name }}** введите имя федерации, например `test-iam-federation`.
   1. Нажмите кнопку **{{ ui-key.yacloud_billing.iam.cloud.create.popup-create-cloud_button_add }}**.

{% endlist %}

### Создайте пользовательский секрет

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан секрет.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
   1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета `MY_SECRET`.
   1. Выберите **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}** `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}`.
   1. В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите неконфиденциальный идентификатор, например `secret`.
   1. В поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** введите конфиденциальные данные для хранения.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Создайте сервисный аккаунт

1. Создайте сервисный аккаунт:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Введите имя сервисного аккаунта, например `sa-lockbox`.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   {% endlist %}

1. Назначьте сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) `{{ roles-lockbox-payloadviewer }}` на каталог: 

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. На [стартовой странице]({{ link-console-main }}) консоли управления выберите каталог.
      1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
      1. Найдите аккаунт `sa-lockbox` в списке и нажмите значок ![image](../../_assets/console-icons/ellipsis.svg).
      1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
      1. В открывшемся диалоге нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** и выберите роль `{{ roles-lockbox-payloadviewer }}`.

   {% endlist %}

### Привяжите сервисный аккаунт к Федерации

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором был создан сервисный аккаунт.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. В списке выберите сервисный аккаунт `sa-lockbox`.
   1. Перейдите на вкладку **{{ ui-key.yacloud.iam.label_federations }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.connected-federation.action_connect-federation }}**.
   1. В поле **{{ ui-key.yacloud.iam.connected-federation.field_federation }}** выберите ранее созданную федерацию.
   1. В поле **{{ ui-key.yacloud.iam.connected-federation.field_subject }}** укажите идентификатор внешнего аккаунта `system:serviceaccount:<пространство_имен>:<имя_аккаунта>`.
   
      Где:
      * `пространство_имен` — значение поля `Namespace` в выводе команды `kubectl describe serviceaccount <имя_аккаунта>`, например `default`;
      * `имя_аккаунта` — название созданного аккаунта, например `wlif`.

   1. Нажмите кнопку **{{ ui-key.yacloud.iam.connected-federation.action_connect }}**.

{% endlist %}

## Настройте сценарий в {{ k8s }} { #k8s-workflow }

1. Заполните переменные:

   ```bash
   SA_ID="<идентификатор_сервисного_аккаунта>"
   SECRET_ID="<идентификатор_секрета>"
   ```

   Где:
   * `SA_ID` — идентификатор сервисного аккаунта;
   * `SECRET_ID` — идентификатор пользовательского секрета.

1. Получите токен сервисного аккаунта {{ k8s }}:

   ```bash
   SA_TOKEN=`kubectl exec -it test-wlif -- cat /var/run/secrets/tokens/sa-token`
   ```

1. Обменяйте токен сервисного аккаунта {{ k8s }} на IAM-токен сервисного аккаунта в {{ yandex-cloud }}:
   
   ```bash
   IAMTOKEN=$(curl -sH "Content-Type: application/x-www-form-urlencoded" -d "grant_type=urn:ietf:params:oauth:grant-type:token-exchange&requested_token_type=urn:ietf:params:oauth:token-type:access_token&audience=$SA_ID&subject_token=$SA_TOKEN&subject_token_type=urn:ietf:params:oauth:token-type:id_token" -X POST https://auth.yandex.cloud/oauth/token | jq -r '.access_token')
   ```

1. Запросите значение секрета через API, используя IAM-токен в {{ yandex-cloud }}:

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

* [секрет {{ lockbox-name }}](../../lockbox/operations/secret-delete.md);
* [бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md);
* [сервисный аккаунт](../../iam/operations/sa/delete.md).

## Смотрите также {#see-also}

* [{#T}](../../tutorials/security/wlif-gitlab-integration.md);
* [{#T}](../../tutorials/security/wlif-github-integration.md).