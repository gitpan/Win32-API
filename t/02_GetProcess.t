#!perl -w
#
# kernel32.dll GetCurrentProcessId() function test
#
# $Id: 02_GetProcess.t 452 2009-01-17 16:16:08Z cosimo.streppone $

use strict;
use warnings;
use Test::More; plan tests => 3;

use_ok('Win32::API');

my $function = new Win32::API("kernel32", "GetCurrentProcessId", "", "N");
ok( defined($function), 'kernel32!GetCurrentProcessId import successful');

my $result = $function->Call();
diag('$result=', $result);
diag('$$=', $$);

if($^O eq 'cygwin')
{
	ok(defined($result) && $result > 0 && $result != $$, 'GetCurrentProcessId() on cygwin is != $$');
}
else
{
	ok( $result == $$, 'kernel32!GetCurrentProcessId() == Perl\'s $$' );
}

