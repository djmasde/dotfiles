/* See LICENSE file for copyright and license details. */
/* Colours and workspaces names in japanese, stealed from a 4chan user in a /g/ desktop thread  */
/* appearance */
//static const char font[]            = "-*-terminus-medium-r-*-*-16-*-*-*-*-*-*-*";
//static const char font[] = "-*-fixed-bold-*-*-*-13-*-*-*-*-*-*-*";
//static const char font[]            ="*-dejavu sans light-*-*-*-*-13-*-*-*-*-*-*-*"
//static const char font
// other method for utf-8
//static const char font[] = "-*-*-*-*-*-*-12-*-*-*-*-*-koi8-*";
// for dwm with pango patch = utf-8 in dwm o_O
static const char font []           = "Sans 8";
//static const char font[]            = "7x13";
static const char normbordercolor[] = "#7588A3";
static const char normbgcolor[]     = "#956671";
static const char normfgcolor[]     = "#EDE7F4"; // #36FF00
static const char selbordercolor[]  = "#956671"; //  #6f6f6f // #0066ff
static const char selbgcolor[]      = "#20202E";
static const char selfgcolor[]      = "#B5A7B7";
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int snap      = 1;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */

/* tagging */
static const char *tags[] = { "ichi", "ni", "san", "shi", "go", "roku", };

static const Rule rules[] = {
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            True,        -2 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       False,       -1 },
        { "MPlayer",  NULL,       NULL,             0,       True,       -1 },
        { "mplayer2",  NULL,       NULL,            0,       True,       -1 },
        { "mednafen",  NULL,       NULL,            0,       True,       -1 },
        { "Snes9x",    NULL,       NULL,            0,       True,       -1 },
        { "XDosEmu",   NULL,       NULL,            0,       True,       -1 },
        { "Transmission-gtk", NULL, NULL,           0,       True,       -1 },
        { "feh", NULL, NULL,           0,       True,       -1 },

};

/* layout(s) */
static const float mfact      = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = False; /* True means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "+",      tile },    /* first entry is default */
	{ "-",      NULL },    /* no layout function means floating behavior */
	{ "M",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[]  = { "gmrun", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]   = { "uxterm", NULL };
static const char *termuxcmd[] = { "uxterm", "screen", NULL };
static const char *firexcmd[]  = { "qupzilla", NULL };
static const char *mpdprev[] = { "ncmpcpp", "prev", NULL };
static const char *mpdnext[] = { "ncmpcpp", "next", NULL };
static const char *mpdpause[] = { "ncmpcpp", "toggle", NULL};
/* control de MOCP */
static const char *toggmocp[] = { "mocp", "-G", NULL};
static const char *nextmocp[] = { "mocp", "-f", NULL};
static const char *prevmocp[] = { "mocp", "-r", NULL};
static const char *shutmocp[] = { "mocp", "-x", NULL};

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_p,      spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termuxcmd } },
	{ MODKEY,                       XK_o,      spawn,          {.v = firexcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
//	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
//	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
//	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
//	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
        { MODKEY,                       XK_F1,     spawn,          {.v = mpdprev } },
        { MODKEY,                       XK_F2,     spawn,          {.v = mpdnext } },
        { MODKEY,                       XK_Escape, spawn,          {.v = mpdpause } },
        { MODKEY,                       XK_y,      spawn,          {.v = prevmocp } },
        { MODKEY,                       XK_u,      spawn,          {.v = nextmocp } },
        { MODKEY,                       XK_g,      spawn,          {.v = toggmocp } },
        { MODKEY|ShiftMask,             XK_g,      spawn,          {.v = shutmocp } },


	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
