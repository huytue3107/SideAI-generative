abi <abi/4.0>,
include <tunables/global>

profile sideai /opt/SideAI/sideai flags=(unconfined) {
  userns,
  include if exists <local/sideai>
}
