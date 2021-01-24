parent <weight> <type> <ip> <port> <username> <password>
	this command must follow "allow" rule. It extends last allow  rule  to
       build  proxy  chain.  Proxies may be grouped. Proxy inside the group is
       selected	randomly. If few groups	are specified one  proxy  is  randomly
       picked  from each group and chain of proxies is created (that is	second
       proxy connected through first one and so	on).  Weight is	used to	 group
       proxies.	 Weigt is a number between 1 and 1000.	Weights	are summed and
       proxies are grouped together untill weight of group is 1000. That is:
	allow *
	parent 500 socks5 192.168.10.1 1080
	parent 500 connect 192.168.10.1	3128
	makes 3proxy to	randomly choose	between	2  proxies  for	 all  outgoing
       connections. These 2 proxies form 1 group (summarized weight is 1000).
	allow *	* * 80
	parent 1000 socks5 192.168.10.1	1080
	parent 1000 connect 192.168.20.1 3128
	parent 300 socks4 192.168.30.1 1080
	parent 700 socks5 192.168.40.1 1080
	creates	 chain	of  3 proxies: 192.168.10.1, 192.168.20.1 and third is
       (192.168.30.1 with probability of 0.3 or	192.168.40.1 with  probability
       of 0.7) for outgoing web	connections.

	type is	one of:
	 tcp - simply redirect connection. TCP is always last in chain.
	 http -	redirect to HTTP proxy.	HTTP is	always last chain.
	 pop3  -  redirect to POP3 proxy (only local redirection is supported,
       can not be used for chaining)
	 ftp - redirect	to FTP proxy (only local redirection is	supported, can
       not be used for chaining)
	 connect - parent is HTTP CONNECT method proxy
	 connect+ - parent is HTTP CONNECT proxy with name resolution
	 socks4	- parent is SOCKSv4 proxy
	 socks4+ - parent is SOCKSv4 proxy with	name resolution	(SOCKSv4a)
	 socks5	- parent is SOCKSv5 proxy
	 socks5+ - parent is SOCKSv5 proxy with	name resolution
	 socks4b  -  parent  is	 SOCKS4b  (broken  SOCKSv4 implementation with
       shortened server	reply. I never saw this	kind ofservers	byt  they  say
       there  are).  Normally you should not use this option. Do not mess this
       option with SOCKSv4a (socks4+).
	 socks5b - parent  is  SOCKS5b	(broken	 SOCKSv5  implementation  with
       shortened  server  reply. I think you will never	find it	useful). Never
       use this	option unless you know exactly you need	it.
	 admin - redirect request to local 'admin' service  (with  -s  parame-
       ter).
	Use "+"	proxy only with	"fakeresolve" option

	IP  and	 port are ip addres and	port of	parent proxy server.  If IP is
       zero, ip	is taken from original request,	only port is changed.  If port
       is zero,	it's taken from	original request, only IP is changed.  If both
       IP and port are zero - it's a special case  of  local  redirection,  it
       works  only  with  socks	proxy. In case of local	redirection request is
       redirected to different service,	ftp locally redirects  to  ftppr  pop3
       locally	redirects  to  pop3p http locally redurects to proxy admin lo-
       cally redirects to admin	-s service.

	Main purpose of	local redirections is to have requested	resource  (URL
       or  POP3	 username) logged and protocol-specific	filters	to be applied.
       In case of local	redirection ACLs are revied  twice:  first,  by	 SOCKS
       proxy  up  to redirected	(HTTP, FTP or POP3) after 'parent' command. It
       means, additional 'allow' command is required for redirected  requests,
       for example:
	allow *	* * 80
	parent 1000 http 0.0.0.0 0
	allow *	* * 80 HTTP_GET,HTTP_POST
	socks
	redirects  all SOCKS requests with target port 80 to local HTTP	proxy,
       local HTTP proxy	parses requests	and allows only	GET and	POST requests.
	parent 1000 http 1.2.3.4 0
	Changes	external address for given connection to 1.2.3.4  (an  equiva-
       lent to -e1.2.3.4)
	Optional  username  and	 password  are	used to	authenticate on	parent
       proxy. Username of '*' means username must be supplied by user.
