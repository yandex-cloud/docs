{% include [http-common-body-params](./http-common-body-params.md) %}

* `format`: Searching for images of specified format. This is an optional parameter. If not set, the search includes images of all formats. The possible values are:

    * `IMAGE_FORMAT_JPEG`: [JPG](https://en.wikipedia.org/wiki/JPEG)
    * `IMAGE_FORMAT_GIF`: [GIF](https://en.wikipedia.org/wiki/GIF)
    * `IMAGE_FORMAT_PNG`: [PNG](https://en.wikipedia.org/wiki/PNG)
* `size`: Searching for images of specified size. This is an optional parameter. If not set, the search includes images of all sizes. The possible values are:

    * `IMAGE_SIZE_ENORMOUS`: Very large images (over `1600 × 1200` in pixels).
    * `IMAGE_SIZE_LARGE`: Large images (from `800 × 600` to `1600 × 1200` in pixels).
    * `IMAGE_SIZE_MEDIUM`: Medium images (from `150 × 150` to `800 × 600` in pixels).
    * `IMAGE_SIZE_SMALL`: Small images (from `32 × 32` to `150 × 150` in pixels).
    * `IMAGE_SIZE_TINY`: Icons (up to `32 × 32` in pixels).
    * `IMAGE_SIZE_WALLPAPER`: Wallpaper images.
* `orientation`: Searching for images of specified orientation. This is an optional parameter. If not set, the search includes images of any orientation. The possible values are:

    * `IMAGE_ORIENTATION_VERTICAL`: Vertical images.
    * `IMAGE_ORIENTATION_HORIZONTAL`: Horizontal images.
    * `IMAGE_ORIENTATION_SQUARE`: Square aspect ratio images.
* `color`: Searching for images with specified color parameters. This is an optional parameter. If not set, the search includes images with any color parameters. The possible values are:

    * `IMAGE_COLOR_COLOR`: Colored images.
    * `IMAGE_COLOR_GRAYSCALE`: Grayscale images.
    * `IMAGE_COLOR_RED`: Images with red as the main color.
    * `IMAGE_COLOR_ORANGE`: Images with orange as the main color.
    * `IMAGE_COLOR_YELLOW`: Images with yellow as the main color.
    * `IMAGE_COLOR_GREEN`: Images with green as the main color.
    * `IMAGE_COLOR_CYAN`: Images with cyan as the main color.
    * `IMAGE_COLOR_BLUE`: Images with blue as the main color.
    * `IMAGE_COLOR_VIOLET`: Images with violet as the main color.
    * `IMAGE_COLOR_WHITE`: Images with white as the main color.
    * `IMAGE_COLOR_BLACK`: Images with black as the main color.
* `site`: Searching for images only on specified website, e.g., `yandex.cloud`. This is an optional parameter. If not set, the search includes all websites in the search base.
* `docsOnPage`: Number of result groups displayed per search result page. You can specify values between `1` and `60`. This is an optional parameter. The default value is `20`.
* `folderId`: [Folder ID](../../resource-manager/operations/folder/get-id.md) of the user or service account you will use for queries.
* `userAgent`: String containing the [User-Agent header](https://en.wikipedia.org/wiki/User-Agent_header). Use this parameter to have your search results optimized for a specific device and browser, including [mobile search results](../../search-api/operations/v2-mobile.md). This is an optional parameter. If not specified, you will get the default output.