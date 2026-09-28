---
title: Получение информации о субъектах в системе управления доступом {{ yandex-cloud }}
description: 'Из этой инструкции вы узнаете, как использовать функциональность получения информации о субъектах для поиска и получения атрибутов любых субъектов в системе управления доступом {{ yandex-cloud }}: пользователей, сервисных аккаунтов, групп пользователей, системных и публичных групп.'
---

# Получение информации о субъектах в системе управления доступом {{ yandex-cloud }}

{{ iam-full-name }} предоставляет функциональность [получения информации о субъектах](../concepts/subject-details.md) для поиска и получения атрибутов различных типов субъектов системы управления доступом {{ yandex-cloud }} в [организации](*organization).

[Роли](../concepts/access-control/roles.md), необходимые для получения информации о субъектах, зависят от целевого [типа субъектов](../concepts/subject-details.md#subject-types):

* Пользователи — [роль](../../organization/security/index.md#organization-manager-users-viewer) `organization-manager.users.viewer` или выше на организацию.
* [Сервисные аккаунты](../concepts/users/service-accounts.md) — [роль](../security/index.md#iam-auditor) `iam.auditor` или выше на организацию.
* [Группы пользователей](../../organization/concepts/groups.md), [системные](../concepts/access-control/system-group.md) и [публичные](../concepts/access-control/public-group.md) группы — [роль](../../organization/security/index.md#organization-manager-groups-viewer) `organization-manager.groups.viewer` или выше на организацию.
* Пользователи с аккаунтом на Яндексе, которые были [приглашены](../../organization/operations/add-account.md#send-invitation) в организацию, но еще не приняли приглашение — [роль](../../organization/security/index.md#organization-manager-users-viewer) `organization-manager.users.viewer` или выше на организацию.

## Получить список субъектов {subject-list}

Чтобы получить список [субъектов](../concepts/subject-details.md#subject-types) организации:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. Посмотрите описание команды CLI для получения списка субъектов организации:

      ```bash
      yc iam subject-details list --help
      ```
  1. {% include [get-federation-id-cli](../../_includes/organization/get-federation-id-cli.md) %}
  1. Получите список субъектов:

      ```bash
      yc iam subject-details list \
        --organization-id <идентификатор_организации> \
        --field-mask <список_атрибутов> \
        --filter '(<фильтрующее_CEL-выражение>)' \
        --limit <количество_субъектов> \
        --format yaml
      ```

      Где:
      * `--organization-id` — идентификатор организации, список субъектов которой вы хотите получить.
      * `--field-mask` — маска субъектов, то есть список [атрибутов](../concepts/subject-details.md#attributes), которые вы хотите получить. Для разных типов субъектов доступны разные наборы атрибутов.
      
          Например, чтобы вывести в списке даты создания, адреса электронной почты и фамилии пользователей, укажите в этом параметре `created_at,user_account.email,user_account.family_name`.

          Необязательный параметр. По умолчанию, независимо от значения параметра `--field-mask`, в списке выводятся идентификаторы и типы субъектов.
      * `--filter` — [фильтрующее выражение](../concepts/subject-details.md#filter) на языке [Common Expression Language (CEL)](https://cel.dev/).

          Например, чтобы вывести только список локальных пользователей, в профилях которых заполнено поле `{{ ui-key.yacloud_org.entity.user.caption.email }}` и адрес электронной почты которых содержит имя `ivan`, укажите в этом параметре:

          ```text
          '(subject.type in [1] && 
          has(subject.user_account.email) && 
          subject.user_account.email.icontains("ivan"))'
          ```

          {% note info %}

          Функция `icontains` позволяет выполнять регистронезависимую проверку вхождения подстроки в строку.

          {% endnote %}

          Необязательный параметр. По умолчанию фильтры к результатам не применяются.
      * `--limit` — ограничение на количество субъектов в списке с результатами. Необязательный параметр. По умолчанию — `1000`.
      * `--format` — чтобы получить результат с атрибутами, отличными от значений по умолчанию, используйте формат вывода `json` или `yaml`.

      Результат:

      ```text
      - sub: ek09f4kjk3mk********
        type: USER_ACCOUNT
        created_at: "2026-09-23T16:54:03.297124Z"
        user_account:
          family_name: Иванов
          email: Sergey-Ivanov@example.com
      - sub: ek0ogbhh6o3p********
        type: USER_ACCOUNT
        created_at: "2026-09-23T16:55:42.318668Z"
        user_account:
          family_name: Сергеев
          email: IVANsergeev@example.com
      ```

- API {#api}

  Воспользуйтесь методом REST API [list](../api-ref/SubjectDetails/list.md) для ресурса [SubjectDetails](../api-ref/SubjectDetails/index.md) или вызовом gRPC API [SubjectDetailsService/List](../api-ref/grpc/SubjectDetails/list.md).

  {% include [subject-details-short-api-filter-tip](../../_includes/iam/subject-details-short-api-filter-tip.md) %}

{% endlist %}


### Примеры {#list-examples}

#### Получить список всех субъектов, созданных позднее определенной даты {#list-creation-date}

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  ```bash
  yc iam subject-details list \
    --organization-id bpf2c65rqcl8******** \
    --field-mask created_at \
    --filter '(subject.created_at >= timestamp("2026-09-01T00:00:00Z"))' \
    --format yaml
  ```

  {% cut "Результат" %}


  ```text
  - sub: aje7gcq7usen********
    type: SERVICE_ACCOUNT
    created_at: "2026-09-24T07:26:05.813707Z"
  - sub: ek09f4kjk3mk********
    type: USER_ACCOUNT
    created_at: "2026-09-23T16:54:03.297124Z"
  - sub: ek0ogbhh6o3p********
    type: USER_ACCOUNT
    created_at: "2026-09-23T16:55:42.318668Z"
  ```

  {% endcut %}

{% endlist %}

#### Получить список с именами сервисных аккаунтов в определенных каталогах {#list-sa-in-folder}

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  ```bash
  yc iam subject-details list \
    --organization-id bpf2c65rqcl8******** \
    --field-mask name,service_account.folder.id \
    --filter '(subject.service_account.folder.id in ["b1gkd6dks6i1********", "b1gfq9pe6rd2********"])' \
    --format yaml
  ```

  {% cut "Результат" %}

  ```text
  - sub: aje8ibek25c6********
    type: SERVICE_ACCOUNT
    name: sa-sd
    service_account:
      folder:
        id: b1gkd6dks6i1********
  - sub: ajepodjpcifj********
    type: SERVICE_ACCOUNT
    name: sa-lockbox
    service_account:
      folder:
        id: b1gfq9pe6rd2********
  - sub: ajet9uglmjir********
    type: SERVICE_ACCOUNT
    name: sample-sa
    service_account:
      folder:
        id: b1gkd6dks6i1********
  ```

  {% endcut %}

{% endlist %}

#### Получить список со статусами локальных пользователей, в профилях которых не указан номер телефона {#list-users-no-phone}

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  ```bash
  yc iam subject-details list \
    --organization-id bpf2c65rqcl8******** \
    --field-mask status \
    --filter '(subject.user_account.subject_container.container_type == 4 && 
              !has(subject.user_account.phone_number))' \
    --format yaml
  ```

  {% cut "Результат" %}

  ```text
  - sub: aje3i1gq49n3********
    type: USER_ACCOUNT
    status: ACTIVE
  - sub: ajejij9f440p********
    type: USER_ACCOUNT
    status: ACTIVE
  - sub: ajejvne736i3********
    type: USER_ACCOUNT
    status: ACTIVE
  - sub: ek09f4kjk3mk********
    type: USER_ACCOUNT
    status: SUSPENDED
  ```

  {% endcut %}

{% endlist %}


## Получить атрибуты отдельных субъектов {subject-details-get}

Чтобы получить атрибуты отдельных [субъектов](../concepts/subject-details.md#subject-types) организации:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. Посмотрите описание команды CLI для получения атрибутов отдельных субъектов организации:

      ```bash
      yc iam subject-details get --help
      ```
  1. Получите информацию о субъектах:

      ```bash
      yc iam subject-details get \
        --subject-ids <список_идентификаторов> \
        --field-mask <список_атрибутов> \
        --filter '(<фильтрующее_CEL-выражение>)' \
        --format yaml \
        --organization-id <идентификатор_организации>
      ```

      Где:
      * `--subject-ids` — список идентификаторов субъектов, атрибуты которых вы хотите получить. Несколько значений указываются через запятую. Например: `ek09f4kjk3mk********,ek0ogbhh6o3p********`.
      * `--field-mask` — маска субъектов, то есть список [атрибутов](../concepts/subject-details.md#attributes), которые вы хотите получить. Для разных типов субъектов доступны разные наборы атрибутов.
      
          Например, чтобы получить адреса электронной почты и полные наборы данных о месте работы пользователей, укажите в этом параметре `user_account.email,user_account.job_info`.

          Необязательный параметр. По умолчанию, независимо от значения параметра `--field-mask`, в списке выводятся идентификаторы и типы субъектов.
      * `--filter` — [фильтрующее выражение](../concepts/subject-details.md#filter) на языке [Common Expression Language (CEL)](https://cel.dev/).

          Например, чтобы команда вывела только тех пользователей, в профилях которых заполнены поля в разделе `{{ ui-key.yacloud_org.my-account.ProfilePage.job_info_subheader }}`, укажите в этом параметре:

          ```text
          '(has(subject.user_account.job_info))'
          ```

          Необязательный параметр. По умолчанию фильтры к результатам не применяются.
      * `--format` — чтобы получить результат с атрибутами, отличными от значений по умолчанию, используйте формат вывода `json` или `yaml`.
      * `--organization-id` — [идентификатор организации](../../organization/operations/organization-get-id.md), к которой относятся искомые субъекты.

          Необязательный параметр. Указывайте идентификатор организации в случаях, когда без него получить информацию невозможно. 

          {% note tip %}

          Например, идентификатор организации необходим при попытке получить список групп, в которых состоит пользователь организации с аккаунтом на Яндексе. Необходимость явно указывать организацию связана с тем, что такой пользователь может состоять одновременно в нескольких разных организациях.

          {% endnote %}

      Результат:

      ```text
      - sub: ek09f4kjk3mk********
        type: USER_ACCOUNT
        user_account:
          email: Sergey-Ivanov@example.com
          job_info:
            company_name: Top Company
            department: Accounting
            job_title: Senior Accountant
            employee_id: "456"
      - sub: ek0ogbhh6o3p********
        type: USER_ACCOUNT
        user_account:
          email: IVANsergeev@example.com
          job_info:
            company_name: Top Company
            department: IT
            job_title: DevOps engineer
            employee_id: "123"
      ```

- API {#api}

  Воспользуйтесь методом REST API [batchGet](../api-ref/SubjectDetails/batchGet.md) для ресурса [SubjectDetails](../api-ref/SubjectDetails/index.md) или вызовом gRPC API [SubjectDetailsService/BatchGet](../api-ref/grpc/SubjectDetails/batchGet.md).

  {% include [subject-details-short-api-filter-tip](../../_includes/iam/subject-details-short-api-filter-tip.md) %}

{% endlist %}

### Примеры {#get-examples}

#### Получить список групп, участником которых является пользователь {#get-user-groups}

{% list tabs group=instructions %}

- CLI {#cli}

  {% note info %}

  Чтобы получить список групп для пользователя с аккаунтом на Яндексе, передайте в команде идентификатор организации.

  {% endnote %}

  Выполните команду:

  ```bash
  yc iam subject-details get \
    --subject-ids ajei280a73vc******** \
    --field-mask groups \
    --organization-id bpf2c65rqcl8******** \
    --format yaml
  ```

  {% cut "Результат" %}

  ```text
  sub: ajei280a73vc********
  type: USER_ACCOUNT
  groups:
    - id: ajeql2iqn9d1********
      name: sample-group
      type: EXPLICIT
    - id: allUsers
      name: All users
      type: PUBLIC_ACCESS
    - id: allAuthenticatedUsers
      name: All authenticated users
      type: PUBLIC_ACCESS
    - id: group:organization:bpf2c65rqcl8********:users
      name: All users in organization Test Organization
      type: META
  ```

  {% endcut %}

{% endlist %}

#### Получить все имеющиеся атрибуты пользователей {#get-all-user-attributes}

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  ```bash
  yc iam subject-details get \
    --subject-ids aje3b3juqevc********,ek0ogbhh6o3p********,ajei280a73vc******** \
    --field-mask created_at,status,name,last_authenticated_at,external_id,user_account \
    --format yaml
  ```

  {% cut "Результат" %}

  ```text
  - sub: aje3b3juqevc********
    type: USER_ACCOUNT
    created_at: "2025-08-03T18:38:44.195748Z"
    status: ACTIVE
    user_account:
      preferred_username: sample-federated-user
      subject_container:
        id: bpfsuecgv39i********
        name: sample-federation
        container_type: SAML
      last_id_proof_at: "2025-08-03T18:38:44.195748Z"
      modified_at: "2025-08-03T18:38:44.195748Z"
    external_id: sample-federated-user
  - sub: ek0ogbhh6o3p********
    type: USER_ACCOUNT
    created_at: "2026-09-23T16:55:42.318668Z"
    status: ACTIVE
    name: Иван Сергеев
    user_account:
      given_name: Иван
      family_name: Сергеев
      preferred_username: ivanserg@example.com
      email: IVANsergeev@example.com
      subject_container:
        id: ek0o6g0irskn********
        name: sample-pool
        container_type: USERPOOL
      job_info:
        company_name: Top Company
        department: IT
        job_title: DevOps engineer
        employee_id: "123"
      modified_at: "2026-09-23T19:48:49.112910Z"
  - sub: ajei280a73vc********
    type: USER_ACCOUNT
    created_at: "2020-01-23T06:21:07Z"
    status: ACTIVE
    name: Алексей И.
    last_authenticated_at: "2026-09-24T05:40:00Z"
    user_account:
      given_name: Алексей
      family_name: Иванов
      preferred_username: aivan********
      email: aivan********@yandex.ru
      phone_number: "+79876******"
      subject_container:
        id: yandex
        name: yandex
        container_type: PASSPORT
      last_id_proof_at: "2026-09-24T05:42:45.551123Z"
      modified_at: "2026-09-22T05:55:45.853516Z"
    external_id: "114*****"
  ```

  {% endcut %}

{% endlist %}

#### Получить фамилии федеративных и локальных пользователей, которые никогда не аутентифицировались в {{ yandex-cloud }} {#get-never-authenticated}

{% note warning %}

Если в фильтре вы используете поля с типом данных `enum`, передавайте для таких полей числовые значения, указанные в таблице с [атрибутами субъектов](../concepts/subject-details.md#attributes).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  ```bash
  yc iam subject-details get \
    --subject-ids aje3b3juqevc********,ek0ogbhh6o3p********,ajei280a73vc******** \
    --field-mask user_account.family_name \
    --filter 'subject.user_account.subject_container.container_type in [1, 4] && 
              !has(subject.last_authenticated_at)' \
    --format yaml
  ```

  {% cut "Результат" %}

  ```text
  sub: ek0ogbhh6o3p********
  type: USER_ACCOUNT
  user_account:
    family_name: Сергеев
  ```

  {% endcut %}

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../concepts/subject-details.md)

[*organization]: {% include [organization-definition](../../_popups/identity-hub/organization-definition.md) %}
