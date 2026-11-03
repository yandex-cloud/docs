---
editable: false
---

# Video API, gRPC: StreamLineService.BatchGet

Retrieves multiple stream lines by their IDs in a specific channel in a single request.
This is more efficient than making multiple Get requests when retrieving several stream lines.

## gRPC request

**rpc BatchGet ([BatchGetStreamLinesRequest](#yandex.cloud.video.v1.BatchGetStreamLinesRequest)) returns ([BatchGetStreamLinesResponse](#yandex.cloud.video.v1.BatchGetStreamLinesResponse))**

## BatchGetStreamLinesRequest {#yandex.cloud.video.v1.BatchGetStreamLinesRequest}

```json
{
  "channel_id": "string",
  "stream_line_ids": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel containing the stream lines to retrieve.

The maximum string length in characters is 50. ||
|| stream_line_ids[] | **string**

List of stream line IDs to retrieve.

The maximum string length in characters for each value is 50. The number of elements must be in the range 1-100. ||
|#

## BatchGetStreamLinesResponse {#yandex.cloud.video.v1.BatchGetStreamLinesResponse}

```json
{
  "stream_lines": [
    {
      "id": "string",
      "channel_id": "string",
      "title": "string",
      "input_source": "LineInputSource",
      // Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`
      "rtmp_push": {
        "url": "string",
        "backup_url": "string"
      },
      "srt_push": {
        "url": "string",
        "backup_url": "string"
      },
      "rtmp_pull": {
        "url": "string",
        "backup_url": "string"
      },
      "srt_pull": {
        "url": "string",
        "backup_url": "string"
      },
      // end of the list of possible fields
      // Includes only one of the fields `manual_line`, `auto_line`
      "manual_line": "ManualLine",
      "auto_line": {
        "status": "AutoLineStatus"
      },
      // end of the list of possible fields
      "processing_settings": {
        "summarization": {
          "enable": "bool",
          "tracks": [
            {
              "track_index": "int64",
              "src_lang": "string"
            }
          ]
        },
        "translation": {
          "enable": "bool",
          "tracks": [
            {
              "input_track": {
                "track_index": "int64",
                "src_lang": "string"
              },
              "subtitles": [
                {
                  "dst_lang": "string"
                }
              ],
              "audios": [
                {
                  "dst_lang": "string"
                }
              ]
            }
          ]
        }
      },
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp",
      "labels": "map<string, string>"
    }
  ]
}
```

#|
||Field | Description ||
|| stream_lines[] | **[StreamLine](#yandex.cloud.video.v1.StreamLine)**

List of stream lines matching the requested IDs. ||
|#

## StreamLine {#yandex.cloud.video.v1.StreamLine}

Entity representing the incoming video signal settings.

#|
||Field | Description ||
|| id | **string**

ID of the line. ||
|| channel_id | **string**

ID of the channel to which this stream line belongs. ||
|| title | **string**

Title of the stream line. ||
|| input_source | enum **LineInputSource**

Specifies which input source (main or backup) is currently active.

- `ANY`: Use any available input source (main or backup).
- `MAIN`: Use main input source.
- `BACKUP`: Use backup input source (works only if backup input source is provided). ||
|| rtmp_push | **[RTMPPushInput](#yandex.cloud.video.v1.RTMPPushInput)**

Real-Time Messaging Protocol (RTMP) push input type.

Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`.

Specifies the input type and settings for the video signal source. ||
|| srt_push | **[SRTPushInput](#yandex.cloud.video.v1.SRTPushInput)**

Secure Reliable Transport (SRT) push input type.

Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`.

Specifies the input type and settings for the video signal source. ||
|| rtmp_pull | **[RTMPPullInput](#yandex.cloud.video.v1.RTMPPullInput)**

Real-Time Messaging Protocol (RTMP) pull input type.

Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`.

Specifies the input type and settings for the video signal source. ||
|| srt_pull | **[SRTPullInput](#yandex.cloud.video.v1.SRTPullInput)**

Secure Reliable Transport (SRT) pull input type.

Includes only one of the fields `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`.

Specifies the input type and settings for the video signal source. ||
|| manual_line | **[ManualLine](#yandex.cloud.video.v1.ManualLine)**

Manual stream control.

Includes only one of the fields `manual_line`, `auto_line`.

Specifies the control type of the stream line. ||
|| auto_line | **[AutoLine](#yandex.cloud.video.v1.AutoLine)**

Automatic stream control.

Includes only one of the fields `manual_line`, `auto_line`.

Specifies the control type of the stream line. ||
|| processing_settings | **[StreamLineProcessingSettings](#yandex.cloud.video.v1.StreamLineProcessingSettings)**

Processing settings. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the stream line was initially created in the system. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the last modification to the stream line or its metadata. ||
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
|| backup_url | **string**

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
|| backup_url | **string**

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
|| backup_url | **string**

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
|| backup_url | **string**

Backup SRT url (optional). ||
|#

## ManualLine {#yandex.cloud.video.v1.ManualLine}

Represents a manual line type where the stream control is handled manually.
This means that stream start/stop actions are performed by the user.

#|
||Field | Description ||
|| Empty | > ||
|#

## AutoLine {#yandex.cloud.video.v1.AutoLine}

Represents an automatic line type where the stream control is handled automatically.

#|
||Field | Description ||
|| status | enum **AutoLineStatus**

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
|| enable | **bool**

Enable line summarization. ||
|| tracks[] | **[InputTrack](#yandex.cloud.video.v1.StreamLineProcessingSettings.InputTrack)**

Input tracks. ||
|#

## InputTrack {#yandex.cloud.video.v1.StreamLineProcessingSettings.InputTrack}

#|
||Field | Description ||
|| track_index | **int64**

Input audio track index (one-based).

The minimum value is 1. ||
|| src_lang | **string**

Source track language represented as a three-letter code according to ISO 639-2/T.

Value must match the regular expression ``` ara|deu|eng|spa|fra|ita|jpn|kor|rus|tur|zho ```. ||
|#

## Translation {#yandex.cloud.video.v1.StreamLineProcessingSettings.Translation}

#|
||Field | Description ||
|| enable | **bool**

Enable line translation.
Neurotranslations and neurosubtitles cannot be enabled in low latency mode. ||
|| tracks[] | **[TranslationTrack](#yandex.cloud.video.v1.StreamLineProcessingSettings.TranslationTrack)**

Input tracks. ||
|#

## TranslationTrack {#yandex.cloud.video.v1.StreamLineProcessingSettings.TranslationTrack}

#|
||Field | Description ||
|| input_track | **[InputTrack](#yandex.cloud.video.v1.StreamLineProcessingSettings.InputTrack)**

Required field. Input track settings. ||
|| subtitles[] | **[SubtitleTrack](#yandex.cloud.video.v1.StreamLineProcessingSettings.SubtitleTrack)**

Settings for target subtitle tracks. ||
|| audios[] | **[AudioTrack](#yandex.cloud.video.v1.StreamLineProcessingSettings.AudioTrack)**

Settings for target audio tracks. ||
|#

## SubtitleTrack {#yandex.cloud.video.v1.StreamLineProcessingSettings.SubtitleTrack}

#|
||Field | Description ||
|| dst_lang | **string**

Required field. Language of subtitles represented as a three-letter code according to ISO 639-2/T.

Value must match the regular expression ``` eng|kaz|rus ```. ||
|#

## AudioTrack {#yandex.cloud.video.v1.StreamLineProcessingSettings.AudioTrack}

#|
||Field | Description ||
|| dst_lang | **string**

Required field. Target language represented as a three-letter code according to ISO 639-2/T.

Value must match the regular expression ``` eng|kaz|rus ```. ||
|#