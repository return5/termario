//-------------------------------- description ------------------------------------------------
    //simple wrappers for using ncurses through lua.
    //hosted at www.github.com/return5/sluacurses
//-------------------------------- license ----------------------------------------------------
/*
    Copyright (c) <2020> <github.com/return5>

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
*/

//-------------------------------- includes ---------------------------------------------------
#include <ncurses.h>
#include <stdlib.h>
#include <lua.h>
#include <lauxlib.h>
#include <time.h>

//-------------------------------- function prototypes ----------------------------------------
static int l_mvprintw(lua_State *L);
static int l_color_set(lua_State *L);
static int l_attron(lua_State *L);
static int l_attroff(lua_State *L);
static int l_refresh(__attribute__((unused)) lua_State *L);
static int l_clear(__attribute__((unused)) lua_State *L) ;
static int l_getch(lua_State *L);
static int l_init_pair(lua_State *L);
static int l_start_color(__attribute__((unused)) lua_State *L);
static int l_color_pair(lua_State *L);
static int addColorValue(lua_State *L);
static int l_init_color(lua_State *L);
static int l_init(lua_State *L);
static int l_tearDown(__attribute__((unused)) lua_State * L);
static int l_getTime(lua_State *L);
static int l_getMaxYX(lua_State *L);
static int l_drawBorder(lua_State * L);
static int l_blockingInput(lua_State * L);

//-------------------------------- code -------------------------------------------------------

static int addColorValue(lua_State *L) {
    lua_pushinteger(L,COLOR_RED);
    lua_setglobal(L,"COLOR_RED");
    lua_pushinteger(L,COLOR_BLACK);
    lua_setglobal(L,"COLOR_BLACK");
    lua_pushinteger(L,COLOR_GREEN);
    lua_setglobal(L,"COLOR_GREEN");
    lua_pushinteger(L,COLOR_MAGENTA);
    lua_setglobal(L,"COLOR_MAGENTA");
    lua_pushinteger(L,COLOR_YELLOW);
    lua_setglobal(L,"COLOR_YELLOW");
    lua_pushinteger(L,COLOR_BLUE);
    lua_setglobal(L,"COLOR_BLUE");
    lua_pushinteger(L,COLOR_CYAN);
    lua_setglobal(L,"COLOR_CYAN");
    lua_pushinteger(L,COLOR_WHITE);
    lua_setglobal(L,"COLOR_WHITE");
    lua_pushinteger(L,A_STANDOUT);
    lua_setglobal(L,"A_STANDOUT");
    return 8;
}

int luaopen_libs_ncurses_sluacurses(lua_State *L) {
    addColorValue(L);
    lua_register(L,"getch",l_getch);
    lua_register(L,"refresh",l_refresh);
    lua_register(L,"clear",l_clear);
    lua_register(L,"init_pair",l_init_pair);
    lua_register(L,"start_color",l_start_color);
    lua_register(L,"mvprintw",l_mvprintw);
    lua_register(L,"COLOR_PAIR",l_color_pair);
    lua_register(L,"attron",l_attron);
    lua_register(L,"attroff",l_attroff);
    lua_register(L,"color_set",l_color_set);
    lua_register(L,"init_color",l_init_color);
    lua_register(L,"init",l_init);
    lua_register(L,"endwin",l_tearDown);
    lua_register(L,"getTime",l_getTime);
    lua_register(L,"getMaxYX",l_getMaxYX);
    lua_register(L,"drawBorder",l_drawBorder);
    lua_register(L,"blockingInput",l_blockingInput);
    return 0;
}

static int l_start_color(__attribute__((unused)) lua_State *L) {
    start_color();
    return 0;
} 

static int l_init_pair(lua_State *L) {
    const int color      = luaL_checknumber(L,1);
    const int foreground = luaL_checknumber(L,2);
    const int background = luaL_checknumber(L,3);
    init_pair(color,foreground,background);
    return 0;
}

static int l_clear(__attribute__((unused)) lua_State *L) {
    clear();
    return 0;
} 

static int l_refresh(__attribute__((unused)) lua_State *L) {
    refresh();
    return 0;
}

static int l_mvprintw(lua_State *L) {
    const int y = luaL_checknumber(L,1);
    const int x = luaL_checknumber(L,2);
    const char *const str = luaL_checkstring(L,3);
    mvprintw(y,x,str);
    return 0;
}

static int l_getch(lua_State *L) {
    lua_pushfstring(L,"%c",getch());
    return 1;
}

static int l_init_color(lua_State *L) {
    const int color = luaL_checknumber(L,1);
    const int r     = luaL_checknumber(L,2);
    const int g     = luaL_checknumber(L,3);
    const int b     = luaL_checknumber(L,4);
    init_color(color,r,g,b);
    return 0;
}

static int l_color_pair(lua_State *L) {
    const int color = luaL_checknumber(L,1);
    lua_pushnumber(L,COLOR_PAIR(color));
    return 1;
}

static int l_attron(lua_State *L) {
    const int attr = luaL_checknumber(L,1);
    attron(attr);
    return 0;
}

static int l_attroff(lua_State *L) {
    const int attr = luaL_checknumber(L,1);
    attroff(attr);
    return 0;
}

static int l_color_set(lua_State *L) {
    const int attr = luaL_checknumber(L,1);
    color_set(attr,NULL);
    return 0;
}

static int l_tearDown(__attribute__((unused)) lua_State * L) {
    endwin();
    return 0;
}

static int l_init(__attribute__((unused)) lua_State * L) {
    initscr();
    cbreak();
    noecho();
    nodelay(stdscr,1);
    curs_set(0);
    start_color();
    init_color(COLOR_YELLOW,700,700,98);
    refresh();
    return 0;
}

static int l_blockingInput(__attribute__((unused)) lua_State * L) {
    nodelay(stdscr,0);
    return 0;
}

static int l_getTime(lua_State * L) {
    const struct timespec now;
    clock_gettime(CLOCK_REALTIME,&now);
    lua_pushnumber(L,now.tv_sec);
    lua_pushnumber(L,now.tv_nsec);
    return 2;
}

static int l_getMaxYX(lua_State * L) {
    int x,y;
    getmaxyx(stdscr,y,x);
    lua_pushnumber(L,y);
    lua_pushnumber(L,x);
    return 2;
}

static int l_drawBorder(lua_State * L){
    const int height = luaL_checknumber(L,1);
    const int width = luaL_checknumber(L,2);
    mvvline(0,0,'|',height + 1);
    mvvline(0,width,'|',height + 1);
    mvhline(0,0,'=',width + 1);
    mvhline(height,0,'=',width + 1);
    return 0;
}
