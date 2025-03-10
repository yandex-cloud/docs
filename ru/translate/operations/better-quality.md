---
title: Как повысить точность перевода в {{ translate-full-name }}
description: Из статьи вы узнаете, как можно повысить точность перевода.
---

# Повышение точности перевода

Чтобы повысить точность перевода:

* [Укажите язык исходного текста](#with-source-language). Некоторые слова пишутся одинаково в разных языках, но имеют разное значение. Если модель неправильно определит язык исходного текста, то и перевод будет другим.
* [Укажите собственный глоссарий для перевода](#with-glossary). Слово может переводиться по-разному. Например <q>oil</q> переводится как <q>масло</q> или <q>нефть</q>. С помощью глоссария вы сможете указать, как правильно переводить слово или словосочетание. [Подробнее о глоссариях](../concepts/glossary.md).

## Перед началом работы {#before-you-begin}

{% include [curl](../../_includes/curl.md) %}

{% include [bash-windows-note](../../_includes/translate/bash-windows-note.md) %}

{% include [ai-before-beginning](../../_includes/translate/ai-before-beginning.md) %}


## Указать язык исходного текста {#with-source-language}

Есть слова, которые пишутся одинаково в разных языках, но переводятся по-разному. Например, слово <q>angel</q> в английском языке означает духовное существо, а в немецком — удочку. Если переданный текст состоит из таких слов, то {{ translate-short-name }} может ошибиться при определении языка текста.

Чтобы избежать ошибки, укажите в поле `sourceLanguageCode` язык, с которого необходимо перевести текст:

{% list tabs group=programming_language %}

- Bash {#bash}

    ```json
    {
        "folderId": "<идентификатор_каталога>",
        "texts": ["angel"],
        "targetLanguageCode": "ru",
        "sourceLanguageCode": "de"
    }
    ```

    Где:

    * `folderId` — идентификатор каталога, полученный [перед началом работы](#before-begin).
    * `texts` — текст для перевода в виде списка из строк.
    * `targetLanguageCode` — [язык](../concepts/supported-languages.md), на который переводится текст. Вы можете узнать код языка вместе со [списком поддерживаемых языков](list.md).
    * `sourceLanguageCode` — язык, с которого переводится текст.

    Сохраните тело запроса в файле, например в `body.json`, и передайте файл с помощью метода [translate](../api-ref/Translation/translate):

    {% include [translate-file](../../_includes/translate/translate-file.md) %}

    Где `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin).

    В ответе будет перевод с корректно распознанного языка:

    {% include [with-source-language](../../_untranslatable/translate/with-source-language.md) %}


{% endlist %}

## Указать собственный глоссарий для перевода {#with-glossary}

Слово может переводиться по-разному. Например, <q>oil</q> переводится как <q>масло</q> или <q>нефть</q>. Чтобы повысить точность перевода, используйте [глоссарий](../concepts/glossary.md) со своим набором терминов и фраз, и однозначным переводом для них.

Глоссарий укажите в поле `glossaryConfig`. Сейчас глоссарий можно передать только в виде массива текстовых пар.

В поле `sourceLanguageCode` укажите язык, с которого необходимо перевести текст. Это поле обязательно при использовании глоссариев:

{% list tabs group=programming_language %}

- Bash {#bash}

    {% include [with-glossary-req](../../_untranslatable/translate/with-glossary-req.md) %}

    Где:

    * `sourceLanguageCode` — [язык](../concepts/supported-languages.md), с которого переводится текст. Вы можете узнать код языка вместе со [списком поддерживаемых языков](list.md).
    * `targetLanguageCode` — язык, на который переводится текст.
    * `texts` — текст для перевода в виде списка из строк.
    * `folderId` — идентификатор каталога, полученный [перед началом работы](#before-begin).

    Сохраните тело запроса в файле, например в `body.json`, и передайте файл с помощью метода [translate](../api-ref/Translation/translate):

    {% include [translate-file](../../_includes/translate/translate-file.md) %}

    Где `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin).

    В ответе будет перевод с использованием терминов из глоссария:

    {% include [with-glossary-ans1](../../_untranslatable/translate/with-glossary-ans1.md) %}

    Без использования глоссария перевод будет таким:

    {% include [with-glossary-ans2](../../_untranslatable/translate/with-glossary-ans2.md) %}

{% endlist %}

## Экранировать текст {#screen}

Чтобы определенные фрагменты текста не переводились, в теле запроса укажите формат текста `HTML` и экранируйте не требующие перевода фрагменты тегом `<span>` с атрибутом `translate=no`. Например:

{% list tabs group=programming_language %}

- Bash {#bash}

  ```json
  {
      "format": "HTML",
      "texts": [
          "The e-mail has been changed. The new password is **<span translate=no>**%\$Qvd14aa2NMc**</span>**"
      ]
  }
  ```

  Где:

  * `format` — формат текста.
  * `texts` — текст для перевода в виде списка из строк.

  В ответе текст внутри тега `<span>` останется без перевода:

  ```json
  {
      "translations": [
          {
              "text": "L'e-mail a été modifié. Le nouveau mot de passe est **<span translate="no">**%\$Qvd14aa2NMc**</span>**"
          }
      ]
  }
  ```

{% endlist %}

## Проверить опечатки {#with-speller}

Слова с опечатками могут быть переведены неправильно или транслитерированы. Например, слово <q>hellas</q> переводится как <q>эллада</q>. Это же слово, написанное с ошибкой — <q>helas</q>, будет переводиться как <q>хелас</q>. Чтобы проверить правильность написания слов, используйте параметр `speller`:

{% list tabs group=programming_language %}

- Bash {#bash}

    ```json
    {
      "sourceLanguageCode": "en"
      "targetLanguageCode": "ru",
      "texts": [
        "helas"
        ],
      "folderId": "<идентификатор_каталога>",
      "speller": true
    }
    ```

    Где:

    * `sourceLanguageCode` — [язык](../concepts/supported-languages.md) оригинала. Вы можете узнать код языка вместе со [списком поддерживаемых языков](list.md).
    * `targetLanguageCode` — целевой язык перевода.
    * `texts` — текст для перевода в виде списка строк.
    * `folderId` — идентификатор каталога, полученный [перед началом работы](#before-begin).
    * `speller` — параметр, который включает проверку орфографии.

    Сохраните тело запроса в файле, например в `body.json`, и передайте файл с помощью метода [translate](../api-ref/Translation/translate):

    {% include [translate-file](../../_includes/translate/translate-file.md) %}

    Где `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin).

    В ответе будет перевод слова, проверенного на наличие ошибок:
    
    {% include [with-speller-ans1](../../_untranslatable/translate/with-speller-ans1.md) %}

    Без проверки ошибок в слове (`"speller": false`) перевод будет таким:

    {% include [with-speller-ans2](../../_untranslatable/translate/with-speller-ans2.md) %}

{% endlist %}
