<img src="assets/logo.svg" width="200" height="200" />

PIANOBERRY
==========


Headless* [Pianoteq](https://www.modartt.com/pianoteq_overview) on Raspberry PI 5 with [Pisound](https://blokas.io/pisound/) sound card.  
Tweaked for ~1.5ms latency at 96kHz sample rate.

<small>* Headless: without a monitor, keyboard, or mouse.</small>

## Trying

1. Download the [latest image](https://github.com/elektrofon/pianoberry/releases/latest)
2. Flash the image to a microSD card using [Raspberry Pi Imager](https://www.raspberrypi.org/software/)
3. Insert the microSD card into the Raspberry PI 5 with a Pisound sound card
4. Connect a MIDI keyboard to the Pisound MIDI input or via USB
5. Play!

## Activating Pianoteq licence

1. Download the [latest image](https://github.com/elektrofon/pianoberry/releases/latest)
2. Flash the image to a microSD card using [Raspberry Pi Imager](https://www.raspberrypi.org/software/)
3. Download the licenced Pianoteq Linux Aarch64 binary from your Modartt account
4. Plug the SD card into your computer. You should see an external drive named `pianoberry`
5. Place your Linux Aarch64 Pianoteq 8 binary on the root of the `pianoberry` drive
6. Open the `config.txt` file on the root of the `pianoberry` drive. Scroll down to the bottom and add your serial number and initial preset:
```
[PIANOBERRY]
pianoteq_serial=xxxx-xxxx-xxxx-xxxx
pianoteq_initial_preset=NY Steinway D Jazz
```
7. Eject the SD card and insert it into the Raspberry PI 5 with a Pisound sound card
8. Connect a MIDI keyboard to the Pisound MIDI input or via USB
9. Play!

**Activation of the licence requires internet connection on first boot**.  
After the activation, Pianoberry doesn't need network access.

Please do not contact Modartt support about Pianoberry activation issues.  
Open an issue in this repository instead.

## Building

### Requirements

- [Docker](https://docs.docker.com/get-docker/)
- [Pianoteq](https://www.modartt.com/pianoteq_overview) Linux Aarch64 binary

### Building

1. Download the Pianoteq 8 Standard trial for Linux from the [Pianoteq website](https://www.modartt.com/try?file=pianoteq_linux_trial_v840.7z)
2. Place the Linux Aarch64 Pianoteq 8 trial binary in the `pianoteq` directory
3. Build:

```bash
./build
```

The image will be created in the `deploy` directory.

### Get build options

```bash
./build --help
```

```
Usage: ./build [options]
Options:
  --force-rebuild            Force rebuild of the pianoberry-build image.
  --help                     Show this help message.
```

---

<i><sup>
The prebuilt Pianoberry image includes a trial version of Pianoteq Standard.  
Pianoteq is redistributed courtesy of Modartt.  
Please don't redistribute the Pianoteq binary without explicit permission from Modartt.
</sup></i>
