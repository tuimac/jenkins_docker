# Create Jenkins(Docker) Pipeline Environment

These scripts create Jenkins Environment on Docker. Plugins include for MY Pipeline environment.
These scirpts and files give you how to set configs.

## Getting Started

You have to install Docker on your machine before do below.

### How to build

#### Build and run Jenkins docker container

Run `run.sh` to build and run docker script.

```
$ ./run.sh create
```

And there is `./run.sh help` to help you understand how to use `run.sh`.

#### Set items through Jenkins CLI

Bash user can execute like below but other users couldn't. 

```
$ ./createPipeline.sh
```

Other user do following procedure.

* **Download API Client**

Download from `http://localhost:8080/jnlpJars/jenkins-cli.jar`.

* **Create items from GUI**

Literally.

* **Dump configuration to XML file**

```
$ java -jar jenkins-cli.jar -s http://localhost:8080 get-job <item name> >> Anyfilename.xml
```

* **Create item**
```
$ cat Anyfilename.yaml | java -jar jenkins-cli.jar -s http://localhost:8080 create-job <item name>
```

#### Access from Browser

Access `http://localhost:8080` is default.
So you can change the port within Dockerfilr or `run.sh` to config container port or deploy which network.

## Authors

* **Kento Kashiwagi** - [tuimac](https://github.com/tuimac)

If you have some opinion and find bugs, please post [here](https://github.com/tuimac/tagdns/issues).

## License

There is no license. I don't have any responsibility to this product.
