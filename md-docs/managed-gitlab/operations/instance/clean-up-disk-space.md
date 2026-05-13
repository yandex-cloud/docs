# Очистка переполненного дискового пространства инстанса

У инстанса GitLab может закончиться место на диске, на это указывает HTTP-код состояния `500 Internal Server Error`. В этом случае вы не сможете войти в инстанс GitLab.

Вы можете самостоятельно [увеличить дисковое пространство инстанса](instance-update.md).

Чтобы уменьшить вероятность переполнения дискового пространства в будущем:

* регулярно [очищайте дисковое пространство инстанса](#manual-cleanup) вручную;
* периодически [удаляйте неактуальные пайплайны](#pipeline-cleanup);
* [настройте политики очистки дискового пространства](#set-cleanup-policy).

Также вы можете настроить алерты для графика **Data disk** в [мониторинге](monitoring.md#monitoring-integration).

## Очистите дисковое пространство инстанса {#manual-cleanup}

1. [Просмотрите вручную](https://docs.gitlab.com/ee/user/packages/container_registry/#view-the-container-registry) все Docker-образы и их теги в GitLab Container Registry.
1. [Удалите](https://docs.gitlab.com/ee/user/packages/container_registry/delete_container_registry_images.html) устаревшие образы и теги.

## Удалите устаревшие пайплайны {#pipeline-cleanup}

Пайплайны создают задачи (jobs), которые в свою очередь генерируют логи. Чем дольше и активнее вы пользуетесь инстансом GitLab, тем больше места на диске требуется для хранения логов. Чтобы освободить место, можно [удалить ненужные пайплайны](https://docs.gitlab.com/ci/pipelines/#delete-a-pipeline), а вместе с ними удалятся задачи (jobs) и их логи.

Через веб-интерфейс GitLab можно удалять только один пайплайн за раз. Чтобы массово удалить ненужные пайплайны и их логи, используйте скрипт:

{% note warning %}

После запуска скрипт сразу выполнит массовое безвозвратное удаление пайплайнов и всех связанных с ним данных, таких как задачи (jobs), логи, артефакты и триггеры. Данное действие нельзя отменить.

{% endnote %}

{% note info %}

Чтобы скрипт работал корректно, скачайте и установите утилиту [jq](https://stedolan.github.io/jq/download/).

{% endnote %}

```bash
#!/bin/sh
set -e

TOKEN=<ваш_токен>
PER_PAGE=<количество_удаляемых_пайплайнов>
UPDATED_BEFORE=<дата_последнего_обновления>
GITLAB_URL=<FQDN_инстанса_GitLab>

for PROJECT in $(curl -sL --header "PRIVATE-TOKEN: $TOKEN" "$GITLAB_URL/api/v4/projects?per_page=$PER_PAGE" | jq '.[].id') ; do
  echo "Deleting in project $PROJECT"
  for PIPELINE in $(curl -sL --header "PRIVATE-TOKEN: $TOKEN" "$GITLAB_URL/api/v4/projects/$PROJECT/pipelines?per_page=$PER_PAGE&sort=asc&updated_before=${UPDATED_BEFORE}T00:00:00Z" | jq '.[].id') ; do
      echo "Deleting pipeline $PIPELINE"
      curl -L --header "PRIVATE-TOKEN: $TOKEN" --request "DELETE" "$GITLAB_URL/api/v4/projects/$PROJECT/pipelines/$PIPELINE"
  done
done

```

Где:
* `TOKEN` — [токен GitLab](https://docs.gitlab.com/user/profile/personal_access_tokens/) пользователя с ролью Owner в проекте. 
* `PER_PAGE` — количество пайплайнов, которые будут удалены за один запрос. Максимум можно удалить 100 записей за раз, если у вас их больше, то скрипт потребуется запустить несколько раз.
* `UPDATED_BEFORE` — верхняя граница даты обновления в формате `ГГГГ-ММ-ДД`. Будут удалены все пайплайны, которые были обновлены до этой даты.
* `GITLAB_URL` — FQDN инстанса GitLab.

## Настройте политики очистки дискового пространства {#set-cleanup-policy}

Вы можете воспользоваться любой из следующих опций:

* [Настройте время жизни артефактов сборки](https://docs.gitlab.com/ee/administration/settings/continuous_integration.html#default-artifacts-expiration) на уровне всего инстанса. По умолчанию оно составляет 30 дней.
* [Создайте и настройте политику очистки тегов](https://docs.gitlab.com/ee/user/packages/container_registry/reduce_container_registry_storage.html#create-a-cleanup-policy) на уровне отдельных проектов, которые используют GitLab Container Registry.
* Если вы используете [интеграцию с Yandex Container Registry](../../tutorials/image-storage.md), создайте и настройте [политику удаления Docker-образов](../../../container-registry/concepts/lifecycle-policy.md) на стороне Yandex Container Registry.