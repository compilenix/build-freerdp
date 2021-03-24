# Build FreeRDP
```sh
git clone https://git.compilenix.org/CompileNix/build-freerdp.git
cd build-freerdp
docker build -t build-freerdp:fedora-33 .
docker run --rm -it -v $(pwd)/dist:/dist build-freerdp:fedora-33
ls -la "dist/*.zip"
```
