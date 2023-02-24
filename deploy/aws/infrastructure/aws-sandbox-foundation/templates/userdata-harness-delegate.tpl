MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: text/x-shellscript; charset="us-ascii"
#!/bin/bash
set -ex

ulimit -n 10000 && cd /var/tmp/harness-delegate && ./start.sh

--//--