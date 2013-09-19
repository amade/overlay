EAPI="4"

IUSE=""
MODS="rfkill"
BASEPOL="9999"
POLICY_FILES="rfkill.te rfkill.fc rfkill.if"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for local stuff"

KEYWORDS="~amd64 ~x86"


