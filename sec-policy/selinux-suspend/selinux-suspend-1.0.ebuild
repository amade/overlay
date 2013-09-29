EAPI="4"

IUSE=""
MODS="suspend"
BASEPOL="9999"
POLICY_FILES="suspend.te suspend.fc suspend.if"

inherit selinux-policy-2

DESCRIPTION="SELinux policy to allow s2disk to operate"

KEYWORDS="~amd64 ~x86"


