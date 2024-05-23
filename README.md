# Noise of Antimatter - Subshaper
## disclaimer
This repository contains all files required to make or repair the SSH. The following files are provided as is, with no responsibility. They're provided for personal use only. If you'd like to sell anything made out of them feel free to ping me, I'm mostly ok, as long as you're not big company scamming small manufacturers :)
## Module description
SSH is 16HP triple waveshaper with subharmonicon and sequencer. It's versatile tool for enriching sound sources and animating voices. More information can be found on [the webpage](https://noiseofantimatter.com/modules/ssh_module/) or by checking out [the demo](https://www.youtube.com/watch?v=Nd7Cz19s0W0).
![photo of the module](/IMG_5130.JPG)

## File structure
- electronics design can be found in folder [electronics](/electronics)
  - schematic.pdf is useful for quick look. For editing and deep dive full kicad design is provided. Project was done in kicad 6 but seems to work equally well in 7/8
- CPDL firmware is provided in folder [greenpak](/greenpak)
  - the device hides all complex digital logic into two greenpak CPLDs.
  - Their configuration and ESP32 software used for flashing are here
- panel design can be found in folder [panel](/panel)
  - panel has been designed as 3d model in openSCAD. Two projections are available for CNC production. Additionally, stls for dual color printing are provided
- manual generating files and pdf can be found in [manual](/manual)
  - It's written in LaTeX. For people who don't know LaTeX I recommend you read about it, especially if you're doing group projects and need to git proper documents
