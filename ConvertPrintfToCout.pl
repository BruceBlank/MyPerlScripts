#!/usr/bin/perl
# reads a C-style printf-line from stdin, writes a C++style cout-line to stdout
# For simplicity, no "\%" are allowed and only "%s", "%d", ... are supported in printf-string

# This is the main-program:
# read input lines and convert them from printf-style to cout-style using the class below
$converter = ConvertPrintfToCout->new(1);
while($cline = <STDIN>){
	print $converter->convert($cline);
	print "\n";
}


# Class definition (package) for the converter class
package ConvertPrintfToCout;
# the initializer takes one argument -> useStd: use "std::" in output
sub new {
	my $class = shift;
	my $self = {useStd => shift || 0};	
	bless $self, $class;
	return $self;
}

# this method takes the C-line as argument and returns the CPP-line
sub convert {
	my $self = shift;
	my $cline = shift;
	my $tmpline, $fstr, @args, @fstrparts, $index, $cppline;

	# remove end-of-line
	chomp($cline);

	# strip 'printf("");', if there
	if ( $cline =~ /printf\((.*)\);/ ) {
		$tmpline = $1;
	}
	else {
		$tmpline = $cline;
	}

	# split into parts: format-string, arg, arg, ...
	( $fstr, @args ) = split( /\s*,\s*/, $tmpline );

	# strip '"' at begin and end of format-string
	$fstr =~ s/^"//s;
	$fstr =~ s/"$//s;

	# cut format string on format-specifiers
	@fstrparts = split( /%./, $fstr );

	# create C++-style-output
	if($self->{useStd}){
		$cppline = "std::cout";
	}else{
		$cppline = "cout";
	}
	for ( $index = 0 ; $index <= $#fstrparts ; $index++ ) {
		if ( $fstrparts[$index] ) {
			$cppline = "$cppline << \"$fstrparts[$index]\"";
		}
		if ( $args[$index] ) {
			$cppline = "$cppline << $args[$index]";
		}
	}
	$cppline = "$cppline;";
	return $cppline;
}
