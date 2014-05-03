#!/usr/bin/perl
 
sub daemon(){
    umask 0;
    open(STDIN, "</dev/null");
    open(STDOUT,">>/dev/null");
    open(STDERR, ">>/dev/null");
    my $pid = fork;
    exit if $pid;
}
 
sub main(){
        my $bar;
        my ($second, $minute, $hour, $dayOfMonth, $month, $yearOffset, $dayOfWeek, $dayOfYear, $daylightSavings) = localtime();
 
        # You add 1 because the number in $month is based on a starting number of 0.  
        # So, if $month is 0, then $monthnum is 1 (ie:  January)
        # Adding 1 gets you a number from the list below.  
 
my $monthnum = $month + 1;
 
my %monthname = (
                  1 => 'Enero',
                  2 => 'Febrero',
                  3 => 'Marzo',
                  4 => 'Abril',
                  5 => 'Mayo',
                  6 => 'Junio',
                  7 => 'Julio',
                  8 => 'Agosto',
                  9 => 'Septiembre',
                 10 => 'Octubre',
                 11 => 'Noviembre',
                 12 => 'Diciembre',
);
        daemon();
 
        while(1){
 
                $username = getpwuid($<);
                $ENV{'HOSTNAME'} =~ /(\w*)/;$hostname = $1;
 
                `uptime`   =~ /up +([^,]*)/;$uptime = "$1";
 
                $iwconfig = `/sbin/iwconfig`;
                $iwconfig =~ /ESSID:(.*)  [\s\S]*(Signal level=.*dBm)?/;
                $essid = $1;
                $iwconfig =~ /(Signal level=.*dBm)/;
                $dBmnumeric = $1;
                $dBmnumeric =~ s/Signal level=-(\d+) dBm/$1/i;
                $dBm = '|' x ($dBmnumeric ? ((100-$dBmnumeric)+19)/20 : 0);
 
                ($sec, $min, $hr, $day, $mes) = localtime(time);
 
 
                $bar = sprintf("[ESSID:%s;%s]{%-4s}  {%02d/%s - %02d:%02d:%02d} up[%s] %s\@%s",$essid,$dBmnumeric,$dBm,$day,$monthname{$monthnum},$hr,$min,$sec,$uptime,$username,$hostname);
                `xsetroot -name "$bar"`;
                sleep(5)
        }
}
 
main;
