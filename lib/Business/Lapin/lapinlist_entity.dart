import 'package:flutter_shop/generated/json/base/json_convert_content.dart';

class LapinlistEntity with JsonConvert<LapinlistEntity> {
	List<LapinlistLapinlist> lapinlist;
}

class LapinlistLapinlist with JsonConvert<LapinlistLapinlist> {
	List<String> kwdlist;
	int newsid;
	String title;
	String postdate;
	String orderdate;
	String description;
	String image;
	int hitcount;
	int commentcount;
	bool hidecount;
	int cid;
	int nd;
	int sid;
	String url;
	int aid;
}
