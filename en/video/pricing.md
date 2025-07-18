---
title: '{{ video-full-name }} pricing policy'
description: This article covers the {{ video-name }} pricing policy.
editable: false
---

# {{ video-full-name }} pricing policy

At the [Preview](../overview/concepts/launch-stages.md) stage, {{ video-name }} is free of charge.

{% note warning %}

The pricing below will become effective as of August 1, 2025.

{% endnote %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## What goes into the cost of using {{ video-name }} {#rules}

When using {{ video-name }}, you are charged for the following:

* Outgoing traffic: Fee for transmitting video content from the {{ yandex-cloud }} CDN servers to the internet. Such traffic means transmitting and showing video content to your audience.
* Transcoding: Fee for converting video content when uploading it to {{ video-name }}.
* Video streaming storage: Fee for storing video streaming content after transcoding. When transcoding, you get multiple versions of video content with different bitrate and resolution. This is why the overall size of the video streaming content may be larger than that of the original content.
* Original files storage: Fee for storing the original video files uploaded to {{ video-name }}.

The video content is stored in {{ objstorage-name }}. The data amount is measured in GBs per month. The size of video content per month is calculated as the average value based on granular per-second data. The minimum billing unit is 1 hour of storing 1 MB of data.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Storage and transcoding of video {#video}



{% include [usd.md](../_pricing/video/usd.md) %}


The daily cost of storing the video streaming content and original files is calculated as `Price_per_GB_per_month / number_of_days_in_month`. For shorter months, the storage price per day is higher. For longer months, it is lower.

### Outgoing traffic {#traffic}



{% include notitle [usd.md](../_pricing/cdn/usd.md) %}


### Cost calculation example {#price-example}

Let’s assume you need to calculate the monthly cost for using {{ video-name }} as per the following data:

* Number of uploaded videos: `10 items`.
* Duration of each video: `10 minutes`.
* Total video duration (to calculate the cost of transcoding): `10 items` × `10 minutes` = `100 minutes`.
* Overall size of the original files: `5 GB`.
* Overall size of the video files in streaming format (optimized, multiple versions with different bitrate and resolution): `8 GB`.
* Outgoing traffic (total size of the transmitted content when viewed): `50 GB`.

We also assume that the videos (both the original and the streaming content) are stored for the entire month.



{% include notitle [usd-video.md](../_pricing_examples/video/usd-video.md) %}
