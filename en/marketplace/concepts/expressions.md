---
title: Calculated expressions in resource attribute values
description: In this article, you will learn about calculated expressions in resource attribute values ​​that can be used to set up {{ cloud-apps-name }} product configurations.
---

# Calculated expressions in a {{ cloud-apps-name }} product configuration

When [setting up](../operations/create-configuration.md#configure) a {{ cloud-apps-name }} product configuration, users can use _calculated expressions_ in string values of resource attributes. Such expressions allow you to dynamically generate an attribute value based on calculations, input parameters, and values ​​of other attributes.

## Basic syntax {#basic-syntax}

The expressions are based on [interpolation syntax](https://en.wikipedia.org/wiki/String_interpolation) and support various operators, functions, and filters for data processing.

### Interpolation {#interpolation}

The expressions are enclosed in double curly braces:

```
Hello not_var{{ expression }} world!
```

### Escaping {#escape-characters}

To output the `{{` and `}}` combinations, use the `\` escape character:

* `\{{` outputs `{{`
* `\}}` outputs `}}`

### Basic use cases {#basic-examples}

```yaml
# Simple interpolation
name: "not_var{{ input.environment }}-server"

# Mixed text with expressions
description: "Server for not_var{{ input.environment }} (environment) in not_var{{ input.region }} (region)"

# Escaping
template: "Use \{{ variable \}} to substitute values"
```

## Data types {#data-types}

### Strings {#strings}

String literals are enclosed in single or double quotes:

```
"string in double quotes"
'string in single quotes'
```

### Numbers {#numbers}

```
# Integers
42
-17

# Decimal fractions
3.14
-2.5
```

### Boolean values {#boolean}

```
true
false
```

## Operators {#operators}

### Arithmetic operators {#arithmetics}

* `+`: Addition
* `-`: Subtraction
* `*`: Multiplication
* `/`: Division
* `%`: Remainder of division

```yaml
# Examples
cpu_count: "{{ input.base_cpu + 2 }}"
memory_gb: "{{ input.memory_mb / 1024 }}"
```

### Comparison operators {#relational}

* `==`: Equal to
* `!=`: Not equal to
* `<`: Less than
* `>`: Greater than
* `<=`: Less than or equal to
* `>=`: Greater than or equal to

```yaml
# Example
high_availability: "{{ input.node_count >= 3 }}"
```

### Logical operators {#logical}

* `&&`: Logical `AND`
* `||`: Logical `OR`
* `!`: Logical `NOT`

```yaml
# Examples
enable_backup: "{{ input.environment == 'prod' && input.backup_enabled }}"
use_spot: "{{ input.cost_optimization || input.environment != 'prod' }}"
is_dev: "{{ !input.production }}"
```

### Ternary operator {#ternary}

Conditional operator `condition ? value_if_true : value_if_false`

```yaml
# Examples
instance_type: "{{ input.environment == 'prod' ? 'large' : 'small' }}"
replica_count: "{{ input.high_availability ? 3 : 1 }}"
```

## Variables {#variables}

### Resources {#resources}

Access to attributes of created resources:

```
resource.<resource_type>.<resource_name>.<attribute>
```

```yaml
# Examples
vpc_id: "not_var{{ resource.yandex_vpc_network.main.id }}"
subnet_cidr: "{{ resource.yandex_vpc_subnet.private.v4_cidr_blocks[0] }}"
instance_ip: "not_var{{ resource.yandex_compute_instance.web_server.network_interface.0.nat_ip_address }}"
```

### Data sources {#data-sources}

Access to data source attributes:

```
data.<source_type>.<source_name>.<attribute>
```

```yaml
# Examples
image_id: "not_var{{ data.yandex_compute_image.ubuntu.id }}"
zone_id: "not_var{{ data.yandex_dns_zone.main.zone_id }}"
folder_id: "not_var{{ data.yandex_resourcemanager_folder.current.folder_id }}"
```

### Input parameters {#inputs}

Access to parameters provided by the user:

```
input.<parameter_name>
```

```yaml
# Examples
environment: "not_var{{ input.environment }}"
region: "not_var{{ input.deployment_region }}"
instance_count: "not_var{{ input.replica_count }}"
```

### Artifacts {#artifacts}

Access to artifacts, such as Docker images:

```
artifact.<artifact_name>
```

```yaml
# Examples
container_image: "not_var{{ artifact.web_app_image }}"
deployment_package: "not_var{{ artifact.application_archive }}"
```

### Application attributes {#app-attributes}

Access to system attributes of the current application ({{ cloud-apps-name }} product instance):

* `application.id`: Unique application ID
* `application.folderId`: {{ yandex-cloud }} [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) ID
* `application.serviceAccountId`: [Service account](../../iam/concepts/users/service-accounts.md) ID

```yaml
# Examples
app_id: "not_var{{ application.id }}"
folder_id: "not_var{{ application.folderId }}"
service_account: "not_var{{ application.serviceAccountId }}"
```

### Access chains {#hierarchy-chains}

Complex data structures use access chains. The names of variables are written in [snake_case](https://{{ lang }}.wikipedia.org/wiki/Snake_case) and formed from the field names, e.g., `Folder Id` → `folder_id`.

Use dot notation for access to the attributes of a resource or nested object:

```text
<resource>.<level_1_attribute>.<level_2_attribute>.<...>.<level_n_attribute>
```

Use square bracket notation for access to the elements of an array or map (associative array):

```text
<array>[0].<attribute>["<element>"]
```

```yaml
# Access to nested fields via dot
network_id: "not_var{{ resource.yandex_compute_instance.resources.cores }}"

# Access to array elements via square brackets
first_ip: "{{ resource.yandex_vpc_subnet.public.v4_cidr_blocks[0] }}"
second_ip: "{{ resource.yandex_vpc_subnet.public.v4_cidr_blocks[1] }}"

# Combined access
instance_zone: "{{ resource.yandex_compute_instance_group.web.instances[0].zone_id }}"
```

## Functions {#functions}

### min() {#min}

Returns the minimum value from the list of arguments:

```yaml
# Examples
min_cpu: "not_var{{ min(input.cpu_request, 4, input.cpu_limit) }}"
min_memory: "not_var{{ min(1, input.memory_gb) }}"
```

### max() {#max}

Returns the maximum value from the list of arguments:

```yaml
# Examples
max_cpu: "not_var{{ max(input.cpu_request, 2) }}"
max_replicas: "not_var{{ max(input.min_replicas, 1, input.desired_replicas) }}"
```

## Filters {#filters}

Filters are applied to expressions via `|` and allow transforming data:

### abs {#abs}

Absolute value of the number:

```yaml
positive_value: "not_var{{ input.offset | abs }}"
# input: -5 -> output: 5
```

### base64decode {base64-decode}

Decoding from [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64):

```yaml
decoded_data: "not_var{{ input.encoded_config | base64decode }}"
```

### base64encode {#base64-encode}

Encoding a string to [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64):

```yaml
encoded_data: "not_var{{ input.user_data | base64encode }}"
```

### capitalize {#capitalize}

All words in a string are capitalized without converting the string to lowercase:

```yaml
label: "not_var{{ input.type | capitalize }}"
# input: "dataBase" -> output: "DataBase"
```

### default {#default}

Default:

```yaml
region: "{{ input.region | default('{{ region-id }}-a') }}"
# If input.region is empty or null, '{{ region-id }}-a' will be used
```

### ident {#ident}

Adding spaces to the beginning of a string:

```yaml
value: "not_var{{ input.data | ident(2) }}"
# input: "some: 3" -> output: "  some: 3"
```

### length {#length}

Length of a string or array:

```yaml
name_length: "not_var{{ input.service_name | length }}"
# input: "webapp" -> output: 6
```

### lower {#lower}

Converting a string to lowercase:

```yaml
resource_name: "not_var{{ input.service_name | lower }}"
# input: "WebApp" -> output: "webapp"
```

### replace {#replace}

Replacing a substring:

```yaml
# Replacing spaces with hyphens
safe_name: "{{ input.display_name | replace(' ', '-') | lower }}"
# input: "My Service" -> output: "my-service"
```

### sha256 {#sha256}

Calculating the [SHA256](https://en.wikipedia.org/wiki/SHA-2) hash:

```yaml
config_hash: "not_var{{ input.configuration | sha256 }}"
```

### title {#title}

Converting a string to lowercase, then capitalizing all words:

```yaml
display_name: "not_var{{ input.service_name | title }}"
# input: "weB serVice" -> output: "Web Service"
```

### trim {#trim}

Removing spaces from the beginning and end of a string:

```yaml
clean_name: "not_var{{ input.name | trim }}"
# input: "  app  " -> output: "app"
```

### upper {#upper}

Converting a string to uppercase:

```yaml
env_name: "not_var{{ input.environment | upper }}"
# input: "prod" -> output: "PROD"
```

### Filter chains {#filter-chains}

You can join filters together to form chains:

```yaml
# Combining multiple filters
resource_name: "{{ input.service_name | trim | lower | replace(' ', '-') }}"
# input: "  Web Service  " -> output: "web-service"

# Using default
final_name: "{{ input.custom_name | default('default-app') | upper }}"
# If input.custom_name is empty -> output: "DEFAULT-APP"
```

## Recommendations and limitations {#usage-specifics}

When using expressions in resource names, explicitly add the unique {{ cloud-apps-name }} product ID. This will allow you to install several applications at once into the same user [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) without risking a conflict of resource names.

```yaml
  - type: resource.yandex_compute_instance
    name: web_server
    config:
      name: "my-best-application-not_var{{ application.id }}"
      ...
```

## Practical use cases {#practical-examples}

### VM configuration {#vm-config}

```yaml
  - type: resource.yandex_compute_instance
    name: web_server
    config:
      name: "not_var{{ input.environment }}-web-not_var{{ input.instance_number | default(1) }}-not_var{{ application.id }}"
      hostname: "{{ input.service_name | lower | replace(' ', '-') }}.not_var{{ input.domain }}"
      cores: "not_var{{ min(input.cpu_cores, 2) }}"
      memory: "{{ input.memory_gb * 1024 }}"

      boot_disk:
        image_id: "not_var{{ data.yandex_compute_image.ubuntu.id }}"
        size: "not_var{{ input.disk_size | default(20) }}"

      network_interface:
        subnet_id: "not_var{{ resource.yandex_vpc_subnet.main.id }}"
        nat: "{{ input.environment != 'prod' }}"

      metadata:
        user-data: |
          users:
            - name: not_var{{ input.username }}
              sudo: 'ALL=(ALL) NOPASSWD:ALL'
              shell: /bin/bash
              ssh_authorized_keys:
              - not_var{{ input.public_key  }}

      labels:
        environment: "not_var{{ input.environment }}"
        project: "not_var{{ application.id }}"
        cost-center: "{{ input.cost_center | default('default') | upper }}"
```

### Conditional database configuration {#db-config}

```yaml
  - type: resource.yandex_mdb_postgresql_cluster
    name: main_db
    config:
      name: "not_var{{ input.project_name | lower }}-not_var{{ input.environment }}-db-not_var{{ application.id }}"

      # Instance size depends on the environment
      resources:
        resource_preset_id: "{{ input.environment == 'prod' ? 's3-c8-m32' : 's3-c2-m8' }}"
        disk_size: "{{ input.environment == 'prod' ? 100 : 20 }}"
        disk_type_id: "{{ input.environment == 'prod' ? 'network-ssd' : 'network-hdd' }}"

      # Network
      network_id: "not_var{{ resource.yandex_vpc_network.main.id }}"

      # Access configuration
      config:
        access:
          web_sql: "{{ input.environment == 'dev' }}"
          serverless: "not_var{{ input.enable_functions | default(false) }}"

```

### Configuring security groups {#sg-settings}

```yaml
  - type: resource.yandex_vpc_security_group
    name: web_sg
    config:
      name: "not_var{{ input.project_name }}-web-sg-not_var{{ application.id }}"
      network_id: "not_var{{ resource.yandex_vpc_network.main.id }}"

      ingress:
        # HTTP access
        - protocol: TCP
          port: 80
          v4_cidr_blocks: "{{ input.allow_public_access ? ['0.0.0.0/0'] : input.allowed_cidrs }}"

        # HTTPS access only for prod
        - protocol: TCP
          port: 443
          v4_cidr_blocks: "{{ input.environment == 'prod' ? ['0.0.0.0/0'] : [] }}"

        # SSH access only from certain IPs
        - protocol: TCP
          port: 22
          v4_cidr_blocks: "{{ input.admin_cidrs | default(['10.0.0.0/8']) }}"
```

## Best practices {#best-practices}

### Using default values {#using-default-values}

```yaml
# Always set reasonable default values ​​for fields with optional values
instance_type: "{{ input.instance_type | default('s3-c4-m8') }}"
region: "{{ input.region | default('{{ region-id }}-a') }}"
```

### Value validation {#value-validation}

```yaml
# Use conditional expressions for validation
cpu_cores: "not_var{{ max(min(input.cpu_cores, 32), 1) }}"
memory_gb: "{{ input.memory_gb >= 1 ? input.memory_gb : 1 }}"
```

### Human-readable resource names {#names-make-sense}

```yaml
# Create resource names that make sense
name: "{{ input.project_name | lower | replace(' ', '-') }}-not_var{{ input.environment }}-not_var{{ input.component }}"
```

### Conditional logic for environments {#env-conditioning}

```yaml
# Distinguish configuration by environment
backup_enabled: "{{ input.environment == 'prod' || input.environment == 'staging' }}"
monitoring_level: "{{ input.environment == 'prod' ? 'detailed' : 'basic' }}"
```

### Security {#security}

```yaml
# Limit access based on environment
public_access: "{{ input.environment == 'dev' && input.debug_mode }}"
```