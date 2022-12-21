#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "backend.h"
#include <QQmlContext>                           //////////
                                                //////////

int main(int argc, char *argv[])
{
//  BackEnd *backend = new BackEnd;                                 //
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
//    QVariant whose_move;                                            //
//    QQuickView view;                                                //
//    QQmlContext *context = view.engine() -> rootContext();          //
//    context -> setContextProperty("_whose_move", whose_move );      //
//    view.setSource(QUrl("qrc:main.qml"));                           //

//  engine.rootContext() ->setContextProperty("backend",backend);     //
    const QUrl url(u"qrc:/NoughtsAndCrosses/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
