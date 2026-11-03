[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Video](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [StreamLine](index.md) > List

# Video API, gRPC: StreamLineService.List

Lists all stream lines in a specific channel with pagination support.
Results can be filtered and sorted using the provided parameters.

## gRPC request

**rpc List ([ListStreamLinesRequest](#yandex.cloud.video.v1.ListStreamLinesRequest)) returns ([ListStreamLinesResponse](#yandex.cloud.video.v1.ListStreamLinesResponse))**

## ListStreamLinesRequest {#yandex.cloud.video.v1.ListStreamLinesRequest}

```json
{
  "channel_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel containing the stream lines to list.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of stream lines to return per page.

The maximum value is 100. ||
|| page_token | **string**

Page token for retrieving the next page of results.
This token is obtained from the next_page_token field in the previous ListStreamLinesResponse.

The maximum string length in characters is 15000. ||
|| order_by | **string**

Specifies the ordering of results.
Format is "&lt;field&gt; &lt;order&gt;" (e.g., "createdAt desc").
Default: "id asc".
Supported fields: ["id", "title", "createdAt", "updatedAt"].
Both snake_case and camelCase field names are supported.

The maximum string length in characters is 50. ||
|| filter | **string**

Filter expression to narrow down the list of returned stream lines.
Expressions consist of terms connected by logical operators.
Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
with inner quotes being backslash-escaped.

Supported logical operators: ["AND", "OR"].
Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
Parentheses can be used to group logical expressions.

Example: `title:'main' AND id='line-1'`

Filterable fields: ["id", "title"].
Both snake_case and camelCase field names are supported.

The maximum string length in characters is 1000. ||
|#

## ListStreamLinesResponse {#yandex.cloud.video.v1.ListStreamLinesResponse}

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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| stream_lines[] | **[StreamLine](#yandex.cloud.video.v1.StreamLine)**

List of stream lines matching the request criteria.
May be empty if no stream lines match the criteria or if the channel has no stream lines. ||
|| next_page_token | **string**

Token for retrieving the next page of results.
Empty if there are no more results available. ||
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