#!/usr/bin/perl
# script to wake the hosts of bruce

%hosts = ("ultra"=>"00:1C:85:40:24:E3" , "marenostrum2"=>"00:1C:C0:60:F0:6C" , "deepthought"=>"00:24:1D:14:E6:BD");
$domain = "local";

(@ARGV == 1) || die "exactly one argument required.";
($macadr = $hosts{$ARGV[0]}) || die "wrong hostname \"${ARGV[0]}\"";

# here we have an existing MAC / Hostname -> wake it
system("sudo etherwake -D ${macadr}");


