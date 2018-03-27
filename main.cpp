#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <modules.h>


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQuickStyle::setStyle(":/UiTheme");
    QQuickStyle::setFallbackStyle("Default");

    loadModules();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
