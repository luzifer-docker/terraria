# luzifer-docker/terraria

This image contains a [Terraria](http://terraria.org/) 1.3.5.3 server with automatic world generatation and the possibility to store / inject a world using a Docker mount

## How to run

You can simply run the image with the default settings:

```console
$ docker run -d --name=terraria -p 7777:7777 luzifer/terraria
```

If you want the world to persist you can mount a volume into the container:

```console
$ docker run -d --name=terraria -p 7777:7777 -v ~/terraria:/data luzifer/terraria
```

### Interacting with the server command line

In case you want to use the [console commands](https://terraria.gamepedia.com/Server#List_of_console_commands) on the Terraria server this image has a helper for you:

```console
$ docker exec terraria terraria_cmd save
```
