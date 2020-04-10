# Docker4Acquia

This project intends to be a containerized solution that mimics Acquia environment for multiple purposes.

The source code is available under GPLv3 at GitHub in this [link](https://github.com/ciandt-dev/Docker4Acquia/blob/master/LICENSE).

The solution utilizes the same versions of softwares, packages, modules and underlying operating system as Acquia. We do our best efforts to keep it updated according to the published platform infrastructure table from Acquia's website: https://docs.acquia.com/cloud/arch/tech-platform.

By leveraging Docker technologies, Docker4Acquia provides an easy way of spinning up new environments along with its dependencies. This image can speed up a developer's onboarding time, despite his/her backgrounds and equipments, and quickly create a new local environment allowing them to easily integrate in automated tests and deployment pipelines.

Per design this solution will treat each Docker4Acquia instance/copy running as a __Acquia subscription__, *what does it mean?*

It means that it's capable of running __multiple environments__ at the same time and each one of them are __isolated__ one from another.

* * *

## [*Requirements*](#requirements)

* Docker Engine => 1.12
* Docker Compose => 1.8.0
* Mysql Client >=5.5
* Netcat (nc)
* Lynx
* make

__Note for Windows users:__ On Windows environments it is also required to install Linux Bash for Windows, more information about it can be found [here](https://msdn.microsoft.com/en-us/commandline/wsl/about) and [here](http://www.howtogeek.com/249966/how-to-install-and-use-the-linux-bash-shell-on-windows-10/).

* * *

## [Bundled software](#bundled-software)

At this moment this solution already contains the following Docker images:

| Docker-Compose | Docker Hub Image                                              |  Port  |
| -------------- | ------------------------------------------------------------- | ------ |
| cache          | [ciandt/memcached](https://hub.docker.com/r/ciandt/memcached) | 11211  |
| database       | [ciandt/percona](https://hub.docker.com/r/ciandt/percona)     | 3306   |
| search         | [ciandt/solr](https://hub.docker.com/r/ciandt/solr)           | 8983   |
| web            | [ciandt/php](https://hub.docker.com/r/ciandt/php)             | 80/443 |

\**For specific software, OS, modules and libraries versions, please visit the refered Docker Image page*

* * *

## [Versioning](#versioning)

GitHub repo will have the following pattern;

> __*YYYY-MM-DD*__

And also it is always available the latest version though this [link](https://github.com/ciandt-dev/Docker4Acquia/releases/latest).

* * *

## [Quick Start - Running with default configurations](#quickstart)

First of all, download the code from __[Acquia subscription GIT repository](https://docs.acquia.com/cloud/manage/code/repository/git)__.

We recommend to adopt the path __/home/your-user/workspace__ as your workspace. Then, open a terminal go to the root of your subscription code, probably it is __/home/your-user/workspace/your-subscription__, and add Docker4Acquia as a __[GIT submodule](https://git-scm.com/docs/git-submodule)__ with the command:

```
git submodule add https://github.com/ciandt-dev/Docker4Acquia.git
```

Simply start Docker4Acquia with __default parameters__:

```
cd docker4acquia
make linux # Change to mac OR windows according to your OS
```

You are ready to go, just follow the instructions on the screen.

* * *

## [Customizing](#customizing)

There are two options to customize Docker4Acquia to better suit your project needs.

First one is to __[fork](https://help.github.com/articles/fork-a-repo/)__ Docker4Acquia. This is very usefull when you can have your code avaiable publicly on [Github](https://www.github.com). And the second one, is to donwload a [release of Docker4Acquia](https://github.com/ciandt-dev/Docker4Acquia/releases) and commit the modified code in your Acquia subscription GIT repository directly.

Lets explore these two options in detail.

### [*Fork*](#fork)

Before starting any change, fork the project.
In order to achieve it, please read Github official documentation about this topic [here](https://help.github.com/articles/fork-a-repo/).

Then, download the code from your __[Acquia subscription GIT repository](https://docs.acquia.com/cloud/manage/code/repository/git)__.

We recommend to adopt the path __/home/your-user/workspace__ as your workspace. Then, open a terminal go to the root of your subscription code, probably it is __/home/your-user/workspace/your-subscription__, and add your __Docker4Acquia fork__ as a __[GIT submodule](https://git-scm.com/docs/git-submodule)__ with the command:

```
git submodule add https://github.com/my-Org/my-Fork-Repo
```

Change anything you may need and remember to commit.

Then, simply start Docker4Acquia with __custom parameters__:

```
cd docker4acquia
make linux # Change to mac OR windows according to your OS
```

You are ready to go, just follow the instructions on the screen

### [*Bundling in Acquia git*](#bundling-acquia-git)

By any reason that your project may require to keep the code private, you can download the latest release of Docker4Acquia in [releases page](https://github.com/ciandt-dev/Docker4Acquia/releases) and customize it.
For obvious reasons, we always recommend to use the newest version.

Start by downloading the code from your __[Acquia subscription GIT repository](https://docs.acquia.com/cloud/manage/code/repository/git)__. We recommend to adopt the path __/home/your-user/workspace__ as your workspace.

After, simply download the [latest Docke4Acquia release](https://github.com/ciandt-dev/Docker4Acquia/releases/latest), decompress in the root of your Git repo and change anything your project need.

Then, just run Docker4Acquia
```
cd docker4acquia
make linux # Change to mac OR windows according to your OS
```
You are ready to go, just follow the instructions on the screen

* * *

### [*.gitignore*](#gitignore)

Hence your project is already hosted on Acquia platform there is no need to commit Docker4Acquia files other than __dev__ branch.

Nevertheless, remember to include Docker4Acquia folder in your __.gitignore__ file in __stage__ and __master__ (production) branches.

* * *

### [*.env - Changing parameters*](#changing-parameters)

There is an __.env__ file in the root of Docker4Acquia that can help tune Docker4Acquia in your project.

This file has several entries, better explained as follows.

* * *

### [*Using custom Docker Images*](#custom-docker-images)

#### [*Building*](#custom-docker-images-build)

Every Docker Image in this project is prepared to be customized to better fit any project requirements.

Let's suppose that your project needs a custom version of Memcached image for example.

First of all, open the file __infrastructure/docker-compose.yaml__, uncomment the build line and comment the image line.

From this:

```
#build: ./custom/memcached
image: ciandt/memcached:acquia-latest
```

To this:

```
build: ./custom/memcached
#image: ciandt/memcached:acquia-latest
```

After changing the docker-compose.yaml file just change the __infrastructure/custom/memcached/Dockerfile__ to customize your Memcached with everything that your project may need.

To check if your Docker Image is building appropriately, simply run:

```
make build
```

If the build has run properly you are ready to go and use your own custom Docker Image.

#### [*Your own Docker Hub hosted image*](#custom-docker-images-byoi)

If your project already have a public Docker Hub image and you want to use instead of the default Docker4Acquia one, just simply open the __infrastructure/docker-compose.yaml__ and change to your own.

Let's suppose that you are changing Solr image.

From this:

```
image: ciandt/solr:acquia-latest
```

To this:

```
image: my-Docker-Hub-repo/my-Image:latest
```

Then you can use the bundled make commands to run and test with your Docker Image.

* * *

## [How-to](#how-to)

It is possible to perform any of the actions described below:

### [*Build*](#how-to-build)

Build Docker images

```
make build
```

### [*Run*](#how-to-run)

Build Docker images and run Docker Containers based on built Docker images

```
make run
```

### [*Test*](#how-to-test)

Perform some tests on runnning Docker containers (requires run first)

```
make test
```

### [*Debug*](#how-to-debug)

Build Docker images, run Docker Containers based on built Docker images and attaches output to current shell

```
make debug
```

### [*Shell access*](#how-to-shell)

Build Docker images, run Docker Containers based on built Docker images and attaches to PHP container bash

```
make shell
```

### [*Clean*](#how-to-clean)

Stop running Docker containers, remove the containers and Docker network

```
make clean
```

### [*Clean All*](#how-to-clean-all)

Stop running Docker containers, remove the containers, delete Docker images and Docker network

```
make clean-all
```

### [*All*](#how-to-all)

Build Docker images, run Docker Containers based on built Docker images and perform tests

```
make all
```

<sub>*or simply*</sub>

```
make
```

### [*Proxy*](#how-to-proxy)

Creates a Nginx proxy that exposes the HTTP and HTTPS port and redirects to Docker4Acquia containers, it is used for MacOS and Windows compatibity hence they work differently of Linux.
More information about the proxy can be found [here](https://github.com/jwilder/nginx-proxy).

```
make proxy
```

### [*Linux*](#how-to-linux)

Same as make all

```
make linux
```

### [*Mac*](#how-to-mac)

Same as build, run and proxy

```
make mac
```

### [*Windows - Same as build, run and proxy*](#how-to-windows)

Same as build, run and proxy

```
make windows
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
