---
title: '{{ speechsense-full-name }} release notes'
description: This page presents {{ speechsense-full-name }} release notes.
---

# {{ speechsense-full-name }} release notes

## March 2025 {#0325}

{{ speechsense-name }} can now analyze dialogs not only in Russian, but also in Kazakh, or a Russian-Kazakh combination. With this in mind, the required `language` field has been added to [new connections](../operations/connection/create.md). The metadata of dialogs uploaded via such connections must contain the codes of potential dialog languages. If a dialog contains Kazakh speech, the service will recognize the audio and make a Russian transcript for further analysis.

When tagging, {{ speechsense-name }} now counts the _balance_ for the [main tags](../concepts/tags.md#dependent-tags). The balance consists of all the dialogs with the main tag that did not get at least one dependent tag. 

The processing status is now displayed for newly uploaded dialogs. You can now see the current processing stage for each dialog.

Added analysis of statistical metrics for text dialogs. 

You can now export dialogs to process them further using your own tools.

Dialog info update: we recommend using [semantic tags](../concepts/tags.md#sense-tags) instead of the obsolete **{{ yagpt-name }} analysis** section.

## February 2025 {#0225}

Advanced [dialog search](../concepts/dialogs.md#filters) options are now available. Now, apart from full-text search that locates word matches and dictionary search that finds phrases and word combinations, you can use semantic search. It enables you to search for dialogs based on context, find synonyms and related terms rather than just exact matches. The search page will also show a summary of each dialog, so you can quickly understand its main idea and select the ones you need.

Dialogs now include [semantic tags](../concepts/tags.md#sense-tags) for faster and easier analysis. When creating a semantic tag, you can select an attribute, such as the dialog topic or outcome, or formulate a general question. The neural network will analyze dialogs and select those that match the specified criteria. You can adjust the trigger probability threshold for a tag as you create it. Learn more about creating semantic tags [here](../operations/project/tag/create-sense-tag.md).

While creating or editing a tag, you can test how it works before applying it to the entire project. You can now view how changes will affect your data without waiting until the next day. For more information about tag testing, see [this guide](../operations/project/tag/test.md).

Following numerous requests, the {{ speechsense-name }} interface now includes the option to [upload dialogs](../operations/data/upload-audio-console.md). This option works well if you are just getting started with the service or want to quickly check a few dialogs. Only MP3 files are supported for upload. To upload audio files in other formats and integrate {{ speechsense-name }} into your processes and systems, use the [API upload](../operations/data/upload-data.md) option.
