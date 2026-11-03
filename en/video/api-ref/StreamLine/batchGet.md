---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/streamLines:batchGet
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            Required field. ID of the channel containing the stream lines to retrieve.
            The maximum string length in characters is 50.
          type: string
        streamLineIds:
          description: |-
            **string**
            List of stream line IDs to retrieve.
            The maximum string length in characters for each value is 50. The number of elements must be in the range 1-100.
          type: array
          items:
            type: string
      required:
        - channelId
      additionalProperties: false
    definitions: null
---

# Video API, REST: StreamLine.BatchGet

Retrieves multiple stream lines by their IDs in a specific channel in a single request.
This is more efficient than making multiple Get requests when retrieving several stream lines.

## HTTP request

```
POST https://video.{{ api-host }}/video/v1/streamLines:batchGet
```

## Body parameters {#yandex.cloud.video.v1.BatchGetStreamLinesRequest}

```json
{
  "channelId": "string",
  "streamLineIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel containing the stream lines to retrieve.

The maximum string length in characters is 50. ||
|| streamLineIds[] | **string**

List of stream line IDs to retrieve.

The maximum string length in characters for each value is 50. The number of elements must be in the range 1-100. ||
|#

## Response {#yandex.cloud.video.v1.BatchGetStreamLinesResponse}

**HTTP Code: 200 - OK**

```json
{
  "streamLines": [
    {
      "id": "string",
      "channelId": "string",
      "title": "string",
      "inputSource": "string",
      // Includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`
      "rtmpPush": {
        "url": "string",
        "backupUrl": "string"
      },
      "srtPush": {
        "url": "string",
        "backupUrl": "string"
      },
      "rtmpPull": {
        "url": "string",
        "backupUrl": "string"
      },
      "srtPull": {
        "url": "string",
        "backupUrl": "string"
      },
      // end of the list of possible fields
      // Includes only one of the fields `manualLine`, `autoLine`
      "manualLine": "object",
      "autoLine": {
        "status": "string"
      },
      // end of the list of possible fields
      "processingSettings": {
        "summarization": {
          "enable": "boolean",
          "tracks": [
            {
              "trackIndex": "string",
              "srcLang": "string"
            }
          ]
        },
        "translation": {
          "enable": "boolean",
          "tracks": [
            {
              "inputTrack": {
                "trackIndex": "string",
                "srcLang": "string"
              },
              "subtitles": [
                {
                  "dstLang": "string"
                }
              ],
              "audios": [
                {
                  "dstLang": "string"
                }
              ]
            }
          ]
        }
      },
      "createdAt": "string",
      "updatedAt": "string",
      "labels": "object"
    }
  ]
}
```

#|
||Field | Description ||
|| streamLines[] | **[StreamLine](#yandex.cloud.video.v1.StreamLine)**

List of stream lines matching the requested IDs. ||
|#

## StreamLine {#yandex.cloud.video.v1.StreamLine}

Entity representing the incoming video signal settings.

#|
||Field | Description ||
|| id | **string**

ID of the line. ||
|| channelId | **string**

ID of the channel to which this stream line belongs. ||
|| title | **string**

Title of the stream line. ||
|| inputSource | **enum** (LineInputSource)

Specifies which input source (main or backup) is currently active.

- `ANY`: Use any available input source (main or backup).
- `MAIN`: Use main input source.
- `BACKUP`: Use backup input source (works only if backup input source is provided). ||
|| rtmpPush | **[RTMPPushInput](#yandex.cloud.video.v1.RTMPPushInput)**

Real-Time Messaging Protocol (RTMP) push input type.

Includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`.

