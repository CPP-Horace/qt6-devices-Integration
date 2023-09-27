#include "DBConnectionPool.h"
#include "Logger.h"
#include "Utils.h"

DBConnectionPool::DBConnectionPool(QString host, quint16 port, QString dbName, QString user, QString password,
                                   int maxConnections, int idleTimeout)
    : host_(host), port_(port), dbName_(dbName), user_(user), password_(password), maxConnections_(maxConnections),
      idleTimeout_(idleTimeout)
{
}

DBConnectionPool::~DBConnectionPool()
{
    releaseAllConnections();
}

QSqlDatabase *DBConnectionPool::getConnection()
{
    QMutexLocker locker(&mutex_);
    QSqlDatabase *db = nullptr;
    // 如果连接池中有可用连接，则返回
    if (!connectionPool_.isEmpty())
    {
        db = connectionPool_.takeFirst();
        if (!db->isOpen() || !db->isValid())
        {
            delete db;
            db = nullptr;
        }
    }
    else
    {
        if (connectionPool_.size() < maxConnections_)
        {
            db = createConnection();
        }
    }

    return db;
}

void DBConnectionPool::releaseConnection(QSqlDatabase *db)
{
    if (db != nullptr)
    {
        if (db->isOpen() && db->isValid())
        {
            QMutexLocker locker(&mutex_);
            connectionPool_.append(db);
        }
        else
        {
            delete db;
        }
    }
}

void DBConnectionPool::releaseAllConnections()
{
    QMutexLocker locker(&mutex_);

    for (QSqlDatabase *db : connectionPool_)
    {
        if (db->isOpen())
        {
            db->close();
        }
        delete db;
    }

    connectionPool_.clear();
}
