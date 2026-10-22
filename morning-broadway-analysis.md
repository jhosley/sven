# Song Analysis: "Morning Broadway" by Keith Mansfield & The KPM Orchestra

> A reference model for writing new tracks with Claude and generating them in Suno.
>
> **How sure each part is:**
> - ✅ **Verified:** taken from Spotify or published sources.
> - 🟡 **Estimated:** based on the record's genre, label and era, and how it's been described. Not measured from the audio.
> - 🎧 **Check by ear:** listen once and correct these before relying on them.

---

## 0. Source Facts ✅

| Field | Value |
|---|---|
| Title | Morning Broadway |
| Composer / arranger | Keith Mansfield |
| Performer | The KPM Orchestra |
| Album | *KPM 1000 Series: Chorus and Orchestra* (KPM library LP, 1969; track 5) |
| Length | 2:05 |
| Spotify | spotify:track:6X0ufegIaeHxuShNKKmIGQ |
| Context | British **library music**: production music written for TV, film and ads, not for the charts. Short, cleanly arranged, mood-driven. |
| Notable reuse | Sampled by Danger Mouse for DANGERDOOM's "Space Ho's" (2005), plus about 10 other samples listed on WhoSampled |
| Mood tag (from a YouTube listing) | "lazy mood, whistling featured" |

## 1. Core Specs

| Field | Value |
|---|---|
| Genre / subgenre | 🟡 Late-'60s British library music: easy listening, light orchestral, with a gentle jazz and Broadway-showtune flavor |
| Tempo (BPM) | 🎧 Probably a relaxed, strolling medium tempo (~90–110). Tap it out to confirm. |
| Key / mode | 🎧 Probably major and sunny. Confirm the key. |
| Time signature | 🟡 4/4, probably with a light swing or shuffle feel |
| Length | ✅ 2:05 (short and complete, typical of library cues) |
| Era / decade feel | ✅ 1969, London studio orchestra |
| Mood | 🟡 Lazy, carefree, sunny, unhurried, gently cheerful. Think "morning stroll in the city." |
| Energy curve | 🟡 Flat to gently rising. Library cues stay at a usable, even level with no big drops. |

## 2. Instrumentation & Production

- **Rhythm section:** 🟡 Brushed or lightly played kit, upright or electric bass walking or two-feel, light guitar or piano comping
- **Lead / melody:** ✅ Whistling is featured. 🎧 Check whether a wordless choir also carries the melody. The album is *Chorus and Orchestra*, so a "ba-da" or "ooh" choir part is likely somewhere in the arrangement.
- **Orchestra:** 🟡 Strings for warmth and countermelodies; muted brass and/or flutes and clarinets for answer phrases
- **Ear candy:** 🎧 Note any vibraphone, harpsichord, celeste, flute trills or pizzicato
- **Mix character:** 🟡 Warm, slightly roomy analog tape sound; instruments panned wide in the style of '60s stereo; clean and polished; little compression
- **Signature sound:** 🟡 A whistled, easy-going tune over a lush, polished light-orchestral bed. Sophisticated but casual.
- **Why it samples well:** Clean, tuneful phrases with space between them, which is ideal for chopping and looping.

## 3. Vocals

- **Type:** 🟡 No lead singer and no lyrics. The "vocals" are whistling and possibly a **wordless mixed choir**.
- **Choir delivery (if present):** Smooth and blended; "ba-da-ba," "doo," "ooh" or "ah" syllables in close harmony, in the Swingle Singers / Ray Conniff Singers vein
- **Effects:** Natural room reverb only

## 4. Structure Map 🎧

A typical shape for a 2-minute library cue. Fix the timings by ear.

| # | Section | Approx. time | What happens |
|---|---|---|---|
| 1 | Intro | 0:00–0:08 | Short pickup or vamp from the rhythm section |
| 2 | A (theme) | ~0:08–0:30 | Main whistled or choir melody over strings and rhythm |
| 3 | A' (repeat) | ~0:30–0:50 | Theme again, with fuller orchestration or answers from another section |
| 4 | B (bridge) | ~0:50–1:15 | Contrasting phrase, maybe a key shift or instrument handoff (brass/woodwinds) |
| 5 | A (return) | ~1:15–1:45 | Theme returns, fullest arrangement, choir and strings together |
| 6 | Tag / ending | ~1:45–2:05 | Button ending or ritard with a final chord. Library cues end cleanly. |

