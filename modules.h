#ifndef MODULES_H
#define MODULES_H

#include <HomeThings/screen.h>
#include <HomeThings/system.h>
#include <HomeThings/wireless.h>
#include <HomeThings/info.h>

void loadModules()
{
    qmlRegisterType<System>("System", 1, 0, "System");
    qmlRegisterType<Screen>("Screen", 1, 0, "Screen");
    qmlRegisterType<Wireless>("Wireless", 1, 0, "Wireless");
    qmlRegisterType<Info>("Info", 1, 0, "Info");
}

#endif // MODULES_H
