# `yt-dlp` docker image for Ceska televize

This doesn't do much, it just takes the upstream `yt-dlp` repository
and replaces `ceskatelevize.py` extractor with the one developed
y `user:peci1` ([https://github.com/peci1/yt-dlp](peci1/yt-dlp)).

Then it sets some options I consider useful when downloading from iVysilani,
but feel free to change them to your liking.

## Example

```bash
docker run -v ./download:/download -it yt-dlp-czechtv https://www.ceskatelevize.cz/porady/12091158348-zeme-patri-lune/222385702090022/
```

## References

- https://github.com/yt-dlp/yt-dlp
- https://github.com/peci1/yt-dlp (currently working fix)
