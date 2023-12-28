# Как автоматизировать настройку проектов с помощью API

[Сообщества {{ ml-platform-name }}](../../datasphere/concepts/community.md) позволяют организовать групповую работу и совместный доступ к материалам и ресурсам. Например, [Docker-образы](../../datasphere/concepts/docker.md) с предустановленными библиотеками, подключения к бакетам [{{ objstorage-full-name }}](../../storage/) и подготовленные датасеты, созданные в одном проекте, можно [опубликовать](../../datasphere/operations/index.md#share), чтобы открыть к ним доступ для всех проектов сообщества. Это может быть полезно при подготовке учебных заданий или работе нескольких разработчиков над одним исследованием.

Создать и настроить проекты {{ ml-platform-name }} можно с помощью интерфейса [{{ ml-platform-name }}]({{ link-datalens-main }}). Однако если вам нужно настроить несколько одинаковых проектов, вы можете автоматизировать действия с помощью [API {{ ml-platform-name }}.](../../datasphere/api-ref/overview.md) и [API {{ org-name }}](../../organization/api-ref/authentication.md). Для этого вам понадобится свое настроенное сообщество с проектом, из которого вы будете вызывать методы API {{ ml-platform-name }}.

Чтобы создать и настроить сообщество и несколько проектов:

1. [Получите IAM-токен](#get-iam).
1. [Создайте проекты](#create-projects).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость автоматизации входит плата за использование [вычислительных ресурсов {{ ml-platform-name }}](../../datasphere/pricing.md).

## Получите IAM-токен {#get-iam}

Чтобы получить доступ к вашей организации из {{ ml-platform-name }}, вам понадобится [IAM-токен](../../iam/concepts/authorization/iam-token.md).

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  Получите IAM-токен:

  ```bash
  yc iam create-token
  ```

- API

  {% include [owner-warning](../../_includes/iam/owner-warning.md) %}

  {% include [create-iam-token-api-steps](../../_includes/iam/create-iam-token-api-steps.md) %}

{% endlist %}

## Создайте проекты {#create-projects}

Чтобы создать проекты, скопируйте код в ячейки ноутбука и запустите их.

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Укажите полученный IAM-токен:

    ```python
    iam_token = "<IAM-токен>"
    ```

1. Импортируйте необходимую библиотеку:

    ```python
    import requests
    ```

1. Выведите на экран список всех доступных организаций и их идентификаторы:

    ```python
    res = requests.get('https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds', 
                        headers={"Authorization" : "Bearer {}".format(iam_token)})

    res.json()
    ```

1. Укажите идентификатор организации, в которой должно быть создано сообщество:

    ```python
    ORGANIZATION_ID = "<идентификатор_организации>"
    ```

1. Получите список доступных платежных аккаунтов:

    ```python
    res = requests.get('https://billing.api.cloud.yandex.net/billing/v1/billingAccounts', 
                        headers={"Authorization" : "Bearer {}".format(iam_token)})
    res.json()
    ```

1. Создайте сообщество, подставив его имя, описание, а также идентификатор [активного](../../billing/concepts/billing-account-statuses.md) платежного аккаунта:

    ```python
    data={}
    data['name'] = "<имя_сообщества>"
    data['description'] = "<описание_сообщества>"
    data['organizationId'] = ORGANIZATION_ID
    data['billingAccountId'] = "<идентификатор_платежного_аккаунта>"

    res = requests.post('https://datasphere.api.cloud.yandex.net/datasphere/v2/communities', 
                        json=data,
                        headers={"Authorization" : "Bearer {}".format(iam_token)})
    community_res = res.json()
    community_res
    ```

1. Получите список идентификаторов ролей в {{ ml-platform-name }}:

    ```python
    res = requests.get('https://iam.api.cloud.yandex.net/iam/v1/roles', 
                        headers={"Authorization" : "Bearer {}".format(iam_token)})
    roles = res.json()['roles']
    datasphere_roles = [role for role in roles if 'datasphere' in role['id']]
    datasphere_roles
    ```

1. [Получите](/organization/api-ref/User/listMembers) список участников организации:

    ```python
    res = requests.get("https://organization-manager.api.cloud.yandex.net/organization-manager/v1/organizations/{}/users".format(ORGANIZATION_ID), 
                        headers={"Authorization" : "Bearer {}".format(iam_token)})
    res.json()
    ```

    Идентификаторы из поля `sub` понадобятся вам на следующем шаге.

1. Создайте проекты, задайте [ограничения](../../datasphere/operations/projects/restrictions.md) и [настройте роли](../../datasphere/security/index.md) участников:

    ```python
    # Укажите список идентификаторов участников из поля 'sub', для которых должны быть созданы проекты
    user_organization_ids = ['<идентификатор_участника_1>','<идентификатор_участника_2>']

    projects = {}
    for user_id in user_organization_ids:
      # Создайте проект для пользователя
       data={}
       data['name'] = "Student {}".format(user_id)
       data['communityId'] = community_res['metadata']['communityId']
       data['description'] = "This is a workplace and create code and store resources"
       data['limits'] = {
         # Задайте ограничение на максимальное количество юнитов в час для проекта
         "maxUnitsPerHour": 10000,
         # Задайте ограничение на максимальное количество юнитов на один запуск ячейки для проекта
         "maxUnitsPerExecution": 5000
       }
       res = requests.post('https://datasphere.api.cloud.yandex.net/datasphere/v2/projects', 
                           json=data,
                           headers={"Authorization" : "Bearer {}".format(iam_token)})
       print("Project for {} is created with response: {}".format(user_id, res))
      
       data={}
       data['communityId'] = community_res['metadata']['communityId']
       data['projectNamePattern'] = "Student {}".format(user_id)
       res = requests.get('https://datasphere.api.cloud.yandex.net/datasphere/v2/projects', 
                           json=data,
                           headers={"Authorization" : "Bearer {}".format(iam_token)})
       projects[user_id] = res.json()['projects'][0]
       project_id = res.json()['projects'][0]['id']
      
       # Добавьте в проект себя с ролью {{ roles-datasphere-project-admin }} 
       # и пользователя с ролью {{ roles-datasphere-project-developer }}
       data={}
       data['accessBindings'] = [{
         "roleId": 'datasphere.community-projects.admin',
         "subject": {
               "id": "<идентификатор_администратора_проекта>", # Укажите идентификатор администратора проекта
               "type": "userAccount"
         }},
         {
         "roleId": 'datasphere.community-projects.developer',
         "subject": {
               "id": "<идентификатор_разработчика_проекта>", # Укажите идентификатор разработчика проекта
               "type": "userAccount"
         }}
       ]
       res = requests.post('https://datasphere.api.cloud.yandex.net/datasphere/v2/projects/{}:setAccessBindings'.\
                           format(project_id), 
                           json=data,
                           headers={"Authorization" : "Bearer {}".format(iam_token)})
       print("Admin was added to project {} with response: {}".format(project_id, res))
    ```

1. Получите список созданных проектов:

    ```python
    projects
    ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите](../../datasphere/operations/projects/delete.md) проект.
