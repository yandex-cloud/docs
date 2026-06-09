# Синхронизация с секретами {{ managed-k8s-full-name }}

С помощью инструмента [External Secrets Operator](https://external-secrets.io/latest/provider/yandex-lockbox/) вы можете настроить синхронизацию [секретов](../concepts/secret.md) [{{ lockbox-name }}](../index.md) с [секретами](../../managed-kubernetes/concepts/encryption.md) [кластера {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

Существует [несколько схем интеграции](https://external-secrets.io/latest/guides/multi-tenancy/) {{ lockbox-name }} с сервисом {{ managed-k8s-name }}. Далее для примера рассматривается схема [ESO as a Service](https://external-secrets.io/latest/guides/multi-tenancy/#eso-as-a-service):

![image](../../_assets/managed-kubernetes/mks-lockbox-eso.svg)

Чтобы настроить синхронизацию секретов:
1. [Установите External Secrets Operator и настройте {{ lockbox-name }}](#install-eso-lockbox).
1. [Настройте кластер {{ managed-k8s-name }}](#configure-k8s).
1. [Создайте External Secret](#create-es).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Также инфраструктуру для синхронизации секретов {{ lockbox-name }} с секретами кластера {{ managed-k8s-name }} можно развернуть через {{ TF }} с помощью готового файла конфигурации. Подробнее см. в подразделе [Создайте инфраструктуру](#deploy-infrastructure) на вкладке {{ TF }}.

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов для синхронизации секретов входит:
* Плата за использование [мастера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master) (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за [вычислительные ресурсы](../../compute/concepts/vm-platforms.md) и [диски](../../compute/concepts/disk.md) [группы узлов {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#node-group) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за хранение и операции с секретом (см. [тарифы {{ lockbox-name }}](../pricing.md)).

### Создайте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

  1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
  1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы кластер {{ managed-k8s-name }} и группа узлов.
  1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):
     * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для ресурсов {{ k8s }} с [ролями](../../iam/concepts/access-control/roles.md) `k8s.clusters.agent` и `vpc.publicAdmin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается кластер {{ managed-k8s-name }}.
     * Сервисный аккаунт для узлов {{ managed-k8s-name }} с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#container-registry-images-puller) на каталог с [реестром](../../container-registry/concepts/registry.md) [Docker-образов](../../container-registry/concepts/docker-image.md). От его имени узлы {{ managed-k8s-name }} будут скачивать из реестра необходимые Docker-образы.

     {% note tip %}

     Вы можете использовать один и тот же сервисный аккаунт для всех операций.

     {% endnote %}

  1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера {{ managed-k8s-name }} и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

  1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md). При создании кластера {{ managed-k8s-name }} укажите ранее созданные сервисные аккаунты для ресурсов и узлов и группы безопасности.

  1. [Создайте секрет](../operations/secret-create.md) {{ lockbox-name }} со следующими параметрами:
     * **{{ ui-key.yacloud.common.name }}** — `lockbox-secret`.
     * **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }}** — введите неконфиденциальный идентификатор `password`.
     * **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_value }}** — введите конфиденциальные данные для хранения `p@$$w0rd`.

     Сохраните идентификатор секрета, он понадобится в дальнейшем.

- {{ TF }} {#tf}

  1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
  1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
  1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.
  1. Скачайте в ту же рабочую директорию файл конфигурации кластера {{ managed-k8s-name }} [k8s-cluster-and-lockbox.tf](https://github.com/yandex-cloud-examples/yc-mk8s-lockbox/blob/main/k8s-cluster-and-lockbox.tf).

     В этом файле описаны:
     * [Сеть](../../vpc/concepts/network.md#network).
     * [Подсеть](../../vpc/concepts/network.md#subnet).
     * Секрет {{ lockbox-name }}.
     * Кластер {{ managed-k8s-name }}.
     * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для ресурсов и узлов {{ managed-k8s-name }}.
     * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../../managed-kubernetes/operations/connect/security-groups.md) для кластера {{ managed-k8s-name }} и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

  1. Укажите в файле конфигурации:
     * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
     * [Версию {{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера {{ managed-k8s-name }} и групп узлов.
     * Имя сервисного аккаунта для ресурсов и узлов {{ managed-k8s-name }}.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
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

     В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

  1. Сохраните выведенный в терминале идентификатор созданного секрета, он понадобится в дальнейшем.

{% endlist %}

### Настройте окружение {#environment-set-up}

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. Установите утилиту `jq`:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

## Установите External Secrets Operator и настройте {{ lockbox-name }} {#install-eso-lockbox}

1. Установите [External Secrets Operator](https://yandex.cloud/ru/marketplace/products/yc/external-secrets) согласно [инструкции](../../managed-kubernetes/operations/applications/external-secrets-operator.md).
1. [Назначьте сервисному аккаунту](../operations/secret-access.md), который вы создали при установке External Secrets Operator, роль `lockbox.payloadViewer` на [созданный ранее](#deploy-infrastructure) секрет `lockbox-secret`.

## Настройте кластер {{ managed-k8s-name }} {#configure-k8s}

1. Создайте [пространство имен](../../managed-kubernetes/concepts/index.md#namespace) `ns`, в котором будут размещены объекты External Secrets Operator:

   ```bash
   kubectl create namespace ns
   ```

1. Создайте секрет `yc-auth` с ключом `sa-key.json`, который вы создали при [установке](#install-eso) External Secrets Operator:

   ```bash
   kubectl --namespace ns create secret generic yc-auth \
     --from-file=authorized-key=sa-key.json
   ```

1. Создайте хранилище секретов [SecretStore](https://external-secrets.io/latest/api/secretstore/), содержащее секрет `yc-auth`:


   ```bash
   kubectl --namespace ns apply -f - <<< '
   apiVersion: external-secrets.io/v1beta1
   kind: SecretStore
   metadata:
     name: secret-store
   spec:
     provider:
       yandexlockbox:
         auth:
           authorizedKeySecretRef:
             name: yc-auth
             key: authorized-key'
   ```


## Создайте External Secret {#create-es}

1. Создайте объект [ExternalSecret](https://external-secrets.io/latest/api/externalsecret/), указывающий на секрет `lockbox-secret` в хранилище `secret-store`:

   ```bash
   kubectl --namespace ns apply -f - <<< '
   apiVersion: external-secrets.io/v1beta1
   kind: ExternalSecret
   metadata:
     name: external-secret
   spec:
     refreshInterval: 1h
     secretStoreRef:
       name: secret-store
       kind: SecretStore
     target:
       name: k8s-secret
     data:
     - secretKey: password
       remoteRef:
         key: <идентификатор_секрета>
         property: password'
   ```

   Где:
   * `key` — идентификатор [созданного ранее](#deploy-infrastructure) секрета {{ lockbox-name }} `lockbox-secret`.
   * `spec.target.name` — имя нового ключа: `k8s-secret`. External Secret Operator создаст этот ключ и поместит в него параметры секрета `lockbox-secret`.
1. Убедитесь, что новый ключ `k8s-secret` содержит значение секрета `lockbox-secret`:

   ```bash
   kubectl --namespace ns get secret k8s-secret \
     --output=json | \
     jq --raw-output '."data"."password"' | \
     base64 --decode
   ```

   В выводе команды будет содержаться значение ключа `password` секрета `lockbox-secret`:

   ```text
   p@$$w0rd
   ```

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. Если вы зарезервировали для кластера {{ managed-k8s-name }} [публичный статический IP-адрес](../../vpc/concepts/address.md#public-addresses), [удалите его](../../vpc/operations/address-delete.md).
  1. [Удалите секрет](../operations/secret-delete.md) `lockbox-secret`.

- {{ TF }} {#tf}

  1. В терминале перейдите в директорию с планом инфраструктуры.
  
      {% note warning %}
  
      Убедитесь, что в директории нет {{ TF }}-манифестов с ресурсами, которые вы хотите сохранить. {{ TF }} удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
  
      {% endnote %}
  
  1. Удалите ресурсы:
  
      1. Выполните команду:
  
          ```bash
          terraform destroy
          ```
  
      1. Подтвердите удаление ресурсов и дождитесь завершения операции.
  
      Все ресурсы, которые были описаны в {{ TF }}-манифестах, будут удалены.

{% endlist %}