# Remediation is applicable only in certain platforms
if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then

systemctl disable --now ctrl-alt-del.target
systemctl mask --now ctrl-alt-del.target

else
    >&2 echo 'Remediation is not applicable, nothing was done'
fi