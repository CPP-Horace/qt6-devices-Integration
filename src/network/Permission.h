#ifndef PERMISSION_H
#define PERMISSION_H
#include "TCPClient.h"
#include <vector>
class Permission : public TCPClient
{
    Q_OBJECT
  public:
    explicit Permission(QObject *parent = nullptr);
    virtual ~Permission() noexcept;
    virtual void dealing(std::vector<unsigned char> buffer) override;
    virtual void pingBehavior() override;
  public slots:
    void sendQRCode(const std::string &code, const std::string &num);
  signals:
    void codeRight(const std::string &num, const std::string &code1, const std::string &code2);

  private:
    std::string strCodeError = "FFFFEor1\r\n";  // 激光码返回错误信息
    std::string strSystemOk = "FFFFSysOK\r\n";  // 普什系统就绪
    std::string strCodeNull = "FFFFNULL\r\n";   // 激光码空返回
    std::string strSysEor1 = "FFFFSysEor1\r\n"; // 表示生产品出现连续NG等异常情况
    std::string strHead = "FFFF";               // 协议头
    std::string strTail = "\r\n";               // 协议尾
};

#endif // Permission_H