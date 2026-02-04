---
title: '{{ video-full-name }} release notes'
description: This section contains the {{ video-name }} release notes.
---

# {{ video-full-name }} release notes

## October – December 2025 {#oct-dec-2025}

* Added [support for presets](concepts/presets.md) that allow you to configure video player appearance and features:

  * Display of the playlist and video descriptions, as well as summarization.
  * Position and visibility of UI elements.
  * Color scheme, size, and other visual settings.

    For each channel, two presets are created automatically:

  * **Default Style Preset**: Applies to all videos by default.
  * **Summarization Style Preset**: Comes with a summarization widget to show a brief video summary.

  You can modify existing presets or create custom ones. You can also select a default preset for the entire channel or apply a preset to a specific video or playlist.

* Added descriptions of player methods and events for the [IFrame SDK](sdk/iframe/).

## July – September 2025 {#jul-sep-2025}

* Added [neural features](concepts/videos.md#ai-capabilities) to increase video availability and audience reach: summarization, neural translation, and automatic subtitle generation. These operate based on [Yandex](https://habr.com/ru/companies/yandex/articles/792608/) ML models and get regular updates.

* Added support video content monetization based on the [Yandex Advertising Network](https://yandex.ru/support/partner/en/yan-rules/video). Advertising is configured at the [channel](operations/channels/settings.md#ad-settings) level: you can select a video ad category aligned with the subject matter of your videos.

* Added the ability to [specify domains](operations/channels/settings.md#channel-settings) to allow the videos only on particular websites. The videos will not play on other domains.

* On August 1, 2025, {{ video-name }} entered the [General Availability](../overview/concepts/launch-stages.md) stage and is now subject to the [pricing policy](pricing.md).

## November – December 2024 {#nov-dec-2024}

* Implemented [channel](concepts/index.md#channels) search by name on the {{ video-name }} [home page]({{ link-video-main }}).
* You can now share a video via a [temporary link](concepts/videos.md#temporary-link).

## October 2024 {#oct-2024}

* Published a video player SDK for [iOS](./sdk/ios-sdk.md).

## September 2024 {#sep-2024}

* Added support for [video](./concepts/videos.md#subtitles) [subtitle](./concepts/videos.md) uploading.
* Published a video player SDK for [JavaScript](./sdk/javascript/index.md).
* Added support for [REST API methods](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/video) for {{ video-name }}; published a [reference](./api-ref/).

## August 2024 {#aug-2024}

* Implemented the [playlists](./concepts/playlists.md) functionality.
* The service is publicly available at the [Preview stage](../overview/concepts/launch-stages.md).

## July 2024 {#jul-2024}

* Added the ability to [upload](./operations/video/upload.md#multiple) multiple videos at the same time.

## April 2024 {#apr-2024}

* Published the [gRPC API call reference](./api-ref/grpc/).

## March 2024 {#mar-2024}

* Added the option to get [view statistics](./operations/video/get-statistics.md) for a video.
* Published the [reference guide on Cloud Video Player SDK for IFrame](./sdk/iframe/index.md).
* Added the option to [configure public access](./operations/video/publish.md) to a video.

## November 2023 {#nov-2023}

Published the [{{ video-name }} gRPC API specifications](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/video).

## October 2023 {#oct-2023}

The service is available upon request at the [Preview stage](../overview/concepts/launch-stages.md) on a [separate page]({{ link-video-main }}) in {{ video-name }}.
