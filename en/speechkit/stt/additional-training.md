---
title: Extending a speech recognition model
description: 'In this tutorial, you will learn about methods of extending a speech recognition model: autotuning, model fine-tuning, and the use of audio to improve quality.'
---

# Extending a speech recognition model

{{ speechkit-name }} provides multiple ways to improve speech recognition:

* [Auto-tuning](#autotuning)
* [Model tuning](#advanced-training)
* [Using audio to improve quality](#audio)


## Auto-tuning based on logged data {#autotuning}

By default, {{ speechkit-name }} does not save data provided by users. However, the most effective way to improve a speech recognition model is to train it on real user data.

To improve the quality of speech recognition, use model _auto-tuning_. It will enable you to save data transmitted in requests and use it for further training. Auto-tuning improves recognition quality while the model is running without any further data collecting actions on your part.

Auto-tuning is a good option under these conditions:

* The current script used for work tasks fails to recognize some of the vocabulary.
* The vocabulary for auto-tuning should be easy to perceive by ear and to transcribe. For example, drug names are not suitable as these terms come from a narrow domain. To recognize domain-specific terms, use [model tuning](#advanced-training).

To send data for auto-tuning, provide the `x-data-logging-enabled: true` header in your API requests. For an example with logging enabled, see [{#T}](../concepts/support-headers.md). Then contact support to request model fine-tuning on the provided data.

Auto-tuning tips:

{% include [autotuning-requirements](../../_includes/speechkit/autotuning-requirements.md) %}

## Using audio to improve quality {#audio}

You can improve speech recognition by submitting an audio file to the {{ speechkit-name }} team. This method is similar to [auto-tuning](#autotuning) but uses an audio prepared by you instead of data provided in API requests. [Submit it to the support team]({{ link-console-support }}) as a ZIP archive. You can also attach transcripts of the messages, but this is optional.

For the recommended data size, refer to the auto-tuning restrictions.

## Fine-tuning {#advanced-training}

The basic speech recognition model is designed to work with everyday language, but it may not be sufficient to recognize specific vocabulary. By tuning, you can train the model to recognize domain-specific terms from different fields:

* Medicine: Diagnoses, biological terms, drug names.
* Business: Company names.
* Trade: Product ranges (jewelry, electronics, and so on).
* Finance: Banking terms and names of banking products.

Model tuning relies on text templates and glossaries.

### Text template {#templates}

A _text template_ contains similar phrases with variables the model uses to generate utterances. The variables are replaced with glossary terms.

To improve overall recognition quality, you can use templates together with [auto-tuning](#autotuning). They work even for domain-specific vocabulary, such as drug names.

### Glossary {#glossary}

A _glossary_ is a full list of terms used in place of variables in templates. It contains words found in test audio files, as well as other vocabulary.

A glossary must be provided as a separate file. One such file is created for each template variable. The variable serves as the name for the relevant glossary file. Each term occupies a separate line in the file.

For example, the `first-name.tsv`, `middle-name.tsv`, and `last-name.tsv` glossary files used for tuning a call center model may contain the first, middle, and last names of customers.

| first-name.tsv | middle-name.tsv | last-name.tsv |
|---|---|---|
|  John<br>Tom<br>Peter<br>... <br> |  Wendell<br>Sean<br>Larry<br>... <br> | Thompson<br>Carter<br>Smith<br>... <br> |

If the pattern phrases assume that the glossary terms may have possessive case forms, you need to create a separate glossary file for each form. For example, files with names in the possessive case will contain the following entries:

| first-name-ablative.tsv | middle-name-ablative.tsv | last-name-ablative.tsv |
|---|---|---|
|  John<br>Tom<br>Peter<br>... <br> |  Wendell<br>Sean<br>Larry<br>... <br> | Thompson's<br>Carter's<br>Smith's<br>... <br> |

Then, the `templates.tsv` file may contain entries in the following format:

```text
Hello, are you {first-name=first-names.tsv} {middle-name=middle-names.tsv} {last-name=last-names.tsv}?
Hello, can I talk to {first-name=first-names-ablative.tsv} {middle-name=middle-names-ablative.tsv}?
```

### Restrictions and requirements for text templates and glossaries {#requirements}

Glossaries and text templates must be provided in normalized [TSV](https://en.wikipedia.org/wiki/Tab-separated_values) format:

* Numerals: Written as words.
* Latin words and characters: Transcribed.
* Abbreviations: Spelled out.
* Foreign language acronyms: Spelled out or transcribed.
* Russian acronyms: Left unchanged.

> ![No](../../_assets/common/no.svg): We're giving away, i.e. for free, 2 kilos of potatoes, a DNA helix model, and some ABC magazine from 2020.
> 
> ![Yes](../../_assets/common/yes.svg): We are giving away, that is for free, two kilos of potatoes, a dee-en-ay helix model, and some ay-bee-cee magazines from twenty-twenty.

Requirements for text templates and glossaries:

* The length of a template including variables must not exceed 200 characters.
* Only Russian is supported.
* Tuning works better if there are at least 100 phrases for each glossary term.

Tuning takes about two months from when you [submit the data archive to the support team](upload-data-for-training.md).

