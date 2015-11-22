# luzifer-docker/terraria

This image contains a [Terraria](http://terraria.org/) 1.3.0.8 server with automatic world generatation and the possibility to store / inject a world using a Docker mount

## How to run

You can simply run the image with the default settings:

```
docker run -d -p 7777:7777 quay.io/luzifer/terraria
```

If you want the world to persist you can mount a volume into the container:

```
docker run -d -p 7777:7777 -v ~/terraria:/data quay.io/luzifer/terraria
```

