# Создание продукта для {{ managed-k8s-name }}

Чтобы добавить программный продукт для {{ managed-k8s-name }} в {{ marketplace-short-name }}, его пакеты необходимо загрузить в [реестр](../../container-registry/concepts/registry.md) {{ yandex-cloud }}. Этот раздел поможет подготовить продукт {{ marketplace-short-name }} для {{ managed-k8s-full-name }}. 

Вы также можете создать продукты для {{ compute-full-name }} на базе ОС [Linux](create-image.md), воспользовавшись соответствующими рекомендациями.

## Размещение и именование образов {#registry}

* [Helm chart](https://helm.sh/docs/topics/charts/) продукта и все docker-образы, входящие в него, должны быть размещены в [реестре](../../container-registry/concepts/registry.md) издателя, созданном в {{ container-registry-full-name }}. О том, как [создать реестр](../../container-registry/operations/registry/registry-create.md) и как [загрузить образ](../../container-registry/operations/docker-image/docker-image-push.md), см. в соответствующих разделах документации.

* Имя helm chart продукта должно иметь вид:

   ```
   {{ registry }}/<registry-id>/<vendor-name>/<product-name>/<chart>
   ``` 

   Где:

   * `<registry-id>` — идентификатор реестра издателя;
   * `<vendor-name>` — наименования компании-издателя продукта;
   * `<product-name>` — наименования продукта;
   * `<chart>` — название helm chart.

* Имена docker-образов продукта должны иметь вид:

   ```
   {{ registry }}/<registry-id>/<vendor-name>/<product-name>/<component-name>:<tag>
   ``` 
   
   Где:

   * `<registry-id>` — идентификатор реестра издателя;
   * `<vendor-name>` — наименования компании-издателя продукта;
   * `<product-name>` — наименования продукта;
   * `<component-name>` — наименование компонента продукта, поставляемого в виде docker-образа;
   * `<tag>` — тег docker-образа. Не используйте тег `latest`.

Во время публикации все образы, входящие в продукт, из реестра издателя перемещаются в публично доступный реестр `yc-marketplace`. При этом вся иерархия продукта, определенная издателем, сохраняется.

> Например, образ `{{ registry }}/{{ tf-cloud-id }}/yandex-cloud/prometheus/pushgateway:1.0` будет опубликован под именем `{{ registry }}/yc-marketplace/yandex-cloud/prometheus/pushgateway:1.0`.
 
Подробнее о работе с реестром см. в разделах [{#T}](../../container-registry/operations/helm-chart/helm-chart-push.md) и [{#T}](../../container-registry/operations/docker-image/docker-image-push.md).

## Особенности сборки helm chart {#special-requirements}

Helm chart должен содержать файл `values.yaml`, в котором в виде параметров будут перечислены все используемые docker-образы. Имена docker-образов в файле `values.yaml` должны начинаться с префикса `.Values` и указывать на образы, размещенные в реестре издателя, чтобы публикация и дальнейшая установка продукта в кластере пользователя прошли без ошибок.

Спецификация пода без параметров в общем виде:

```yaml
# pod spec
spec:
  containers:
  - image: {{ registry }}/<registry-id>/<vendor-name>/<product-name>/<component-name>:<tag>
```

Спецификация пода, в котором имя образа заменено на переменную YAML path, описанную в файле `values.yaml`:

```yaml
# pod spec
spec:
  containers:
  - image: {{ .Values.images.pushgateway }}
```

```yaml
# values.yaml
images:
  pushgateway: {{ registry }}/<registry-id>/<vendor-name>/<product-name>/<component-name>:<tag>
```

## Манифест {#manifest}

Для публикации продукта необходим манифест — документ, в котором будут описаны параметры развертывания продукта. Подготовьте манифест и [загрузите](../../storage/operations/objects/upload.md) его в {{ objstorage-full-name }}.

Манифест описывается в формате YAML и содержит следующие данные:

1. `helm_chart` — обязательное поле. Содержит имя и тег helm chart продукта.

   ```yaml
   helm_chart:
     name: {{ registry }}/<registry-id>/<vendor-name>/<product-name>/<chart>
     tag: <tag>
   ```

1. `requirements` — обязательное поле. Обязательные параметры кластера, в котором продукт будет разворачиваться. Раздел должен содержать параметр `k8s_version`, определяющий диапазон поддерживаемых версий {{ k8s }}.

   ```yaml
   requirements:
     k8s_version: ">=1.18"
   ```

1. `images` — обязательное поле. Содержит список метаданных образов, входящих в продукт. Значения переменных параметров метаданных образа — это ссылки в формате YAML Path на переменные из файла `values.yaml`. Записи могут быть оформлены в одном из форматов:
  
   * Имя образа, адрес реестра и тег описаны отдельными полями:

      ```yaml
      images:
      - registry: images.app.image.registry
        name_without_registry: images.app.image.name
        tag: images.app.image.tag
      ```

      ```yaml
      # values.yaml
      images:
        app:
          image:
            registry: "{{ registry }}"
            name: "<registry-id>/<vendor-name>/<product-name>/<component-name>"
            tag: "<tag>"
      ```

   * Имя образа и адрес реестра описаны в одном поле, тег — в другом: 
   
      ```yaml
      images:
        - name_with_registry: images.app.config.image.name
          tag: images.app.config.image.tag
      ```
   
      ```yaml
      # values.yaml
      images:
        app:
          config:
            image:
              name: "{{ registry }}/<registry-id>/<vendor-name>/<product-name>/<component-name>"
              tag: "<tag>"
      ```

   * Описан полный путь до образа:

      ```yaml
      images:
        - full: images.app.image.name
      ```
   
      ```yaml
      # values.yaml
      images:
        app:
          image:
            name: "{{ registry }}/<registry-id>/<vendor-name>/<product-name>/<component-name>:<tag>"
      ```

1. `user_values` — необязательный параметр. Список переменных продукта, которые пользователь может переопределить во время установки или редактирования уже установленного продукта через консоль управления {{ yandex-cloud }}. Каждая переменная описывается обязательными полями:
   * `name` — YAML Path переменной из файла `values.yaml`;
   * `title` — краткое название переменной, может быть на русском и английском языке. Значение должно начинаться с заглавной буквы.
   
     ```yaml
     user_values:
     - name: app.port
       title:
         en: <english_title>
         ru: <заголовок_на_русском>
     ```
   * `description` — описание переменной, может быть на русском и английском языке. Значение должно начинаться с заглавной буквы.

      ```yaml
      user_values:
        - name: app.port
          title: <Заголовок>
          description:
            en: <English_description>
            ru: <Описание_на_русском>
      ```

   * `required` (опционально) — флаг *Обязательно для заполнения*. Может быть установлен в любом типе переменной, кроме `boolean_value`. Доступны значения `true` и `false`.

   * Тип переменной. Доступны значения:
      * `simple_disabled`. Может содержать значение по умолчанию и флаг включения.

        ```yaml
        user_values:
          - name: <название>
            disabled: true
            title: <Заголовок>
            string_value:
              required: true
              default_value: "simple_string_value"
        ```

      * `integer_value`. Может содержать значение по умолчанию и диапазон допустимых значений.

        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
            description: <Описание>
            integer_value:
              default_value: <целое_число_по_умолчанию>
              required: true
              restrictions:
                min: <целое_число_1>
                max: <целое_число_2>
        ```

      * `boolean_value`. Может содержать значение по умолчанию.

        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
            description: <Описание>
            boolean_value:
              default_value: true
        ```

      * `string_selector_value` — строка из определенного списка. Может содержать значение по умолчанию и список допустимых значений.

        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
            description: <Описание>
            string_selector_value:
              default_value: <значение_1>
              required: true
              values:
                - <значение_1>
                - <значение_2>
                - <значение_3>
        ```

      * `integer_selector_value` — целочисленное значение из определенного списка. Может содержать значение по умолчанию и список допустимых значений.

        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
            description: <Описание>
            integer_selector_value:
              default_value: <целое_число_1>
              required: true
              values:
                - <целое_число_1>
                - <целое_число_2>
                - <целое_число_3>
        ```

      * `string_value`. Может содержать флаг и *поле с секретом*, а также ограничение на длину значения.

        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
            description: <Описание>
            string_value:
              required: true
              secret: true
              length_restrictions:
                min: <min_длина_строки>
                max: <max_длина_строки>
        ```

      * `cloudiddisabled` — идентификатор [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) в {{ yandex-cloud }}. Если параметр был передан, соответствующее поле продукта в консоли управления будет недоступно для редактирования и автоматически предзаполнится.

        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
            cloud_id_value:
              required: true
        ```

      * `cloudid` — идентификатор облака в {{ yandex-cloud }}, который можно выбрать из консоли управления.

        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
            cloud_id_value:
              required: true
        ```

      * `folderid` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder).

        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
            folder_id_value:
              required: true
        ```

      * `clusterid` — идентификатор [кластера {{ k8s }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).
  
        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
            cluster_id_value:
              required: true
        ```

      * `networkid` — идентификатор [сети](../../vpc/concepts/network.md#network) {{ vpc-full-name }}.

        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
            network_id_value:
              required: true
        ```
      
      * `subnetid` — идентификатор [подсети](../../vpc/concepts/network.md#subnet) {{ vpc-name }}.

        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
            subnet_id_value:
              required: true
        ```

      * `serviceaccountid` — идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
            service_account_id_value:
              required: true
        ```

      * `serviceaccountkey` — [авторизованный ключ](../../iam/concepts/authorization/key.md) сервисного аккаунта.

        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
            service_account_key_value:
              required: true
        ```

      * `service_account_aws_key_value` — [статический ключ](../../iam/concepts/authorization/access-key.md) сервисного аккаунта для доступа к {{ objstorage-name }}. Передается в формате JSON. 
      
        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
            description: <Описание>
            service_account_aws_key_value:
              required: true
        ```

        Чтобы использовать значение этого поля в helm chart или передавать его в файле при ручной установке, необходимо добавить в конец шаблона `templates/_helpers.tpl` следующий код:

        {% note warning %}

        После значения поля `name` из манифеста обязательно укажите `_generated`.

        {% endnote %}

        ```
        {{- define "<название_чарта>.access_key_id" -}}
        not_var{{- if .Values.saAccessKeyFile -}}
        {{- $key := .Values.saAccessKeyFile | fromJson -}}
        {{- $key.access_key.key_id -}}
        not_var{{- else }}
        {{- .Values.<значение_поля_name_из_манифеста>_generated.accessKeyID -}}
        not_var{{- end }}
        not_var{{- end }}

        {{- define "<название_чарта>.access_key_secret" -}}
        not_var{{- if .Values.saAccessKeyFile -}}
        {{- $key := .Values.saAccessKeyFile | fromJson -}}
        {{- $key.secret -}}
        not_var{{- else }}
        {{- .Values.<значение_поля_name_из_манифеста>_generated.secretAccessKey -}}
        not_var{{- end }}
        not_var{{- end }}
        ```

        Пример использования значений в шаблоне объекта `Secret`:
         
        ```
        apiVersion: v1
        kind: Secret
        metadata:
          name: {{ include "mychart.fullname" . }}
          labels:
            {{- include "mychart.labels" . | nindent 4 }}
        type: Opaque
        data:
          ACCESS_KEY_ID: {{ include "mychart.access_key_id" . | b64enc | quote }}
          SECRET_ACCESS_KEY: {{ include "mychart.access_key_secret" . | b64enc | quote }}
        ```

      * `ciliumvaluedisabled` — использование провайдера сетевых политик Cilium. Если параметр был передан, соответствующее поле продукта в консоли управления будет недоступно для редактирования и автоматически предзаполнится.
      
        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
          cilium_value: {}
        ```

      * `ciliumvalue` — использование провайдера сетевых политик Cilium.
      
        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
          cilium_value: {}
        ```

      * `kubednsclusteripvaluedisabled` — IP-адрес кластера {{ k8s }}. Если параметр был передан, соответствующее поле продукта в консоли управления будет недоступно для редактирования и автоматически предзаполнится.
      
        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
          kube_dns_cluster_ip_value:
            required: true
        ```

      * `kubednsclusteripvalue` — IP-адрес кластера {{ k8s }}.
      
        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
          kube_dns_cluster_ip_value:
            required: true
        ```

      * `loggroupidvalue` — идентификатор [лог-группы](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}.
      
        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
          log_group_id_value:
            required: true
        ```

      * `kmskeyidvalue` — содержимое [ключа {{ kms-full-name }}](../../kms/concepts/key.md).
      
        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
          kms_key_id_value:
            required: true
        ```

      * `domainvalue` — домен, в котором будет расположен кластер {{ k8s }}.
      
        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
          domain_value:
            required: true
        ```

      * `iamapikeyvalue` — значение [API-ключа](../../iam/concepts/authorization/api-key.md) сервисного аккаунта. Передается в формате JSON.
      
        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
          iam_api_key_value:
            required: true
        ```

      * `storagebucketvalue` — [бакет](../../storage/concepts/bucket.md) {{ objstorage-name }}.
      
        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
          storage_bucket_value:
            required: true
        ```

      * `prometheusworkspaceidvalue` — название рабочего пространства {{ prometheus-name }}.
      
        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
          prometheus_workspace_id_value:
            required: false
        ```

      * `licenseidvalue` — идентификатор [подписки](license-manager-integration.md) из {{ license-manager }} API.
      
        ```yaml
        user_values:
          - name: <название>
            title: <Заголовок>
          license_id_value:
            required: false
        ```

Значения переменных, указанные пользователем при установке продукта в кластер {{ k8s }}, будут переопределять значения из файла `values.yaml`.

## Пример манифеста и соответствующего файла переменных {#examples}

### Манифест {#manifest}

```yaml
# Link to helm chart in publisher registry.
helm_chart:
  name: {{ registry }}/{{ tf-cloud-id }}/Vendor/Product/chart
  tag: 1.0-0

# Required parameters.
requirements:
  k8s_version: ">=1.18"

images:
  - registry: app1.image.registry
    name_without_registry: app1.image.name
    tag: app1.image.tag
  - name_with_registry: app2.config.image.name
    tag: app2.config.image.tag
  - full: another-whatever-key.subkey.name

# Configurable parameters that might be changed by end user during installation of product. Should be presented in values.yaml
# Supported types: integer, boolean, string, string selector, integer selector.
user_values:
  - name: app.port
    title:
      en: Application port
      ru: Порт приложения
    description:
      en: Port that application will listen to
      ru: Порт, на котором приложение принимает входящие запросы
    integer_value:
      default_value: 8080
      required: true
      restrictions:
        min: 8000
        max: 9000
  - name: app.tls.use
    title:
      en: TLS
      ru: TLS
    description:
      en: Use TLS
      ru: Использовать TLS
    boolean_value:
      default_value: true
  - name: app.admin.password
    title:
      en: Admin password
      ru: Пароль администратора
    description:
      en: Password of administrator, should be at least 8 symbols
      ru: Пароль администратора, должен быть длиной не менее 8 символов
    string_value:
      required: true
      secret: true
      length_restrictions:
        min: 8
        max: 20
  - name: app.selector.string
    title:
      en: Custom string selector
      ru: Строковая опция
    description:
      en: One value string selector
      ru: Выбор одного строкового значения
    string_selector_value:
      default_value: opt1
      required: true
      values:
        - opt1
        - opt2
        - opt3
  - name: app.selector.integer
    title:
      en: Custom integer selector
      ru: Числовая опция
    description:
      en: One value integer selector
      ru: Выбор одного integer значения
    integer_selector_value:
      default_value: 1
      required: true
      values:
        - 1
        - 2
        - 3
```

### Файл переменных values.yaml {#values}

```yaml
# An example of values.xml related to publisher manifest above.
replicaCount: 1
podAnnotations: {}
podSecurityContext: {}
...
app1:
  image:
    registry: {{ registry }}/{{ tf-cloud-id }}/
    name: service-images/application-1
    tag: 1.0
app2:
  name: application-name
  config:
    # image can be declared on any level
    image:
      name: {{ registry }}/{{ tf-cloud-id }}/service-images/application-2
      tag: 2.0
    pullPolicy: IfNotPresent
another-whatever-key: # key name is not fixed
  subkey:
    name: {{ registry }}/{{ tf-cloud-id }}/service-images/application-3:3.0
...

# values
app:
  port: 80
  tls:
    use: true
  admin:
    password: ""
  selector:
    string: "opt1"
    integer: 1
```
