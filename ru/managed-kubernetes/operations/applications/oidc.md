# Установка OIDC Аутентификация


[OIDC Аутентификация](/marketplace/products/yc/oidc) — приложение для аутентификации пользователей в кластере {{ managed-k8s-name }} с помощью сторонних провайдеров аутентификации, поддерживающих протоколы идентификации [OIDC](https://openid.net/specs/openid-connect-core-1_0.html), [Active Directory](https://docs.microsoft.com/windows-server/identity/ad-ds/active-directory-domain-services), [LDAP](https://ru.wikipedia.org/wiki/LDAP) или [GitHub](https://github.com/). Приложение использует протокол [OAuth 2.0](https://oauth.net/2/) для выпуска токена доступа пользователя по идентификатору и секретному ключу, предоставленному провайдером.

Приложение состоит из двух компонентов:

* Concierge — прокси-сервер для {{ k8s }} API.
* Supervisor — OIDC-сервер авторизации кластера для прокси-сервера.

Приложение использует решение [Pinniped](https://pinniped.dev) для обеспечения работы.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Зарегистрируйте в OIDC-сервере организации нового OAuth-клиента и получите его идентификатор и секретный ключ.

    О том, как получить идентификатор и секретный ключ, см. в [официальной документации по настройке провайдеров идентификации](https://pinniped.dev/docs/howto/supervisor/).

1. [Зарезервируйте](../../../vpc/operations/get-static-ip.md) публичный IP-адрес для сервиса Supervisor с помощью {{ vpc-full-name }}.
1. [Зарегистрируйте](../../../dns/operations/resource-record-create.md) DNS-запись для сервиса Supervisor (обычно это поддомен `supervisor.<ваш_домен>`) с помощью {{ dns-full-name }} и привяжите к ней зарезервированный IP-адрес.
1. [Выпустите](../../../certificate-manager/operations/managed/cert-create.md) сертификат для зарегистрированного домена Supervisor с помощью {{ certificate-manager-full-name }}.
1. Получите содержимое выпущенного сертификата и сохраните его в файл `cert.json`:

   ```bash
   yc certificate-manager certificate content <идентификатор_сертификата> \
     --format json > cert.json
   ```

## Установка OIDC Аутентификация с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [OIDC Аутентификация](/marketplace/products/yc/oidc) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
    * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) `pinniped-concierge`. Приложение использует его по умолчанию. Если вы оставите пространство имен `default`, OIDC Аутентификация может работать некорректно.
    * **Название приложения** — укажите название приложения.
    * **OIDC-домен компании** — укажите URL основного домена вашей организации.
    * **Идентификатор клиента** — укажите идентификатор OAuth-клиента.
    * **Секрет клиента** — укажите секретный ключ OAuth-клиента.
    * **Дополнительные права доступа** — укажите дополнительные права доступа для токена.
    * **Поле в токене с именем пользователя** — укажите название поля, в котором содержится имя пользователя.
    * **Поле в токене с группой** — укажите название поля, в котором содержится группа пользователя.
    * **Домен супервайзера** — укажите [созданный ранее поддомен сервиса Supervisor](#before-you-begin).
    * **IP-адрес супервайзера** — укажите [зарезервированный ранее IP-адрес](#before-you-begin).
    * **Доменный сертификат супервайзера** — вставьте содержимое файла `cert.json`.

1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с приложением OIDC Аутентификация выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_external-secrets.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_oidc-authenticator.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace pinniped-concierge \
     --create-namespace \
     --set domain=<основной_домен_организации> \
     --set client_id=<идентификатор_OAuth-клиента> \
     --set client_secret=<секретный_ключ_OAuth-клиента> \
     --set username_claim=<поле_токена_с_именем_пользователя> \
     --set group_claim=<поле_токена_с_группой> \
     --set domain=<поддомен_сервиса_Supervisor_организации> \
     --set ip=<IP-адрес_поддомена_сервиса_Supervisor> \
     --set additional_scopes=<дополнительные_права_доступа_токена> \
     --set-file certificate=<путь_к_файлу_cert.json> \
     oidc-authenticator ./oidc-authenticator/
   ```

   Эта команда создаст новое пространство имен, необходимое для работы OIDC Аутентификации.

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## Получение доступа к кластеру {#cluster-access}

1. Назначьте роли в кластере, соответствующие пользователю в организации.

   {% cut "Пример назначения роли" %}

   ```yaml
   kind: ClusterRoleBinding
   apiVersion: rbac.authorization.k8s.io/v1
   metadata:
     name: clusterroleall-user
   subjects:
   - kind: User
     name: <user_account_id_в_организации>
   roleRef:
     kind: ClusterRole
     name: <роль_в_кластере>
     apiGroup: rbac.authorization.k8s.io
   ```

   {% endcut %}

1. Выполните действия на компьютере с правами доступа к ресурсам Supervisor в кластере:

    1. [Установите утилиту pinniped-cli](https://pinniped.dev/docs/howto/install-cli/).
    1. Выполните команду для получения публичного конфигурационного файла:

       ```shell
       pinniped get kubeconfig \
         --upstream-identity-provider-flow browser_authcode > public_config.yaml
       ```

       Для провайдеров LDAP и Active Directory в команде используются другие параметры:

       ```shell
       pinniped get kubeconfig \
         --upstream-identity-provider-flow cli_password > public_config.yaml 
       ```

       Подробнее о параметрах команды см. в [официальной документации](https://pinniped.dev/docs/howto/login/).

1. Установите на компьютере сотрудника необходимые ресурсы:

   1. Установите утилиту `pinniped-cli`.
   1. Скопируйте публичную конфигурацию. В файле публичной конфигурации укажите локальный путь к утилите `pinniped-cli` в параметре `users.user.exec.command`.

1. Укажите файл публичной конфигурации при выполнении команд в кластере, например:

   ```shell
   kubectl get namespaces \
     --kubeconfig "$HOME/public_config.yaml"
   ```

   При первом выполнении команды `kubectl` сотрудник будет перенаправлен в браузер для OIDC-аутентификации и выпуска OAuth-токена доступа к кластеру.

   Далее команды `kubectl` выполняются без прохождения аутентификации до истечения срока действия токена доступа.

## См. также {#see-also}

* [Документация Pinniped](https://pinniped.dev/docs/).
