
message YLT_LogModel {
    primary int logId = 0;//日志ID
    optional string title = nil;//日志标题
    optional string log = nil;//日志内容
    optional string mark = nil;//备注
    optional int time = 0;//耗时 单位毫秒
    optional string dateTime = 0;
} CRUD

message YLT_APILogModel {
    primary int logId = 0;//日志ID
    optional string title = nil;
    optional string url = nil;//网络请求路径
    optional string parameters = nil;//请求参数
    optional string result = nil;//请求结果
    optional string mark = nil;//备注
    optional int time = 0;//耗时 单位毫秒
    optional string dateTime = nil;//记录时间
} CRUD



