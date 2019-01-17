# HIBPPasswort
Check locally if password is in HaveIBeenPawned Database

Today, another dump of email/password combinations became pubic termed
Collection #1 in
https://www.troyhunt.com/the-773-million-record-collection-1-data-reach/

It is easy to search HaveIBeenPawned for your email address but that
will almost surely show up everywhere. The question is if your
passwords are there as well (at least the ones for important sites, as
I am sure we are all using different passwords for different
sites....). So you want to check if your password has become public.

Of your you don't want to ask anybody if your password is in the list
because that would mean you have to tell somebody your password. You
rather want to check that yourself (do it locally on your own
computer).

Luckily, HaveIBeenPawned offers an API for that (see
https://www.troyhunt.com/ive-just-launched-pwned-passwords-version-2/
) The idea is to locally compute the SHA-1 hash of your password and
send only the first five charaters to the site which returns with all
the hashes it has passwords of starting with those five characters.

This perl script automates this and compares your locally computed
hash to those in the database.
