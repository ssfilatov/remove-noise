# Remove noise from youtube audio

The intention of the script is to remove noise from youtube video, convert it to audio and create a static-image video so it can be uploaded back to youtube.

What this script does step by step:
1. downloads video from youtube via youtube-dl
2. uses youtube-dl post-processing to retrieve "wav"
3. applies DeepFilterNet(https://github.com/Rikorose/DeepFilterNet)
4. creates static-image video from the audio

Usage:
```bash
chmod +x remove-noise.sh
./remove-noise.sh <url> -o <output-name> -i <image-path> 
```
