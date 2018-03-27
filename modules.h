#ifndef MODULES_H
#define MODULES_H

#include <HomeThings/screen.h>

void loadModules()
{
    qmlRegisterType<Screen>("Screen", 1, 0, "Screen");
}

#endif // MODULES_H
