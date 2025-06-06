# tftmixer
 
Forking the tftmizer by OfficiallySp because I wanted to try and implement some features and wanted to experiment.
OfficiallySp's repo https://github.com/OfficiallySp/tftmixer

## Launching in local
### Docker
Make sure docker is installed. You should be able to run docker -h and get a list of help commands.

Run ``docker-compose up`` or use ``sh dev.sh up``

The local site should launch and you can access under ``http://localhost:8080``

We do this because when trying to launch by just opening the index.html, it tries to access the files under files//:path/to/music/files, but it's unable to play because it's trying to prevent a CORS vulnerability, which is reasonable. By launching in a docker container that serves the files in a website-like format. We fix this issue when trying to play or test on our machine.
