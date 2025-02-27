# Solr Text to Vector Sample

## System Architecture

![system-architecture](images/solr-ttv-demo.drawio.png)

## Environment

### OS

The following environments have been confirmed to work.

```bash
$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=20.04
DISTRIB_CODENAME=focal
DISTRIB_DESCRIPTION="Ubuntu 20.04.6 LTS"
```

### Machine Spec

|      | Size |
| :--- | :--- |
| RAM  | 16GB |
| VRAM | 8GB  |

### Tools

|                | Version  |
| :------------- | :------- |
| Docker         | 20.10.21 |
| docker-compose | 1.29.2   |
| wget           | 1.20.3   |

## Usage

```bash
# initial
$ make all
# index already exists
$ make launch
```

Access http://localhost:8501 by any Browser.

## Related Documents

- [Solr のベクトル検索がちょっとだけ楽になったらしい](https://zenn.dev/sashimimochi/articles/35a54fa62d32aa)
