my $filename = $ARGV[0];    
my $content;
    open(my $fh, '<', $filename) or die "cannot open file $filename";
    {
        local $/;
        $content = <$fh>;
	
	($file) = $content =~ m/\/(.*),/;
 	print '/',$file;
	print "\n";
    }
    close($fh);
