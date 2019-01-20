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
use HTTP::Tiny;

# Hier Proxy eintragen und Kommentarzeichen '#' entfernen
# $proxy = "http://myhost:3128";

while(1) {
  print "Password to check:\n";
  ReadMode ( 'noecho' );
  my $pw = <STDIN>;
  ReadMode ( 'normal' );    #Back to your regularly scheduled program
  chomp $pw;

  last unless $pw =~ /\S/;
  $sha = sha1_hex($pw);
  $first = substr($sha, 0, 5);
  $rest = substr($sha, 5);
  
  print "SHA-1: $sha\n";
  
  $url = "https://api.pwnedpasswords.com/range/$first";
  $response = HTTP::Tiny->new(proxy => $proxy)->get($url);
  die "Cannot reach API" unless $response->{success};
  $answer = $response->{content};
  
  my $hits = 0;
  
  foreach $line(split /\n/, $answer) {
    if ($line =~ /$rest/i) {
      print "\nFound: $line\n";
      ++$hits;
    }
  }
}

exit($hits);
