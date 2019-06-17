import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/model/Repository.dart';
import 'package:flutter_app/model/EventPayload.dart';
part 'evtent.g.dart';

@JsonSerializable()
class evtent{
  String id;
  String type;
  User actor;
  Repository repo;
  User org;
  EventPayload payload;
  @JsonKey(name :'public')
  bool isPublic;
  @JsonKey(name:'created_at')
  DateTime createdAt;

  evtent(
      this.id,
      this.type,
      this.actor,
      this.repo,
      this.org,
      this.payload,
      this.isPublic,
      this.createdAt,
      );

  factory evtent.fromJson(Map<String, dynamic> json) => _$evtentFromJson(json);

  Map<String, dynamic> toJson() => _$evtentToJson(this);

}