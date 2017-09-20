//paper scissors rock ie. rock paper scissors for us normal people

\p 15000 


r:"    _______   \n",
  "---'   ____)  \n",
  "      (_____) \n",
  "      (_____) \n",
  "      (____)  \n",
  "---.__(___)   \n";

p:"    _______       \n",
  "---'   ____)____  \n",
  "          ______) \n",
  "          _______)\n",
  "         _______) \n",
  "---.__________)   ";

s:"    _______       \n",
  "---'   ____)____  \n",
  "          ______) \n",
  "         <_______ \n",
  "       __________)\n",
  "      (____)      \n",
  "---.__(___)       \n";

rf:"  _______     \n",
   " (____   '--- \n",
   "(_____)       \n",
   "(_____)       \n",
   " (____)       \n",
   "  (___)__.--- \n";

pf:"       _______     \n",
   "  ____(____   '--- \n",
   " (______           \n",         
   "(_______           \n",        
   " (_______          \n",        
   "   (__________.--- \n";

sf:"       _______     \n",
   "  ____(____   '--- \n",
   " (______           \n",
   " _______>          \n",
   "(__________        \n",
   "      (____)       \n",
   "       (___)__.--- \n";

cron:([] time:();job:());

.z.ts:{value each exec job from cron where time<.z.P;delete from `cron where time<.z.P};

\t 5000

//table for storing handle and weapon choice
choice:([handle:()]name:();weapon:());

//dict of players
players:()!();

//dict of weapons and correlating numbers
weapons:`scissors`paper`rock!`s`p`r;
wepf:`s`p`r!`sf`pf`rf;

welc:"Welcome to paper scissors rock!\n Please select your weapon by typing either paper scissors or rock.\n You can change choice up until GO!"

//when user connects add handle to table and default a weapon
.z.po:{`choice upsert ([handle:enlist x];name:`$ .z.w(system;"whoami");weapon:1?key weapons);
	(neg .z.w)({`.z.pi set x@neg .z.w};pi);
	neg[x]({`weapons set x};weapons);
	neg[x](-1;welc);
	if[2=count .z.W;janken[]]};

//remove player if they quit
.z.pc:{delete from `choice where handle = x};

//pi function for players
pi:{[h;x] $[x~enlist "\n";"\n";
	    x~"quit\n";exit 0;
	    x~"\\\\\n";exit 0;
	    x~"start\n";neg[h](`janken;::);
	   [a:"Not a weapon!\n";if[(`$(lower -1_x)) in key weapons;neg[h](`move;(lower -1_x));a:"Weapon choice sent\n"];a]]};

//function called by user to upload weapon choice
move:{`choice upsert ([handle:enlist .z.w];weapon:enlist `$x)};

//rules on what beats what
rules:{(d cross d:(key weapons))!(`DRAW;x;y;y;`DRAW;x;x;y;`DRAW)};

fight:{p:2#exec name from choice;
	l:rules[p[0];p[1]];
	res:l exec weapon from choice;
	wep1:first exec weapon from choice where name = p[0];
	wep2:first exec weapon from choice where name = p[1];
	-25!(key .z.W;(-1;("\033[G",value weapons[wep1]),"   VS   \n",value wepf[weapons[wep2]]));
	-25!(key .z.W;(-1;(string p[0])," chose ",string wep1));
	-25!(key .z.W;(-1;(string p[1])," chose ",string wep2));
	{-25!(key .z.W;(-1;"The winner is: ", string x))}res};

//countdown for reveal
janken:{-25!(key .z.W;(-1;"Game Starting."));-25!(key .z.W;::);system "sleep 10";
	-25!(key .z.W;(-1;"paper!\n",p));-25!(key .z.W;::);system "sleep 2";
	-25!(key .z.W;(-1; "scissors!\n",s));-25!(key .z.W;::);system "sleep 2";
	-25!(key .z.W;(-1; "rock!\n",r));-25!(key .z.W;::);system "sleep 2";
	-25!(key .z.W;(-1; "GO!"));-25!(key .z.W;::);system "sleep 2";
	`cron upsert (.z.P+00:00:01;"fight[]")};
