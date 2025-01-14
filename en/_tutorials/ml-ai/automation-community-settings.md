# How to automate project setup using APIs

With [{{ ml-platform-name }} communities](../../datasphere/concepts/community.md), you can arrange team work and shared access to different materials and resources. For example, you can [publish](../../datasphere/operations/index.md#share) [Docker images](../../datasphere/concepts/docker.md) with pre-installed libraries, connections to [{{ objstorage-full-name }}](../../storage/) buckets, and ready-made datasets created in a single project to grant all community projects access to them. This may be useful when preparing training tasks or when multiple developers are working on the same research.

You can use the [{{ ml-platform-name }}]({{ link-datalens-main }}) interface to create and set up projects in {{ ml-platform-name }}. However, if you need to set up a number of identical projects, you can automate operations using the [{{ ml-platform-name }} API](../../datasphere/api-ref/overview.md) and the [{{ org-name }} API](../../organization/api-ref/authentication.md). To do this, you will need a preset custom community with a project to invoke the {{ ml-platform-name }} API methods from.

To create and set up a community and multiple projects:

1. [Get an IAM token](#get-iam).
1. [Create projects](#create-projects).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

The automation cost includes a fee for using [{{ ml-platform-name }} computing resources](../../datasphere/pricing.md).

## Get an IAM token {#get-iam}

To access your organization from {{ ml-platform-name }}, you need an [IAM token](../../iam/concepts/authorization/iam-token.md).

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  Get an IAM token:

  ```bash
  yc iam create-token
  ```

- API {#api}

  {% include [owner-warning](../../_includes/iam/owner-warning.md) %}

  {% include [create-iam-token-api-steps](../../_includes/iam/create-iam-token-api-steps.md) %}

{% endlist %}

## Create projects {#create-projects}

To create projects, copy and paste the code into notebook cells and run them.

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Specify the IAM token you obtained:

    ```python
    iam_token = "<IAM_token>"
    ```

1. Import the required library:

    ```python
    import requests
    ```

1. Output the list of all available organizations and their IDs:

    ```python
    res = requests.get('https://resource-manager.{{ api-host }}/resource-manager/v1/clouds', 
                        headers={"Authorization" : "Bearer {}".format(iam_token)})

    res.json()
    ```

1. Specify the ID of the organization to create a community in:

    ```python
    ORGANIZATION_ID = "<organization_ID>"
    ```

1. Get a list of available billing accounts:

    ```python
    res = requests.get('https://billing.{{ api-host }}/billing/v1/billingAccounts', 
                        headers={"Authorization" : "Bearer {}".format(iam_token)})
    res.json()
    ```

1. Create a community by substituting its name and description and the ID of the [active](../../billing/concepts/billing-account-statuses.md) billing account:

    ```python
    data={}
    data['name'] = "<community_name>"
    data['description'] = "<community_description>"
    data['organizationId'] = ORGANIZATION_ID
    data['billingAccountId'] = "<billing_account_ID>"

    res = requests.post('https://datasphere.{{ api-host }}/datasphere/v2/communities', 
                        json=data,
                        headers={"Authorization" : "Bearer {}".format(iam_token)})
    community_res = res.json()
    community_res
    ```

1. Get a list of role IDs in {{ ml-platform-name }}:

    ```python
    res = requests.get('https://iam.{{ api-host }}/iam/v1/roles', 
                        headers={"Authorization" : "Bearer {}".format(iam_token)})
    roles = res.json()['roles']
    datasphere_roles = [role for role in roles if 'datasphere' in role['id']]
    datasphere_roles
    ```

1. [Get](../../organization/api-ref/User/listMembers.md) a list of organization members:

    ```python
    res = requests.get("https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/{}/users".format(ORGANIZATION_ID), 
                        headers={"Authorization" : "Bearer {}".format(iam_token)})
    res.json()
    ```

    You will need the IDs from the `sub` field at the next step.

1. Create projects, set [limits](../../datasphere/operations/projects/restrictions.md), and [set up roles](../../datasphere/security/index.md) for the members:

    ```python
    # List the IDs of the members from the 'sub' field to create projects for
    user_organization_ids = ['<member_1_ID>','<member_2_ID>']

    projects = {}
    for user_id in user_organization_ids:
      # Create a project for the user
       data={}
       data['name'] = "Student {}".format(user_id)
       data['communityId'] = community_res['metadata']['communityId']
       data['description'] = "This is a workplace and create code and store resources"
       data['limits'] = {
         # Set a limit on the maximum number of units per hour for the project
         "maxUnitsPerHour": 10000,
         # Set a limit on the maximum number of units per cell run for the project
         "maxUnitsPerExecution": 5000
       }
       res = requests.post('https://datasphere.{{ api-host }}/datasphere/v2/projects', 
                           json=data,
                           headers={"Authorization" : "Bearer {}".format(iam_token)})
       print("Project for {} is created with response: {}".format(user_id, res))
      
       data={}
       data['communityId'] = community_res['metadata']['communityId']
       data['projectNamePattern'] = "Student {}".format(user_id)
       res = requests.get('https://datasphere.{{ api-host }}/datasphere/v2/projects', 
                           json=data,
                           headers={"Authorization" : "Bearer {}".format(iam_token)})
       projects[user_id] = res.json()['projects'][0]
       project_id = res.json()['projects'][0]['id']
      
       # Add to the project yourself with the {{ roles-datasphere-project-admin }} role 
       # and the user with the {{ roles-datasphere-project-developer }} role
       data={}
       data['accessBindings'] = [{
         "roleId": 'datasphere.community-projects.admin',
         "subject": {
               "id": "<project_administrator_ID>", # Specify the project administrator ID
               "type": "userAccount"
         }},
         {
         "roleId": 'datasphere.community-projects.developer',
         "subject": {
               "id": "<project_developer_ID>", # Specify the project developer ID
               "type": "userAccount"
         }}
       ]
       res = requests.post('https://datasphere.{{ api-host }}/datasphere/v2/projects/{}:setAccessBindings'.\
                           format(project_id), 
                           json=data,
                           headers={"Authorization" : "Bearer {}".format(iam_token)})
       print("Admin was added to project {} with response: {}".format(project_id, res))
    ```

1. Get a list of the projects you created:

    ```python
    projects
    ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete](../../datasphere/operations/projects/delete.md) the project.
