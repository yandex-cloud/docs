### datalens.instances.admin {#datalens-instances-admin}

Роль `{{ roles-datalens-instances-admin }}` предоставляет доступ к сервису {{ datalens-short-name }} в качестве администратора экземпляра {{ datalens-short-name }}. Администратор получает права доступа на все объекты и папки в сервисе {{ datalens-short-name }}.

Роль автоматически присваивается создателю экземпляра {{ datalens-short-name }}. Администратор обладает правами `{{ roles-datalens-instances-user }}`. Ему доступны настройки [{{ datalens-short-name }}]({{ link-datalens-settings }}).

После назначения сервисной роли вы можете назначить пользователю права доступа на объекты и папки в сервисе {{ datalens-short-name }}.

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}