# Внутренняя документация Yandex.Cloud

Добро пожаловать в репозиторий [документации](https://docs.yandex-team.ru/cloud/) Yandex.Cloud.

## Про документацию

Документация разработана с использованием [Yandex Flavored Markdown](https://github.com/yandex-cloud/yfm-transform/) с некоторыми расширениями. [Подробнее про синтаксис](https://github.com/yandex-cloud/yfm-transform/blob/master/DOCS.ru.md).

## Как предложить правки

Чтобы предложить правки:

1. Изучите основные правила разработки документации Yandex.Cloud:

   - [Cloud Docs Guidelines](https://wiki.yandex-team.ru/cloud/docs/cloud-guidelines/)
   - [Соглашения по Git workflow для документов Yandex.Cloud](https://wiki.yandex-team.ru/cloud/docs/branches-workflow/);

1. Создайте PR в репозитории https://bb.yandex-team.ru/projects/CLOUD/repos/docs/. Это репозиторий с общей кодовой базой для внутренней и внешней версии документации. Если правки затрагивают только внутреннюю документацию, используйте [условные операторы](https://github.com/yandex-cloud/yfm-transform/blob/master/DOCS.ru.md#условные-операторы-).

## Как собрать документацию локально

Чтобы просмотреть, как будут выглядеть ваши правки в собранной документации, воспользуйтесь инструментом [yfm-docs](https://github.com/yandex-cloud/yfm-docs):

1. Установите `yfm-docs`:
   ```
   npm i @doc-tools/docs -g
   ```
1. Чтобы собрать внутреннюю версию документации, выполните команду:
   ```
   yfm -i ./docs -o ./docs-gen --varsPreset "internal" -c ./docs/internal-doc-config/.yfm
   ```