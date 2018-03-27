#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <HomeThings/screen.h>
//#include <HomeThings/info.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<Screen>("Screen", 1, 0, "Screen");

    QQuickStyle::setStyle(":/UiTheme");
    QQuickStyle::setFallbackStyle("Default");

    //Info info;

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
