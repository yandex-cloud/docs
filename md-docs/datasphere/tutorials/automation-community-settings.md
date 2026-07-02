[Документация Yandex Cloud](../../index.md) > [Yandex DataSphere](../index.md) > Как организовать работу в DataSphere > Автоматизировать настройку проектов

# Как автоматизировать настройку проектов с помощью API

[Сообщества DataSphere](../concepts/community.md) позволяют организовать групповую работу и совместный доступ к материалам и ресурсам. Например, [Docker-образы](../concepts/docker.md) с предустановленными библиотеками, подключения к бакетам [Yandex Object Storage](../../storage/index.md) и подготовленные файловые хранилища, созданные в одном проекте, можно [опубликовать](../operations/index.md#share), чтобы открыть к ним доступ для всех проектов сообщества. Это может быть полезно при подготовке учебных заданий или работе нескольких разработчиков над одним исследованием.

Создать и настроить проекты DataSphere можно с помощью интерфейса [DataSphere](https://datasphere.yandex.cloud). Однако если вам нужно настроить несколько одинаковых проектов, вы можете автоматизировать действия с помощью [API DataSphere.](../api-ref/overview.md) и [API Yandex Identity Hub](../../organization/api-ref/authentication.md). Для этого вам понадобится свое настроенное сообщество с проектом, из которого вы будете вызывать методы API DataSphere.

Чтобы создать и настроить сообщество и несколько проектов:

1. [Получите IAM-токен](#get-iam).
1. [Создайте проекты](#create-projects).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Перед началом работы нужно зарегистрироваться в Yandex Cloud, настроить [сообщество](../concepts/community.md) и привязать к нему [платежный аккаунт](../../billing/concepts/billing-account.md):
1. [На главной странице DataSphere](https://datasphere.yandex.cloud) нажмите **Попробовать бесплатно** и выберите аккаунт для входа — Яндекс ID или рабочий аккаунт в федерации (SSO).
1. Выберите [организацию Yandex Identity Hub](../../organization/index.md), в которой вы будете работать в Yandex Cloud.
1. [Создайте сообщество](../operations/community/create.md).
1. [Привяжите платежный аккаунт](../operations/community/link-ba.md) к сообществу DataSphere, в котором вы будете работать. Убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, создайте его в интерфейсе DataSphere.

### Необходимые платные ресурсы {#paid-resources}

В стоимость автоматизации входит плата за использование [вычислительных ресурсов DataSphere](../pricing.md).

## Получите IAM-токен {#get-iam}

Чтобы получить доступ к вашей организации из DataSphere, вам понадобится [IAM-токен](../../iam/concepts/authorization/iam-token.md).

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  Получите IAM-токен:

  ```bash
  yc iam create-token
  ```

{% endlist %}

## Создайте проекты {#create-projects}

Чтобы создать проекты, скопируйте код в ячейки ноутбука и запустите их.

1. Откройте проект DataSphere:
   
   1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
   1. Нажмите кнопку **Открыть проект в JupyterLab** и дождитесь окончания загрузки.
   1. Откройте вкладку с ноутбуком.

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

1. Укажите [идентификатор](../../organization/operations/organization-get-id.md) организации, в которой должно быть создано сообщество:

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

1. Получите список идентификаторов ролей в DataSphere:

    ```python
    res = requests.get('https://iam.api.cloud.yandex.net/iam/v1/roles', 
                        headers={"Authorization" : "Bearer {}".format(iam_token)})
    roles = res.json()['roles']
    datasphere_roles = [role for role in roles if 'datasphere' in role['id']]
    datasphere_roles
    ```

1. [Получите](../../organization/api-ref/User/listMembers.md) список участников организации:

    ```python
    res = requests.get("https://organization-manager.api.cloud.yandex.net/organization-manager/v1/organizations/{}/users".format(ORGANIZATION_ID), 
                        headers={"Authorization" : "Bearer {}".format(iam_token)})
    res.json()
    ```

    Идентификаторы из поля `sub` понадобятся вам на следующем шаге.

1. Создайте проекты, задайте [ограничения](../operations/projects/restrictions.md) и [настройте роли](../security/index.md) участников:

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
      
       # Добавьте в проект себя с ролью datasphere.community-projects.admin 
       # и пользователя с ролью datasphere.community-projects.developer
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

Чтобы перестать платить за созданные ресурсы, [удалите](../operations/projects/delete.md) проект.