use vars qw($VERSION %IRSSI $path);

use Irssi;

$VERSION = '1.0';
%IRSSI = (
    authors     => 'Marius Nettum',
    contact     => 'marius@internettum.no',
    name        => 'irssi-quotes',
    description => 'Trigger fun quotes in channel when a user requests it',
    license     => 'GPL'
);

$path = '/path/to/quotes-files/'; #E.g. /home/marius/.irssi/quotes-files/. Remember trailing slash.

sub beer {
        my ($server, $target) = @_;
        if (open(FILE, $path.'quotes_beer.txt')) {
            my (@quotesarr) = <FILE>;
            chomp @quotesarr;
            my ($rl) = rand(scalar(@quotesarr));
            $server->command('msg ' . $target . ' ' . $quotesarr[$rl]);
        } else {
            $server->command('msg ' . $target . ' To file to open drunk *buuuurp*');
        }
}


sub chucknorris {
        my ($server, $target) = @_;
        if (open(FILE, $path.'facts_chucknorris.txt')) {
            my (@quotesarr) = <FILE>;
            chomp @quotesarr;
            my ($rl) = rand(scalar(@quotesarr));
            $server->command('msg ' . $target . ' ' . $quotesarr[$rl]);
        } else {
            $server->command('msg ' . $target . ' Chuck Norries does not allow Norris facts on irc!');
        }
}


sub simpsons {
	my ($server, $target) = @_;
        if (open(FILE, $path.'quotes_simpsons.txt'))  {
	    my (@quotesarr) = <FILE>;
	    chomp @quotesarr;
	    my ($rl) = rand(scalar(@quotesarr));
	    $server->command('msg ' . $target . ' ' . $quotesarr[$rl]);
        } else {
	    $server->command('msg ' . $target . ' Do\'h! Could not open file with simpsons quotes!');
	}
}

sub getcommands {
  my %commands = (
        'simpsons' => 'random Simpsons quotes.',
        'chucknorris' => 'random Chuck Norris facts',
        'beer' => 'random beer quotes'
    );
  
  return(%commands);
}

sub checkinput {
    my ($server, $msg, $nick, $addr, $target) = @_;

    if (substr($msg, 0, 1) eq '!') {
    	my $inputcommand = substr($msg, 1);
    	my %legalcommands = getcommands();
 
        if (exists($legalcommands{$inputcommand})) {
            &{$inputcommand}($server, $target);
    	}
    }
}

Irssi::signal_add('message public', 'checkinput');