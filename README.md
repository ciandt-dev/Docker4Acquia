# CI&T Docker4Acquia project

This project intends to be a containerized solution that mimics Acquia environment for multiple purposes.

The source code is available under GPLv3 at Github in this [link](https://github.com/ciandt-dev/Docker4Acquia/blob/master/LICENSE).

The solution utilizes the same versions of softwares, packages, modules and its underlying operating system as Acquia, we do our best effort to keep updated with the published platform infrastructure table on Acquia website: https://docs.acquia.com/cloud/arch/tech-platform.

By utilizing Docker technologies, that already provides an easy way of spinning up new environments along with its dependecies. This image can speed up developers which different backgrounds and equipments to create quickly a new local environment allowing them to easily integrate in automated tests and deployment pipelines.

Per design this solution will treat each Docker4Acquia running as a __Acquia subscription__, *what does it mean?*

Means that it is capable of running __multiple environments__ at the same time and each one of them are __isolated__ one from another.

* * *

## [*Requirements*](#requirements)

* __Any Linux OS__ *(Support for Mac/Windows will come soon)*
* Docker Engine => 1.12
* Docker Compose => 1.8.0
* Mysql Client >=5.5
* Netcat (nc)
* Lynx
* make

* * *

## [Bundled software](#bundled-software)

At this moment this solution already contains the following Docker images:

| Docker-Compose | Docker Hub Image                                                               |  Port  |
| -------------- | ------------------------------------------------------------------------------ | ------ |
| cache          | [ciandtsoftware/memcached](https://hub.docker.com/r/ciandtsoftware/memcached)  | 11211  |
| database       | [ciandtsoftware/percona](https://hub.docker.com/r/ciandtsoftware/percona)      | 3306   |
| search         | [ciandtsoftware/solr](https://hub.docker.com/r/ciandtsoftware/solr)            | 8983   |
| web            | [ciandtsoftware/php](https://hub.docker.com/r/ciandtsoftware/php)              | 80/443 |

\**For specific software, OS, modules and libraries versions, please visit the refered Docker Image page*

* * *

## [Versioning](#versioning)

Github repo will have the following name pattern;

> __acquia-*YYYY-MM-DD*__

And also a tag with __acquia-latest__ for easy use.

* * *

## [Quick Start](#quickstart)

First of all, download the code from __[Acquia subscription GIT repository](https://docs.acquia.com/cloud/manage/code/repository/git)__.

We recommend to adopt the path __/home/your-user/workspace__ as your workspace. Then, open a terminal go to the root of your subscription code, probably it is __/home/your-user/workspace/your-subscription__, and add Docker4Acquia as a __[GIT submodule](https://git-scm.com/docs/git-submodule)__ with the command:

```
git submodule add https://github.com/ciandt-dev/docker4acquia
```


Simply start Docker4Acquia with __default parameters__:

```
cd docker4acquia
make
```

You are ready to go, just follow the instructions on the screen.

* * *

## [How-to](#how-to)

It is possible to perform any of the actions described below:

### [*Build*](#how-to-build)

```
make build
```

### [*Run*](#how-to-run)

```
make run
```

### [*Test*](#how-to-test)

```
make test
```

### [*Debug*](#how-to-debug)

```
make debug
```

### [*Shell access*](#how-to-shell)

```
make shell
```

### [*Clean*](#how-to-clean)

```
make clean
```

### [*Clean All*](#how-to-clean-all)

```
make clean-all
```

### [*All - Build / Run / Test*](#how-to-all)

```
make all
```

<sub>*or simply*</sub>

```
make
```

* * *

## [User Feedback](#user-feedback)

### [*Issues*](#issues)

If you have problems, bugs, issues with or questions about this, please reach us in [Github issues page](https://github.com/ciandt-dev/Docker4Acquia/issues).

__Needless to say__, please do a little research before posting.

### [*Contributing*](#contributing)

We gladly invite you to contribute fixes, new features, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a GitHub issue, especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.

* * *

Happy coding, enjoy!!

"We develop people before we develop software" - Cesar Gon, CEO
