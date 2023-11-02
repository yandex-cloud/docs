# Custom translation glossaries

To increase the accuracy of translations on a specific topic, you can provide a glossary in your request. A glossary is a termbase containing words and phrases with a single translation.

Currently, the glossary is provided as an array of text pairs within the request. Going forward, we will add a feature that will allow you to create glossaries from files in advance.

## Word forms {#word-forms}

When translating, the service considers different forms of words, meaning how the word morphs based on the case and gender.

For example, if you specified in the glossary that the Russian word <q>черный</q> should be translated as <q>dark</q>, then <q>самая черная комната</q> will be translated as <q>the darkest room</q>.

This currently works for the following language pairs:

* `en-ru`: English-Russian
* `ru-en`: Russian-English
* `tr-ru`: Turkish-Russian

## Capitalizing a translation using a glossary {#capitalization}

Translation of glossary terms takes the capitalization of the provided translation into account. Capitalization is determined using the following rules:

* If a term is written in lowercase letters, its capitalization will be determined automatically based on the source text.
* If a terms starts with a capital letter or is all-caps, its capitalization in a translation will match the one set in a glossary.
* If a term contains both uppercase and lowercase letters, but starts with a lowercase letter, a substring will be found that is as common as possible for the term and generated translation. Capitalization in the translation will be copied from the term, while the other characters will be lowercase.

**Example:**

> Source text: `I saw a KITTEN`.
>
> Glossary: `kitten` → `котенок`.
> Translation: `Я видел КОТЕНКА`.
>
> Glossary: `kitten` → `Котенок`.
> Translation: `Я видел Котенка`.
>
> Глоссарий: `kitten` → `КОТЕНОК`.
> Translation: `Я видел КОТЕНКА`.
>
> Glossary: `kitten` → `КотЕнОк`.
> Translation: `Я видел КотЕнка`.

## How to use glossaries {#how-to-use-glossaries}

* Only add words and phrases to the glossary that have a single translation. The bigger the glossary, the greater the risk that the text may contain a word from the glossary with a different meaning.
* Glossaries are good for translating names, such as brands and products.
* When using glossaries, mind the limits described in [Quotas and limits](../../translate/concepts/limits#translate-limits).

## Restrictions in the current version {#restrictions-in-the-current-version}

* You can only provide a glossary as an array of text pairs. Going forward, we will add a feature that will allow you to provide a glossary as a file.
* Glossaries are only supported for specific language pairs. If you enter <q>масло</q> as the source glossary term and translate it as <q>oil</q>, this will apply to the texts translated from Russian to English.
* Only certain language pairs support glossaries. See the list of supported language pairs [here](glossary-supported-pairs.md).

#### See also {#see-also}

* [{#T}](glossary-supported-pairs.md)
* [{#T}](../operations/better-quality.md#with-glossary)
* [Authentication in the API](../api-ref/authentication.md)