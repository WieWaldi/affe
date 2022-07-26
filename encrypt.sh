#!/usr/bin/env bash
#
# +----------------------------------------------------------------------------+
# | encrypt.sh                                                                 |
# +----------------------------------------------------------------------------+
# | Copyright © 2019 Waldemar Schroeer                                         |
# |                  waldemar.schroeer(at)rz-amper.de                          |
# +----------------------------------------------------------------------------+

# +----- Include bash-framework.sh --------------------------------------------+
export LANG="en_US.UTF-8"
export base_dir="$(dirname "$(readlink -f "$0")")"
export cdir=$(pwd)
export datetime="$(date "+%Y-%m-%d-%H-%M-%S")"
export logfile="${cdir}/${datetime}.log"
export framework_width=80
export notice=notice.txt
export bash_framework="${HOME}/.local/bin/bash-framework.sh"
source ${bash_framework}

# +----- Variables ------------------------------------------------------------+
export gnupg="/usr/bin/gpg"
export algo="AES256"

# +----- Functions ------------------------------------------------------------+

# read_secretly() {
#     unset secret
#     secret=
#     unset charcount
#     charcount=0
#     prompt="${1}"
#     while IFS= read -p "${prompt}" -r -s -n 1 char
#     do
#         if [[ $char == $'\0' ]]; then
#             break
#         fi
#         if [[ $char == $'\177' ]] ; then
#             if [ $charcount -gt 0 ] ; then
#                 charcount=$((charcount-1))
#                 prompt=$'\b \b'
#                 secret="${secret%?}"
#             else
#                 prompt=''
#             fi
#         else
#             charcount=$((charcount+1))
#             prompt='*'
#             secret+="${char}"
#         fi
#     done
#     echo "${secret}"
# }


# +----- Main -----------------------------------------------------------------+
if [[ "$#" = "0" ]]; then
    echo "No file specified."
    exit 1
fi
file=$1

echo_title "Passphrase"
password_1="$(read_secretly "Passphrase         ")"
echo
password_2="$(read_secretly "Confirm Passphrase ")"
echo

echo "Password 1:${password_1}"
echo "Password 2:${password_2}"

if [[ "${password_1}" = "${password_2}" ]]; then
    passphrase="${password_1}"
else
    echo_Error_Msg "You messed up!"
    exit 1
fi


echo "Pass ist:${passphrase}"
echo "Base: ${base_dir}"
echo "Log:${logfile}"
echo "CDIR: ${cdir}"

${gnupg} --batch --passphrase ${passphrase} --symmetric --armor --cipher-algo ${algo} --output ${file}.affe ${file}

# +----- End ------------------------------------------------------------------+
exit 0 
