# nujiistudio.js

User interface assets for [Nujii Studio Digital Audio Workstation](http://www.nujii.com). 

[![Build Status](https://secure.travis-ci.org/nujii/nujiistudio.js.png?branch=development)](http://travis-ci.org/nujii/nujiistudio.js)

## Overview

Nujii Studio is a collaborative [digital audio workstation](http://en.wikipedia.org/wiki/Digital_audio_workstation) allowing musicians to mix and produce with each other from anywhere in the world.

## Building

    npm install
    grunt

## Development

    npm install -d
    grunt dev

You can start using the application in the browser at [localhost:3333](http://localhost:3333)

Nujii Studio uses [LiveReload](http://livereload.com) for easier development.  You can download the browser extensions [here](http://feedback.livereload.com/knowledgebase/articles/86242-how-do-i-install-and-use-the-browser-extensions-).

## Contributing to Nujii Studio

We want this experience to be collaborative at all levels, including development.  We encourage contributions from the community.  Here's how to get started.

  * Fork the project
  * Make your changes and run the [tests](#testing)
  * Commit your changes and push them to your fork
  * Open a pull request on GitHub
  * We will review the pull request, suggest changes, and merge it when it's ready.

## How to Report a Bug

You can submit a bug [here](https://github.com/nujii/nujiistudio.js/issues)

## Testing

First install the dependencies

    npm install -d

Then run the tests

    npm test
