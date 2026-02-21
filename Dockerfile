# FROM ghcr.io/astral-sh/uv:debian
FROM docker.io/python:3.12-slim

# Copy 'uv' from the official image for incredibly fast package installation
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
COPY --from=docker.io/mwader/static-ffmpeg:8.0.1 /ffmpeg /bin/

VOLUME ["/download"]

WORKDIR /app
RUN apt-get update && apt-get install -y git
RUN git clone --single-branch https://github.com/yt-dlp/yt-dlp.git /app
RUN uv add brotli certifi mutagen requests urllib3 websockets yt_dlp_ejs
# https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-arm64-static.tar.xz
ADD ./ceskatelevize.py yt_dlp/extractor/

ENTRYPOINT ["uv", "run", "/app/yt-dlp.sh", "--force-ipv4", "--verbose", "-o", "/download/%(title)s [%(id)s].%(ext)s", "--audio-multistreams", "-f", "bv*+mergeall[vcodec=none]", "--embed-subs", "--embed-metadata", "--all-subs"]
CMD ["--verbose", "--force-ipv4", "--sleep-interval 5", "--max-sleep-interval 30", "--ignore-errors", "--no-continue", "--no-overwrites", "--download-archive archive.log", "--add-metadata", "--write-description", "--write-info-json", "--write-annotations", "--write-thumbnail", "--embed-thumbnail", "--all-subs", "--embed-subs"]
