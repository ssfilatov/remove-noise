#!/bin/bash

# Check the number of arguments
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 video_url [-o output_name] [-i image_path]"
  exit 1
fi

# Default values
video_url="$1"
output_name="output"
image_path="image.jpg"

# Check if the optional -o option is provided
if [ "$#" -gt 2 ] && [ "$2" = "-o" ]; then
  output_name="$3"
fi

# Check if the optional -i option is provided
if [ "$#" -gt 4 ] && [ "$4" = "-i" ]; then
  image_path="$5"
fi

# Download video and extract audio
youtube-dl "$video_url" -x --audio-format wav --audio-quality 0 -o "$output_name".mp4

# Check the success of youtube-dl
if [ $? -ne 0 ]; then
  echo "Error during youtube-dl execution."
  exit 1
fi

# Call deep-filter to process the audio
deep-filter "$output_name".wav -o .

echo "WAV file created successfully."

ffmpeg -loop 1 -i "$image_path" -i "$output_name".wav -c:v libx264 -tune stillimage -c:a aac -b:a 192k -pix_fmt yuv420p -vf scale=1280:720 -shortest "$output_name".mp4

echo "Processing completed successfully."

