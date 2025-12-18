# Fixing the `Webpage is temporarily unavailable` error when paying with a Sber card


## Issue description {#issue-description}

When linking a Sber card to a billing account or paying for resources with that card, the frame displays `Web page temporarily unavailable`.

## Solution {#issue-resolution}

The Sber online services now use Russian CA certificates issued by the Ministry for Digital Development, Communications and Mass Media of the Russian Federation. Such certificates are not supported by non-Russian browsers. To fix this issue, install the required certificates on your device by following [this guide](https://www.sberbank.com/ru/certificates), or use [Yandex Browser](https://browser.yandex.com/), which already supports them.

If you re-open the Sber guide page after installation, it will show **Certificates installed**.