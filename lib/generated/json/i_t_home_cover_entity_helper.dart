import 'package:flutter_shop/Business/Cover/Model/i_t_home_cover_entity.dart';

iTHomeCoverEntityFromJson(ITHomeCoverEntity data, Map<String, dynamic> json) {
	if (json['s'] != null) {
		data.s = json['s'].toString();
	}
	if (json['e'] != null) {
		data.e = json['e'].toString();
	}
	if (json['u'] != null) {
		data.u = json['u'].toString();
	}
	if (json['ux'] != null) {
		data.ux = json['ux'].toString();
	}
	if (json['cu'] != null) {
		data.cu = json['cu'].toString();
	}
	if (json['tp'] != null) {
		data.tp = json['tp'].toString();
	}
	if (json['len'] != null) {
		data.len = json['len'] is String
				? double.tryParse(json['len'])
				: json['len'].toDouble();
	}
	if (json['icon'] != null) {
		data.icon = json['icon'];
	}
	return data;
}

Map<String, dynamic> iTHomeCoverEntityToJson(ITHomeCoverEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['s'] = entity.s;
	data['e'] = entity.e;
	data['u'] = entity.u;
	data['ux'] = entity.ux;
	data['cu'] = entity.cu;
	data['tp'] = entity.tp;
	data['len'] = entity.len;
	data['icon'] = entity.icon;
	return data;
}