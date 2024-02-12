# Custom translation glossaries

To increase the accuracy of translations on a specific topic, you can provide a glossary in your request. A glossary is a termbase containing words and phrases with a single translation.

Currently, the glossary is provided as an array of text pairs within the request. Going forward, we will add a feature that will allow you to create glossaries from files in advance.

## Neuroglossaries {#word-forms}

When translating, the service considers different forms of words, e.g., how the word morphs based on the case and gender.

For example, if you specified in the glossary that the Russian word _черный_ should be translated as _dark_, then _самая черная комната_ will be translated as _the darkest room_.

Currently, this works for the following [languages](supported-languages.md): `ar`, `bg`, `cs`, `de`, `en`, `es`, `fr`, `it`, `kk`, `pl`, `ru`, `tr`, `tt`, and `uk`.

Each pair is provided with the `exact` parameter (bool), which allows you to add translations for specific terms to neuroglossaries. For example, if you specified that _table_ should be translated as _таблицей_, then _It is a table_ will be translated as _Это таблицей_.

If a neuroglossary does not support a particular language, there is no point using this parameter. It may not always work correctly or may produce inaccurate results, so we recommend [escaping](../operations/better-quality.md#screen) it.

## Multiglossaries {#multi}

When translating, the service considers different forms of words, e.g., how the word morphs based on the case and gender.

In contrast to neuroglossaries, in a mutliglossary, you manually specify translation suggestions for one and the same word. The neural network will select the appropriate suggestion depending on the context. For example, _cat_ means _кошка_ and _кот_.

The service works the most effectively with close or synonymic translation meanings. If you specify totally different meanings, this might cause confusion. For example, _letter_ means both _письмо_ and _буква_.

The multiglossary works with all languages for which glossaries are available.

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

## Limitations in the current version {#restrictions-in-the-current-version}

* You can only provide a glossary as an array of text pairs. Going forward, we will add a feature that will allow you to provide a glossary as a file.
* Glossaries are only supported for specific language pairs. If you enter _масло_ as the source glossary term and translate it as _oil_, this will apply to texts translated from Russian to English.
* Only certain language pairs support glossaries. See the list of supported language pairs [here](glossary-supported-pairs.md).

#### See also {#see-also}

* [{#T}](glossary-supported-pairs.md)
* [{#T}](../operations/better-quality.md#with-glossary)
* [Authentication with the API](../api-ref/authentication.md)
