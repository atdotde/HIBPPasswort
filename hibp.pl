#!/usr/bin/perl

# Check locally if password is in the HaveIBeenPawned database
# using the range API described on https://www.troyhunt.com/ive-just-launched-pwned-passwords-version-2/
# by
# Robert C. Helling (helling@atdotde.de)
#
# published under GNU General Public License v2.0 (GPL 2.0)


# Functional style
use Digest::SHA1  qw(sha1 sha1_hex sha1_base64);
use Term::ReadKey;

print "Password to check:\n";
ReadMode ( 'noecho' );
my $pw = <STDIN>;
ReadMode ( 'normal' );    #Back to your regularly scheduled program
chomp $pw;

$sha = sha1_hex($pw);
$first = substr($sha, 0, 5);
$rest = substr($sha, 5);

print "SHA-1: $sha\n";

$answer = `curl -s https://api.pwnedpasswords.com/range/$first`;

foreach $line(split /\n/, $answer) {
  if ($line =~ /$rest/i) {
    print "\nFound: $line\n";
  }
}
