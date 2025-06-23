---
title: Extending a speech recognition model
description: 'In this tutorial, you will learn about methods of extending a speech recognition model: autotuning, model fine-tuning, and the use of audio to improve quality.'
---

# Extending a speech recognition model

{{ speechkit-name }} provides multiple ways to improve speech recognition:

* [Auto-tuning](#autotuning)
* [Using audio to improve quality](#audio)
* [Model tuning](#advanced-training)


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

For tuning you will need a list of terms (words or phrases) and at least three free-form text examples for each term.

Tuning is available for the Russian language only.


Tuning takes about two months from when you [submit the data archive to the support team](upload-data-for-training.md).