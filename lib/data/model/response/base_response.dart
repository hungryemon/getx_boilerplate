import 'dart:convert';

BaseResponse baseResponseFromJson(String str) => BaseResponse.fromJson(json.decode(str));

String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());

class BaseResponse {
    BaseResponse({
        this.code,
        this.status,
        this.msg,
    });

    int? code;
    String? status;
    String? msg;

    factory BaseResponse.fromJson(Map<String, dynamic>? json) => BaseResponse(
        code: json?["code"],
        status: json?["status"],
        msg: json?["msg"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "msg": msg,
    };
}
