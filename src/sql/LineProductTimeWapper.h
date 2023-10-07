#pragma once
#include "BaseProduct.h"
#include "PgsqlHelper.h"
#include "Utils.h"
#include "json/json.h"
#include <QDebug>
#include <map>
#include <memory>
#include <string>

class LineProductTimeWapper
{
#define TABLE_PRODUCT_TIME "product_time"
  public:
    LineProductTimeWapper() = default;
    ~LineProductTimeWapper() = default;
    static bool insert(std::shared_ptr<ProductItem> ptr)
    {
        QVariantMap mapData;
        mapData.insert("type_pd", static_cast<uint8_t>(ptr->typePd_));
        mapData.insert("bottle_num", ptr->bottleNum_);
        mapData.insert("batch_num", ptr->batchNum_.c_str());
        mapData.insert("formula_name", ptr->formulaName_.c_str());
        mapData.insert("is_remove", ptr->isRemove_);

        mapData.insert("qrcode_time", ptr->QRCodeTime.c_str());
        mapData.insert("logistics_ret_time", ptr->logisticsTime.c_str());

        mapData.insert("coding_signal_time", ptr->codingSigTime.c_str());
        mapData.insert("ocr_signal_time", ptr->OCRSigTime.c_str());
        mapData.insert("ocr_image_time", ptr->OCRImageTime.c_str());
        mapData.insert("ocr_result_time", ptr->OCRResultTime.c_str());
        mapData.insert("complete_signal_time", ptr->completeSigTime.c_str());
        bool res = PgsqlHelper::getSqlHelper().insertData("line_product_time", mapData);
        return res;
    }
};