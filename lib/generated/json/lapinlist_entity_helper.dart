import 'package:flutter_shop/Business/Lapin/lapinlist_entity.dart';

lapinlistEntityFromJson(LapinlistEntity data, Map<String, dynamic> json) {
	if (json['lapinlist'] != null) {
		data.lapinlist = (json['lapinlist'] as List).map((v) => LapinlistLapinlist().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> lapinlistEntityToJson(LapinlistEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['lapinlist'] =  entity.lapinlist?.map((v) => v.toJson())?.toList();
	return data;
}

lapinlistLapinlistFromJson(LapinlistLapinlist data, Map<String, dynamic> json) {
	if (json['kwdlist'] != null) {
		data.kwdlist = (json['kwdlist'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['newsid'] != null) {
		data.newsid = json['newsid'] is String
				? int.tryParse(json['newsid'])
				: json['newsid'].toInt();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['postdate'] != null) {
		data.postdate = json['postdate'].toString();
	}
	if (json['orderdate'] != null) {
		data.orderdate = json['orderdate'].toString();
	}
	if (json['description'] != null) {
		data.description = json['description'].toString();
	}
	if (json['image'] != null) {
		data.image = json['image'].toString();
	}
	if (json['hitcount'] != null) {
		data.hitcount = json['hitcount'] is String
				? int.tryParse(json['hitcount'])
				: json['hitcount'].toInt();
	}
	if (json['commentcount'] != null) {
		data.commentcount = json['commentcount'] is String
				? int.tryParse(json['commentcount'])
				: json['commentcount'].toInt();
	}
	if (json['hidecount'] != null) {
		data.hidecount = json['hidecount'];
	}
	if (json['cid'] != null) {
		data.cid = json['cid'] is String
				? int.tryParse(json['cid'])
				: json['cid'].toInt();
	}
	if (json['nd'] != null) {
		data.nd = json['nd'] is String
				? int.tryParse(json['nd'])
				: json['nd'].toInt();
	}
	if (json['sid'] != null) {
		data.sid = json['sid'] is String
				? int.tryParse(json['sid'])
				: json['sid'].toInt();
	}
	if (json['url'] != null) {
		data.url = json['url'].toString();
	}
	if (json['aid'] != null) {
		data.aid = json['aid'] is String
				? int.tryParse(json['aid'])
				: json['aid'].toInt();
	}
	return data;
}

Map<String, dynamic> lapinlistLapinlistToJson(LapinlistLapinlist entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['kwdlist'] = entity.kwdlist;
	data['newsid'] = entity.newsid;
	data['title'] = entity.title;
	data['postdate'] = entity.postdate;
	data['orderdate'] = entity.orderdate;
	data['description'] = entity.description;
	data['image'] = entity.image;
	data['hitcount'] = entity.hitcount;
	data['commentcount'] = entity.commentcount;
	data['hidecount'] = entity.hidecount;
	data['cid'] = entity.cid;
	data['nd'] = entity.nd;
	data['sid'] = entity.sid;
	data['url'] = entity.url;
	data['aid'] = entity.aid;
	return data;
}