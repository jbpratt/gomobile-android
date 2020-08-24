```
docker run -v $(pwd):/x/ \
  -ti --rm docker.pkg.github.com/jbpratt/gomobile-android/gomobile-android \
  /bin/bash -c "cd /x && gomobile init && gomobile bind -o /x/sample.aar -target=android /x/sample"
```
