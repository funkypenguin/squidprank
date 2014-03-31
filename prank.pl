#!/usr/bin/perl
$|=1;
$count = 0;
$pid = $$;
while (<>) {
 chomp $_;
 # Allow facebook content, unmolested - don't want to be too obvious!
 if ($_ =~ /(.*facebook.*)/i) {
 $url = $1;
 print "$url\n";

 }
 # Allow google static content, unmolested
 if ($_ =~ /(.*gstatic.*)/i) {
 $url = $1;
 print "$url\n";

 }
 # Change google language to Klingon
 elsif ($_ =~ /(.*google.*)/i) {
 $url = $1;
 $url =~ s/hl=en/hl=xx-klingon/;
 print "$url\n";

 }
 # "Paint" the occasional JPG 
 elsif ($_ =~ /(.*\.jpg)/i) {
 $url = $1;
 system("/usr/bin/wget", "-q", "-O","/var/www/prank/$pid-$count.jpg", "$url");
 system("/usr/bin/mogrify", "-flip","/var/www/prank/$pid-$count.jpg");
 print "http://127.0.0.1/prank/$pid-$count.jpg\n";
 }
 # Paint the occasional GIF 
 elsif ($_ =~ /(.*\.gif)/i) {
 $url = $1;
 system("/usr/bin/wget", "-q", "-O","/var/www/prank/$pid-$count.gif", "$url");
 system("/usr/bin/mogrify", "-flip","/var/www/prank/$pid-$count.gif");
 print "http://127.0.0.1/prank/$pid-$count.gif\n";

 }
 # Paint the occasional PNG
 elsif ($_ =~ /(.*\.png)/i) {
 $url = $1;
 system("/usr/bin/wget", "-q", "-O","/var/www/prank/$pid-$count.png", "$url");
 system("/usr/bin/mogrify", "-flip","/var/www/prank/$pid-$count.png");
 print "http://127.0.0.1/prank/$pid-$count.png\n";

 }
 # Redirect coworker's blog to archive of idgames hack (http://www.2600.com/hacked_pages/)
  elsif ($_ =~ /(.*muppetz.com.*)/i) {
  $url = $1;
  print "http://127.0.0.1/prank/muppetz.html\n";
 }

 else {
 print "$_\n";;
 }
 $count++;
}
