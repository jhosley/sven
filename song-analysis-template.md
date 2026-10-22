# Song Analysis: [TITLE] by [ARTIST]

> A reference model for writing new songs with Claude and generating them in Suno.
> Fill in every `[ ]` field. Delete any line that doesn't apply.

---

## 1. Core Specs

| Field | Value |
|---|---|
| Genre / subgenre | [ ] |
| Tempo (BPM) | [ ] |
| Key / mode | [ ] |
| Time signature | [ ] |
| Length | [ ] |
| Era / decade feel | [ ] |
| Mood (3–5 words) | [ ] |
| Energy curve | [e.g. low verse → lift pre → full chorus → drop bridge → biggest final chorus] |

## 2. Instrumentation & Production

- **Drums / rhythm:** [ ]
- **Bass:** [ ]
- **Harmony instruments (guitar, keys, synths):** [ ]
- **Lead / hooks / riffs:** [ ]
- **Textures / ear candy (pads, FX, risers, samples):** [ ]
- **Mix character (dry/wet, lo-fi/polished, wide/narrow, loud/dynamic):** [ ]
- **Signature sound (the one thing that makes it *this* song):** [ ]

## 3. Vocals

- **Voice type / gender / range:** [ ]
- **Delivery (breathy, belted, spoken, raspy, falsetto, rapped):** [ ]
- **Harmonies / doubles / gang vocals:** [ ]
- **Vocal effects (reverb, autotune, distortion, delay throws):** [ ]
- **Ad-libs / call-and-response:** [ ]

## 4. Structure Map

| # | Section | Bars / time | What happens (instruments in/out, energy 1–10) |
|---|---|---|---|
| 1 | Intro | [ ] | [ ] |
| 2 | Verse 1 | [ ] | [ ] |
| 3 | Pre-Chorus | [ ] | [ ] |
| 4 | Chorus | [ ] | [ ] |
| 5 | Verse 2 | [ ] | [ ] |
| 6 | Pre-Chorus | [ ] | [ ] |
| 7 | Chorus | [ ] | [ ] |
| 8 | Bridge | [ ] | [ ] |
| 9 | Final Chorus | [ ] | [ ] |
| 10 | Outro | [ ] | [ ] |

## 5. Lyric Anatomy

- **Theme / story:** [ ]
- **Point of view (I / you / we / third person):** [ ]
- **Tone (literal, metaphorical, conversational, poetic):** [ ]
- **Rhyme scheme per section:** Verse [ABAB?] · Pre [ ] · Chorus [ ] · Bridge [ ]
- **Syllables per line (approx.):** Verse [ ] · Chorus [ ]
- **Lines per section:** Verse [ ] · Pre [ ] · Chorus [ ] · Bridge [ ]
- **Hook / title placement:** [first line of chorus? last line? repeated?]
- **Recurring images / vocabulary:** [ ]
- **Bridge function (new perspective, twist, release):** [ ]

## 6. Suno Kit

### Style prompt (≤ 200 chars, no artist names)
```
[genre, subgenre, era, BPM, key, mood, lead instruments, vocal type + delivery, production descriptors]
```

### Exclude styles
```
[e.g. autotune, trap hi-hats, orchestral]
```

### Lyric skeleton with tags
```
[Intro]
[instrumental cue, e.g. "Clean guitar arpeggio"]

[Verse 1]
(line)
(line)
(line)
(line)

[Pre-Chorus]
(line)
(line)

[Chorus]
(HOOK line)
(line)
(line)
(HOOK line)

[Verse 2]
...

[Bridge]
[cue, e.g. "Half-time, sparse"]
(line)
(line)

[Final Chorus]
[cue, e.g. "Full band, key change up"]
...

[Outro]
[cue, e.g. "Fade out"]
```

### Settings notes
- Model version: [ ]
- Style influence / weirdness: [ ]
- Tips that worked / didn't: [ ]

## 7. Brief for Claude

> Use this file as the blueprint for a new song. Keep: [elements to preserve: structure, rhyme scheme, syllable counts, vocal style, mood].
> Change: [new topic / title / perspective].
> Avoid: [copying lyric lines, specific clichés, etc.].
> Output: full lyrics with Suno section tags plus a style prompt under 200 characters.
