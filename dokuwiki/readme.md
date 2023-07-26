
# dokuwiki

Command to run dokuwiki
```bash
docker run -d \
  --name=dokuwiki \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 80:80 \
  -p 443:443 `#optional` \
  -v ./config:/config \
  --restart unless-stopped \
  lscr.io/linuxserver/dokuwiki:latest
```
