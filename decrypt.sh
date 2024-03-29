#!/usr/bin/env bash
#
# +----------------------------------------------------------------------------+
# | decrypt.sh                                                                 |
# +----------------------------------------------------------------------------+
# | Copyright © 2019 Waldemar Schroeer                                         |
# |                  waldemar.schroeer(at)rz-amper.de                          |
# +----------------------------------------------------------------------------+

# +----- Variables ------------------------------------------------------------+
gnupg="/usr/bin/gpg"
algo="AES256"

# +----- Functions ------------------------------------------------------------+

# +----- Main -----------------------------------------------------------------+
if [[ "$#" = "0" ]]; then
    echo "No file specified."
    exit 1
fi
file=$1

${gnupg} --decrypt --pinentry-mode loopback ${file}

# +----- End ------------------------------------------------------------------+
exit 0 
