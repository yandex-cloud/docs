# Очистка переполненного дискового пространства инстанса

У инстанса {{ GL }} может закончиться место на диске, на это указывает HTTP-код состояния `500 Internal Server Error`. В этом случае вы не сможете войти в инстанс {{ GL }}. Для очистки диска и восстановления доступа к инстансу {{ GL }} обратитесь в [техническую поддержку]({{ link-console-support }}).

Чтобы уменьшить вероятность переполнения дискового пространства в будущем:

* регулярно [очищайте дисковое пространство инстанса](#manual-cleanup) вручную;
* [настройте политики очистки дискового пространства](#set-cleanup-policy).

## Очистите дисковое пространство инстанса {#manual-cleanup}

1. [Просмотрите вручную]({{ gl.docs }}/ee/user/packages/container_registry/#view-the-container-registry) все Docker-образы и их теги в {{ GL }} Container Registry.
1. [Удалите]({{ gl.docs }}/ee/user/packages/container_registry/delete_container_registry_images.html) устаревшие образы и теги.

## Настройте политики очистки дискового пространства {#set-cleanup-policy}

Вы можете воспользоваться любой из следующих опций:

* [Настройте время жизни артефактов сборки]({{ gl.docs }}/ee/administration/settings/continuous_integration.html#default-artifacts-expiration) на уровне всего инстанса. По умолчанию оно составляет 30 дней.
* [Создайте и настройте политику очистки тегов]({{ gl.docs }}/ee/user/packages/container_registry/reduce_container_registry_storage.html#create-a-cleanup-policy) на уровне отдельных проектов, которые используют {{ GL }} Container Registry.
* Если вы используете [интеграцию с {{ container-registry-full-name }}](../../tutorials/image-storage.md), создайте и настройте [политику удаления Docker-образов](../../../container-registry/concepts/lifecycle-policy.md) на стороне {{ container-registry-full-name }}.
