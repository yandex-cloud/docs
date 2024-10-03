# Fixing the "no such bucket" and "no such key" errors when uploading objects from CDN


## Issue description {#issue-description}

* You cannot download objects by CDN links the first time
* Sometimes, objects by CDN links start downloading after you refresh the browser page.

## Solution {#issue-resolution}

Possibly, the value of the `origin` field in CDN parameters is set to `<bucket_name>.website.yandexcloud.net` and `header host` is set to  `<bucket_name>.storage.yandexcloud.net`. You need both parameters to have the same values.

Change the values if they differ and wait for some time (up to 15 minutes). Then check if you can download objects by CDN links.

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:

1. CDN ID
2. One or more problematic CDN object links
3. Problem description.
