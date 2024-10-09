# Enumeration: PlayerSdkStatus

[Playback status](../../../sdk/javascript/player-state.md#status-desc).

## Enumeration Members {#Enumeration-Members}

- [broken](#broken)
- [buffering](#buffering)
- [cancelled](#cancelled)
- [destroyed](#destroyed)
- [end](#end)
- [fatal](#fatal)
- [finished](#finished)
- [idle](#idle)
- [init](#init)
- [pause](#pause)
- [play](#play)
- [preparing](#preparing)

### broken {#broken}

• **broken** = `"broken"`

The player is broken and cannot play the video, the user gets an error screen. Switching to other content is not possible.

### buffering {#buffering}

• **buffering** = `"buffering"`

The player is in buffering state and cannot play the video, e.g., due to lack of data.

### cancelled {#cancelled}

• **cancelled** = `"cancelled"`

The live stream was canceled.

### destroyed {#destroyed}

• **destroyed** = `"destroyed"`

The `destroy` method was called, the player is destroyed and can no longer play the video.

### end {#end}

• **end** = `"end"`

Current video playback has ended at the right edge of the timeline. 

### fatal {#fatal}

• **fatal** = `"fatal"`

The current video cannot be played and the user gets an error screen. To start a video, the user can try switching to other content.

### finished {#finished}

• **finished** = `"finished"`

The live stream ended.

### idle {#idle}

• **idle** = `"idle"`

The player is waiting for content to play.

### init {#init}

• **init** = `"init"`

Initializing the player after the first playable content is set.

### pause {#pause}

• **pause** = `"pause"`

The player is paused.

### play {#play}

• **play** = `"play"`

Video playback is in progress.

### preparing {#preparing}

• **preparing** = `"preparing"`

The live stream is about to start.