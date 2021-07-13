## Overview
An example project to demonstrate:

* how to create a Spring Boot REST API with unit testing
* how to run Spring Boot in Docker and publish to Docker Hub using Gradle
* how to integrate Gradle with Jenkins CI

### Pre-requisites
* JDK 8+
* Docker
* Github webhook
  * `Settings` -> `Webhooks` -> add a webhook `https://<jenkins-host>/github-webhook/` with content type `application/json`
* Jenkins
  * To create a new project, click `New item` and choose `Multibranch Pipeline`
    * `Branch Sources` -> `Add Source` -> `Github` -> enter Repository HTTPS URL
    * `Build Configuration` -> Mode: `by Jenkinsfile`, Script Path: `Jenkinsfile`
  * To registal credentials, go to `Manage Jenkins` -> `Manage Credentials` -> `Jenkins` -> `Global Credentials` -> `Add Credentials` -> enter username, password, and credential ID. In our example, the credential ID is `docker-hub`, which contains the dockerhub username and password
  * If Jenkins runs in a container, remember to mount host docker socket so that Jenkins could build and publish docker image in pipeline steps. Below is a docker-compose example.

```yaml
version: '3'
services:
  jenkins:
    image: jenkinsci/blueocean:1.24.7
    restart: always
    ports:
      - 8080:8080
      - 50000:50000
    tty: true
    user: root
    volumes:
      - jenkins-data:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
volumes:
  jenkins-data:
```
### Running
Using gradlew wrapper:
```bash
./gradlew bootRun
```
Using gradle:
```bash
gradle bootRun
```
### Project Initialization
To initialize a gradle project, run `gradle init` to start the Gradle setup wizard, choosing to create a basic Groovy project with the default name. This creates a skeleton of a Gradle project, including the Gradle wrapper used for interacting with the application.
### Testing
Using gradlew wrapper:
```bash
./gradlew test
```
Using gradle:
```bash
gradle test
```
### Building (no tests)
Clean and build without tests using gradlew wrapper:
```bash
./gradlew clean assemble
```
Using gradle:
```bash
gradle clean assemble
```
### Building (with tests)
Clean and build with tests using gradlew wrapper:
```bash
./gradlew clean build
```
Using gradle:
```bash
gradle clean build
```
### Building and Running in Docker
The following command build applcation jar without tests, build docker image, and run the container in the backgroud.
```bash
./gradlew assemble docker dockerRun
```
Using gradle:
```bash
gradle assemble docker dockerRun
```
### Stopping Docker container
Using gradlew wrapper:
```bash
./gradlew dockerStop
```
Using gradle:
```bash
gradle dockerStop
```
### Using API

* get all rides - GET [/ride](http://localhost:8080/ride) to get a list of all the rides
* get specific ride - GET [/ride/${id}](http://localhost:8080/ride/1) to get a specific ride
* create ride - POST JSON to [/ride](http://localhost:8080/ride) to create a new ride 