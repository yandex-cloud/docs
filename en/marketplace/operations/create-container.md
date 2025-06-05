# Creating a product for {{ managed-k8s-name }}

To add a software product for {{ managed-k8s-name }} in {{ marketplace-short-name }}, upload its packages to the {{ yandex-cloud }} [registry](../../container-registry/concepts/registry.md). This section will help you prepare your {{ marketplace-short-name }} product for {{ managed-k8s-full-name }}.

For more information about setting up [subscription-based](license-manager-integration.md#managed-k8s) product access, see [Integration with the {{ license-manager }} API](../concepts/subscription.md).

You can also create products for {{ compute-full-name }} to run on [Linux](create-image.md) by following the relevant guidelines.

## Hosting and naming images {#registry}

* A [Helm chart](https://helm.sh/docs/topics/charts/) and all its included docker images must be placed in the publisher [registry](../../container-registry/concepts/registry.md) created in {{ container-registry-full-name }}. To learn about [creating a registry](../../container-registry/operations/registry/registry-create.md) and [uploading an image](../../container-registry/operations/docker-image/docker-image-push.md), see the documentation.

* The name of the product's Helm chart should follow the format:

   ```
   {{ registry }}/<registry-id>/<vendor-name>/<product-name>/<chart>
   ```

   Where:

   * `<registry-id>`: Publisher's registry ID.
   * `<vendor-name>`: Names of the product publisher.
   * `<product-name>`: Product names.
   * `<chart>`: Helm chart name.

* The names of the product's docker images should follow the format:

   ```
   {{ registry }}/<registry-id>/<vendor-name>/<product-name>/<component-name>:<tag>
   ```

   Where:

   * `<registry-id>`: Publisher's registry ID.
   * `<vendor-name>`: Names of the product publisher.
   * `<product-name>`: Product names.
   * `<component-name>`: Name of the product component provided as a docker image.
   * `<tag>`: Docker image tag. Do not use the `latest` tag.

During publication, all the images that come with the product are moved from the publisher's registry to the public `yc-marketplace` registry. The whole product hierarchy defined by the publisher is maintained in the process.

> For example, the `{{ registry }}/{{ tf-cloud-id }}/yandex-cloud/prometheus/pushgateway:1.0` image will be published as `{{ registry }}/yc-marketplace/yandex-cloud/prometheus/pushgateway:1.0`.

For more information on using the registry, see [{#T}](../../container-registry/operations/helm-chart/helm-chart-push.md) and [{#T}](../../container-registry/operations/docker-image/docker-image-push.md).

## Helm chart specifics {#special-requirements}

A Helm chart must contain a file named `values.yaml` listing all docker images presented as parameters. The names of Docker images in the `values.yaml` file must start with the `.Values` prefix and refer to images in the publisher's registry to ensure error-free publication and subsequent installation of the product in the user's cluster.

Generic pod specification without parameters:

```yaml
# pod spec
spec:
  containers:
  - image: {{ registry }}/<registry-id>/<vendor-name>/<product-name>/<component-name>:<tag>
```

Pod specification with image name replaced with the YAML path variable described in `values.yaml`:

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

## Manifest {#manifest}

To publish a product, you need a manifest document that describes product deployment parameters. Prepare a manifest and [upload](../../storage/operations/objects/upload.md) it to {{ objstorage-full-name }}.

The manifest uses YAML format and contains the following data:

1. `helm_chart`: Required field. Contains the product's Helm chart name and tag.

   ```yaml
   helm_chart:
     name: {{ registry }}/<registry-id>/<vendor-name>/<product-name>/<chart>
     tag: <tag>
   ```

1. `requirements`: Required field. Required parameters of the cluster where the product will be deployed. This section must include the `k8s_version` parameter that defines the range of supported {{ k8s }} versions.

   ```yaml
   requirements:
     k8s_version: ">=1.18"
   ```

1. `images`: Required field. It contains a list of metadata of the images included in the product. The values of image metadata variables are YAML Path format references to variables from `values.yaml`. Entries can be in one of the following formats:

   * Image name, registry address, and tag are described in separate fields:

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

   * Image name and registry address are described in one field, the tag in a different field:

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

   * The full path to the image is provided:

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

1. `user_values`: Optional parameter. It stands for a list of product variables the user can override while installing or modifying an already installed product via the {{ yandex-cloud }} management console. Each variable is described by the required fields below:
   * `name`: YAML Path of the variable from `values.yaml`.
   * `title`: Short name of the variable, either in Russian or English. The value must start with a capital letter.

     ```yaml
     user_values:
     - name: app.port
       title:
         en: <english_title>
         ru: <russian_title>
     ```
   * `description`: Variable description, either in Russian or English. The value must start with a capital letter.

      ```yaml
      user_values:
        - name: app.port
          title: <Title>
          description:
            en: <English_description>
            ru: <Russian_description>
      ```

   * `required` (optional): *Required* flag. The flag can be set for any variable type except `boolean_value`. The available values are `true` and `false`.

   * Variable type. Legal values:
      * `simple_disabled`. May contain a default value and the enable flag.

        ```yaml
        user_values:
          - name: <name>
            disabled: true
            title: <Title>
            string_value:
              required: true
              default_value: "simple_string_value"
        ```

      * `integer_value`. May contain a default value and a range of valid values.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
            description: <Description>
            integer_value:
              default_value: <default_integer>
              required: true
              restrictions:
                min: <integer_1>
                max: <integer_2>
        ```

      * `boolean_value`. May contain a default value.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
            description: <Description>
            boolean_value:
              default_value: true
        ```

      * `string_selector_value`: String from a pre-defined list. May contain a default value and a list of valid values.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
            description: <Description>
            string_selector_value:
              default_value: <value_1>
              required: true
              values:
                - <value_1>
                - <value_2>
                - <value_3>
        ```

      * `integer_selector_value`: Integer value from a pre-defined list. May contain a default value and a list of valid values.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
            description: <Description>
            integer_selector_value:
              default_value: <integer_1>
              required: true
              values:
                - <integer_1>
                - <integer_2>
                - <integer_3>
        ```

      * `string_value`: May contain a flag and a *secret field*, as well as a value length limit.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
            description: <Description>
            string_value:
              required: true
              secret: true
              length_restrictions:
                min: <min_row_length>
                max: <max_row_length>
        ```

      * `cloudiddisabled`: [Cloud ID](../../resource-manager/concepts/resources-hierarchy.md#cloud) in {{ yandex-cloud }}. If you provide a parameter, the appropriate product field in the management console will not be available for editing and will be automatically pre-filled.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
            cloud_id_value:
              required: true
        ```

      * `cloudid`: Cloud ID in {{ yandex-cloud }} which you can select from the management console.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
            cloud_id_value:
              required: true
        ```

      * `folderid`: [Folder](../../resource-manager/concepts/resources-hierarchy.md#folder) ID.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
            folder_id_value:
              required: true
        ```

      * `clusterid`: [{{ k8s }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) ID.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
            cluster_id_value:
              required: true
        ```

      * `networkid`: {{ vpc-full-name }} [network](../../vpc/concepts/network.md#network) ID.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
            network_id_value:
              required: true
        ```

      * `subnetid`: {{ vpc-name }} [subnet](../../vpc/concepts/network.md#subnet) ID.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
            subnet_id_value:
              required: true
        ```

      * `serviceaccountid`: [Service account](../../iam/concepts/users/service-accounts.md) ID.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
            service_account_id_value:
              required: true
        ```

      * `serviceaccountkey`: Service account's [authorized key](../../iam/concepts/authorization/key.md).

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
            service_account_key_value:
              required: true
        ```

      * `service_account_aws_key_value`: Service account's [static key](../../iam/concepts/authorization/access-key.md) for access to {{ objstorage-name }}. It is delivered in JSON format.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
            description: <Description>
            service_account_aws_key_value:
              required: true
        ```

        To use the value of this field in a helm chart or transmit it in a file during manual installation, add the following code at the end of the `templates/_helpers.tpl` template:

        {% note warning %}

        Make sure to put `_generated` after the `name` field value from the manifest.

        {% endnote %}

        ```
        {{- define "<chart_name>.access_key_id" -}}
        not_var{{- if .Values.saAccessKeyFile -}}
        {{- $key := .Values.saAccessKeyFile | fromJson -}}
        {{- $key.access_key.key_id -}}
        not_var{{- else }}
        {{- .Values.<name_field_value_from_manifest>_generated.accessKeyID -}}
        not_var{{- end }}
        not_var{{- end }}

        {{- define "<chart_name>.access_key_secret" -}}
        not_var{{- if .Values.saAccessKeyFile -}}
        {{- $key := .Values.saAccessKeyFile | fromJson -}}
        {{- $key.secret -}}
        not_var{{- else }}
        {{- .Values.<name_field_value_from_manifest>_generated.secretAccessKey -}}
        not_var{{- end }}
        not_var{{- end }}
        ```

        Example of using values in the `Secret` object template:

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

      * `ciliumvaluedisabled`: Use of the Cilium network policy provider. If you provide a parameter, the appropriate product field in the management console will not be available for editing and will be automatically pre-filled.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
          cilium_value: {}
        ```

      * `ciliumvalue`: Use of the Cilium network policy provider.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
          cilium_value: {}
        ```

      * `kubednsclusteripvaluedisabled`: IP address of the {{ k8s }} cluster. If you provide a parameter, the appropriate product field in the management console will not be available for editing and will be automatically pre-filled.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
          kube_dns_cluster_ip_value:
            required: true
        ```

      * `kubednsclusteripvalue`: IP address of the {{ k8s }} cluster.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
          kube_dns_cluster_ip_value:
            required: true
        ```

      * `loggroupidvalue`: {{ cloud-logging-full-name }} [log group](../../logging/concepts/log-group.md) ID.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
          log_group_id_value:
            required: true
        ```

      * `kmskeyidvalue`: [{{ kms-full-name }} key](../../kms/concepts/key.md) content.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
          kms_key_id_value:
            required: true
        ```

      * `domainvalue`: Domain to host the {{ k8s }} cluster.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
          domain_value:
            required: true
        ```

      * `iamapikeyvalue`: Service account's [API key](../../iam/concepts/authorization/api-key.md) value. It is delivered in JSON format.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
          iam_api_key_value:
            required: true
        ```

      * `storagebucketvalue`: {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md).

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
          storage_bucket_value:
            required: true
        ```

      * `prometheusworkspaceidvalue`: {{ prometheus-name }} workspace name.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
          prometheus_workspace_id_value:
            required: false
        ```

      * `licenseidvalue`: [Subscription](license-manager-integration.md) ID from the {{ license-manager }} API.

        ```yaml
        user_values:
          - name: <name>
            title: <Title>
          license_id_value:
            required: false
        ```

The variable values specified by the user when installing the product in a {{ k8s }} cluster will override the values from the `values.yaml` file.

## Example manifest and corresponding variable file {#examples}

### Manifest {#manifest}

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

# Optional: if set to `true`, the Helm chart and Docker images will not be placed in a public repo.
# This will make the product only installable via Marketplace (and not with `helm install ...`).
private_artifacts: false
```

### values.yaml variable file {#values}

```yaml
# An example of values.yaml related to publisher manifest above.
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
