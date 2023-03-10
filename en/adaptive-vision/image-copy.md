---
editable: false
---

# Vision batchAnalyze method

Analyzes a set of images and returns the search results for similar images.

## HTTP request {#https-request}

```
POST https://vision.{{ api-host }}/vision/v1/batchAnalyze
```

## Parameters in the request body {#body_params}

```json
{
  "analyzeSpecs": [
    {
      "features": [
        {
          "type": "IMAGE_COPY_SEARCH"
        }
      ],
      "mimeType": "string",
      "content": "string"
    }
  ]
}
```

| Field | Description |
---- | --------
| analyzeSpecs[] | **object**<br><p>List of specifications. Each specification contains the image to analyze and type of analysis.</p> |
| analyzeSpecs[].<br>features[] | **object**<br><p>List of analysis types.</p> |
| analyzeSpecs[].<br>features[].type | **string**<br><p>Analysis type. Use the value `IMAGE_COPY_SEARCH`.</p> |
| analyzeSpecs[].<br>mimeType | **string**<br><p>Content [MIME type](https://en.wikipedia.org/wiki/Media_type).</p> <p>For example, `application/pdf`.</p> <p>The maximum length is 255 characters. |
| analyzeSpecs[].<br>content | **string** (byte)<br><p>Image content represented as a stream of bytes.</p> <p>Note: As any byte field, protobuf uses a pure binary representation, whereas a JSON representation uses base64.</p> <p>The maximum length is 10485760 characters. |

## Response {#responses}

**HTTP Code: 200 - OK**

```json
{
 "results": [
  {
   "results": [
    {
     "imageCopySearch": {
      "topResults": [
       {
        "imageUrl": "string",
        "pageUrl": "string",
        "title": "string",
        "description": "string"
       },

       // Other items of the list `results[].results[].imageCopySearch.topResults[]`.

      ],
      "copyCount": "integer"
     }
    }
   ]
  }
 ]
}
```

| Field | Description |
---- | --------
| results[] | **object**<br><p>List of request results.</p> |
| results[].results[] | **object**<br><p>List of request results for a separate specification.</p> |
| results[].results[].<br>imageCopySearch | **object**<br><p>Request result for the `IMAGE_COPY_SEARCH` analysis.</p> |
| results[].results[].<br>imageCopySearch.<br>topResults[] | **object**<br><p>List of links and sites where the image is found, in descending order of relevance.</p> |
| results[].results[].<br>imageCopySearch.<br>topResults[].imageUrl | **string**<br><p>Image URL.</p> |
| results[].results[].<br>imageCopySearch.<br>topResults[].pageUrl | **string**<br><p>URL of the page where the image is found.</p> |
| results[].results[].<br>imageCopySearch.<br>topResults[].title | **string**<br><p>Page title.</p> |
| results[].results[].<br>imageCopySearch.<br>topResults[].description | **string**<br><p>Page description.</p> |
| results[].results[].<br>imageCopySearch.<br>copyCount | **integer**<br><p>The number of image copies found.</p> |

## Sample request {#sample}

```
curl -H "Authorization: Api-Key <Your API key>" --data @data.json https://vision.{{ api-host }}/vision/v1/batchAnalyze
```

The `data.json` file content is described below. Use your data or [download the data.json file](https://{{ s3-storage-host }}/doc-files/data.json) with data from the example.
```json
{
  "analyzeSpecs": [
    {
      "features": [
        {
          "type": "IMAGE_COPY_SEARCH"
        }
      ],
      "mimeType": "application/json",
      "content": "<Image>"
    }
  ]
}
```

**Response**

```json
{
 "results": [
  {
   "results": [
    {
     "imageCopySearch": {
      "topResults": [
       {
        "imageUrl": "https://i.mycdn.me/i?r=AzEPZsRbOZEKgBhR0XGMT1RkPP9W1BmgpMQhwHsyiKHQlqaKTM5SRkZCeTgDn6uOyic",
        "pageUrl": "www.wallpaperinhd.net/leonardo-dicaprio-wallpaper-22/",
        "title": "Leonardo DiCaprio Wallpaper 22 - Desktop Wallpapers HD Free Backgrounds",
        "description": "Leonardo DiCaprio Wallpaper 22"
       },
       {
        "imageUrl": "https://sun9-68.userapi.com/c635102/v635102124/51ccb/-wkH1Q727zI.jpg",
        "pageUrl": "vk.com/wall-22890129_219793",
        "title": "VK wall",
        "description": "Love at first sight?"
       },

       // Other items of the list `results[].results[].imageCopySearch.topResults[]`.

      ],
      "copyCount": 13
     }
    }
   ]
  }
 ]
}
```
