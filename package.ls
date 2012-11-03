name: 'webworker-threads'
version: '0.2.0'
main: 'build/release/WebWorkerThreads.node'
description: 'Lightweight Web Worker API implementation with POSIX threads'
keywords: [ 'threads' 'web worker' 'a gogo' ]
author: {
  name: 'Audrey Tang'
  email: 'audreyt@audreyt.org'
  twitter: 'audreyt'
}
homepage: 'https://github.com/audreyt/node-webworker-threads'
bugs: {
  url: 'http://github.com/audreyt/node-webworker-threads/issues'
  email: 'audreyt@audreyt.org'
}
license: 'MIT'
repository: {
  type: 'git'
  url: 'http://github.com/audreyt/node-webworker-threads.git'
}
scripts: {
  prepublish: 'livescript -cj package.ls'
  compile: """
gcc deps/minifier/src/minify.c -o deps/minifier/bin/minify;
livescript -cbp src/load.ls                      > src/load.js;
./deps/minifier/bin/minify kLoad_js              < src/load.js            > src/load.js.c;
livescript -cbp src/worker.ls                    > src/worker.js;
./deps/minifier/bin/minify kWorker_js            < src/worker.js          > src/worker.js.c;
livescript -cbp src/events.ls                    > src/events.js;
./deps/minifier/bin/minify kEvents_js            < src/events.js          > src/events.js.c;
livescript -cbp src/thread_nextTick.ls           > src/thread_nextTick.js;
./deps/minifier/bin/minify kThread_nextTick_js 1 < src/thread_nextTick.js > src/thread_nextTick.js.c;
livescript -cbp src/createPool.ls                > src/createPool.js;
./deps/minifier/bin/minify kCreatePool_js        < src/createPool.js      > src/createPool.js.c;
"""
gypfile: true
os: [ 'macos' 'linux' 'darwin' ]
engines: { node: '>=0.5.1' }