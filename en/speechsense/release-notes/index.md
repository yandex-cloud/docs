---
title: '{{ speechsense-full-name }} release notes'
description: This page presents the {{ speechsense-full-name }} release notes.
---

# {{ speechsense-full-name }} release notes

### November 2025 {#1125}

#### Changes in connections

Added the{{ bitrix24-name }} and {{ amocrm-name }} templates with a pre-installed set of keys for [creating a connection](../operations/connection/create.md). Now some connection settings are populated automatically.

#### Changes in dialogs

Improved the player on the audio dialog view page. Added new features:
* Fast forwarding and rewinding by 5 seconds.
* Separate volume control for channels.
* Changing playback speed.

## September 2025 {#0925}

You can now create an [AI assistant](../concepts/assistants.md). An AI assistant will help you analyze dialogs as they come streaming in to extract relevant data, such as phone numbers, cities, products your customers express interest in, or company feedback. With a knowledge base in PDF format uploaded into it, your assistant will be able to analyze dialogs based on transcripts to highlight the agent's omissions.

## August 2025 {#0825}

* The [reports](../concepts/reports/index.md) export format has been changed to XLSX.
* Added new limits:
   * Maximum number of projects per space.
   * Maximum number of tags per project.
   * Maximum number of metadata entries per connection.
   * Maximum number of dictionaries per space.

#### Changes in tags

Added a new tag type, [semantic Pro tags](../concepts/tags.md#sense-pro-tags), which rely on complex search queries for dialog analysis. These tags are an improved version of [semantic tags](../concepts/tags.md#sense-tags).

## July 2025 {#0725}

You can now [change a billing account](../operations/space/change-ba.md) after you link it.

## May 2025 {#0525}

#### Changes in tags

Dictionary tags now use a greater distance. A key phrase may contain no more than five extra words between the keywords.

#### Changes in connections

* You can now [edit](../operations/connection/edit.md) an existing connection and add new metadata to it.
* A new connection type is now available: [single-channel audio](../operations/connection/create.md#create-one-channel-audio-connection) with [audio splitting option](../operations/data/upload-data-split.md).

## April 2025 {#0425}

You can now [edit dialog metadata](../operations/data/manage-dialogs.md#edit-dialog-metadata).

Added [integration with {{ datalens-full-name }}](../operations/external-integrations/create-datalens-connection.md). You can now create reports with even more detailed analytics.

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
