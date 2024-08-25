# run.sh 

A collection of shell scripts that make my every developer life easier. It's best to add the `run.sh` scripts as an alias to `.bashrc`.

```bash
alias run.sh=~/run.sh/run.sh
```

## Minimal requirements

A bash interpreter and [fzf](https://github.com/junegunn/fzf). That's it. Everything else is required on a per script basis. For example spawning a temporary postgres container & psql shell using [shared/new-temporary-postgres.sh](shared/new-temporary-postgres.sh) requires [docker](https://docs.docker.com/).

## License

This project is licensed under the [GLWTSPL](/LICENSE.txt).

![Good Luck](https://github.com/me-shaon/GLWTPL/raw/master/good-luck.gif)

...and godspeed.
