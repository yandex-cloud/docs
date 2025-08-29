---
title: Вычисляемые выражения в значениях атрибутов ресурсов
description: Из статьи вы узнаете о вычисляемых выражениях в значениях атрибутов ресурсов, которые можно использовать при настройке конфигураций продуктов {{ cloud-apps-name }}.
---

# Вычисляемые выражения в конфигурации продукта {{ cloud-apps-name }}

При [настройке](../operations/create-configuration.md#configure) конфигурации продукта {{ cloud-apps-name }} в строковых значениях атрибутов ресурсов пользователи могут использовать _вычисляемые выражения_. Такие выражения позволяют динамически формировать значение атрибута на основе вычислений, входных параметров и значений других атрибутов.

## Базовый синтаксис {#basic-syntax}

Выражения основаны на [синтаксисе интерполяции](https://en.wikipedia.org/wiki/String_interpolation) и поддерживают различные операторы, функции и фильтры для обработки данных.

### Интерполяция {#interpolation}

Выражения заключаются в двойные фигурные скобки:

```
Привет {{ выражение }} мир!
```

### Экранирование {#escape-characters}

Для вывода сочетаний символов `{{` и `}}` используется экранирование — символ `\`:

* `\{{` выводит `{{`;
* `\}}` выводит `}}`.

### Примеры базового использования {#basic-examples}

```yaml
# Простая интерполяция
name: "not_var{{ input.environment }}-server"

# Смешанный текст с выражениями
description: "Сервер для окружения not_var{{ input.environment }} в регионе not_var{{ input.region }}"

# Экранирование
template: "Используйте \{{ variable \}} для подстановки значений"
```

## Типы данных {#data-types}

### Строки {#strings}

Строковые литералы заключаются в одинарные или двойные кавычки:

```
"строка в двойных кавычках"
'строка в одинарных кавычках'
```

### Числа {#numbers}

```
# Целые числа
42
-17

# Десятичные дроби
3.14
-2.5
```

### Булевы значения {#boolean}

```
true
false
```

## Операторы {#operators}

### Арифметические операторы {#arithmetics}

* `+` — сложение;
* `-` — вычитание;
* `*` — умножение;
* `/` — деление;
* `%` — остаток от деления.

```yaml
# Примеры
cpu_count: "{{ input.base_cpu + 2 }}"
memory_gb: "{{ input.memory_mb / 1024 }}"
```

### Операторы сравнения {#relational}

* `==` — равно;
* `!=` — не равно;
* `<` — меньше;
* `>` — больше;
* `<=` — меньше или равно;
* `>=` — больше или равно.

```yaml
# Пример
high_availability: "{{ input.node_count >= 3 }}"
```

### Логические операторы {#logical}

* `&&` — логическое `И`;
* `||` — логическое `ИЛИ`;
* `!` — логическое `НЕ`.

```yaml
# Примеры
enable_backup: "{{ input.environment == 'prod' && input.backup_enabled }}"
use_spot: "{{ input.cost_optimization || input.environment != 'prod' }}"
is_dev: "{{ !input.production }}"
```

### Тернарный оператор {#ternary}

Условный оператор `условие ? значение_если_истина : значение_если_ложь`:

```yaml
# Примеры
instance_type: "{{ input.environment == 'prod' ? 'large' : 'small' }}"
replica_count: "{{ input.high_availability ? 3 : 1 }}"
```

## Переменные {#variables}

### Ресурсы {#resources}

Доступ к атрибутам созданных ресурсов:

```
resource.<тип_ресурса>.<имя_ресурса>.<атрибут>
```

```yaml
# Примеры
vpc_id: "not_var{{ resource.yandex_vpc_network.main.id }}"
subnet_cidr: "{{ resource.yandex_vpc_subnet.private.v4_cidr_blocks[0] }}"
instance_ip: "not_var{{ resource.yandex_compute_instance.web_server.network_interface.0.nat_ip_address }}"
```

### Источники данных (Data Sources) {#data-sources}

Доступ к атрибутам источников данных:

```
data.<тип_источника>.<имя_источника>.<атрибут>
```

```yaml
# Примеры
image_id: "not_var{{ data.yandex_compute_image.ubuntu.id }}"
zone_id: "not_var{{ data.yandex_dns_zone.main.zone_id }}"
folder_id: "not_var{{ data.yandex_resourcemanager_folder.current.folder_id }}"
```

### Входные параметры {#inputs}

Доступ к параметрам, переданным пользователем:

```
input.<имя_параметра>
```

```yaml
# Примеры
environment: "not_var{{ input.environment }}"
region: "not_var{{ input.deployment_region }}"
instance_count: "not_var{{ input.replica_count }}"
```

### Артефакты {#artifacts}

Доступ к артефактам (например, Docker-образам):

```
artifact.<имя_артефакта>
```

```yaml
# Примеры
container_image: "not_var{{ artifact.web_app_image }}"
deployment_package: "not_var{{ artifact.application_archive }}"
```

### Атрибуты приложения {#app-attributes}

Доступ к системным атрибутам текущего приложения (экземпляра продукта {{ cloud-apps-name }}):

* `application.id` — уникальный идентификатор приложения;
* `application.folderId` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) {{ yandex-cloud }};
* `application.serviceAccountId` — идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

```yaml
# Примеры
app_id: "not_var{{ application.id }}"
folder_id: "not_var{{ application.folderId }}"
service_account: "not_var{{ application.serviceAccountId }}"
```

### Цепочки доступа {#hierarchy-chains}

Для сложных структур данных используются цепочки доступа. Имена переменных пишутся в [snake_case](https://{{ lang }}.wikipedia.org/wiki/Snake_case) и формируются из названий полей. Например: `Folder Id` → `folder_id`.

Для доступа к атрибутам ресурса или вложенного объекта используется запись через точку:

```text
<ресурс>.<атрибут_уровня_1>.<атрибут_уровня_2>.<...>.<атрибут_уровня_n>
```

Для доступа к элементам массива или карты (ассоциативного массива) используется запись с квадратными скобками:

```text
<массив>[0].<атрибут>["<элемент>"]
```

```yaml
# Доступ к вложенным полям через точку
network_id: "not_var{{ resource.yandex_compute_instance.resources.cores }}"

# Доступ к элементам массива через квадратные скобки
first_ip: "{{ resource.yandex_vpc_subnet.public.v4_cidr_blocks[0] }}"
second_ip: "{{ resource.yandex_vpc_subnet.public.v4_cidr_blocks[1] }}"

# Комбинированный доступ
instance_zone: "{{ resource.yandex_compute_instance_group.web.instances[0].zone_id }}"
```

## Функции {#functions}

### min() {#min}

Возвращает минимальное значение из списка аргументов:

```yaml
# Примеры
min_cpu: "not_var{{ min(input.cpu_request, 4, input.cpu_limit) }}"
min_memory: "not_var{{ min(1, input.memory_gb) }}"
```

### max() {#max}

Возвращает максимальное значение из списка аргументов:

```yaml
# Примеры
max_cpu: "not_var{{ max(input.cpu_request, 2) }}"
max_replicas: "not_var{{ max(input.min_replicas, 1, input.desired_replicas) }}"
```

## Фильтры {#filters}

Фильтры применяются к выражениям через символ `|` и позволяют преобразовывать данные:

### abs {#abs}

Абсолютное значение числа:

```yaml
positive_value: "not_var{{ input.offset | abs }}"
# input: -5 -> output: 5
```

### base64decode {base64-decode}

Декодирование из [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64):

```yaml
decoded_data: "not_var{{ input.encoded_config | base64decode }}"
```

### base64encode {#base64-encode}

Кодирование строки в [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64):

```yaml
encoded_data: "not_var{{ input.user_data | base64encode }}"
```

### capitalize {#capitalize}

Все слова в строке с заглавной буквы без преобразования строки в нижний регистр:

```yaml
label: "not_var{{ input.type | capitalize }}"
# input: "dataBase" -> output: "DataBase"
```

### default {#default}

Значение по умолчанию:

```yaml
region: "{{ input.region | default('{{ region-id }}-a') }}"
# Если input.region не заполнен или null, будет использовано '{{ region-id }}-a'
```

### ident {#ident}

Добавление пробелов в начало строки:

```yaml
value: "not_var{{ input.data | ident(2) }}"
# input: "some: 3" -> output: "  some: 3"
```

### length {#length}

Длина строки или массива:

```yaml
name_length: "not_var{{ input.service_name | length }}"
# input: "webapp" -> output: 6
```

### lower {#lower}

Преобразование строки в нижний регистр:

```yaml
resource_name: "not_var{{ input.service_name | lower }}"
# input: "WebApp" -> output: "webapp"
```

### replace {#replace}

Замена подстроки:

```yaml
# Заменить пробелы на дефисы
safe_name: "{{ input.display_name | replace(' ', '-') | lower }}"
# input: "My Service" -> output: "my-service"
```

### sha256 {#sha256}

Вычисление хеша [SHA256](https://ru.wikipedia.org/wiki/SHA-2):

```yaml
config_hash: "not_var{{ input.configuration | sha256 }}"
```

### title {#title}

Преобразование строки в нижний регистр, затем все слова с заглавной буквы:

```yaml
display_name: "not_var{{ input.service_name | title }}"
# input: "weB serVice" -> output: "Web Service"
```

### trim {#trim}

Удаление пробелов в начале и конце строки:

```yaml
clean_name: "not_var{{ input.name | trim }}"
# input: "  app  " -> output: "app"
```

### upper {#upper}

Преобразование строки в верхний регистр:

```yaml
env_name: "not_var{{ input.environment | upper }}"
# input: "prod" -> output: "PROD"
```

### Цепочки фильтров {#filter-chains}

Фильтры можно объединять в цепочки:

```yaml
# Комбинирование нескольких фильтров
resource_name: "{{ input.service_name | trim | lower | replace(' ', '-') }}"
# input: "  Web Service  " -> output: "web-service"

# С использованием default
final_name: "{{ input.custom_name | default('default-app') | upper }}"
# Если input.custom_name пустой -> output: "DEFAULT-APP"
```

## Особенности использования {#usage-specifics}

При использовании выражений в именах ресурсов необходимо явно добавлять уникальный идентификатор продукта {{ cloud-apps-name }}. Это позволит установить в один [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) пользователя одновременно несколько приложений, не рискуя спровоцировать конфликт в именах ресурсов.

```yaml
  - type: resource.yandex_compute_instance
    name: web_server
    config:
      name: "my-best-application-not_var{{ application.id }}"
      ...
```

## Примеры практического использования {#practical-examples}

### Конфигурация виртуальной машины {#vm-config}

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

### Условная конфигурация базы данных {#db-config}

```yaml
  - type: resource.yandex_mdb_postgresql_cluster
    name: main_db
    config:
      name: "not_var{{ input.project_name | lower }}-not_var{{ input.environment }}-db-not_var{{ application.id }}"

      # Размер инстанса зависит от окружения
      resources:
        resource_preset_id: "{{ input.environment == 'prod' ? 's3-c8-m32' : 's3-c2-m8' }}"
        disk_size: "{{ input.environment == 'prod' ? 100 : 20 }}"
        disk_type_id: "{{ input.environment == 'prod' ? 'network-ssd' : 'network-hdd' }}"

      # Сеть
      network_id: "not_var{{ resource.yandex_vpc_network.main.id }}"

      # Конфигурация доступа
      config:
        access:
          web_sql: "{{ input.environment == 'dev' }}"
          serverless: "not_var{{ input.enable_functions | default(false) }}"

```

### Настройка групп безопасности {#sg-settings}

```yaml
  - type: resource.yandex_vpc_security_group
    name: web_sg
    config:
      name: "not_var{{ input.project_name }}-web-sg-not_var{{ application.id }}"
      network_id: "not_var{{ resource.yandex_vpc_network.main.id }}"

      ingress:
        # HTTP доступ
        - protocol: TCP
          port: 80
          v4_cidr_blocks: "{{ input.allow_public_access ? ['0.0.0.0/0'] : input.allowed_cidrs }}"

        # HTTPS доступ только для prod
        - protocol: TCP
          port: 443
          v4_cidr_blocks: "{{ input.environment == 'prod' ? ['0.0.0.0/0'] : [] }}"

        # SSH доступ только с определенных IP
        - protocol: TCP
          port: 22
          v4_cidr_blocks: "{{ input.admin_cidrs | default(['10.0.0.0/8']) }}"
```

## Лучшие практики {#best-practices}

### Использование значений по умолчанию {#using-default-values}

```yaml
# Всегда задавайте разумные значения по умолчанию для полей с необязательными значениями
instance_type: "{{ input.instance_type | default('s3-c4-m8') }}"
region: "{{ input.region | default('{{ region-id }}-a') }}"
```

### Валидация значений {#value-validation}

```yaml
# Используйте условные выражения для валидации
cpu_cores: "not_var{{ max(min(input.cpu_cores, 32), 1) }}"
memory_gb: "{{ input.memory_gb >= 1 ? input.memory_gb : 1 }}"
```

### Человекочитаемые имена ресурсов {#names-make-sense}

```yaml
# Создавайте понятные имена ресурсов
name: "{{ input.project_name | lower | replace(' ', '-') }}-not_var{{ input.environment }}-not_var{{ input.component }}"
```

### Условная логика для окружений {#env-conditioning}

```yaml
# Различайте конфигурацию по окружениям
backup_enabled: "{{ input.environment == 'prod' || input.environment == 'staging' }}"
monitoring_level: "{{ input.environment == 'prod' ? 'detailed' : 'basic' }}"
```

### Безопасность {#security}

```yaml
# Ограничивайте доступ в зависимости от окружения
public_access: "{{ input.environment == 'dev' && input.debug_mode }}"
```