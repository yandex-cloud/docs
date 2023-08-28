#### datalens.instances.user {#datalens-instances-user}

Роль `{{ roles-datalens-instances-user }}` предоставляет доступ к сервису {{ datalens-short-name }} в качестве пользователя с правами на создание, чтение и изменение объектов согласно [правам доступа на объекты](../datalens/security/manage-access.md).

После назначения сервисной роли вы можете назначить пользователю права доступа на объекты и папки в сервисе {{ datalens-short-name }}.

{% note tip %}

Даже если вы еще не перешли на [воркбуки и коллекции](../datalens/workbooks-collections/index.md#enable-workbooks), рекомендуем вместо роли `{{ roles-datalens-instances-user }}` использовать `{{ roles-datalens-creator }}`. Новая роль при навигации по папкам действует аналогично старой роли. Единственное отличие заключается в том, что `{{ roles-datalens-instances-user }}` позволяет просматривать все каталоги в организации, поэтому `{{ roles-datalens-creator }}` использовать безопаснее.

{% endnote %}