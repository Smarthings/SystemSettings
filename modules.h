#ifndef MODULES_H
#define MODULES_H

#include <HomeThings/screen.h>
#include <HomeThings/system.h>
#include <HomeThings/info.h>

void loadModules()
{
    qmlRegisterType<System>("System", 1, 0, "System");
    qmlRegisterType<Screen>("Screen", 1, 0, "Screen");
    qmlRegisterType<Info>("Info", 1, 0, "Info");
}

#endif // MODULES_H
