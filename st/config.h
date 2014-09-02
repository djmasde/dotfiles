/* See LICENSE file for copyright and license details. */

/*
 * appearance
 *
 * font: see http://freedesktop.org/software/fontconfig/fontconfig-user.html
 */
static char font[] = "terminus:pixelsize=10:pixelsize=12:antialias=false:autohint=false";
static int borderpx = 2;
static char shell[] = "/bin/sh";

/* identification sequence returned in DA and DECID */
static char vtiden[] = "\033[?6c";

/* Kerning / character bounding-box multipliers */
static float cwscale = 1.0;
static float chscale = 1.0;

/*
 * word delimiter string
 *
 * More advanced example: " `'\"()[]{}"
 */
static char worddelimiters[] = " ";

/* selection timeouts (in milliseconds) */
static unsigned int doubleclicktimeout = 300;
static unsigned int tripleclicktimeout = 600;

/* alt screens */
static bool allowaltscreen = true;

/* frames per second st should at maximum draw to the screen */
static unsigned int xfps = 120;
static unsigned int actionfps = 30;

/*
 * blinking timeout (set to 0 to disable blinking) for the terminal blinking
 * attribute.
 */
static unsigned int blinktimeout = 800;

/*
 * bell volume. It must be a value between -100 and 100. Use 0 for disabling
 * it
 */
static int bellvolume = 0;

/* TERM value */
static char termname[] = "st-256color";

static unsigned int tabspaces = 8;


/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {
	 /* 8 normal colors */
    "#101010",
    "#960050",
    "#66aa11",
    "#c47f2c",
    "#30309b",
    "#7e40a5",
    "#3579a8",
    "#9999aa",

    /* 8 bright colors */
    "#303030",
    "#ff0090",
    "#80ff00",
    "#ffba68",
    "#5f5fee",
    "#bb88dd",
    "#4eb4fa",
    "#d0d0d0",

    [255] = 0,

    /* more colors can be added after 255 to use with DefaultXX */
    "#9999aa",
    "#d0d0d0",
};


/*
 * Default colors (colorname index)
 * foreground, background, cursor
 */
static unsigned int defaultfg = 7;
static unsigned int defaultbg = 0;
static unsigned int defaultcs = 256;
//static unsigned int defaultfg = 15;
//static unsigned int defaultbg = 0;
//static unsigned int defaultcs = 15;

/*
 * Colors used, when the specific fg == defaultfg. So in reverse mode this
 * will reverse too. Another logic would only make the simple feature too
 * complex.
 */
static unsigned int defaultitalic = 11;
static unsigned int defaultunderline = 7;

/* Internal mouse shortcuts. */
/* Beware that overloading Button1 will disable the selection. */
static Mousekey mshortcuts[] = {
	/* button               mask            string */
	{ Button4,              XK_ANY_MOD,     "\031" },
	{ Button5,              XK_ANY_MOD,     "\005" },
};

/* Internal keyboard shortcuts. */
#define MODKEY Mod1Mask

static Shortcut shortcuts[] = {
	/* mask                 keysym          function        argument */
	{ ControlMask,          XK_Print,       toggleprinter,  {.i =  0} },
	{ ShiftMask,            XK_Print,       printscreen,    {.i =  0} },
	{ XK_ANY_MOD,           XK_Print,       printsel,       {.i =  0} },
	{ MODKEY|ShiftMask,     XK_Prior,       xzoom,          {.i = +1} },
	{ MODKEY|ShiftMask,     XK_Next,        xzoom,          {.i = -1} },
	{ ShiftMask,            XK_Insert,      selpaste,       {.i =  0} },
	{ MODKEY|ShiftMask,     XK_Insert,      clippaste,      {.i =  0} },
	{ MODKEY,               XK_Num_Lock,    numlock,        {.i =  0} },
};

/*
 * Special keys (change & recompile st.info accordingly)
 *
 * Mask value:
 * * Use XK_ANY_MOD to match the key no matter modifiers state
 * * Use XK_NO_MOD to match the key alone (no modifiers)
 * appkey value:
 * * 0: no value
 * * > 0: keypad application mode enabled
 * *   = 2: term.numlock = 1
 * * < 0: keypad application mode disabled
 * appcursor value:
 * * 0: no value
 * * > 0: cursor application mode enabled
 * * < 0: cursor application mode disabled
 * crlf value
 * * 0: no value
 * * > 0: crlf mode is enabled
 * * < 0: crlf mode is disabled
 *
 * Be careful with the order of the definitions because st searches in
 * this table sequentially, so any XK_ANY_MOD must be in the last
 * position for a key.
 */

/*
 * If you want keys other than the X11 function keys (0xFD00 - 0xFFFF)
 * to be mapped below, add them to this array.
 */
static KeySym mappedkeys[] = { -1 };

/*
 * State bits to ignore when matching key or button events.  By default,
 * numlock (Mod2Mask) and keyboard layout (XK_SWITCH_MOD) are ignored.
 */
static uint ignoremod = Mod2Mask|XK_SWITCH_MOD;

/* Override mouse-select while mask is active (when MODE_MOUSE is set).
 * Note that if you want to use ShiftMask with selmasks, set this to an other
 * modifier, set to 0 to not use it. */
static uint forceselmod = ShiftMask;

static Key key[] = {
    { XK_BackSpace, XK_NO_MOD, "\177" },
    { XK_Insert,    XK_NO_MOD, "\033[2~" },
    { XK_Delete,    XK_NO_MOD, "\033[3~" },
    { XK_Home,      XK_NO_MOD, "\033[1~" },
    { XK_End,       XK_NO_MOD, "\033[4~" },
    { XK_Prior,     XK_NO_MOD, "\033[5~" },
    { XK_Next,      XK_NO_MOD, "\033[6~" },
    { XK_F1,        XK_NO_MOD, "\033OP"   },
    { XK_F2,        XK_NO_MOD, "\033OQ"   },
    { XK_F3,        XK_NO_MOD, "\033OR"   },
    { XK_F4,        XK_NO_MOD, "\033OS"   },
    { XK_F5,        XK_NO_MOD, "\033[15~" },
    { XK_F6,        XK_NO_MOD, "\033[17~" },
    { XK_F7,        XK_NO_MOD, "\033[18~" },
    { XK_F8,        XK_NO_MOD, "\033[19~" },
    { XK_F9,        XK_NO_MOD, "\033[20~" },
    { XK_F10,       XK_NO_MOD, "\033[21~" },
    { XK_F11,       XK_NO_MOD, "\033[23~" },
    { XK_F12,       XK_NO_MOD, "\033[24~" },
	
};

/*
 * Selection types' masks.
 * Use the same masks as usual.
 * Button1Mask is always unset, to make masks match between ButtonPress.
 * ButtonRelease and MotionNotify.
 * If no match is found, regular selection is used.
 */
static uint selmasks[] = {
	[SEL_RECTANGULAR] = Mod1Mask,
};

