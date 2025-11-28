# Browser autoplay policy

Automatic playback of a video hosted on an HTML page using the [video player SDK for IFrame](./iframe-sdk.md) may not work due to the browser's media autoplay policy.

Browsers may restrict video autoplay for the following reasons:

* **Traffic consumption**: Autoplaying videos may result in unwanted traffic consumption for the user.
* **Resource consumption**: Video playback requires significant resources, which may negatively impact the device's performance.
* **User experience**: Autoplaying videos with sound on can be annoying for users.


## Recommendations {#recommendations}

To ensure correct operation of automatic video playback:

* Check the latest information about browser autoplay policies.
* Allow the user to turn sound on manually after playback has started. Do it by using the `mute=true` parameter together with `autoplay=1`.


## See also {#see-also}

* [Video player SDK for IFrame](./iframe-sdk.md)