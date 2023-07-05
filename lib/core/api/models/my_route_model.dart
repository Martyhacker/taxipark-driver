class MyRouteModel {
	String? code;
	List<Routes>? routes;
	List<Waypoints>? waypoints;

	MyRouteModel({this.code, this.routes, this.waypoints});

	MyRouteModel.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['routes'] != null) {
			routes = <Routes>[];
			json['routes'].forEach((v) { routes!.add(Routes.fromJson(v)); });
		}
		if (json['waypoints'] != null) {
			waypoints = <Waypoints>[];
			json['waypoints'].forEach((v) { waypoints!.add(Waypoints.fromJson(v)); });
		}
	}
}

class Routes {
	String? geometry;
	List<Legs>? legs;
	String? weightName;
	double? weight;
	double? duration;
	double? distance;

	Routes({this.geometry, this.legs, this.weightName, this.weight, this.duration, this.distance});

	Routes.fromJson(Map<String, dynamic> json) {
		geometry = json['geometry'];
		if (json['legs'] != null) {
			legs = <Legs>[];
			json['legs'].forEach((v) { legs!.add(Legs.fromJson(v)); });
		}
		weightName = json['weight_name'];
		weight = double.tryParse(json['weight'].toString());
		duration = double.tryParse(json['duration'].toString());
		distance = double.tryParse(json['distance'].toString());
	}
}

class Legs {
	List<Steps>? steps;
	String? summary;
	double? weight;
	double? duration;
	double? distance;

	Legs({this.steps, this.summary, this.weight, this.duration, this.distance});

	Legs.fromJson(Map<String, dynamic> json) {
		if (json['steps'] != null) {
			steps = <Steps>[];
			json['steps'].forEach((v) { steps!.add(Steps.fromJson(v)); });
		}
		summary = json['summary'];
		weight = double.tryParse(json['weight'].toString());
		duration = double.tryParse(json['duration'].toString());
		distance = double.tryParse(json['distance'].toString());
	}
}

class Steps {
	String? geometry;
	Maneuver? maneuver;
	String? mode;
	String? drivingSide;
	String? name;
	List<Intersections>? intersections;
	double? weight;
	double? duration;
	double? distance;

	Steps({this.geometry, this.maneuver, this.mode, this.drivingSide, this.name, this.intersections, this.weight, this.duration, this.distance});

	Steps.fromJson(Map<String, dynamic> json) {
		geometry = json['geometry'];
		maneuver = json['maneuver'] != null ? Maneuver.fromJson(json['maneuver']) : null;
		mode = json['mode'];
		drivingSide = json['driving_side'];
		name = json['name'];
		if (json['intersections'] != null) {
			intersections = <Intersections>[];
			json['intersections'].forEach((v) { intersections!.add(Intersections.fromJson(v)); });
		}
		weight = double.tryParse(json['weight'].toString());
		duration = double.tryParse(json['duration'].toString());
		distance = double.tryParse(json['distance'].toString());
	}

}

class Maneuver {
	int? bearingAfter;
	int? bearingBefore;
	List<double>? location;
	String? modifier;
	String? type;
	int? exit;

	Maneuver({this.bearingAfter, this.bearingBefore, this.location, this.modifier, this.type, this.exit});

	Maneuver.fromJson(Map<String, dynamic> json) {
		bearingAfter = json['bearing_after'];
		bearingBefore = json['bearing_before'];
		location = json['location'].cast<double>();
		modifier = json['modifier'];
		type = json['type'];
		exit = json['exit'];
	}
}

class Intersections {
	int? out;
	List<bool>? entry;
	List<int>? bearings;
	List<double>? location;
	int? jin;

	Intersections({this.out, this.entry, this.bearings, this.location, this.jin});

	Intersections.fromJson(Map<String, dynamic> json) {
		out = json['out'];
		entry = json['entry'].cast<bool>();
		bearings = json['bearings'].cast<int>();
		location = json['location'].cast<double>();
	 jin = json['in'];
	}
}

class Waypoints {
	String? hint;
	double? distance;
	String? name;
	List<double>? location;

	Waypoints({this.hint, this.distance, this.name, this.location});

	Waypoints.fromJson(Map<String, dynamic> json) {
		hint = json['hint'];
		distance = json['distance'];
		name = json['name'];
		location = json['location'].cast<double>();
	}
}