acl browser_firefox browser Mozilla
acl browser_ie browser MSIE
url_rewrite_access allow localnet 
url_rewrite_program /etc/squid3/prank.pl
url_rewrite_bypass on
url_rewrite_children 1

http_port 3129 intercept

# Since we're just pranking, let's not keep records of our co-workers surfing habits. Makes it more innocent when we're caught!
access_log none
