#!/bin/bash

JENKINS_TAG_VERSION="jenkins-2.131"
PLAY_GROUND="playground"

function check_maven_installed() {

	if (mvn --version); then
		echo "ok maven is installed"
	else
		echo "ERROR we need maven Please install"
		exit 1
	fi

}

function create_playground() {

	cd "$HOME" || exit 1
	mkdir "${PLAY_GROUND}"
	cd "${PLAY_GROUND}" || exit 1

}

function checkout_jenkins_repo() {

	git clone https://github.com/jenkinsci/jenkins.git
	cd "$HOME/${PLAY_GROUND}/jenkins" || exit 1
	# be sure you have all tags local
	git fetch --all --tags --prune

}

function switch_version() {

	cd "${PLAY_GROUND}"/jenkins || exit 1
	git checkout tags/${JENKINS_TAG_VERSION}

}

function build_minimal_jenkins() {

	# from BUILDING.TXT
	mvn clean install -pl war -am -DskipTests

}

create_playground
checkout_jenkins_repo
switch_version
build_minimal_jenkins
