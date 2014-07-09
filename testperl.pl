#!/usr/bin/perl
# This perl file is just playing around with Perl

#$myclass = new MyClass;  

MyClass->greetingOutput("Bruce");
MyClass->greetingOutput("Kathrin");
MyClass->greetingOutput("David");


package MyClass;
#sub new {
#	my $name = shift;
#}
sub greetingOutput {
	my $class = shift;
	my $name = shift;
	print "Hello ${name}!\n";
} 

