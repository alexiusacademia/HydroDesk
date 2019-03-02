module dialogs.newrectangularsection;

import tkd.window.window;

import std.stdio;

class RectangularChannelDialog 
{
    this(Window parent, int left)
    {
        Window win = new Window(parent, "Rectangular Open Channel", true);
        win.setGeometry(320, 240, left, 10);
        writeln(left);
    }
}