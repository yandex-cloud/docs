Чтобы искать данные через REST API {{ yandex-cloud }}:

1. {% include [create-sa](create-sa.md) %}
1. [Добавьте сервисный аккаунт в пространство](../../../speechsense/operations/space/add-user-to-space.md) с ролью `{{ roles-speechsense-data-viewer }}`. Это позволит сервисному аккаунту работать с данными в {{ speechsense-name }}.
1. {% include [create-api-key](create-api-key.md) %}
1. [Загрузите аудиозаписи](../../../speechsense/operations/data/upload-data.md) или [чаты](../../../speechsense/operations/data/upload-chat-text.md) в {{ speechsense-name }}.
