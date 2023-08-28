#### datalens.instances.admin {#datalens-instances-admin}

Роль `{{ roles-datalens-instances-admin }}` предоставляет доступ к сервису {{ datalens-short-name }} в качестве администратора экземпляра {{ datalens-short-name }}. Администратор получает полные права на все объекты и папки в сервисе {{ datalens-short-name }}, а также доступ к настройкам [{{ datalens-short-name }}]({{ link-datalens-settings }}).

{% note tip %}

Даже если вы еще не перешли на [воркбуки и коллекции](../datalens/workbooks-collections/index.md#enable-workbooks), рекомендуем вместо роли `{{ roles-datalens-instances-admin }}` использовать `{{ roles-datalens-admin }}`. Новая роль при навигации по папкам действует аналогично старой роли. Единственное отличие заключается в том, что `{{ roles-datalens-instances-admin }}` позволяет просматривать все каталоги в организации, поэтому `{{ roles-datalens-admin }}` использовать безопаснее.

{% endnote %}