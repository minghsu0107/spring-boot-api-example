## Overview

An example project to demonstrate:

* how to create a Spring Boot REST API with Gradle
* how to run Spring Boot in Docker and publish to Docker Hub
* how to integrate Sprint Boot with Jenkins CI

## Pre-requisites

* JDK 8+
* Docker
* Github webhook
  * `Settings` -> `Webhooks` -> add a webhook `https://<jenkins-host>/github-webhook/` with content type `application/json`
* Jenkins
  * If Jenkins is running in a container, remember to mount host docker socket so that Jenkins could build and publish docker image in pipeline steps
  * To create a new project, click `New item` and choose `Multibranch Pipeline`
    * `Branch Sources` -> Enter Repository HTTPS URL
    * `Build Configuration` -> Mode: `by Jenkinsfile`, Script Path: `Jenkinsfile`

Note that to initialize a gradle project, run `gradle init` to start the Gradle setup wizard, choosing to create a basic Groovy project with the default name. This creates a skeleton of a Gradle project, including the Gradle wrapper used for interacting with the application.
## Running
```bash
./gradlew bootRun
```
## Building
### Testing
```bash
./gradlew test
```
### Building (no tests)
```bash
./gradlew assemble
```
### Building (with tests)
```bash
./gradlew build
```
### Building and Running in Docker
The following command build applcation jar without tests, build docker image, and run the container in the backgroud.
```bash
./gradlew assemble docker dockerRun
```
### Stopping Docker container
```bash
./gradlew dockerStop
```
## Using API

* get all rides - GET [/ride](http://localhost:8080/ride) to get a list of all the rides
* get specific ride - GET [/ride/${id}](http://localhost:8080/ride/1) to get a specific ride
* create ride - POST JSON to [/ride](http://localhost:8080/ride) to create a new ride 