## 5. Melodic & "Lyric" Anatomy (for writing new material)

There are no lyrics, so the model is the **melody and phrasing**:
- 🟡 Simple, singable, stepwise melody with short breathing gaps between phrases
- 🟡 Four- or eight-bar phrases arranged as call and response (lead states, orchestra answers)
- 🟡 AABA-style song form, the classic Broadway/Tin Pan Alley structure the title hints at
- If you write lyrics *inspired* by it: a light, bright Broadway-ish tone. City-morning imagery (coffee, sunshine, sidewalks, taxis, newspapers), easygoing optimism, short lines (6–8 syllables), AABB or ABAB rhyme, and the title phrase as the hook at the end of each A section.

## 6. Suno Kit

### Style prompt: instrumental version (under 200 characters, no artist names)
```
1960s British library music, easy listening, light orchestra, whistled melody, lush strings, muted brass, brushed drums, walking bass, lazy swing, sunny, warm analog
```

### Style prompt: wordless choir version
```
1969 easy listening, light orchestral jazz, wordless mixed choir ba-da vocals, whistling, lush strings, flutes, brushed drums, relaxed swing, sunny morning, vintage stereo
```

### Style prompt: modern sample-flip version (DANGERDOOM-style use)
```
boom bap instrumental, chopped 1960s easy listening orchestra sample, whistled loop, vinyl crackle, dusty drums, laid-back, warm, jazzy
```

### Exclude styles
```
modern pop, EDM, autotune, trap, heavy distortion, rock, aggressive, sad
```

### Structure skeleton (instrumental mode on, or paste into Lyrics)
```
[Intro]
[Brushed drums and walking bass vamp]

[Instrumental: Theme A]
[Whistled melody over lush strings]

[Instrumental: Theme A Repeat]
[Wordless choir joins, ba-da-ba harmonies]

[Bridge]
[Muted brass and flutes answer, gentle key lift]

[Instrumental: Theme A Return]
[Full orchestra, choir and whistling together]

[Outro]
[Ritard, final sustained major chord]
[End]
```

### Wordless choir lyric line (if Suno needs "lyrics" to sing)
```
[Chorus]
Ba-da-ba-da, ba-da-ba-da-ba
Doo-doo-doo, doo-doo-dah
Ooh, ah, ooh
```

### Settings notes
- Use **Instrumental** mode for the purest result; use the choir prompt with the scat lyrics only if you want voices.
- Short cues work well. Ask for **about 2 minutes** and a **clean ending**: put `[End]` last.
- If Suno makes it too modern or punchy, add "vintage, analog tape, 1969, studio orchestra" and turn Weirdness down.

## 7. Brief for Claude

> Use this file as the blueprint for new tracks in the style of a 1969 British library-music cue.
> **Keep:** about 2-minute length, AABA form, whistled and/or wordless-choir lead, lush light-orchestral bed, lazy swing, sunny mood, clean ending.
> **Vary:** the setting/title ("Evening ___", "Sunday ___", "Harbour ___"), lead instrument (whistle → flute → choir → vibraphone), tempo, and key center.
> **Avoid:** naming real artists or labels in Suno prompts, copying the original melody, modern production terms.
> **Output:** Suno style prompt (under 200 chars), exclude list, and a tagged structure/lyric block like Section 6.

---

### 🎧 Ear-check list (fill in after one listen)
- [ ] BPM: ____
- [ ] Key: ____
- [ ] Lead: whistling / choir / both / other: ____
- [ ] Swing or straight? ____
- [ ] Section timings: ____
- [ ] Standout instrument I missed: ____

### Sources
- [Lyreka: KPM 1000 Series: Chorus and Orchestra](https://www.lyreka.com/album/keith-mansfield-syd-dale-kpm-1000-series-chorus-and-orchestra)
- [WhoSampled: Morning Broadway sampled](https://www.whosampled.com/Keith-Mansfield/Morning-Broadway/sampled/)
- [Wikipedia: Keith Mansfield](https://en.wikipedia.org/wiki/Keith_Mansfield)
- [NTS: Keith Mansfield](https://www.nts.live/artists/447-keith-mansfield)
- [YouTube: "Morning Broadway"](https://www.youtube.com/watch?v=I7kUIeYOcxE)
