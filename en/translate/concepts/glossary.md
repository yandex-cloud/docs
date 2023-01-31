# Custom translation glossaries

To increase the accuracy of translations on a specific topic, pass a glossary in the request. A glossary is a dictionary of words and phrases with a single translation.

Currently, the glossary is passed as an array of text pairs within the request. In the future, we will add a feature that lets you create glossaries from files in advance.

## Word forms {#word-forms}

When translating, the service considers different forms of words, meaning how the word morphs based on the case and gender.

For example, if you specified in the glossary that the Russian word <q>черный</q> should be translated as <q>dark</q>, then <q>самая черная комната</q> will be translated as <q>the darkest room</q>.

This currently works for the following language pairs:

* `en-ru` — English-Russian
* `ru-en` — Russian-English
* `tr-ru` — Turkish-Russian

## How to use glossaries {#how-to-use-glossaries}

* Only add words and phrases to the glossary that have a single translation. The bigger the glossary, the greater the risk that the text may contain a word from the glossary with a different meaning.
* Glossaries are good for translating names, such as brands and products.
* Use glossaries taking into account the limits described in [Quotas and limits](../../translate/concepts/limits#translate-limits).

## Restrictions in the current version {#restrictions-in-the-current-version}

* You can only pass a glossary as an array of text pairs. We will add a feature that lets you pass glossaries as files in the future.
* Glossaries are only supported for specific language pairs. If you enter <q>масло</q> as the source glossary term and translate it as <q>oil</q>, this applies to texts translated from Russian to English.
* Only certain language pairs support glossaries. See the [list of supported language pairs](glossary-supported-pairs.md).

#### See also {#see-also}

* [{#T}](glossary-supported-pairs.md)
* [{#T}](../operations/better-quality.md#with-glossary)
* [Authentication in the API](../api-ref/authentication.md)