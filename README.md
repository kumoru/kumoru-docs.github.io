# Kumoru.io Documentation

Welcome to the official Kumoru.io documentation (docs.kumoru.io) repo. The documentation is build using [Slate](https://github.com/tripit/slate).

The documentation is served via github pages off the branch `gh-pages`.

## Preview

To build and preview the documentation, you can use the following docker command once you've cloned the repo.

```shell
$ docker run -d -p 4567:4567 --name slate -v $(pwd):/app/source -v $(pwd)/build:/app/build quay.io/kumoru/slate
```

The docs will be available at `http://<DOCKERMACHINE_IP>:4567/`

## Building
To build and commit the docs, run `bash build-html.sh`. Note: you must have write privileges to this repo.

## Contributing
1. Clone the repo
2. Edit the files in `source/`
3. Submit a Pull Request
