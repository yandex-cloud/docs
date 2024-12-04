To test the generator of signed links to the secure CDN resource:

1. In your browser, go to the website you created, e.g., `https://example.com`.
1. Click the link that was generated.

    If everything works as it should, you will see the image hosted on the secure CDN resource.

    {% note info %}

    An active VPN may interfere with the signed link generator's operation. For the website to work correctly, disable your VPN.

    {% endnote %}

1. Open the generated link on another device that uses another IP address to access the internet, e.g., a smartphone.

    Access to content will be denied.

1. Try opening the link on the first device after the five-minute timeout expires.

    Access to content will be denied.

You have configured secure access to your content.

When generating links, you can also [specify](../../../cdn/operations/resources/enable-secure-token.md) a trusted IP address, e.g., the one used for internet access in your corporate network. Thus you will restrict access to your content from outside your company’s network infrastructure.