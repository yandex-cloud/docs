# Документация Yandex.Cloud

Добро пожаловать в репозиторий [документации](https://cloud.yandex.ru/docs) Yandex.Cloud.
1
## Про документацию

Документация разработана с использованием [Yandex Flavored Markdown](https://github.com/yandex-cloud/yfm-docs). [Подробнее про синтаксис](guides/yfm-syntax-ru.md).

## Как предложить правки

Чтобы предложить правки, вы должны прочитать «Лицензионное Соглашение Яндекса с Контрибьютором»  и подтвердить свое согласие с его условиями. Подробная информация о том, как это сделать, и ссылки на текст Соглашения приведены в файле [CONTRIBUTING.md](CONTRIBUTING.md).

Если вы заметили опечатку или ошибку в документации или хотите дополнить какой-то раздел, создайте pull request (PR) с правками через GitHub.

## Как собрать документацию локально

Перед тем так создавать pull request, удобно собрать документацию локально и посмотреть на нее вживую. Для этого используется инструмент [yfm-docs](https://github.com/yandex-cloud/yfm-docs).

1. Установите **yfm-docs**:
  
   `npm i @doc-tools/docs`
  
   Чтобы обновить версию **yfm-docs**, используйте эту же команду.

1. Соберите документацию: 
  
   `yfm -i docs -o docs-gen`, где `docs` — каталог с исходными текстами, а `docs-gen` — каталог, в котором будет находится сгенерированная документация.

## Лицензии

© YANDEX LLC, 2018. Licensed under Creative Commons Attribution 4.0 International Public License. See [LICENSE](LICENSE) file for more details.
