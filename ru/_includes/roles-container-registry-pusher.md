### container-registry.images.pusher {#cr-images-pusher}

В роль `{{ roles-cr-pusher }}` входят следующие разрешения: 

- получение списка реестров;
- получение информации о реестре;
- получение списка Docker-образов;
- получение информации о Docker-образе;
- создание Docker-образа;
- изменение Docker-образа;
- удаление Docker-образа.

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}
