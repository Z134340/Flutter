// 將Json資料複製到Json_to_Dart建立class
// https://javiercbk.github.io/json_to_dart/

class ZooData {
  Result result;

  ZooData({this.result});

  ZooData.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  int limit;
  int offset;
  int count;
  String sort;
  List<Results> results;

  Result({this.limit, this.offset, this.count, this.sort, this.results});

  Result.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    sort = json['sort'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    data['count'] = this.count;
    data['sort'] = this.sort;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String ePicURL;
  String eGeo;
  String eInfo;
  String eNo;
  String eCategory;
  String eName;
  String eMemo;
  int iId;
  String eURL;

  Results(
      {this.ePicURL,
        this.eGeo,
        this.eInfo,
        this.eNo,
        this.eCategory,
        this.eName,
        this.eMemo,
        this.iId,
        this.eURL});

  Results.fromJson(Map<String, dynamic> json) {
    ePicURL = json['E_Pic_URL'];
    eGeo = json['E_Geo'];
    eInfo = json['E_Info'];
    eNo = json['E_no'];
    eCategory = json['E_Category'];
    eName = json['E_Name'];
    eMemo = json['E_Memo'];
    iId = json['_id'];
    eURL = json['E_URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['E_Pic_URL'] = this.ePicURL;
    data['E_Geo'] = this.eGeo;
    data['E_Info'] = this.eInfo;
    data['E_no'] = this.eNo;
    data['E_Category'] = this.eCategory;
    data['E_Name'] = this.eName;
    data['E_Memo'] = this.eMemo;
    data['_id'] = this.iId;
    data['E_URL'] = this.eURL;
    return data;
  }
}