Specifies the input type and settings for the video signal source. ||
|| srtPush | **[SRTPushInput](#yandex.cloud.video.v1.SRTPushInput)**

Secure Reliable Transport (SRT) push input type.

Includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`.

Specifies the input type and settings for the video signal source. ||
|| rtmpPull | **[RTMPPullInput](#yandex.cloud.video.v1.RTMPPullInput)**

Real-Time Messaging Protocol (RTMP) pull input type.

Includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`.

Specifies the input type and settings for the video signal source. ||
|| srtPull | **[SRTPullInput](#yandex.cloud.video.v1.SRTPullInput)**

Secure Reliable Transport (SRT) pull input type.

Includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`.

Specifies the input type and settings for the video signal source. ||
|| manualLine | **object**

Manual stream control.

Includes only one of the fields `manualLine`, `autoLine`.

Specifies the control type of the stream line. ||
|| autoLine | **[AutoLine](#yandex.cloud.video.v1.AutoLine)**

Automatic stream control.

Includes only one of the fields `manualLine`, `autoLine`.

Specifies the control type of the stream line. ||
|| processingSettings | **[StreamLineProcessingSettings](#yandex.cloud.video.v1.StreamLineProcessingSettings)**

Processing settings. ||
|| createdAt | **string** (date-time)

Timestamp when the stream line was initially created in the system.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp of the last modification to the stream line or its metadata.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Custom user-defined labels as `key:value` pairs.
Maximum 64 labels per stream line.
Labels can be used for organization, filtering, and metadata purposes. ||
|#

## RTMPPushInput {#yandex.cloud.video.v1.RTMPPushInput}

Settings for an RTMP (Real-Time Messaging Protocol) push input.
Used when the video stream is pushed to an RTMP server.
@see https://en.wikipedia.org/wiki/Real-Time_Messaging_Protocol

#|
||Field | Description ||
|| url | **string**

RTMP server url. ||
|| backupUrl | **string**

RTMP server URL for the signal identified by the backup stream key. ||
|#

## SRTPushInput {#yandex.cloud.video.v1.SRTPushInput}

Settings for an SRT (Secure Reliable Transport) push input.
Used when the video stream is pushed to an SRT server.
@see https://en.wikipedia.org/wiki/Secure_Reliable_Transport

#|
||Field | Description ||
|| url | **string**

SRT server url. ||
|| backupUrl | **string**

SRT server URL for the signal identified by the backup stream key. ||
|#

## RTMPPullInput {#yandex.cloud.video.v1.RTMPPullInput}

Settings for an RTMP pull input.
Used when the service pulls the video stream from an RTMP source.
@see https://en.wikipedia.org/wiki/Real-Time_Messaging_Protocol

#|
||Field | Description ||
|| url | **string**

RTMP url for receiving video signal. ||
|| backupUrl | **string**

Backup RTMP url (optional). ||
|#

## SRTPullInput {#yandex.cloud.video.v1.SRTPullInput}

Settings for an SRT pull input.
Used when the service pulls the video stream from an SRT source.
@see https://en.wikipedia.org/wiki/Secure_Reliable_Transport

#|
||Field | Description ||
|| url | **string**

SRT url for receiving video signal. ||
|| backupUrl | **string**

Backup SRT url (optional). ||
|#

## AutoLine {#yandex.cloud.video.v1.AutoLine}

Represents an automatic line type where the stream control is handled automatically.

#|
||Field | Description ||
|| status | **enum** (AutoLineStatus)

The status of the automatic line.

- `DEACTIVATED`: The automatic line is deactivated and not currently active.
- `ACTIVE`: The automatic line is active and operational. ||
|#

## StreamLineProcessingSettings {#yandex.cloud.video.v1.StreamLineProcessingSettings}

#|
||Field | Description ||
|| summarization | **[Summarization](#yandex.cloud.video.v1.StreamLineProcessingSettings.Summarization)**

Settings for stream line summarization. ||
|| translation | **[Translation](#yandex.cloud.video.v1.StreamLineProcessingSettings.Translation)**

Settings for stream line translation. ||
|#

## Summarization {#yandex.cloud.video.v1.StreamLineProcessingSettings.Summarization}

#|
||Field | Description ||
|| enable | **boolean**

Enable line summarization. ||
|| tracks[] | **[InputTrack](#yandex.cloud.video.v1.StreamLineProcessingSettings.InputTrack)**

Input tracks. ||
|#

## InputTrack {#yandex.cloud.video.v1.StreamLineProcessingSettings.InputTrack}

#|
||Field | Description ||
|| trackIndex | **string** (int64)

Input audio track index (one-based).

The minimum value is 1. ||
|| srcLang | **string**

Source track language represented as a three-letter code according to ISO 639-2/T.

Value must match the regular expression ``` ara|deu|eng|spa|fra|ita|jpn|kor|rus|tur|zho ```. ||
|#

## Translation {#yandex.cloud.video.v1.StreamLineProcessingSettings.Translation}

#|
||Field | Description ||
|| enable | **boolean**

Enable line translation.
Neurotranslations and neurosubtitles cannot be enabled in low latency mode. ||
|| tracks[] | **[TranslationTrack](#yandex.cloud.video.v1.StreamLineProcessingSettings.TranslationTrack)**

Input tracks. ||
|#

## TranslationTrack {#yandex.cloud.video.v1.StreamLineProcessingSettings.TranslationTrack}

#|
||Field | Description ||
|| inputTrack | **[InputTrack](#yandex.cloud.video.v1.StreamLineProcessingSettings.InputTrack)**

Required field. Input track settings. ||
|| subtitles[] | **[SubtitleTrack](#yandex.cloud.video.v1.StreamLineProcessingSettings.SubtitleTrack)**

Settings for target subtitle tracks. ||
|| audios[] | **[AudioTrack](#yandex.cloud.video.v1.StreamLineProcessingSettings.AudioTrack)**

Settings for target audio tracks. ||
|#

## SubtitleTrack {#yandex.cloud.video.v1.StreamLineProcessingSettings.SubtitleTrack}

#|
||Field | Description ||
|| dstLang | **string**

Required field. Language of subtitles represented as a three-letter code according to ISO 639-2/T.

Value must match the regular expression ``` eng|kaz|rus ```. ||
|#

## AudioTrack {#yandex.cloud.video.v1.StreamLineProcessingSettings.AudioTrack}

#|
||Field | Description ||
|| dstLang | **string**

Required field. Target language represented as a three-letter code according to ISO 639-2/T.

Value must match the regular expression ``` eng|kaz|rus ```. ||
|#