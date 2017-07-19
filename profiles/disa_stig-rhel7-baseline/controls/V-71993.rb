# encoding: utf-8
#
=begin
-----------------
Benchmark: Red Hat Enterprise Linux 7 Security Technical Implementation Guide
Status: Accepted

This Security Technical Implementation Guide is published as a tool to improve
the security of Department of Defense (DoD) information systems. The
requirements are derived from the National Institute of Standards and
Technology (NIST) 800-53 and related documents. Comments or proposed revisions
to this document should be sent via email to the following address:
disa.stig_spt@mail.mil.

Release Date: 2017-03-08
Version: 1
Publisher: DISA
Source: STIG.DOD.MIL
uri: http://iase.disa.mil
-----------------
=end

control "V-71993" do
  title "The x86 Ctrl-Alt-Delete key sequence must be disabled."
  desc  "A locally logged-on user who presses Ctrl-Alt-Delete, when at the console,
can reboot the system. If accidentally pressed, as could happen in the case of a
mixed OS environment, this can create the risk of short-term loss of availability of
systems due to unintentional reboot. In the GNOME graphical environment, risk of
unintentional reboot from the Ctrl-Alt-Delete sequence is reduced because the user
will be prompted before any action is taken."
  impact 0.7
  tag "severity": "high"
  tag "gtitle": "SRG-OS-000480-GPOS-00227"
  tag "gid": "V-71993"
  tag "rid": "SV-86617r1_rule"
  tag "stig_id": "RHEL-07-020230"
  tag "cci": "CCI-000366"
  tag "nist": ["CM-6 b", "Rev_4"]
  tag "check": "Verify the operating system is not configured to reboot the system
when Ctrl-Alt-Delete is pressed.

Check that the ctrl-alt-del.service is not active with the following command:

# systemctl status ctrl-alt-del.service
reboot.target - Reboot
   Loaded: loaded (/usr/lib/systemd/system/reboot.target; disabled)
   Active: inactive (dead)
     Docs: man:systemd.special(7)

If the ctrl-alt-del.service is active, this is a finding."
  tag "fix": "Configure the system to disable the Ctrl-Alt_Delete sequence for the
command line with the following command:

# systemctl mask ctrl-alt-del.target

If GNOME is active on the system, create a database to contain the system-wide
setting (if it does not already exist) with the following command:

# cat /etc/dconf/db/local.d/00-disable-CAD

Add the setting to disable the Ctrl-Alt_Delete sequence for GNOME:

[org/gnome/settings-daemon/plugins/media-keys]
logout=’’"

  #@todo - test!
  describe service('ctrl-alt-del.service') do
    it {should_not be_running }
  end
end
