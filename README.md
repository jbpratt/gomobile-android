```
docker run -v $(pwd):/go/src/x/ --rm \
  docker.pkg.github.com/jbpratt/gomobile-android/gomobile-android:latest /bin/bash -c \
  "cd /go/src/x && gomobile init && gomobile bind -o ./sample.aar -target=android ./sample"
```
