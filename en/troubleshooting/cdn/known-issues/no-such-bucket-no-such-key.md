# Fixing the `no such bucket` and `no such key` errors when uploading objects from {{ cdn-name }}



## Issue description {#issue-description}

* You cannot download objects by CDN links the first time
* Sometimes, objects by CDN links start downloading after you refresh the browser page.

## Solution {#issue-resolution}

In the CDN settings, you can specify `<bucket_name>.website.yandexcloud.net` as the `origin` field value, and `<bucket_name>.storage.yandexcloud.net` as the `header host` field value. You need both properties to have the same values.

Change the values if they are different and wait up to 15 minutes. After that, check if you can download objects via CDN links.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. CDN ID.
1. One or multiple links to CDN objects you have issues with.
1. Issue description.
