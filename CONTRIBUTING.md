# Contributing

Thank you for your interest in contributing to this project!
Below you can check some resources to help you getting started.

## Versioning & Contributing

We use [SemVer][1] for versioning and [Conventional Commits][2] for contributing.

## Prerequisites

Make sure you have installed all of the following prerequisites on your development machine:

* Git - [Download & Install Git][3]. OSX and Linux machines typically have this already installed.
* Docker - [Download & Install Docker][4].
* DBeaver - [Download & Install DBeaver][5].

## Running the database

1. Make sure the current image on your machine is no longer necessary. The
image and container will be recreated from scratch.

2. Execute reload-database.sh to create and start the container:

   ```bash
   ./reload-database.sh
   ```

3. Check if the container 'study-track-database' is up and running:

   ```bash
   docker ps
   ```

## Connecting to the database

1. Open DBeaver or your prefered database tool;

2. Create a new Postgres connection, with the following properties:

   * **User**: system
   * **Host**: localhost
   * **Database**: db_study_track
   * **Password**: postgres
   * **Port**: 5432

All set! Now you can query and manipulate the database.

## Authors

* **Lucas Gomes** - *Initial work* - [lucasgomestech][6]

See also the list of [contributors][7] who participated in this project.

[1]: http://semver.org/
[2]: https://www.conventionalcommits.org/en/v1.0.0-beta.2/
[3]: https://git-scm.com/downloads
[4]: https://hub.docker.com/?overlay=onboarding
[5]: https://dbeaver.io/download/
[6]: https://github.com/lucasgomestech
[7]: https://github.com/lucasgomestech/study-track-database/graphs/contributors
